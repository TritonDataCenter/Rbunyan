# Roxygen Comments bunyanLog
#' Logs a message
#' 
#' Log errors, warnings, debug and trace messages  bunyan style, with JSON 
#' formatted machine readable logs, and a memory buffer for traceback.  
#' Supports one log file and memory log. For more than one log file, the JSON
#' emitted Can be used with other logging packages.
#'
#'
#' @param msg optional. Error to report - R struct passed to toJSON
#'
#' @param level string or numeric, required. 'TRACE', 'DEBUG', 'INFO',
#' 'WARN', 'ERROR', 'FATAL' Level required to trigger log write.
#'
#' @param req optional. An http style request R struct 
#'
#' @param res optional. An http style response R struct 
#'
#' @param version optional. A user specified version R struct
#'
#'
#' @export
bunyanLog <- 
function(msg, level, req, res, version) {

  if (bunyan_globals$bunyan_initialized == FALSE) {
    bunyanSetLog() # default is memory logging at INFO level
  }

  if(missing(level)) {
   level_num <- 30 # Assume INFO
  } else {
    level_num <- as.numeric(bunyan_globals$validlevel[match(level, bunyan_globals$validlevel)])
    if (is.na(level_num)) { # no, match string
      level_num <- as.numeric(bunyan_globals$validlevel[match(level, names(bunyan_globals$validlevel))])
      if (is.na(level_num)) { # not matched
      level_num <- as.numeric(level)  # Assume Custom user level number
      }
    }
  }


  if (level_num >= bunyan_globals$level_num) {

    ### Bunyan timestamp
    time <- format(Sys.time(), "%Y-%m-%dT%H:%M:%OS3Z")  

    ### R Namespace
    callfrom <-  capture.output(str(topenv(environment(sys.function(-1))), give.attr=FALSE))
    if (length(grep('namespace', callfrom)) < 1) {
     namespace <- "base"
    } else {
     namespace <- sub('.*namespace:([^>]+)>.*','\\1', callfrom)
    }

    ### Assemble message for JSON output

    tolog <- c(name = bunyan_globals$name,  #R version
               hostname = bunyan_globals$hostname, #Computer name
               pid = bunyan_globals$pid, # Process ID
               Rpackage = namespace, # Rpackage called from
               level = level_num #Log Level Number
              )

    if  (missing(req)) {
      if (missing(res))  {
         if (missing(msg)) {
           tolog <- c(tolog, time = time)
         } else {
           tolog <- c(tolog, msg = msg, time = time)
        }
      } else { # got res
        if (missing(msg)) {
          tolog <- c(tolog, res = res, time = time)
        } else { # got res, msg
          tolog <- c(tolog, res = res, msg = msg, time = time)
        }
      }
    } else { # got req 
      if (missing(msg)) {
        tolog <- c(tolog, req = req, time = time)
      } else {
        tolog <- c(tolog, req = req, msg = msg, time = time)
      } 
    }

    if (!missing(version)) {
      tolog <- c(tolog, v = version)
    }

    loglinef <- toJSON(tolog) 
    ## to make a one-liner JSON from log R object:
    ## this strips \n from JSON returned part of msg..
    logline <- gsub("\n","",loglinef)     

    #####
    # MEMORY logging into fixed array of JSON log strings, wraparound
    if (bunyan_globals$memlines > 0) {
      # Update memstart to place logline into next memory location
      if (bunyan_globals$memstart == bunyan_globals$memlines) { 
        # wraparound condition
        assign("memstart", 1, envir=bunyan_globals)
      } else {
        assign("memstart", bunyan_globals$memstart + 1, envir=bunyan_globals)
      }
      # Put JSON into array location
      bunyan_globals$loglines[bunyan_globals$memstart] <- logline
      # increment number of msgs logged in memory
      assign("linecount", bunyan_globals$linecount + 1, envir=bunyan_globals)
      # increment number of msgs since marker setpoint  
      if (bunyan_globals$setpoint != 0) {
        assign("countsincemark", bunyan_globals$countsincemark + 1, envir=bunyan_globals)
      }
    }

    ######
    #FILE logging
    if (bunyan_globals$logname != "")
      cat(logline, file=bunyan_globals$log_con, sep="\n", append=TRUE)

    #####
    # JSON output
    # Put in place in case someone wants to use bunyan JSON as messages to pass
    # to another R logging package, or wrap for improved readability on console
    if (bunyan_globals$jsonout == TRUE) return(logline)

    ####
    # Verbose output formatted as human readable JSON
    if (bunyan_globals$verbose == TRUE) {
      cat(loglinef,"\n")
    }
  }
}

