# Roxygen Comments bunyanTraceback
#'  Get messages from memory after setpoint
#'
#'  Reports the last JSON lines in the bunyan memory buffer log 
#'  encountered since the last call to  
#'  bunyanSetpoint above the threshold set by bunyanSetLog
#'
#' @param level optional relevant error threshold level to view
#  string or number e.g. 'ERROR', 50, 
#'
#' @keywords bunyan, setpoint, traceback
#'
#'
#'
#' @export
bunyanTraceback <-
function(level) {

 if(missing(level)) {
   level_num <- bunyan_globals$level_num # Current level setting in Log
  } else {
    level_num <- as.numeric(bunyan_globals$validlevel[match(level, bunyan_globals$validlevel)])
    if (is.na(level_num)) { # no, match string
      level_num <- as.numeric(bunyan_globals$validlevel[match(level, names(bunyan_globals$validlevel))])
      if (is.na(level_num)) { # not matched
      level_num <- as.numeric(level)  # Assume Custom user level number
      }
    }
  }


  report <- ""

  # no memory buffer, return nothing
  if (bunyan_globals$memlines == 0) return(report)

  # no return unless bunyanSetpoint called and something logged
  if (bunyan_globals$setpoint == 0) return(report)
  if (bunyan_globals$countsincemark == 0) return(report)

  #  buffer full setpoint at item 1
  if ((bunyan_globals$setpoint == 1) && (bunyan_globals$countsincemark == bunyan_globals$memlines)) {
    report <- bunyan_globals$loglines
  } else {
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
  }
  if (report[1] != "") {
   # extract items > supplied level

   # callback to return level number from JSON line
    matchErr <- function(x) {
      Rline <- fromJSON(x)
      line_level = as.numeric(Rline[which(match(names(Rline),"level") == TRUE)])
    }

    relevant_lines <- unlist(lapply(report,matchErr))
    report <- report[relevant_lines >= level_num ]
  }

  return(report)
}
