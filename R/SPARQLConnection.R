#' SPARQL connection class
#'
#' @export
#' @keywords internal
setClass("SPARQLConnection",
         contains = "DBIConnection",
         slots = list(
           endpoint = "character"
         )
)

#' Connection for SPARQL
#'
#' This driver is for implementing the R database (DBI) API.
#'
#' @param drv An object created by \code{SPARQL()}
#' @rdname SPARQL
#' @export
setMethod("dbConnect", "SPARQLDriver", function(drv, endpoint, ...) {
  new("SPARQLConnection", endpoint = endpoint, ...)
})
