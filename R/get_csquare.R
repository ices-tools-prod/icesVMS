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
#' 
#' @return a data.frame of VMS data
#' @export
get_csquare <- function(c_square, stat_rec, ices_area, ecoregion) {  
  url <- httr::parse_url("https://taf.ices.dk/vms/api/csquares")

  args <- as.list(match.call())[-1]
  if (any(sapply(args, length) > 1)) {
    args_grid <- do.call(expand.grid, c(args, KEEP.OUT.ATTRS = FALSE, stringsAsFactors = FALSE))

    args_list <- lapply(1:nrow(args_grid), function(i) as.list(args_grid[i,,drop = FALSE]))

    message("running ", length(args_list), " calls to get_csquare().")
    out <- lapply(args_list, function(args) do.call(get_csquare, args))

    return (do.call(rbind, out))
  }

  url$query <- as.list(match.call())[-1]
  url <- httr::build_url(url)

  res <- httr::GET(url)

  message(paste("status code:", httr::status_code(res)))

  httr::content(res, simplifyVector = TRUE)
}

