#' Download fishing effort map data
#' 
#' Download a data.frame of kw fishing hours by c-square and gear
#' category averaged over 4 years.
#' 
#' @param ecoregion ICES ecoregion
#' @param year which year to select (see details)
#' 
#' @return a data.frame with a WKT column for the c-square polygons
#' 
#' @details
#' 
#' The spatial data.frame contains average annual mw fishing hours,
#' averaged over 4 years.
#' 
#' @export
get_effort_map <- function(ecoregion, year = NULL) {  
  url <- 
    httr::parse_url(
      paste0("https://taf.ices.dk/vms/api/fisheriesoverviews/effortmap/", 
             utils::URLencode(ecoregion)))
  if (!is.null(year)) {
    url$query <- list(year = year)
  }

  url <- httr::build_url(url)

  jwt <- ""
  if (file.exists(file.path(tempdir(), ".ices-jwt"))) {
      jwt <- readLines(file.path(tempdir(), ".ices-jwt"), n = 1)    
  }

  out <-
    httr::GET(url, 
              httr::add_headers(Authorization = paste("Bearer", jwt)))

  message(paste("status code:", httr::status_code(out)))

  httr::content(out, simplifyVector = TRUE)
}
