# Roxygen Comments bunyanSetpoint
#' Sets marker in memory logging buffer for catching new messages
#'
#' Sets a marker in the Bunyan log marking the start of log
#' buffer space after which logged errors and warnings may be
#' retrieved or counted with bunyanTraceback and
#' bunyanTracebackN. If a setpoint already exists, calls are
#' ignored, they must be explicitally cleared with 
#' bunyanClearSetpoint.
#'
#'
#'
#' @keywords bunyan, setpoint
#'
#' @export
bunyanSetpoint <-
function() {
  if (bunyan_globals$bunyan_initialized == FALSE) {
    bunyanSetLog() # default is memory logging at INFO level
  }

  if (bunyan_globals$memlines == 0) return()
  if (bunyan_globals$setpoint == 0) {
    # bunyanClearSetpoint must be called to reset the setpoint.
    # set to the next slot in memory
    bunyan_globals$setpoint <- bunyan_globals$memstart + 1
    #wrap condition
    if (bunyan_globals$setpoint > bunyan_globals$memlines) bunyan_globals$setpoint <- 1
    #reset the counter
    bunyan_globals$countsincemark <- 0  
  }
}
