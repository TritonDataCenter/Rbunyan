\name{bunyanSetLog}
\alias{bunyanSetLog}
\title{Starts bunyan JSON message logging at
supplied logging threshold to file or memory buffer}
\usage{
  bunyanSetLog(level, logpath, logfile, memlines,
    jsonout = FALSE, verbose = FALSE)
}
\arguments{
  \item{level}{string, required. 'TRACE', 'DEBUG', 'INFO',
  'WARN', 'ERROR', 'FATAL' Level threshold required to
  trigger log write. You can change the level on an
  existing log.}

  \item{logpath}{optional. The log path.  When not
  specified uses getwd. Windows paths must include drive
  letter.}

  \item{logfile}{filename optional. The log file name - no
  path.}

  \item{memlines}{integer optional. Number of lines to
  cache in memory to retrieve with bunyanTraceback() Set to
  0 to disable memory logging. 100 is default.  Dump
  contents of memory buffer wth bunyanBuffer().  Does not
  resize or change an existing bunyan memory buffer.}

  \item{jsonout}{logical. Set to TRUE for bunyanLog to
  return the JSON formatted log string. This function
  itself will also return a JSON formatted log
  initialization INFO message.}

  \item{verbose}{logical. Set to TRUE to write logged
  messages to the console.

  You can opt to write JSON lines using another log package
  To do this, disable bunyan's output and memory logs with:
  bunyanSetLog(level=0, memlines=0, jsonout=TRUE) Then
  retrieve the JSON formatted bunyan format log msg msg <-
  bunyanLog.info(msg="This is a log message") to pass to
  the alternate logging package.}
}
\description{
  Initializes Bunyan Style Error Logging. Set threshold for
  logging with level parameter. Memory buffer is sized with
  memlines parameter. Log location is set with logpath and
  logfile. This function itself writes the first log
  message. Use bunyanStopLog to end logging.
}

