# Roxygen Comments bunyanClearSetpoint
#' Clears memory setpoint
#'
#' Clears the memory buffer setpoint.  After clearing,
#' if no log entries above level threshold, bunyanTraceback
#' and bunyanTracebackN will return blank and 0 results
#' This does not alter the contents of the buffer, which
#' can be dumped at any time with bunyanBuffer.
#' You must use bunyanClearSetpoint on an existing setpoint
#' before setting a new one with bunyanSetpoint.
#'
#' @keywords bunyan, setpoint
#'
#' @export
bunyanClearSetpoint <-
function() {
  # set to 0 
  bunyan_globals$setpoint <- 0
  #reset the counter
  bunyan_globals$countsincemark <- 0  
}
