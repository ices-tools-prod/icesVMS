
convert_df2sf <- function(obj) {
  if (has_sf() && length(obj)) {
    obj <- sf::st_as_sf(obj, wkt = "wkt", crs = 4326)
  }

  obj
}