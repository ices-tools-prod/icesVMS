#' Lists of Vocabularies
#'
#' Get a list of vocabularies such as country codes or ecoregions.
#'
#' @param arg one of country code, ICES statistical rectangle or ICES ecoregion
#' @param stop.on.fail logical, if TRUE function will call stop()
#'
#' @return logical. If the vocabulary could not be downloaded, the check is
#'   skipped and NA is returned.
#'
#' @examples
#' \dontrun{
#' check_ecoregion("Celtic Seas", stop.on.fail = FALSE)
#'
#' check_stat_recs("40F1")
#'
#' check_countries("DK")
#' check_countries(c("DK", "GB"))
#' }
#' @importFrom icesVocab getCodeList
#'
#' @rdname checkVocabLists
#' @export
check_ecoregion <- function(arg, stop.on.fail = TRUE) {
  valid <- get_ecoregion_list()
  if (is.null(valid)) {
    message("Skipping check, the vocabulary could not be downloaded.")
    return(NA)
  }

  ok <- all(arg %in% valid)

  if (!ok && stop.on.fail) {
    stop("ecoregion is not valid. For valid options see: \n\nget_ecoregion_list()")
  }

  ok
}

#' @rdname checkVocabLists
#' @export
check_stat_recs <- function(arg, stop.on.fail = TRUE) {
  valid <- get_stat_rec_list()
  if (is.null(valid)) {
    message("Skipping check, the vocabulary could not be downloaded.")
    return(NA)
  }

  ok <- all(arg %in% valid)

  if (!ok && stop.on.fail) {
    stop("stat_rec is not valid. For valid options see: \n\nget_stat_rec_list()")
  }

  ok
}

#' @rdname checkVocabLists
#' @export
check_countries <- function(arg, stop.on.fail = TRUE) {
  valid <- get_country_list()
  if (is.null(valid)) {
    message("Skipping check, the vocabulary could not be downloaded.")
    return(NA)
  }

  ok <- all(arg %in% valid)

  if (!ok && stop.on.fail) {
    stop("country is not valid. For valid options see: \n\n get_country_list()")
  }

  ok
}
