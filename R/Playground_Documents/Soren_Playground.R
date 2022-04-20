##### NOTES #####
# I will perform a logistic regression model to see if there is a correlation between,
#  the patient status, and the corresponding protein levels.
# If this is the case for multiple proteins, then maybe we should do a PCA of these, 
#  to make some nice illustrations. 
# 
# Sidenote: I do not have high hopes for good results here, but bad results are still results.
#################

# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")


# Load data ---------------------------------------------------------------
my_data_clean <- read_tsv(file = "data/02_my_data_clean.tsv")


# Wrangle data ------------------------------------------------------------
modeldat <- my_data_clean %>% 
  select(Patient_Status, Protein1, Protein2, Protein3, Protein4)

temp <- modeldat %>% 
  pivot_longer(data = .,
               cols = -Patient_Status,
               names_to = "Protein",
               values_to = "Expr_level") %>% 
  group_by("Protein") %>% 
  nest() %>% 
  ungroup()

gravier_clean_long <- gravier_clean %>% 
  pivot_longer(data = .,
               cols = -outcome,
               names_to = "Gene",
               values_to = "log2_expr_level")

# Model data
my_data_clean %>% ...


# Visualise data ----------------------------------------------------------
my_data_clean %>% ...


# Write data --------------------------------------------------------------
# write_tsv(...)
# ggsave(...)