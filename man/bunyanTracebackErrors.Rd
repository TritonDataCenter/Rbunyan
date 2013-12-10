\name{bunyanTracebackErrors}
\alias{bunyanTracebackErrors}
\title{Count of errors above level threshold of 50 after setpoint}
\usage{
  bunyanTracebackErrors()
}
\description{
  Returns the number of ERROR/FATAL log messages
  encountered since bunyanSetpoint first called. Note that
  only the first call to bunyanSetpoint is used, subsequent
  calls are ignored. Use bunyanClearSetpoint to clear
  before setting a new setpoint.
}
\keyword{bunyan,}
\keyword{setpoint}

