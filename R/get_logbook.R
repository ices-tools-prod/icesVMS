#' Download Logbook data
#'
#' RESTRICTED.  Only core members of the ICES VMS data call can access this data.
#' Download a data.frame of logbook data from the ICES VMS and logbook database.
#'
#' The web service only filters the data by country and year. The arguments
#' month, gear_code, metier and stat_rec are applied after the data for the
#' country and year has been downloaded. The web service can not currently
#' filter by ices_area or ecoregion, so these arguments are ignored, with a
#' warning.
#'
#' @param country country code, required
#' @param year integer year, required
#' @param month integer month
#' @param gear_code gear code
#' @param metier level 6 metier code
#' @param stat_rec ICES statistical rectangle
#' @param ices_area ICES area
#' @param ecoregion ICES ecoregion
#'
#' @return a data.frame of logbook data
#'
#' @examples
#' \dontrun{
#' # requires authorization
#' logbook <- get_logbook(country = "DK", year = 2021, month = 1)
#' }
#' 
#' @export
get_logbook <- function(country, year, month,
                    gear_code, metier,
                    stat_rec, ices_area, ecoregion) {

  if (!missing(ecoregion)) {
    check_ecoregion(ecoregion)
  }

  args <- lapply(as.list(match.call())[-1], eval, parent.frame())

  get_country_data(
    "GetLogbookData", args,
    columns = c(
      month = "month", gear_code = "gearCode",
      metier = "leMetLevel6", stat_rec = "icesRectangle"
    ),
    fun = "get_logbook"
  )
}
