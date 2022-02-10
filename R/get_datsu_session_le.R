#' Download logbook data from a DATSU session
#'
#' RESTRICTED.  Only core members of the ICES VMS data call can access this data.
#' Download a data.frame of logbook data from the ICES DATSU data checking facility.
#'
#' @param sessionId DATSU session ID
#'
#' @return a data.frame of VMS data
get_datsu_session_le <- function(sessionId) {
  url <- httr::parse_url("https://taf.ices.dk/vms/api/datsuSession/le")
  url$query <- list(sessionId = sessionId)
  url <- httr::build_url(url)

  out <- vms_get(url)

  httr::content(out, simplifyVector = TRUE)
}
