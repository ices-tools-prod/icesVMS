#' Download VMS data
#'
#' RESTRICED.  Only core members of the ICES VMS datacall can acess this data.
#' Download a data.frame of VMS data from the ICES VMS and logbook database.
#'
#' @param country country code
#' @param year integer year
#' @param month integer month
#' @param c_square character 0.05 degree c-square name
#' @param gear_code benthis gear code
#' @param metier level 6 metier code
#' @param stat_rec ICES statistical rectangle
#' @param ices_area ICES area
#' @param ecoregion ICES ecoregion
#' @param datacall integer year giving which data call year to enquire about.
#'   If NULL returns the a summary of the most recent approved data.
#'
#' @return a data.frame of VMS data
#' @export
get_vms <- function(country, year, month, c_square,
                    gear_code, metier,
                    stat_rec, ices_area, ecoregion, datacall = NULL) {

  url <- httr::parse_url("https://taf.ices.dk/vms/api/vms")

  args <- lapply(as.list(match.call())[-1], eval, parent.frame())
  if (any(sapply(args, length) > 1)) {
    args_grid <- do.call(expand.grid, c(args, KEEP.OUT.ATTRS = FALSE, stringsAsFactors = FALSE))

    args_list <- lapply(1:nrow(args_grid), function(i) as.list(args_grid[i,]))

    message("running ", length(args_list), " calls to get_vms().")
    out <- lapply(args_list, function(args) do.call(get_vms, args))

    return (do.call(rbind, out))
  }

  url$query <- args
  url <- httr::build_url(url)

  out <- vms_get(url)

  httr::content(out, simplifyVector = TRUE)
}
