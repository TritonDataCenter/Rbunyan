# Roxygen Comments bunyanTracebackWarnings
#' Count of warnings above level threshold of 40 after setpoint
#'
#' Returns the number of WARN log messages
#' encountered since bunyanSetpoint first called. Note that
#' only the first call to bunyanSetpoint is used, subsequent
#' calls are ignored. Use bunyanClearSetpoint to clear before
#' setting a new setpoint.
#'
#'
#' @keywords bunyan, setpoint
#'
#' @export
bunyanTracebackWarnings <-
function() {
    return(bunyan_globals$warnsincemark)
}
