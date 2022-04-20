# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")


# Load data ---------------------------------------------------------------
my_data <- read_tsv(file = "data/01_my_data.tsv")

# Make our own class to deal with the date columns being different from the default
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d-%b-%y") )

# Load data and wrangle data ----------------------------------------------
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

# Wrangle data ------------------------------------------------------------
my_data_clean <- my_data # %>% ...


# Write data --------------------------------------------------------------
write_tsv(x = my_data_clean,
          file = "data/02_my_data_clean.tsv")