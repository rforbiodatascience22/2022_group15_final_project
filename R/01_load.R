# Load libraries ----------------------------------------------------------
library("tidyverse")
library("fs")

# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")

# Make our own class to deal with the date columns being different from the default
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d-%b-%y") )

# Load data and wrangle data ----------------------------------------------
my_data_raw <- read.csv(file = "data/_raw/BRCA2.csv", 
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
                                       'myDate',
                                       'myDate',
                                       'factor'))

<<<<<<< HEAD
# Wrangle data ------------------------------------------------------------
#my_data <- my_data_raw %>% 
#  mutate(Gender_bool = case_when(Gender == 'FEMALE' ~ 1,
#                                 Gender == 'MALE' ~ 0),
#         Tumor_Stage_bool = case_when(Tumour_Stage == 'I' ~ 1,
#                                      Tumour_Stage == 'II' ~ 2,
#                                      Tumour_Stage == 'III' ~ 3),
#         ER.status_bool = case_when(ER.status == 'Negative' ~ 0,
#                                    ER.status == 'Positive' ~ 1),
#         PR.status_bool = case_when(PR.status == 'Negative' ~ 0,
#                                    PR.status == 'Positive' ~ 1),
#         HER2.status_bool = case_when(HER2.status == 'Negative' ~ 0,
#                                      HER2.status == 'Positive' ~ 1),
#         
#         
#         .keep = "unused")


# tumor stage romer --> int
# dates should not be strings, not dates 
# booleans 

=======
>>>>>>> 85b26842536f5e1a50d578c7a12727791412510e
# Write data --------------------------------------------------------------
write_csv(x = my_data_raw, 
          file = "data/01_my_data.csv")

