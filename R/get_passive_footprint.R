#' Download passive fishing gear footprint
#'
#' Download a data.frame of presence of fishing by c-square and year
#' for passive fishing gears (see details).
#'
#' @param ecoregion ICES ecoregion
#' @param year which year to select
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
#' @export
get_passive_footprint <- function(ecoregion, year) {
  url <-
    httr::parse_url(
      paste0(
        "https://taf.ices.dk/vms/api/footprint/passive/",
        utils::URLencode(ecoregion), "/",
        year
      )
    )

  url <- httr::build_url(url)

  jwt <- ""
  if (file.exists(file.path(tempdir(), ".ices-jwt"))) {
    jwt <- readLines(file.path(tempdir(), ".ices-jwt"), n = 1)
  }

  out <-
    httr::GET(
      url,
      httr::add_headers(Authorization = paste("Bearer", jwt))
    )

  message(paste("status code:", httr::status_code(out)))

  httr::content(out, simplifyVector = TRUE)
}