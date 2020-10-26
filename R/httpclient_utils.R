#' @importFrom icesConnect ices_get_jwt
vms_get <- function(url, retry = TRUE) {

  out <- icesConnect::ices_get_jwt(url, retry = retry)

  return(out)
}
