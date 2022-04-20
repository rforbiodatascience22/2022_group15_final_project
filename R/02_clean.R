# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")

# Load data ---------------------------------------------------------------
my_data <- read.csv(file = "data/01_my_data.csv",
         colClasses = c('character',
                        'numeric',
                        'factor',
                        'numeric',
                        'numeric',
                        'numeric',
                        'numeric',
                        'factor',
                        'factor',
                        'factor',
                        'factor',
                        'factor',
                        'factor',
                        'Date',
                        'Date',
                        'factor'))


# Wrangle data ------------------------------------------------------------
my_data_clean <- my_data %>% 
  drop_na(Patient_Status)


# Write data --------------------------------------------------------------
write_csv(x = my_data_clean,
          file = "data/02_my_data_clean.csv")
