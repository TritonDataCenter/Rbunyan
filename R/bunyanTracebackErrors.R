# Roxygen Comments bunyanTracebackErrors
#' Count of errors above level threshold of 50 after setpoint
#'
#' Returns the number of ERROR/FATAL log messages
#' encountered since bunyanSetpoint first called. Note that
#' only the first call to bunyanSetpoint is used, subsequent
#' calls are ignored. Use bunyanClearSetpoint to clear before
#' setting a new setpoint.
#'
#'
#' @keywords bunyan, setpoint
#'
#' @export
bunyanTracebackErrors <-
function() {
    return(bunyan_globals$errorssincemark)
}
