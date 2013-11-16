# Roxygen Comments bunyanSetLog.R
#' Initializes Bunyan Style Error Logging
#'
#' @param level string, required. 'TRACE', 'DEBUG', 'INFO', 
#' 'WARN', 'ERROR', 'FATAL' Level threshold required to 
#' trigger log write.
#'
#' @param logpath optional. The log path, default when
#' not specified is getwd. Windows  paths must include drive letter.
#'
#' @param logfile filename optional. The log file name - no path
#'
#' @param memlines integer required. Number of lines to cache
#' in memory to retrieve with bunyanTraceback()  Set to 0 to disable
#' memory logging
#'
#' @param jsonout logical requried. Set to TRUE so bunyanLog
#' returns the JSON formatted log string. This function itself
#' will also return a JSON formatted log initialization INFO message.
#'
#' You can opt to write JSON lines using another log package 
#' To do this, disable bunyan's output and memory logs with:
#' bunyanSetLog(level=0, memlines=0, jsonout=TRUE) 
#' Then retrieve the JSON formatted bunyan format log msg 
#' msg <- bunyanLog.info(msg="This is a log message")
#' to pass to the alternate logging package.
#'
#' @export
bunyanSetLog <-
function(level, logpath, logfile, memlines=20, jsonout=FALSE )  {

  validlevel <- c(TRACE = 10, DEBUG=20, INFO=30, WARN=40, ERROR=50, FATAL=60)
  # Corresponding Bunyan levels

  if(missing(level)) level <- 30 # Assume INFO

  level_num <- as.numeric(validlevel[match(level, validlevel)])
  if (is.na(level_num)) { # no, match string
    level_num <- as.numeric(validlevel[match(level, names(validlevel))])
    if (is.na(level_num)) { # not matched
    level_num <- as.numeric(level)  # Assume Custom user level number
    }
  }

  logname <- ""
  if(!missing(logfile)) {  
    if(missing(logpath)) { # Use Current directory
      if (.Platform$OS.type == "unix") {
         home <- getwd()
         logname <- paste(home, "/", logfile, sep="")
      } else {
        # Windows
        home <- getwd()
        logname <- paste(home, "\\" ,logfile, sep="")
      }
    } else { # User specified directory
      if (.Platform$OS.type == "unix") {
         logname <- paste(logpath, "/", logfile,sep="")
      } else { #Windows, assume user put in drive letter...
         logname <- paste(logpath, "\\", logfile,sep="")
      }
    }
  } else {
    # missing log file is ok
    logname <- ""
  }
 
#  cat("[",logname,"]","\n")

  if (nchar(logname) != 0) {
    if (file.exists(logname) == TRUE) {
    # Appending
      log_con <- file(logname,"at")
    } else {
    # Create empty log write first line
      log_con <- file(logname,"wt")
    }
  } else {
      log_con <- NULL
  }

  # Set up bunyan environment 

  assign("level_num", level_num, envir=bunyan_globals)
  assign("logname", logname, envir=bunyan_globals)
  assign("log_con", log_con, envir=bunyan_globals)
  assign("jsonout", jsonout, envir=bunyan_globals)
  r_version <- as.character(getRversion())
  name <- paste("R-",r_version, sep="")
  assign("name", name, envir=bunyan_globals)
  # Hostname
  hostname <- as.character(Sys.info()["nodename"])
  assign("hostname", hostname, envir=bunyan_globals)
  assign("validlevel", validlevel, envir=bunyan_globals)
  # Process ID
  pid <- Sys.getpid()
  assign("pid", pid, envir=bunyan_globals)
  assign("memlines", memlines, envir=bunyan_globals)  # size of array
  if (memlines > 0) {
    loglines <- character(memlines)
    assign("loglines", loglines, envir=bunyan_globals) # the log array 
    assign("memstart", 0, envir=bunyan_globals) # start of wrapped array 
    assign("linecount", 0, envir=bunyan_globals) # total number of lines logged
    assign("setpoint", 0, envir=bunyan_globals) # setpoint to report new items from
    assign("countsincemark", 0, envir=bunyan_globals) # of lines since setpoint logged
  }

  assign("bunyan_initialized", TRUE, envir=bunyan_globals) # ready

  # Log initialization message
  msg = paste("Initialized bunyan log at level: ", level, "=", level_num, sep="")
  
  if (memlines != 0) {
    msg = paste(msg, " Memory log line buffer: ", memlines ,sep="")
  }
  if (logname != "") {
    msg = paste(msg, " Log file: ", logname, sep="")
  }

  # Log the initialization messge
  json <- bunyanLog(level = level, msg = msg)
  if (jsonout == TRUE) {
    return(json)
  } 

}
