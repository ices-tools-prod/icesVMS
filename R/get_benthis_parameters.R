#' Get gear characteristics for Benthis gear categories
#'
#' Download a data.frame of gear contact models for
#' benthis gear categories used in calculating
#' swept area
#'
#' @return a data.frame
#' @export
get_benthis_parameters <- function() {
  uri <- "https://taf.ices.dk/vms/api/"

  out <- vms_get(url)

  httr::content(out, simplifyVector = TRUE)
}
