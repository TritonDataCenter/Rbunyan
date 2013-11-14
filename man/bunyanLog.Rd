\name{bunyanLog}
\alias{bunyanLog}
\title{Collects errors, information and warnings for log and success reports}
\usage{
  bunyanLog(level, msg, req, res, version, mark = FALSE,
    verbose = FALSE)
}
\arguments{
  \item{level}{string, required. 'TRACE', 'DEBUG', 'INFO',
  'WARN', 'ERROR', 'FATAL' Level required to trigger log
  write.}

  \item{msg}{optional. Error to report - R struct passed to
  toJSON}

  \item{req}{optional. An http style request R struct}

  \item{res}{optional. An http style response R struct}

  \item{version}{optional. A user specified version R
  struct}

  \item{mark}{logical optional. Mark this log entry as
  setpoint}

  \item{verbose}{logical. When TRUE msg appears on console}
}
\description{
  Collects errors, information and warnings for log and
  success reports
}

