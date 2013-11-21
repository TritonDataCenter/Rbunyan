# Roxygen Comments bunyanLog.fatal
#' Logs a message at FATAL level 60
#'
#' Logger bunyan style, to write JSON formatted machine readable logs
#' and to keep JSON log lines in a memory buffer.  Can be used with
#' other logging packages.
#'
#'
#' @param msg optional. Error to report - R struct passed to toJSON
#'
#' @param req optional. An http style request R struct
#'
#' @param res optional. An http style response R struct
#'
#' @param version optional. A user specified version R struct
#'
#'
#' @export
bunyanLog.fatal <- 
  function(msg, req, res, version) {
bunyanLog(msg=msg, level=60, req=req, res=res, version=version)
}

