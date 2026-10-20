#' Download VMS data
#'
#' RESTRICTED.  Only core members of the ICES VMS data call can access this data.
#' Download a data.frame of VMS data from the ICES VMS and logbook database.
#'
#' The web service only filters the data by country and year. The arguments
#' month, c_square, gear_code and metier are applied after the data for the
#' country and year has been downloaded. The web service can not currently
#' filter by stat_rec, ices_area, ecoregion or datacall, so these arguments
#' are ignored, with a warning.
#'
#' @param country country code, required
#' @param year integer year, required
#' @param month integer month
#' @param c_square character 0.05 degree c-square name
#' @param gear_code gear code
#' @param metier level 6 metier code
#' @param stat_rec ICES statistical rectangle
#' @param ices_area ICES area
#' @param ecoregion ICES ecoregion
#' @param datacall integer year giving which data call year to inquire about.
#'   If NULL returns the a summary of the most recent approved data.
#'
#' @return a data.frame of VMS data
#'
#' @examples
#' \dontrun{
#' # requires authorization
#' vms <- get_vms(country = "DK", year = 2021, month = 1)
#' }
#' 
#' @export
get_vms <- function(country, year, month, c_square,
                    gear_code, metier,
                    stat_rec, ices_area, ecoregion, datacall = NULL) {

  if (!missing(ecoregion)) {
    check_ecoregion(ecoregion)
  }

  args <- lapply(as.list(match.call())[-1], eval, parent.frame())

  get_country_data(
    "GetVMSData", args,
    columns = c(
      month = "month", c_square = "cSquare",
      gear_code = "gearCode", metier = "leMetLevel6"
    ),
    fun = "get_vms"
  )
}
