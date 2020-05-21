
vms_get <- function(url, retry = TRUE) {

  out <-
    if (file.exists(file.path(tempdir(), ".ices-jwt"))) {
      jwt <- readLines(file.path(tempdir(), ".ices-jwt"), n = 1)

      httr::GET(
        url,
        httr::add_headers(Authorization = paste("Bearer", jwt))
      )
    } else {
      httr::GET(url)
    }

  httr::message_for_status(out)

  if (httr::status_code(out) == 404 & retry) {
    # try again - sometimes the server seems to return 404 on the
    # first request
    message("Server not responding, doing one retry.")
    vms_get(404, retry = FALSE)
  }

  tryCatch(httr::stop_for_status(out),
    http_404 = function(c) message("Url doesn't exist - the server may not responding."),
    http_403 = function(c) message("You need to authenticate - run update_token(...)"),
    http_401 = function(c) message("You don't have access to this resource."),
    http_400 = function(c) message("Check function arguments, probably a user error."),
    http_500 = function(c) message("Something went wrong on the server :(")
  )

  return(out)
}
