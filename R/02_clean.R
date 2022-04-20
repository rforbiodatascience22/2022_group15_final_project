# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")

# Load data ---------------------------------------------------------------
<<<<<<< HEAD
my_data <- read.csv(file = "data/01_my_data.csv")
=======
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
>>>>>>> 85b26842536f5e1a50d578c7a12727791412510e


# Wrangle data ------------------------------------------------------------
my_data_clean <- my_data %>% 
  drop_na(Patient_Status)


# Write data --------------------------------------------------------------
<<<<<<< HEAD
write.csv(x = my_data_clean,
=======
write_csv(x = my_data_clean,
>>>>>>> 85b26842536f5e1a50d578c7a12727791412510e
          file = "data/02_my_data_clean.csv")
