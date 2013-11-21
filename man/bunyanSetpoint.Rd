\name{bunyanSetpoint}
\alias{bunyanSetpoint}
\title{Sets marker in memory logging buffer for catching new messages}
\usage{
  bunyanSetpoint()
}
\description{
  Sets a marker in the Bunyan log marking the start of log
  buffer space after which logged errors and warnings may
  be retrieved or counted with bunyanTraceback and
  bunyanTracebackN. If a setpoint already exists, calls are
  ignored, they must be explicitally cleared with
  bunyanClearSetpoint.
}
\keyword{bunyan,}
\keyword{setpoint}

