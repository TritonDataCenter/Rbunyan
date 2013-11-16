# Roxygen Comments bunyanTraceback
#'
#'  Reports the last bunyan messages since 
#'  bunyanSetpoint
#'
#'
#' @keywords bunyan, setpoint
#'
#'
#'
#' @export
bunyanTraceback <-
function() {

  report <- ""

  # no memory buffer, return nothing
  if (bunyan_globals$memlines == 0) return(report)

  # no return unless bunyanSetpoint called and something logged
  if (bunyan_globals$setpoint == 0) return(report)
  if (bunyan_globals$countsincemark == 0) return(report)

  #  buffer full setpoint at item 1
  if ((bunyan_globals$setpoint == 1) && (bunyan_globals$countsincemark == bunyan_globals$memlines)) {
    return(bunyan_globals$loglines)
  }

  if (bunyan_globals$countsincemark > bunyan_globals$memlines) {
    # Buffer is full and marker overwritten
    # Report the last buffer worth of lines from the starting position
    if (bunyan_globals$memstart == bunyan_globals$memlines ) {
      #  no wrap case, buffer is in order, last message in last position
      report <- bunyan_globals$loglines
    } else {
      report <- c( bunyan_globals$loglines[(bunyan_globals$memstart + 1):bunyan_globals$memlines],
                   bunyan_globals$loglines[1:bunyan_globals$memstart])
    }
  } else {  # Marker and end are both is within buffer
    # The buffer retains the  marker position message. Report from there to countsincemark
    if (bunyan_globals$memstart == bunyan_globals$memlines) {
      # the end is at the end of the buffer, no wrap
      report <- bunyan_globals$loglines[bunyan_globals$septoint:bunyan_globals$memlines]
    } else {
      if ((bunyan_globals$setpoint + bunyan_globals$countsincemark) > bunyan_globals$memlines) {
        # wrap condition
        report <- c(bunyan_globals$loglines[bunyan_globals$setpoint:bunyan_globals$memlines],
                    bunyan_globals$loglines[1:bunyan_globals$memstart])
      } else { 
        # Simplest no wrap case from marker to last log line written
        report <- bunyan_globals$loglines[bunyan_globals$setpoint:bunyan_globals$memstart]
      }
    }
  }
  return(report)
}
