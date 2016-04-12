#' SPARQL driver class
#'
#' @keywords internal
#' @export
setClass("SPARQLDriver", contains = "DBIDriver")

#' Driver for SPARQL
#'
#' This driver is for implementing the R database (DBI) API.
#'
#' @export
SPARQL <- function() {new("SPARQLDriver")}

#' @export
#' @rdname SPARQLDriver-class
setMethod("dbUnloadDriver", "SPARQLDriver", function(drv, ...) {
  # dummy
  TRUE
})

#' @export
setMethod("show", "SPARQLDriver", function(object) {
  cat("<SPARQLDriver>\n")
})
