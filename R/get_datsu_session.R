#' Download VMS and logbook data from a DATSU session
#'
#' RESTRICTED.  Only core members of the ICES VMS data call can access this data.
#' Download a list of data.frames of VMS and logbook data from the ICES DATSU data checking facility.
#'
#' @param sessionId DATSU session ID
#'
#' @return a list of data.frames of VMS and logbook data
get_datsu_session <- function(sessionId) {

  ve <- get_datsu_session_ve(sessionId)
  le <- get_datsu_session_le(sessionId)

  list(ve = ve, le = le)
}
