#' Download swept area ratio, landings and value map data
#'
#' Download a data.frame of surface and subsurface swept area
#' ratio by c-square for a given ICES ecoregion, year and gear code.
#'
#' @param ecoregion ICES ecoregion
#' @param year which year to select
#'
#' @return a data.frame with a WKT column for the c-square polygons
#'
#'
#' @export
get_wgfbit_data2 <- function(ecoregion, year) {
  url <-
    httr::parse_url(
      paste0("https://taf.ices.dk/vms/api/wgfbit/dataset2/",
             utils::URLencode(ecoregion), "/", year))

  url <- httr::build_url(url)

  vms_get(url, use_token = TRUE)
}
