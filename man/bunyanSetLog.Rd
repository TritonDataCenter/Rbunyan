\name{bunyanSetLog}
\alias{bunyanSetLog}
\title{Initializes Bunyan Style Error Logging}
\usage{
  bunyanSetLog(level, logpath, logfile, memlines = 20,
    jsonout = FALSE)
}
\arguments{
  \item{level}{string, required. 'TRACE', 'DEBUG', 'INFO',
  'WARN', 'ERROR', 'FATAL' Level threshold required to
  trigger log write.}

  \item{logpath}{optional. The log path, default when not
  specified is getwd. Windows paths must include drive
  letter.}

  \item{logfile}{filename optional. The log file name - no
  path}

  \item{memlines}{integer required. Number of lines to
  cache in memory to retrieve with bunyanTraceback() Set to
  0 to disable memory logging}

  \item{jsonout}{logical requried. Set to TRUE so bunyanLog
  returns the JSON formatted log string. This function
  itself will also return a JSON formatted log
  initialization INFO message.

  You can opt to write JSON lines using another log package
  To do this, disable bunyan's output and memory logs with:
  bunyanSetLog(level=0, memlines=0, jsonout=TRUE) Then
  retrieve the JSON formatted bunyan format log msg msg <-
  bunyanLog.info(msg="This is a log message") to pass to
  the alternate logging package.}
}
\description{
  Initializes Bunyan Style Error Logging
}

