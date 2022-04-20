# Load libraries ----------------------------------------------------------
library("tidyverse")
library("fs")


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")

setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d-%b-%y") )

# Load data ---------------------------------------------------------------
my_data_raw <- read.csv(file = "data/_raw/BRCA2.csv", 
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
                                       'myDate',
                                       'myDate',
                                       'factor'))

my_data_raw %>% 
  count(Tumour_Stage == 'III')


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

# Write data --------------------------------------------------------------
write.csv(x = my_data, 
          file = "data/01_my_data.csv")


