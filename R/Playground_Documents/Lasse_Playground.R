# Load libraries ----------------------------------------------------------
library("tidyverse")

### Comments about what is done in this script:
# Basic visualisations, looking for linear correlations of some sort, and basic boxplots for now. 
#(Mostly nonsense right now, won't look properly at it till sunday again)


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")


# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv")


# Wrangle data ------------------------------------------------------------
my_data_clean_aug %>% ...


# Model data
my_data_clean_aug %>% ...


# Visualise data ----------------------------------------------------------
my_data_clean_aug %>% 
  ggplot(aes(x = Age, color=Tumour_Stage)) + 
  geom_histogram(alpha=0.5)


my_data_clean %>% 
  ggplot(mapping = aes(
    x = Patient_ID,
    y = Tumour_Stage,
    color=Protein1)) + 
  geom_point()


library(patchwork)
p1 <- my_data_clean %>% 
  ggplot(mapping = aes(
    x = Tumour_Stage,
    y = Protein1)) + 
  geom_boxplot(colour="009E73")

p2 <- my_data_clean %>% 
  ggplot(mapping = aes(
    x = Protein4,
    y = Tumour_Stage)) + 
  geom_boxplot(colour="#FF9999")

p1+p2

# Write data --------------------------------------------------------------
write_tsv(...)
ggsave(...)