#' Download swept area ratio, landings and value map data
#'
#' Download a data.frame of surface and subsurface swept area
#' ratio by c-square for a given ICES ecoregion, year and gear code.
#'
#' @param ecoregion ICES ecoregion
#' @param year which year to select
#' @param fishing_category optional gear category ("Otter", "Dredge")
#' @param benthis_metier optional benthis metier ("SDN_DMF")
#' @param datacall integer year giving which data call year to inquire about.
#'   If NULL returns the a summary of the most recent approved data.
#'
#' @return a data.frame with a WKT column for the c-square polygons
#'
#' @details
#'
#' gear_group and benthis_metier may not both be supplied, if neither
#' are supplied the total is calculated.
#'
#' @export
get_wgfbit_data1 <- function(ecoregion, year, fishing_category = NULL, benthis_metier = NULL, datacall = NULL) {
  url <-
    httr::parse_url(
      paste0("https://taf.ices.dk/vms/api/wgfbit/dataset1/",
             utils::URLencode(ecoregion), "/", year))

  args <- list()
  if (!is.null(fishing_category)) {
    args <- list(fishing_category = fishing_category)
  } else
  if (!is.null(benthis_metier)) {
    args <- list(benthis_metier = benthis_metier)
  }

  if (!is.null(datacall)) {
    args <- c(args, list(datacall = datacall))
  }
  url$query <- args

  # warn if both gear_group and benthis_metier are supplied
  if (!is.null(fishing_category) & !is.null(benthis_metier)) {
    warning("Both fishing_category and benthis_metier were supplied, only fishing_category was used.")
  }

  url <- httr::build_url(url)

  out <- vms_get(url)

  httr::content(out, simplifyVector = TRUE)
}
