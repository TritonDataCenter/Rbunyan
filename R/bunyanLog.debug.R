# Roxygen Comments bunyanLog.debug
#' Logs a message at DEBUG level 20
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
bunyanLog.debug <- 
function(msg, req, res, version) {
  bunyanLog(msg=msg, level=20, req=req, res=res, version=version)
}
