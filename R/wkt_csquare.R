#' Build a WKT string from latitude and longitude
#'
#' utility to build a WKT (Well Known Text) polygon string
#' for a c-square
#'
#' @param lat latitude (decimal degrees)
#' @param lon longitude (decimal degrees)
#' @param size dimension of c-square (decimal degrees)
#'
#' @return a string in WKT format
#'
#' @examples
#'
#' wkt_csquare(55, 0.1, 0.05)
#'
#' @importFrom glue glue
#'
#' @export

wkt_csquare_flexible <- function(lat, lon, size = 0.05) {
    half_size <- size / 2
    glue("POLYGON(({lon - half_size} {lat - half_size},", 
         "{lon - half_size} {lat + half_size},", 
         "{lon + half_size} {lat + half_size},", 
         "{lon + half_size} {lat - half_size},", 
         "{lon - half_size} {lat - half_size}))")
}
