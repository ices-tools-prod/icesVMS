#' Download swept area ratio map data
#'
#' Download a data.frame of surface and subsurface swept area
#' ratio by c-square for a given ICES ecoregion.
#'
#' @param ecoregion ICES ecoregion
#' @param year which year to select (see details)
#' @param nyears the number of years to take an average over
#'
#' @return a data.frame with a WKT column for the c-square polygons
#'
#' @details
#'
#' The spatial data.frame contains average annual surface-swept-area-ratio
#' and subsurface-swept-area-ratio averaged over 4 years by default.  If year
#' is not specified (NULL) then the present year - 1 is assumed.
#'
#' @export
get_sar_map <- function(ecoregion, year = NULL, nyears = NULL) {
  url <-
    httr::parse_url(
      paste0("https://taf.ices.dk/vms/api/fisheriesoverviews/sarmap/",
             utils::URLencode(ecoregion)))
  if (!is.null(year) || !is.null(nyears)) {
    args <- list(year = year, nyears = nyears)
    url$query <- args[!sapply(args, is.null)]
  }

  url <- httr::build_url(url)

  out <- vms_get(url, use_token = TRUE)

  if (requireNamespace('sf', quietly = TRUE) && length(out)) {
    out <- sf::st_as_sf(out, wkt = "wkt", crs = 4326)
  }

  out
}
