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

```

## Usage

in order to use this Project, there are a few things to take into consideration, which will be listed below.

### 1. Access

The Project can be accessed by clicking on the .Rproj file.
This file will open up the entire project, including all folders outlined above. By utlizing this file, the relative paths will be set correctly.

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


## Add a citation file
Create a citation file for your repository using [cffinit](https://citation-file-format.github.io/cff-initializer-javascript/#/)

## License

This project is licensed under the terms of the [MIT License](/LICENSE).
