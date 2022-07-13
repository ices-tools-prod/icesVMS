#' Build a VMS web service url
#'
#' utility to build a url with optional query arguments
#'
#' @param service the name of the service
#' @param ... name arguments will be added as queries
#'
#' @return a complete url as a character string
#'
#' @examples
#'
#' vms_api("hi", bye = 21)
#' vms_api("csquares")
#'
#' @importFrom httr parse_url build_url GET
#'
#' @export
vms_api <- function(service, ...) {
  url <- paste0(api_url(), "/", service)
  url <- parse_url(url)
  url$query <- list(...)
  url <- build_url(url)

  url
}
