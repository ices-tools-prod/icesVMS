#' Download details for a datsu session
#'
#' RESTRICED.  Only core members of the ICES VMS datacall can acess this data.
#' Download a list of information on a datsu submission.
#'
#' @param sessionId datsu session ID
#'
#' @return a list
get_datsu_session_detail <- function(sessionId) {
  url <- httr::parse_url("https://taf.ices.dk/vms/api/datsuSession/details")
  url$query <- list(sessionId = sessionId)
  url <- httr::build_url(url)
  out <- vms_get(url)

  httr::content(out, simplifyVector = TRUE)
}
