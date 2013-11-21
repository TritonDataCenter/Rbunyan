# Roxygen Comments bunyanTracebackN
#' Count of new messages above level threshold after setpoint
#'
#' Returns the number of threshold passing log messages
#' encountered since bunyanSetpoint first called. Note that
#' only the first call to bunyanSetpoint is used, subsequent
#' calls are ignored. Use bunyanClearSetpoint to clear before
#' setting a new setpoint.
#'
#' @keywords bunyan, setpoint
#'
#' @export
bunyanTracebackN <-
function() {
  return(bunyan_globals$countsincemark)
}
