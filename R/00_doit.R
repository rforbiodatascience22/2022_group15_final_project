# All packages are loaded in 01_load.R script

# Run all scripts ---------------------------------------------------------
source(file = "/cloud/project/R/01_load.R")
source(file = "/cloud/project/R/02_clean.R")
source(file = "/cloud/project/R/03_augment.R")
source(file = "/cloud/project/R/04_analysis_general_visualizations.R")
source(file = "/cloud/project/R/05_analysis_PCA.R")
source(file = "/cloud/project/R/06_analysis_logistic_regression.R")
rmarkdown::render("/cloud/project/doc/Presentation.Rmd")
rstudioapi::viewer("/cloud/project/doc/Presentation.html")
