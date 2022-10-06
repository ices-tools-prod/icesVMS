#' Download a summary of submitted data
#'
#' Download a summary of submitted data
#'
#' @param datacall integer year giving which data call year to inquire about.
#'   If NULL returns the a summary of the most recent approved data.
#'
#' @return a data.frame of VMS summary data
#' @export
get_upload_summary <- function(datacall = NULL) {

  url <- httr::parse_url("https://taf.ices.dk/vms/api/vmssummary")

  if (!is.null(datacall)) {
    url <- httr::parse_url(sprintf("https://taf.ices.dk/vms/api/vmssummary/%i", datacall))
  }

  vms_get(url, use_token = TRUE)
}
