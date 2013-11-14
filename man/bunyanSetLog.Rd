\name{bunyanSetLog}
\alias{bunyanSetLog}
\title{Initializes Bunyan Style Error Logging}
\usage{
  bunyanSetLog(level, logpath, logfile, memlines = 20)
}
\arguments{
  \item{level}{string, required. 'TRACE', 'DEBUG', 'INFO',
  'WARN', 'ERROR', 'FATAL' Level required to trigger log
  write.}

  \item{logpath}{optional. The log path, default when not
  specified is the home directory of the account. Windows
  paths must include drive letter.}

  \item{logfile}{filename required. The log file name - no
  path}

  \item{memlines}{integer required. Number of lines to
  cache in memory to retrieve with bunyanLogTail() Set to 0
  to disable memory logging}
}
\description{
  Initializes Bunyan Style Error Logging
}

