# Load libraries ----------------------------------------------------------
library("tidyverse")
library("fs")


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")


# Load data ---------------------------------------------------------------
my_data_raw <- read.csv(file = "data/_raw/BRCA2.csv", na.strings = '')


# Wrangle data ------------------------------------------------------------
my_data <- my_data_raw %>% 


# Write data --------------------------------------------------------------
write.csv(x = my_data,
          file = "data/01_my_data.csv")


