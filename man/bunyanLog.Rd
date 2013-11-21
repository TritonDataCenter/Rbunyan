\name{bunyanLog}
\alias{bunyanLog}
\title{Logs a message}
\usage{
  bunyanLog(msg, level, req, res, version)
}
\arguments{
  \item{msg}{optional. Error to report - R struct passed to
  toJSON}

  \item{level}{string or numeric, required. 'TRACE',
  'DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL' Level required
  to trigger log write.}

  \item{req}{optional. An http style request R struct}

  \item{res}{optional. An http style response R struct}

  \item{version}{optional. A user specified version R
  struct}
}
\description{
  Log errors, warnings, debug and trace messages bunyan
  style, with JSON formatted machine readable logs, and a
  memory buffer for traceback. Supports one log file and
  memory log. For more than one log file, the JSON emitted
  Can be used with other logging packages.
}

