#' Link Metier level 6 to Benthis categories
#'
#' Download a data.frame of Metier codes to link
#' level 6 metier codes with different gear categories
#'
#' @return a data.frame
#' @export
#' @importFrom httr content
get_metier_lookup <- function() {
  vms_get("https://taf.ices.dk/vms/api/MetierLookup")
}
