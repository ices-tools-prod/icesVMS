
has_sf <- function() {
  requireNamespace("sf", quietly = TRUE)
}

convert_df2sf <- function(obj, crs = 4326) {
  if (has_sf() && length(obj)) {
    obj <- sf::st_as_sf(obj, wkt = "wkt", crs = 4326)
  }

  obj
}

check_ecoregion <- function(ecoregion, stop.on.fail = TRUE) {
  ok <- ecoregion %in% get_ecoregion_list()
  
  if (!ok && stop.on.fail) {
    stop(glue("ecoregion = '{ecoregion}' is not valid. For valid options see: \n\nget_ecoregion_list()"))
  }
  
  ok
}

#' @importFrom icesVocab getCodeList
get_ecoregion_list <- function() {
  getCodeList(code_type = "Ecoregion")$Description
}
