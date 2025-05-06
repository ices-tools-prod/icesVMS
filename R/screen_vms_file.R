#' Screen a VMS file and submit for QC checks
#'
#' In this web service the user can upload a file to be screen and
#' validated by the VMS database. The service can be called using post
#' and the file will have to be part of the body of the call. The user
#' needs to be authenticated in order to call this service.
#' This file can be later pushed to the database by the same user.
#'
#' @param filename file name of the file containing the data to screen
#' @param verbose return verbose information about the POST request
#' @param force force submission even if checks to do not pass
#'
#' @return text message from the screening process
#'
#' @examples
#' \dontrun{
#' # requires authorization
#' filename <- system.file("test_files/vms_test.csv", package = "icesVMS")
#' screen_vms_file(filename)
#'
#' filename <- system.file("test_files/vms_test_ok.csv", package = "icesVMS")
#' screen_vms_file(filename)
#' }
#'
#' @importFrom icesDatsuQC runQCChecks runVocabChecks
#' @importFrom httr upload_file
#' @export
screen_vms_file <- function(filename, verbose = FALSE, force = FALSE) {

  # is first line column headers?
  type <- scan(filename, "", n = 1, sep = ",", quiet = TRUE)
  if (type == "RecordType") {
    type <- scan(filename, "", n = 1, sep = ",", quiet = TRUE, skip = 1)
  }

  message(glue("Assuming record type is {type}"))

  if (verbose) {
    suppressMessages <- function(x) x
  }
  # run local vocab checks
  vc <- suppressMessages(runVocabChecks(filename, 145, type))

  # run local QC checks
  qc <- suppressMessages(runQCChecks(filename, 145, type))

  if (length(vc) > 0) {
    cat("Summary of Vocab errors:\n")
    print(vc)
  }

  if (!is.null(qc)) {
    cat("Summary of QC failures:\n")
    print(qc)
  }

  if (length(vc) > 0 && !is.null(qc)) {
    warning(
      glue(
        "{length(vc)} vocab and {length(qc)} quality checks did not pass."
      )
    )
    if (!force) {
      warning("File NOT sent to DATSU!")
      out <- list(vocab = vc, quality = qc)
      return(invisible(out))
    }
  }

  url <- "https://data.ices.dk/vms/webapi/ScreenVMSFile"

  body <-
    list(
      fileToScreen = upload_file(filename)
    )

  resp <- suppressMessages(vms_post(url, body, verbose = verbose, use_token = TRUE))

  msg <- content(resp)


  msg
}
