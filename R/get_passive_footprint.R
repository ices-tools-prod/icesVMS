#' Download passive fishing gear footprint
#'
#' Download a data.frame of presence of fishing by c-square and year
#' for passive fishing gears (see details).
#'
#' @param ecoregion ICES ecoregion, if NULL no spatial filtering is performed.
#' @param year which year to select
#' @param metier_level4 optional gear code (metier level 4) ("FPO")
#'
#' @return a data.frame with a WKT column for the c-square polygons
#'
#' @details
#'
#' Passive gears defined as all gears registered under
#' the metier level 4 codes, FPO (fishing pots), LLS (long lines) and
#' GNS (set gill nets), with the exclusion of metier level 5 codes
#' within the GNS category: GNS_SPF and GNS_LPF (set gill nets
#' targeting small and large pelagic fish).
#'
#' @importFrom httr build_url
#'
#' @export
get_passive_footprint <- function(ecoregion, year, metier_level4 = NULL) {
  url <-
    httr::parse_url(
      paste0(
        "https://taf.ices.dk/vms/api/footprint/passive/",
        utils::URLencode(ecoregion), "/",
        year
      )
    )

  if (!is.null(metier_level4)) {
    url$query <- list(metier_level4 = metier_level4)
  }

  url <- httr::build_url(url)

  out <- vms_get(url)

  httr::content(out, simplifyVector = TRUE)
}
