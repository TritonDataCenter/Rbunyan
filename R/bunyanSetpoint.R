# Roxygen Comments bunyanSetpoint
#' Removes Manta object specified by full manta path or from current
#' working manta directory
#'
#' @keywords bunyan, setpoint
#'
#' @export
bunyanSetpoint <-
function() {
  if (bunyan_globals$bunyan_initialized == FALSE) {
    bunyanSetLog() # default is memory logging at INFO level
  }

  # set to the next slot in memory
  bunyan_globals$setpoint <- bunyan_globals$memstart + 1
  #wrap condition
  if (bunyan_globals$setpoint > bunyan_globals$memlines) bunyan_globals$setpoint <- 1
  #reset the counter
  bunyan_globals$countsincemark <- 0  

}
