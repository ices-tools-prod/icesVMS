#' Lists of Vocabularies
#'
#' Get a list of vocabularies such as country codes or ecoregions.
#'
#' @return a character vector, or NULL if the ICES vocabulary service
#'   could not be reached
#'
#' @examples
#' \donttest{
#' ecoregions <- get_ecoregion_list()
#' "Celtic Seas" %in% ecoregions
#' 
#' stat_recs <- get_stat_rec_list()
#' "40F1" %in% stat_recs
#'
#' countries <- get_country_list()
#' "DK" %in% countries
#' }
#' @importFrom icesVocab getCodeList
#' 
#' @rdname getVocabLists
#' @export
get_ecoregion_list <- function() {
  get_vocab_list("Ecoregion", "Description")
}

#' @rdname getVocabLists
#'
#' @export
get_stat_rec_list <- function() {
  get_vocab_list("StatRec", "Key")
}

#' @rdname getVocabLists
#'
#' @export
get_country_list <- function() {
  get_vocab_list("ISO_3166", "Key")
}

# fail gracefully if the vocabulary service is unavailable
get_vocab_list <- function(code_type, column) {
  codes <-
    tryCatch(
      getCodeList(code_type = code_type),
      error = function(e) {
        message("Could not download the ", code_type, " vocabulary: ", conditionMessage(e))
        NULL
      }
    )

  codes[[column]]
}
