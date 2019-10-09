#' Download swept area ratio, landings and value map data
#' 
#' Download a data.frame of surface and subsurface swept area 
#' ratio by c-square for a given ICES ecoregion, year and gear code.
#' 
#' @param ecoregion ICES ecoregion
#' @param year which year to select
#' @param fishing_category optional gear category ("Otter", "Dredge")
#' @param benthis_metier optional benthis metier ("SDN_DMF")
#' 
#' @return a data.frame with a WKT column for the c-square polygons
#' 
#' @details
#' 
#' gear_group and benthis_metier may not both be supplied, if neither
#' are supplied the total is calculated.
#' 
#' @export
get_wgfbit_data1 <- function(ecoregion, year, fishing_category = NULL, benthis_metier = NULL) {  
  url <- 
    httr::parse_url(
      paste0("https://taf.ices.dk/vms/api/wgfbit/dataset1/", 
             utils::URLencode(ecoregion), "/", year))
  
  if (!is.null(fishing_category)) {
    url$query <- list(fishing_category = fishing_category)
  } else 
  if (!is.null(benthis_metier)) {
    url$query <- list(benthis_metier = benthis_metier)
  }

  # warn if both gear_group and benthis_metier are supplied
  if (!is.null(fishing_category) & !is.null(benthis_metier)) {
    warning("Both fishing_category and benthis_metier were supplied, only fishing_category was used.")
  }

  url <- httr::build_url(url)

  jwt <- ""
  if (file.exists(file.path(tempdir(), ".ices-jwt"))) {
      jwt <- readLines(file.path(tempdir(), ".ices-jwt"), n = 1)    
  }

  out <-
    httr::GET(url, 
              httr::add_headers(Authorization = paste("Bearer", jwt)))

  message(paste("status code:", httr::status_code(out)))

  httr::content(out, simplifyVector = TRUE)
}
