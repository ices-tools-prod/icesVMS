#' Check to see if the sf package is installed
#'
#' check to see if the \code{sf} package is installed
#'
#' @return logical value, TRUE if the \code{sf} package is installed
#'
#' @examples
#'
#' (has_sf())
#' @export
has_sf <- function() {
  requireNamespace("sf", quietly = TRUE)
}
