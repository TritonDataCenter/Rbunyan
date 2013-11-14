# Roxygen Comments bunyanSetLog.R
#' Initializes Bunyan Style Error Logging
#'
#' @param level string, required. 'TRACE', 'DEBUG', 'INFO', 
#' 'WARN', 'ERROR', 'FATAL' Level required to trigger log write.
#'
#  @param logpath path optional. The log path, default when
#' not specified is the home directory of the account. Windows
#' paths must include drive letter.
#'
#' @param logfile filename required. The log file name - no path
#'
#' @param memlines integer required. Number of lines to cache
#' in memory to retrieve with bunyanLogTail()  Set to 0 to disable
#' memory logging
#'
#' bunyanSetLog(level='DEBUG') logs last 1000 messages to memory
#' bunyanSetLog(level='INFO', logfile="myprogram.log") logs 
#' of level INFO and above are written to myprogram.log in user's
#' home directory
#' bunyanSetLog(level='TRACE', logpath=getwd(), logfile="myprogram.log")
#' writes to myprogram.log in current working directory
#'
#' Default bunyanSetLog() initializes with memory logging at INFO level

bunyanSetLog
function(level, logpath, logfile, memlines=20 )  <- {

  validlevel <- c(TRACE = 10, DEBUG=20, INFO=30, WARN=40, ERROR=50, FATAL=60)
  # Corresponding Bunyan levels

  level_num <- match(level,validlevel)
  if (is.na(level_num)) {
    level_num <- match(level, names(validlevel))
    if (is.na(level_num)) {
      # Assume the worst
      level_num <- validlevel[match(level, 50)]
    }
  }

  if(!missing(logfile)) {  
    if(missing(logpath)) { # User's home directory
      if (.Platform$OS.type == "unix") {
         home <- Sys.getenv("HOME")
         log <- paste(home, "/", logfile, sep="")
      } else {
        # Windows
        homedrive <- Sys.getenv("HOMEDRIVE")
        homepath <- Sys.getenv("HOMEPATH")
        home <- paste(homedrive, homepath, sep="")
        log <- paste(home, "\\" ,logfile, sep="")
      }
    } else { # User specified directory
      if (.Platfor$OS.type == "unix") {
         log <- paste(logpath, "/", logfile,sep="")
      } else { #Windows, assume user put in drive letter...
         log <- paste(logpath, "\\", logfile,sep="")
      }
    }
  } else {
    # missing log file implies we are collecting in memory only
    log <- NULL
  }


  if (file.exists(log) == TRUE) {
  # Appending
    log_con <- file(log,"at")
  } else {
  # Create empty log write first line
    log_con <- file(log,"wt")
  }

  # Set up bunyan environment 

  assign("level_num", level_num, envir=bunyan_globals)
  assign("log", log, envir=bunyan_globals)
  assign("log_con", log_con, envir=bunyan_globals)
  r_version <- as.character(getRversion())
  name <- paste("R-",r_version, sep="")
  assign("name", name, envir=bunyan_globals)
  # Hostname
  hostname <- as.character(Sys.info()["nodename"])
  assign("hostname", hostname, envir=bunyan_globals)
  assign("validlevels", validlevels, envir=bunyan_globals)
  # Process ID
  pid <- Sys.getpid()
  assign("pid", pid, envir=bunyan_globals)
  if (memlines > 0) {
    loglines <- character(memlines)
    assign("loglines", loglines, envir=bunyan_globals) # the log array 
    assign("memlines", memlines, envir=bunyan_globals)  # size of array
    assign("memstart", 1, envir=bunyan_globals) # start of wrapped array 
    assign("linecount", 1, envir=bunyan_globals) # total number of lines logged
    assign("setpoint", 1, envir=bunyan_globals) # setpoint to report new items from
    assign("countsincemark", 1, envir=bunyan_globals) # of lines since setpoint logged
    assign("bunyan_initialized", TRUE, envir=bunyan_globals) # ready
  }
  # Add a log initialize message to the system
  if (log == NULL) {
    msg = paste("Initialized bunyan log at level: ", level, " in memory, keeping", memlines, " log entries." ,sep="")
  } else {
    msg = paste("Initialized bunyan log at level: ", level, " to file: ", log, sep="")
  }
  bunyanLog(level = level, msg = msg)
}
