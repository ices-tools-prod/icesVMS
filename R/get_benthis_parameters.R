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
  
  vms <-
    httr::GET(paste0(uri, "GearWidths"))

  message(paste("status code:", httr::status_code(vms)))

  httr::content(vms, simplifyVector = TRUE)
}
