#' SPARQL result class.
#'
#' @keywords internal
#' @export
setClass("SPARQLResult",
         contains = "DBIResult",
         slots = list(data = "tbl_df",
                      cur  = "numeric",
                      nrow = "numeric"))

#' Send a query to SPARQL.
#'
#' @export
setMethod("dbSendQuery", "SPARQLConnection", function(conn, statement, ...) {
  res <- httr::GET(conn@endpoint,
                   httr::add_headers(`Accept` = "text/csv"),
                   query = list(query = statement))
  httr::stop_for_status(res)
  data <- readr::read_csv(httr::content(res, as = "text"))
  new("SPARQLResult", data = data, cur = 1L, nrow = nrow(data), ...)
})

#' @export
setMethod("dbClearResult", "SPARQLResult", function(res, ...) {
  rm(res@text)
  TRUE
})

#' @export
setMethod("dbFetch", "SPARQLResult", function(res, n = -1L, ...) {
  if(res@cur < 0) return(dplyr::tbl_df(list()))

  n_start <- res@cur
  n_end   <- if(n > 0) res@cur + n - 1L else res@nrow
  res@cur <- if(n_end >= res@nrow) -1L else n_end + 1L

  res@data[n_start:n_end,]
})


#' @export
setMethod("dbHasCompleted", "SPARQLResult", function(res, ...) {
  res@cur < 0
})
