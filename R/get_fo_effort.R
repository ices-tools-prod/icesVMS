#' Download fishing effort summaries
#' 
#' Download a data.frame of kw fishing hours by country and year for a
#' given ICES ecoregion.
#' 
#' @param ecoregion ICES ecoregion
#' 
#' @return a data.frame
#' 
#' @export
get_fo_effort <- function(ecoregion) {  
  url <- 
    httr::parse_url(
      paste0("https://taf.ices.dk/vms/api/fisheriesoverviews/effort/", 
             utils::URLencode(ecoregion)))

  url <- httr::build_url(url)

  out <- httr::GET(url)

  message(paste("status code:", httr::status_code(out)))

  httr::content(out, simplifyVector = TRUE)
}