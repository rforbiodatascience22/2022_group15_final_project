# Load libraries ----------------------------------------------------------
library("tidyverse")
library("fs")

# Define functions --------------------------------------------------------
source(file = "/cloud/project/R/99_project_functions.R")


# Load data ---------------------------------------------------------------
my_data_clean <- read.csv(file = "/cloud/project/data/02_my_data_clean.csv")


# Wrangle data ------------------------------------------------------------

# Adding a column for time difference.
my_data_clean_aug <- my_data_clean %>% 
  mutate(Diff_Time_Days = difftime(Date_of_Last_Visit, Date_of_Surgery, unit = 'days'),
         Patient_Status_Binary = case_when(Patient_Status == "Alive" ~ 0,
                                           Patient_Status == "Dead" ~ 1))

# Write data --------------------------------------------------------------
write_csv(x = my_data_clean_aug,
          file = "/cloud/project/data/03_my_data_clean_aug.csv")
