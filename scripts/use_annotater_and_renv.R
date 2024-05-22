
install.packages('annotater')
install.packages('renv')


### use annotater through addins

library(annotater) # CRAN v0.2.3
library(dplyr)     # CRAN v1.1.4
library(tidyr)     # CRAN v1.3.1


### use renv

#### renv will only work for a given project file (Rproj) - so does not work without

library(renv)
# for every project we need to initialize/ativate for the current project
### this creates a lockfile which is meant for machines to read, not humans
renv:: init()

##this will create a renv folder withing my project directory

#update lockfile using 

# renv::restore() will load the content from the lockfile (keeping unique source, version etc. from the packages used)
### also useful for when a computer breaks
