# Load libraries ----------------------------------------------------------
library("tidyverse")
library("fs")

# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")


# Load data ---------------------------------------------------------------
my_data_clean <- read.csv(file = "data/02_my_data_clean.csv")


# Wrangle data ------------------------------------------------------------

# Adding a column for time difference.
my_data_clean %>% 
  mutate(Date_of_Surgery = as.Date(Date_of_Surgery, format = "%d-%b-%y"),
         Date_of_Last_Visit = as.Date(Date_of_Last_Visit, format = "%d-%b-%y"),
         Diff_Time_Days = difftime(Date_of_Last_Visit, Date_of_Surgery, unit = 'days'))


# Write data --------------------------------------------------------------
write_tsv(x = my_data_clean_aug,
          file = "data/03_my_data_clean_aug.tsv")
