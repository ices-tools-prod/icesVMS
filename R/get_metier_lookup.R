#' Link Metier level 6 to Benthis categories
#' 
#' Download a data.frame of Metier codes to link
#' level 6 metier codes with different gear categories
#' 
#' @return a data.frame
#' @export
get_metier_lookup <- function() {
  uri <- "https://taf.ices.dk/vms/api/"
  
  vms <-
    httr::GET(paste0(uri, "MetierLookup"))

  message(paste("status code:", httr::status_code(vms)))

  httr::content(vms, simplifyVector = TRUE)
}
