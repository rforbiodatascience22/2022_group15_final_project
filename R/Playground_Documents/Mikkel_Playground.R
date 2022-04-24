# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
#source(file = "R/99_project_functions.R")


# Load data ---------------------------------------------------------------
#my_data_clean


# Wrangle data ------------------------------------------------------------
#my_data_clean %>% ...


# Model data
#my_data_clean %>% ...


# Visualise data ----------------------------------------------------------
#my_data_clean %>% ...


# Write data --------------------------------------------------------------
#write_tsv(...)
#ggsave(...)

#### -------- factorials
my_data_clean %>% 
  ggplot(mapping = aes(x = Gender)) + 
  geom_bar()

my_data_clean %>% 
  ggplot(mapping = aes(x = Tumour_Stage)) + 
  geom_bar()

my_data_clean %>% 
  ggplot(mapping = aes(x = Histology)) + 
  geom_bar()

my_data_clean %>% 
  ggplot(mapping = aes(x = ER.status)) + 
  geom_bar()

my_data_clean %>% 
  ggplot(mapping = aes(x = PR.status)) + 
  geom_bar()

my_data_clean %>% 
  ggplot(mapping = aes(x = HER2.status)) + 
  geom_bar()

my_data_clean %>% 
  ggplot(mapping = aes(x = Surgery_type)) + 
  geom_bar()


#### -------- Tumour Stage vs protein colored by patient status
my_data_clean %>% 
  ggplot(mapping = aes(x = Tumour_Stage,
                       y = Protein1,
                       color=Patient_Status)) + 
  geom_boxplot()

my_data_clean %>% 
  ggplot(mapping = aes(x = Tumour_Stage,
                       y = Protein2,
                       color=Patient_Status)) + 
  geom_boxplot()

my_data_clean %>% 
  ggplot(mapping = aes(x = Tumour_Stage,
                       y = Protein3,
                       color=Patient_Status)) + 
  geom_boxplot()

my_data_clean %>% 
  ggplot(mapping = aes(x = Tumour_Stage,
                       y = Protein4,
                       color=Patient_Status)) + 
  geom_boxplot()

#### -------- continues 
my_data_clean %>% 
  ggplot(mapping = aes(x = Protein1,
                       y = Protein2)) + 
  geom_point()

my_data_clean %>% 
  ggplot(mapping = aes(x = Protein1,
                       y = Protein3)) + 
  geom_point()

my_data_clean %>% 
  ggplot(mapping = aes(x = Protein1,
                       y = Protein4)) + 
  geom_point()

my_data_clean %>% 
  ggplot(mapping = aes(x = Protein2,
                       y = Protein3)) + 
  geom_point()

my_data_clean %>% 
  ggplot(mapping = aes(x = Protein2,
                       y = Protein4)) + 
  geom_point()

my_data_clean %>% 
  ggplot(mapping = aes(x = Protein3,
                       y = Protein4)) + 
  geom_point()


my_data_clean %>% 
  ggplot(mapping = aes(x = Age)) + 
  geom_bar()



#### -------- cancertypes vs ages
my_data_clean %>% 
  ggplot(mapping = aes(x = Surgery_type,
                       y = Age)) + 
  geom_violin()

#### -------- cancertypes vs ages
my_data_clean %>% 
  ggplot(mapping = aes(x = Surgery_type,
                       y = Age)) + 
  geom_violin()



#### -------- cancertypes vs protein
my_data_clean %>% 
  ggplot(mapping = aes(x = Surgery_type,
                       y = Protein1)) + 
  geom_violin()

my_data_clean %>% 
  ggplot(mapping = aes(x = Surgery_type,
                       y = Protein2)) + 
  geom_violin()

my_data_clean %>% 
  ggplot(mapping = aes(x = Surgery_type,
                       y = Protein3)) + 
  geom_violin()

my_data_clean %>% 
  ggplot(mapping = aes(x = Surgery_type,
                       y = Protein4)) + 
  geom_violin()


#### -------- HER2 Status vs protein
my_data_clean %>% 
  ggplot(mapping = aes(x = HER2.status,
                       y = Protein1)) + 
  geom_violin()

my_data_clean %>% 
  ggplot(mapping = aes(x = HER2.status,
                       y = Protein2)) + 
  geom_violin()

my_data_clean %>% 
  ggplot(mapping = aes(x = HER2.status,
                       y = Protein3)) + 
  geom_violin()

my_data_clean %>% 
  ggplot(mapping = aes(x = HER2.status,
                       y = Protein4)) + 
  geom_violin()





