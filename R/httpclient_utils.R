#' @importFrom icesConnect ices_get_jwt
vms_get <- function(url, retry = TRUE) {

  out <- icesConnect::ices_get_jwt(url, retry = retry)

  return(out)
}


#' @importFrom icesConnect ices_post_jwt
vms_post <- function(url, body = list(), retry = TRUE, verbose = FALSE) {
  out <- icesConnect::ices_post_jwt(url, body,
    encode = "multipart",
    retry = retry,
    verbose = verbose
  )

  return(out)
}
