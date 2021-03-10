#' Download VMS and logbook data from a datsu session
#'
#' RESTRICED.  Only core members of the ICES VMS datacall can acess this data.
#' Download a list of data.frames of VMS and logbook data from the ICES DATSU data checking facility.
#'
#' @param sessionId datsu session ID
#'
#' @return a list of data.frames of VMS and logbook data
#' @export
get_datsu_session <- function(sessionId) {

  ve <- get_datsu_session_ve(sessionId)
  le <- get_datsu_session_le(sessionId)

  list(ve = ve, le = le)
}
