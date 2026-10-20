
has_sf <- function() {
  requireNamespace("sf", quietly = TRUE)
}

convert_df2sf <- function(obj, crs = 4326) {
  if (has_sf() && length(obj)) {
    obj <- sf::st_as_sf(obj, wkt = "wkt", crs = 4326)
  }

  obj
}

# The VMS and logbook web services only filter on country (part of the url)
# and year. Other arguments are sent as queries, in case the service supports
# them in the future, and are also applied here where the data has a matching
# column. 'columns' maps argument names to column names in the data.
#' @importFrom glue glue
get_country_data <- function(service, args, columns, fun) {
  if (is.null(args$country) || is.null(args$year)) {
    stop("country and year must be supplied", call. = FALSE)
  }

  unsupported <- setdiff(names(args), c("country", "year", names(columns)))
  if (length(unsupported)) {
    warning(
      "The web service can not currently filter on: ",
      paste(unsupported, collapse = ", "), ". These arguments were ignored.",
      call. = FALSE
    )
  }

  # one request per country and year, other single values sent as queries
  grid <- expand.grid(country = args$country, year = args$year, stringsAsFactors = FALSE)
  query <- args[setdiff(names(args), c("country", "year"))]
  query <- query[lengths(query) == 1]

  if (nrow(grid) > 1) {
    message("running ", nrow(grid), " calls to ", fun, "().")
  }

  out <-
    lapply(seq_len(nrow(grid)), function(i) {
      url <-
        do.call(
          vms_api,
          c(list(service = glue("{service}/{grid$country[i]}"), year = grid$year[i]), query)
        )
      vms_get(url, use_token = TRUE)
    })
  out <- do.call(rbind, out)

  filter_by_args(out, args, columns)
}

# keep rows matching the argument values, for arguments with a column in the data
filter_by_args <- function(data, args, columns) {
  if (!is.data.frame(data)) {
    return(data)
  }

  for (arg in intersect(names(args), names(columns))) {
    column <- columns[[arg]]
    if (!column %in% names(data)) {
      warning("Column '", column, "' not found, so '", arg, "' was not applied.", call. = FALSE)
      next
    }
    data <- data[data[[column]] %in% args[[arg]], , drop = FALSE]
  }
  rownames(data) <- NULL

  data
}
