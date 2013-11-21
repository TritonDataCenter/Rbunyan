\name{bunyanStopLog}
\alias{bunyanStopLog}
\title{Stops logging to file, removes memory buffer}
\usage{
  bunyanStopLog()
}
\description{
  Stops bunyan logging, closing the log file connection.
  Memory buffer is cleared, reset to 0 length. Logging can
  be restarted with bunyanSetLog.
}
\keyword{bunyan,}
\keyword{logs}

