#' Download logbook data from a datsu session
#'
#' RESTRICED.  Only core members of the ICES VMS datacall can acess this data.
#' Download a data.frame of logbook data from the ICES DATSU data checking facility.
#'
#' @param sessionId datsu session ID
#'
#' @return a data.frame of VMS data
#' @export
get_datsu_session_le <- function(sessionId) {
  url <- httr::parse_url("https://taf.ices.dk/vms/api/datsuSession/le")
  url$query <- list(sessionId = sessionId)
  url <- httr::build_url(url)

  out <- vms_get(url)

  httr::content(out, simplifyVector = TRUE)
}
