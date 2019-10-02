#' Download VMS data
#' 
#' Download a data.frame of VMS data from the ICES VMS and logbook database.
#' 
#' @return a data.frame of VMS data
#' @export
get_vms <- function() {
  uri <- "https://taf.ices.dk/vms/api/"
  
  jwt <- readLines(".ices-jwt", n = 1)
  vms <-
    httr::GET(paste0(uri, "vms"), 
              httr::add_headers(Authorization = paste("Bearer", jwt)))

  message(paste("status code:", httr::status_code(vms)))

  httr::content(vms, simplifyVector = TRUE)
}
