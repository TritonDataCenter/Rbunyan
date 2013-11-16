# Roxygen Comments bunyanBuffer
#'
#' Shows contents of bunyan memory circular buffer
#' First/Last entry can be determined from timestamp
#'
#' @keywords bunyan,
#'
#' @export
bunyanBuffer <-
function() {
   return(bunyan_globals$loglines)
}
