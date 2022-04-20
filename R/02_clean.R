# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")


# Load data ---------------------------------------------------------------
my_data <- read.csv(file = "data/01_my_data.csv")


# Wrangle data ------------------------------------------------------------
my_data_clean <- my_data # %>% ...


# Write data --------------------------------------------------------------
write.csv(x = my_data_clean,
          file = "data/02_my_data_clean.csv")
