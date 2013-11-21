# Roxygen Comments bunyanBuffer
#' Returns memory buffer
#'
#' Returns the contents of the bunyan memory buffer
#' First/Last entry can be determined from timestamp
#'
#' @keywords bunyan,
#'
#' @export
bunyanBuffer <-
function() {
   return(bunyan_globals$loglines)
}
