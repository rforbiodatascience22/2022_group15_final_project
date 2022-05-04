# Load libraries ----------------------------------------------------------
library("tidyverse")
library("fs")

# Load data ---------------------------------------------------------------
my_data_clean <- read.csv(file = "/cloud/project/data/02_my_data_clean.csv")

# Wrangle data ------------------------------------------------------------

# Adding columns: Patient status in binary, age group and death month.
my_data_clean_aug <- my_data_clean %>% 
  mutate(Patient_Status_Binary = case_when(Patient_Status == "Alive" ~ 0,
                                           Patient_Status == "Dead" ~ 1),
         Age_Group = case_when(25 <= Age & Age < 30 ~ '25 to 30',
                               30 <= Age & Age < 35 ~ '30 to 35',
                               35 <= Age & Age < 40 ~ '35 to 40',
                               40 <= Age & Age < 45 ~ '40 to 45',
                               45 <= Age & Age < 50 ~ '45 to 50',
                               50 <= Age & Age < 55 ~ '50 to 55',
                               55 <= Age & Age < 60 ~ '55 to 60',
                               60 <= Age & Age < 65 ~ '60 to 65',
                               65 <= Age & Age < 70 ~ '65 to 70',
                               70 <= Age & Age < 75 ~ '70 to 75',
                               75 <= Age & Age < 80 ~ '75 to 80',
                               80 <= Age & Age < 85 ~ '80 to 85',
                               85 <= Age & Age < 90 ~ '85 to 90',
                               90 <= Age & Age < 95 ~ '90 to 95'),
         Death_Month = case_when(Patient_Status == 'Dead' ~ 
                       str_sub(Date_of_Last_Visit, 6, 7)))

# Write data --------------------------------------------------------------
write_csv(x = my_data_clean_aug,
          file = "/cloud/project/data/03_my_data_clean_aug.csv")
