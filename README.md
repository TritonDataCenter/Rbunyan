bunyan
=========

Joyent bunyan style JSON error logging for R
See the mantaRSDK for use with RCURL. 
For more about Bunyan and Node.js
see https://github.com/trentm/node-bunyan
and http://blog.nodejs.org/2012/03/28/service-logging-in-json-with-bunyan/
GitHub home - www.github.com/cwvhogue/bunyan


UNDER CONSTRUCTION


### Windows Installation
install_github() requires Rtools in addition to the R package 
http://cran.r-project.org/bin/windows/Rtools



### From R ###


Install:
```
install.packages("devtools")
library(devtools)
install_github("bunyan", username="cwvhogue")
```

Test:
```
library(bunyan)
help(bunyan)
bunyanSetLog(level='INFO',file="mylog.log")
bunyanLog(level='INFO',msg="Log test")
```

Remove:
```
library(bunyan)
detach(package:bunyan, unload=TRUE)
```
