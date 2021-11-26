#' Download fishing landings summaries
#'
#' Download a data.frame of total weight by country and year for a
#' given ICES ecoregion.
#'
#' @param ecoregion ICES ecoregion
#'
#' @return a data.frame
#'
#' @export
get_fo_landings <- function(ecoregion) {
  url <-
    httr::parse_url(
      paste0(
        "https://taf.ices.dk/vms/api/fisheriesoverviews/landings/",
        utils::URLencode(ecoregion)
      )
    )
  url <- httr::build_url(url)
  out <- vms_get(url)

  httr::content(out, simplifyVector = TRUE)
}
