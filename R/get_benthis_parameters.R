#' Get gear characteristics for Benthis gear categories
#'
#' Download a data.frame of gear contact models for
#' benthis gear categories used in calculating
#' swept area
#'
#' @return a data.frame of model parameters
#'
#' @export
get_benthis_parameters <- function() {
  out <- vms_get("https://taf.ices.dk/vms/api/gearwidths")

  httr::content(out, simplifyVector = TRUE)
}
