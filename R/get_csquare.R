#' Download VMS data
#'
#' RESTRICED.  Only core members of the ICES VMS datacall can acess this data.
#' Download a data.frame of VMS data from the ICES VMS and logbook database.
#'
#' @param c_square character 0.05 degree c-square name
#' @param stat_rec ICES statistical rectangle
#' @param ices_area ICES area
#' @param ecoregion ICES ecoregion
#'
#' @return a data.frame of VMS data
#' @export
get_csquare <- function(c_square, stat_rec, ices_area, ecoregion) {
  url <- httr::parse_url("https://taf.ices.dk/vms/api/csquares")

  args <- lapply(as.list(match.call())[-1], eval, parent.frame())
  if (any(sapply(args, length) > 1)) {
    args_grid <- do.call(expand.grid, c(args, KEEP.OUT.ATTRS = FALSE, stringsAsFactors = FALSE))

    args_list <- lapply(1:nrow(args_grid), function(i) as.list(args_grid[i,,drop = FALSE]))

    message("running ", length(args_list), " calls to get_csquare().")
    out <- lapply(args_list, function(args) do.call(get_csquare, args))

    return (do.call(rbind, out))
  }

  url$query <- args
  url <- httr::build_url(url)

  out <- vms_get(url, use_token = FALSE, content = TRUE)

  out
}
