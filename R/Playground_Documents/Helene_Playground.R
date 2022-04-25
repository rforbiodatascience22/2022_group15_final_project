# Load libraries ----------------------------------------------------------
library("tidyverse")
library("fs")


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")


# Load data ---------------------------------------------------------------
my_data_clean_aug <- read.csv(file = "data/03_my_data_clean_aug.csv")


# Wrangle data ------------------------------------------------------------
my_data_clean_aug %>% ...


# Model data
my_data_clean_aug %>% ...


# Visualise data ----------------------------------------------------------
my_data_clean_aug %>%
  ggplot(mapping = aes(x = Patient_Status,
                       y = Diff_Time_Days)) +
  geom_point() 
  


# Write data --------------------------------------------------------------
write_tsv(...)
ggsave(...)