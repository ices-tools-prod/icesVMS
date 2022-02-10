#' Download details for a DATSU session
#'
#' RESTRICTED.  Only core members of the ICES VMS data call can access this data.
#' Download a list of information on a DATSU submission.
#'
#' @param sessionId DATSU session ID
#'
#' @return a list
get_datsu_session_detail <- function(sessionId) {
  url <- httr::parse_url("https://taf.ices.dk/vms/api/datsuSession/details")
  url$query <- list(sessionId = sessionId)
  url <- httr::build_url(url)
  out <- vms_get(url)

  httr::content(out, simplifyVector = TRUE)
}
