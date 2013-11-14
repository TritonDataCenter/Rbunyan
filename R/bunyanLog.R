# Roxygen Comments bunyanLog
#' Collects errors, information and warnings for log and success reports
#'
#' @param level string, required. 'TRACE', 'DEBUG', 'INFO',
#' 'WARN', 'ERROR', 'FATAL' Level required to trigger log write.
#'
#' @param msg optional. Error to report - R struct passed to toJSON
#'
#' @param req optional. An http style request R struct
#'
#' @param res optional. An http style response R struct
#'
#' @param version optional. A user specified version R struct
#'
#' @param mark logical optional. Mark this log entry as setpoint
#'
#' @param verbose logical. When TRUE msg appears on console
#'
#' 
bunyanLog
function(level, msg, req, res, version, mark=FALSE, verbose=FALSE)  <- {

  if (bunyan_globals$bunyan_initialized == FALSE) {
    bunyanSetLog() # default is memory logging at INFO level
  }

  # Bunyan levels
  validlevel <- bunyan_globals$validlevel

  level_num <- match(level,validlevel)
  if (is.na(level_num)) {
    level_num <- match(level, names(validlevel))
    if (is.na(level_num)) {
      # Assume the worst
      level_num <- validlevel[match(level, 50)]
    }
  }
  

 if (level_num < bunyan_globals$level_num) return

  ### Bunyan timestamp
  time <- format(Sys.time(), "%Y-%m-%dT%H:%M:%OS3Z")  

  ### Assemble message for JSON output

  tolog <- c(name = bunyan_globals$name,  #R version
             hostname = bunyan_globals$hostname, #Computer name
             pid = bunyan_globals$pid, # Process ID
             level = level_num, #Log Level Number
            )

  if ((missing(req)) && missing(res))) {
    if (missing(msg)) {
      tolog <- c(tolog, time = time))
    } else {
      tolog <- c(tolog, msg = msg, time = time)
    }
  } else { # Subobjects 
    if ((missing(req)) {
      if (missing(msg)) {
        tolog <- c(tolog, res = res, time = time))
      } else {
        tolog <- c(tolog, res = res, msg = msg, time = time)
      }
    } else { # res is the missing one
      if (missing(msg)) {
        tolog <- c(tolog, req = req, time = time)
      } else {
        tolog <- c(tolog, req = req, msg = msg, time = time)
      }
    }
  }

  if (!missing(version)) {
    tolog <- c(tolog, v = version)
  }

  logline <- toJSON(req) 
  ## to make a one-liner JSON from log R object:
  ## this strips \n from JSON returned part of msg..
  logline <- gsub("\n","",logline)     

  # MEMORY logging into fixed array of JSON log strings, wraparound
  if (bunyan_globals$memlines > 0) {
    # Update memstart to place logline into next memory location
    if (bunayn_globals$memstart == bunyan_globals$memlines) { 
      # wraparound
      assign("memstart", 1, envir=bunyan_globals)
    } else {
      assign("memstart", bunyan_globals$memstart + 1, envir=bunyan_globals)
    }
    # Put JSON into array location
    bunyan_globals$loglines[bunyan_globals$memstart] <- logline
    # mark this one if asked, reset counter
    if (mark == TRUE) { # reset
      assign("setpoint", bunyan_globals$memstart, envir=bunyan_globals)
      assign("countsincemark", 1, envir=bunyan_globals)
    }
    # increment number of msgs logged in memory
    assign("linecount", bunyan_globals$linecount + 1, envir=bunyan_globals)
    # increment number of msgs since marker setpoint 
    assign("countsincemark", bunyan_globals$countsincemark + 1, envir=bunyan_globals)
  }

  # NOTE when bunyan_globals$countsincemark > bunyan_globals$memlines then the marker
  # position no longer matters. We have filled the buffer and can only report from 
  # bunyan_globals$loglines[bunyan_globals$memstart + 1] to  
  # bunyan_globals$loglines[bunyan_globals$memlines] then wrap and report  
  # bunyan_globals$loglines[1] to  
  # bunyan_globals$loglines[memstart] 
  

  # When bunyan_globals$countsincemark <= bunyan_globals$memlines 
  # then the marker position matters, buffer is not full
  # The wrap condition is:
  # bunyan_globals$setpoint + bunyan_globals$countsincemark > bunyan_globals$memlines

  # if wrapping involved report:
  # bunyan_globals$loglines[bunyan_globals$setpoint] to  
  # bunyan_globals$loglines[bunyan_globals$memlines] then wrap and report  
  # bunyan_globals$loglines[1] to  
  # bunyan_globals$loglines[memstart]   

  # no wrapping involved, report 
  # bunyan_globals$loglines[bunyan_globals$setpoint] to  
  # bunyan_globals$loglines[memstart]   


  #FILE logging
  cat(logline, file=bunyan_globals$log_con, sep="\n", append=TRUE)

}
