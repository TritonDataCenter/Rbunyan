# Roxygen Comments bunyanTracebackN
#' Count of new messages above level threshold after setpoint
#'
#' Returns the number of threshold passing log messages
#' encountered since bunyanSetpoint first called. Note that
#' only the first call to bunyanSetpoint is used, subsequent
#' calls are ignored. Use bunyanClearSetpoint to clear before
#' setting a new setpoint.
#'
#' @param level, threshold level to see in traceback count
#'
#' @keywords bunyan, setpoint
#'
#' @export
bunyanTracebackN <-
function(level) {
  if (bunyan_globals$countsincemark == 0) {
   return(0)
  }
  if (missing(level)) {
    return(bunyan_globals$countsincemark) 
  } else { # need to screen for level threshold
    report <- bunyanTraceback(level = level)
    return(length(report))
  }
}
