#' Download VMS data
#'
#' DEPRECATED. The ICES VMS web service no longer provides this data, so
#' this function only gives a warning and returns NULL. Swept area ratio
#' values by year and metier level 4 are available from the web service
#' \code{https://data.ices.dk/vms/API/getSARBy_YearAndMetier4_GeoJSON/{year}/{metier4}},
#' see \url{https://data.ices.dk/vms/webservices}.
#'
#' @param year integer year
#' @param c_square character 0.05 degree c-square name
#' @param gear_code benthis gear code
#' @param stat_rec ICES statistical rectangle
#' @param ices_area ICES area
#' @param ecoregion ICES ecoregion
#' @param datacall integer year giving which data call year to inquire about.
#'   If NULL returns the a summary of the most recent approved data.
#'
#' @return NULL
#'
#' @examples
#' \dontrun{
#' # requires authorization
#' sar <- get_sar(2021, stat_rec = "40F1")
#' }
#' 
#' @export
get_sar <- function(year, c_square,
                    gear_code,
                    stat_rec, ices_area, ecoregion, datacall = NULL) {
  warning(
    "get_sar() is deprecated: the ICES VMS web service no longer provides this data.\n",
    "Swept area ratio values by year and metier level 4 are available from:\n",
    "  https://data.ices.dk/vms/API/getSARBy_YearAndMetier4_GeoJSON/{year}/{metier4}\n",
    "see https://data.ices.dk/vms/webservices",
    call. = FALSE
  )

  invisible(NULL)
}
