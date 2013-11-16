.onLoad <- function(libname, pkgname) {
  # Environment for manta values
  assign("bunyan_globals", new.env(), envir=parent.env(environment()))
  # Uninitialied state
  assign("bunyan_initialized", FALSE, envir=bunyan_globals)
  assign("bunyan_memlines", 0, envir=bunyan_globals)
}


