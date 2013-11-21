\name{bunyanClearSetpoint}
\alias{bunyanClearSetpoint}
\title{Clears memory setpoint}
\usage{
  bunyanClearSetpoint()
}
\description{
  Clears the memory buffer setpoint.  After clearing, if no
  log entries above level threshold, bunyanTraceback and
  bunyanTracebackN will return blank and 0 results This
  does not alter the contents of the buffer, which can be
  dumped at any time with bunyanBuffer. You must use
  bunyanClearSetpoint on an existing setpoint before
  setting a new one with bunyanSetpoint.
}
\keyword{bunyan,}
\keyword{setpoint}

