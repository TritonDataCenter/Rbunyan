\name{bunyanTracebackN}
\alias{bunyanTracebackN}
\title{Count of new messages above level threshold after setpoint}
\usage{
  bunyanTracebackN()
}
\description{
  Returns the number of threshold passing log messages
  encountered since bunyanSetpoint first called. Note that
  only the first call to bunyanSetpoint is used, subsequent
  calls are ignored. Use bunyanClearSetpoint to clear
  before setting a new setpoint.
}
\keyword{bunyan,}
\keyword{setpoint}

