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

  out <- vms_get(url)

  httr::content(out, simplifyVector = TRUE)
}
