#' Rbunyan
#'
#' Joyent Rbunyan JSON error logging package
#'  
#'  R functions to log errors in structured JSON format
#'  to a log file. Also provides a memory buffer for tracing
#'  back log messages from a setpoint. This can be used to
#'  aggregate warnings and errors from multiple calls.
#'  Logging is to a single file only. Bunyan logs provide
#'  timestamps, hostnames, and process IDs for logs as well
#'  as log levels TRACE, DEBUG, INFO, WARN, ERROR, FATAL.
#'  Use examples are found in the mantaRSDK package using RCURL headers
#'  and other messages.  The JSON formatted messages can used with other 
#'  logging  packages by disabling the memory and file write components.
#'
#'  bunyanSetLog      - Starts logging to file, memory or both, set threshold
#'
#'  bunyanStopLog     - Stops logging to file, removes memory buffer 
#'
#'  bunyanLog         - Logs a message
#'
#'  bunyanLog.trace     - Logs message at TRACE level 10
#'
#'  bunyanLog.debug     - Logs message at DEBUG level 20
#'
#'  bunyanLog.info      - Logs message at INFO level 30
#'
#'  bunyanLog.warn      - Logs message at WARN level 40
#'
#'  bunyanLog.error     - Logs message at ERROR level 50
#'
#'  bunyanLog.fatal     - Logs message at FATAL level 60
#'
#'  bunyanSetpoint      - Sets marker in memory buffer at current level threshold
#'
#'  bunyanTraceback     - Get messages from memory after setpoint
#'
#'  bunyanTracebackN    - Count of new messages above level threshold after setpoint
#'
#'  bunyanBuffer        - Returns memory buffer 
#'
#'  bunyanClearSetpoint - Clears memory setpoint
#' 
#' ...
#' 
#' @references http://blog.nodejs.org/2012/03/28/service-logging-in-json-with-bunyan/
#' @import RJSONIO 
#' @name Rbunyan
#' @docType package
NULL
