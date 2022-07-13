#' Get gear characteristics for 'benthis' gear categories
#'
#' Download a data.frame of gear contact models for
#' 'benthis' gear categories used in calculating
#' the swept area of a fishing gear.
#'
#' @return a data.frame of model parameters
#'
#' @export
get_benthis_parameters <- function() {
  out <-
    vms_get(
      vms_api("gearwidths")
    )

  out
}
