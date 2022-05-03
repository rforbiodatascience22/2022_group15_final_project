# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
#source(file = "R/99_project_functions.R")

# Load data ---------------------------------------------------------------
my_data <- read.csv(file = "/cloud/project/data/01_my_data.csv",
        na.strings = '',
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

# Drop rows where:
## Patient status is not-available.
## Date_of_Last_Visit happens in the future (from when the dataset was last updated on Kaggle)
# Drop columns ER.status and PR.status as these are all positive

my_data_clean <- my_data %>% 
  drop_na(Patient_Status) %>% 
  filter(Date_of_Last_Visit < as.Date("2021-07-25")) %>% 
  select(-ER.status, -PR.status)

# This reduces the data from 341 observations to 307 observations

# Write data --------------------------------------------------------------
write_csv(x = my_data_clean,
          file = "/cloud/project/data/02_my_data_clean.csv")

