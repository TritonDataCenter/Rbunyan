# Roxygen Comments bunyanClearSetpoint
#' Clears the memory buffer setpoint after which
#' if no entries above level threshold, bunyanTraceback
#' and bunyanTracebackN will return blank and 0 results
#'
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
