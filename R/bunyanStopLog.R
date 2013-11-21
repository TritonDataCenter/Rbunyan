# Roxygen Comments bunyanStopLog
#' Stops logging to file, removes memory buffer 
#'
#' Stops bunyan logging, closing the log file connection.
#' Memory buffer is cleared, reset to 0 length.
#' Logging can be restarted with bunyanSetLog.
#'
#' @keywords bunyan, logs
#'
#' @export
bunyanStopLog <-
function() {
  if (bunyan_globals$bunyan_initialized != FALSE) {
  # Flush & close file handle 
  if (bunyan_globals$logname != "") {
    flush(bunyan_globals$log_con)
    close(bunyan_globals$log_con)
  }
  # Assign envir variables neutral entries
  assign("level_num", 0, envir=bunyan_globals)
  assign("logname", "", envir=bunyan_globals)
  assign("log_con", NULL, envir=bunyan_globals)
  assign("jsonout", FALSE, envir=bunyan_globals)
  assign("verbose", FALSE, envir=bunyan_globals)
  assign("name", "", envir=bunyan_globals)
  assign("hostname", "", envir=bunyan_globals)
  assign("validlevel", "", envir=bunyan_globals)
  assign("pid", "", envir=bunyan_globals)
  assign("memlines", 0, envir=bunyan_globals)  # size of array
  assign("loglines", "", envir=bunyan_globals) # the log array 
  assign("memstart", 0, envir=bunyan_globals) # start of wrapped array 
  assign("linecount", 0, envir=bunyan_globals) # total number of lines logged
  assign("setpoint", 0, envir=bunyan_globals) # setpoint to report new items from
  assign("countsincemark", 0, envir=bunyan_globals) # of lines since setpoint logged
  assign("bunyan_initialized", FALSE, envir=bunyan_globals) # ready
  }
}
