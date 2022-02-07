#' Download swept area ratio, landings and value map data
#'
#' In this webservice the user can upload a file to be screen and
#' validated by the VMS database. The service can be called using post
#' and the file will have to be part of the body of que call. The user
#' needs to be autenticated in order to call this service.
#' This file can be later pushed to the database by the same user.
#'
#' @param file file name of the file containing the data to screen
#' @param verbose return verbose information about the POST request
#'
#' @return text message from the screening api
#'
#'
#' @export
screen_vms_file <- function(file, verbose = FALSE) {
  url <-
    httr::parse_url(
      "https://data.ices.dk/vms/webapi/ScreenVMSFile"
    )

  body <-
    list(
      fileToScreen = httr::upload_file(file)
    )

  resp <- vms_post(url, body, verbose = verbose)

  httr::content(resp)
}