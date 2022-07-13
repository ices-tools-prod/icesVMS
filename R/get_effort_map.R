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
#' The spatial data.frame contains average annual mega Watt fishing hours,
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

  vms_get(url)
}
