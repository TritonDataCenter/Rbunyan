.onLoad <- function(libname, pkgname) {
  # Environment for manta values
  assign("bunyan_globals", new.env(), envir=parent.env(environment()))
  # Uninitialied state
  assign("bunyan_initialize", FALSE, envir=bunyan_globals)
}


