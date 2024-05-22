# Julia's Dummy Project for the UU Workshop **Best Practices for Writing Reproducible Code**

Dear reader, 

This Project was created for the purposes of the Utrecht University Course “Best Practices for Writing Reproducible Code” and it contains only a small subset of the work that was actually done. The project was altered so that it can stand on its own and so that the code works. Please be mindful and forgiving if some details are not 100% clear.


## Project Structure

The project structure distinguishes three kinds of folders:
- read-only (RO): not edited by either code or researcher
- human-writeable (HW): edited by the researcher only.
- project-generated (PG): folders generated when running the code; these folders can be deleted or emptied and will be completely reconstituted as the project is run.


```
.
├── .gitignore
├── CITATION.cff
├── LICENSE
├── README.md
├── requirements.txt
├── data               <- All project data, ignored by git
│   ├── processed      <- The final, canonical data sets for the statistical analysis. (PG)
│   ├── raw            <- The original (synthesized), immutable data dump. (RO)
│   └── temp           <- Intermediate data that has been transformed or in this case simulated. (PG)
├── docs               <- Documentation notebook for users (HW)
│   ├── manuscript     <- Manuscript source, e.g., LaTeX, Markdown, etc. (HW)
│   └── reports        <- Other project reports and notebooks (e.g. Jupyter, .Rmd) (HW)
├── results
│   ├── figures        <- Figures for the manuscript or reports (PG)
│   └── output         <- Other output for the manuscript or reports (PG)
└── R                  <- Source code for this project (HW)
├───renv               <- This fodler collects all packages used in this project and several subfolders (not important)
│   ├───library
│   │   └───windows
│   │       └───R-4.4
contined.

```

## Usage

To use this Project, there are a few things to take into consideration, which will be listed below.

### 1. Access



The Project can be accessed by clicking on the .Rproj file.
This file will open up the entire project, including all folders outlined above. By utilizing this file, the relative paths will be set correctly.

### 2. Add the data

The data for this project will be shared separately. Please make sure you store the shared data file in the sub folder raw  of the data folder.

### 3. Workflow

#### A. Packages needed 

Please use the following code to install all packages you need. They will be imported at the start of their respective scripts where they are used.

```
packages <- c("car",         #for vif() to calculate variance inflation factors
              "effects",     #effect displays for linear, generalized linear, and mixed effects models
              "ggeffects",   #for marginal effects and adjusted predictions in tidy data frames for plotting using ggplot
              "ggthemes",    #some extra themes, geoms, and scales for 'ggplot2'
              "gtools",      #functions to assist in R programming
              "infer",       #for rep_sample_n(), which allows for repeated sampling
              "knitr",       #data manipulation
              "nlme",        #fitting gls and lme models 
              "patchwork",   #to compose multi plots 
              "Rcpp",        #C++ interface for R; if I do not load this sometimes tidyverse does not load correctly
              "tidyverse",   #collection of packages, including dyplr, ggplot2, tidyr, tibble, stringr, etc. 
              "vegan",       #calculating biodiversity metrics - needed for the Wang et al. 2019 function
              "viridis",     #pretty, color blind friendly colours
              "viridisLite"  #pretty, color blind friendly colours
  )
  
install.packages(packages)

``` 


#### B. The order in which to run the scripts

The scripts needed to replicate the work are numerated. All un-numerated scripts are functions sourced in those. 
Please run the numerated scripts in their order from 01 - 03 to ensure the required data is generated.

**NOTE:** *The file 01_simulation takes a few minutes to run - don't worry if the result is not displayed right away.* 


## Add a citation file
Create a citation file for your repository using [cffinit](https://citation-file-format.github.io/cff-initializer-javascript/#/)

## License

This project is licensed under the terms of the [MIT License](/LICENSE).



`sessionInfo()` from May 22nd 2024:

```
R version 4.4.0 (2024-04-24 ucrt)
Platform: x86_64-w64-mingw32/x64
Running under: Windows 11 x64 (build 22631)

Matrix products: default


locale:
[1] LC_COLLATE=English_United States.utf8  LC_CTYPE=C                            
[3] LC_MONETARY=English_United States.utf8 LC_NUMERIC=C                          
[5] LC_TIME=English_United States.utf8    

time zone: Europe/Rome
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] ggeffects_1.5.2   effects_4.2-2     nlme_3.1-164      viridis_0.6.5     viridisLite_0.4.2 ggplot2_3.5.1    
 [7] car_3.1-2         carData_3.0-5     knitr_1.46        tidyr_1.3.1       dplyr_1.1.4       vegan_2.6-4      
[13] lattice_0.22-6    permute_0.9-7     TempPackage_1.0   docstring_1.0.0  

loaded via a namespace (and not attached):
 [1] gtable_0.3.5      xfun_0.43         insight_0.19.11   vctrs_0.6.5       tools_4.4.0       generics_0.1.3   
 [7] parallel_4.4.0    tibble_3.2.1      fansi_1.0.6       cluster_2.1.6     pkgconfig_2.0.3   Matrix_1.7-0     
[13] desc_1.4.3        lifecycle_1.0.4   compiler_4.4.0    stringr_1.5.1     munsell_0.5.1     mitools_2.4      
[19] survey_4.4-2      htmltools_0.5.8.1 yaml_2.3.8        pillar_1.9.0      nloptr_2.0.3      MASS_7.3-60.2    
[25] boot_1.3-30       abind_1.4-5       tidyselect_1.2.1  digest_0.6.35     stringi_1.8.3     purrr_1.0.2      
[31] splines_4.4.0     rprojroot_2.0.4   fastmap_1.1.1     grid_4.4.0        colorspace_2.1-0  cli_3.6.2        
[37] magrittr_2.0.3    survival_3.5-8    pkgbuild_1.4.4    utf8_1.2.4        withr_3.0.0       scales_1.3.0     
[43] roxygen2_7.3.1    rmarkdown_2.26    nnet_7.3-19       lme4_1.1-35.3     gridExtra_2.3     evaluate_0.23    
[49] mgcv_1.9-1        rlang_1.1.3       Rcpp_1.0.12       glue_1.7.0        DBI_1.2.2         xml2_1.3.6       
[55] pkgload_1.3.4     rstudioapi_0.16.0 minqa_1.2.6       R6_2.5.1          fs_1.6.4         

```
*All packages as well as their dependencies and their versions can be found in and downloaded from the "renv" folder*

      This can be done by installing the R package renv 
      
      `install.packages("renv")`
      
      and using the restore() function
      
      `renv::restore()`

I hope you will have fun going through my code! :) 
