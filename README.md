Rbunyan
=========

Joyent Rbunyan, Bunyan style JSON error logging for R
See the mantaRSDK for use with RCURL. 
For more about Bunyan and Node.js
see https://github.com/trentm/node-bunyan
and http://blog.nodejs.org/2012/03/28/service-logging-in-json-with-bunyan/
GitHub home - github.com/joyent/Rbunyan

Initial Release

### Windows Installation
install_github() requires Rtools in addition to the R package 
http://cran.r-project.org/bin/windows/Rtools


### From R ###


Install:
```
install.packages("devtools")
library(devtools)
install_github("Rbunyan", username="joyent")
```

Test:
```
library(Rbunyan)

#help(Rbunyan)
bunyanSetLog(level = 'INFO', memlines = 20, logfile = "mylog.log")
bunyanLog.info("Log test")
bunyanLog.error("This is an error")
bunyanSetpoint()
bunyanLog.trace("This will not appear in the log")
bunyanLog.fatal("I told you never to do that!")
bunyanLog.error("Another error")
bunyanLog.warn("Always wear clean underwear")
cat(bunyanTracebackN()," messages since bunyanSetpoint()")
bunyanTraceback()
bunyanBuffer()
bunyanSetLog(level = 'TRACE')
bunyanLog.trace("This will now appear in the log")
bunyanStopLog()
#
bunyanLog.error("Without bunyanSetLog, default is memory error logging at INFO level, 100 lines of log")
bunyanBuffer()
bunyanStopLog()
#
#
# This sets up the bunyan package for JSON string return 
# only so you can use them with alternative logging packages:
bunyanSetLog(level="0", memlines=0, jsonout=TRUE)
msg <- bunyanLog.error("This is erroneous")
cat(msg)
```

Remove:
```
library(bunyan)
detach(package:bunyan, unload=TRUE)
```
