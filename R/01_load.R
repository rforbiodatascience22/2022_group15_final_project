# Load libraries ----------------------------------------------------------
library("tidyverse")
library("fs")

# Make our own class to deal with the date columns being different from the default
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d-%b-%y") )

# Load data and wrangle data ----------------------------------------------
my_data_raw <- read.csv(file = "/cloud/project/data/_raw/BRCA2.csv",
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


# Write data --------------------------------------------------------------
write_csv(x = my_data_raw, 
          file = "/cloud/project/data/01_my_data.csv")

