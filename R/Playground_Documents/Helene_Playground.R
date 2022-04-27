# Load libraries ----------------------------------------------------------
library("tidyverse")
library("fs")
library("patchwork")
library('dplyr')


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")


# Load data ---------------------------------------------------------------
my_data_clean_aug <- read.csv(file = "data/03_my_data_clean_aug.csv")


# Wrangle data ------------------------------------------------------------

my_data_clean_aug %>% 
  mutate(across(where(is.numeric), scale))

# Add column of death month.
# Most people die in winter time. 
my_data_clean_aug %>% mutate(Death_Month = 
                               case_when(Patient_Status == 'Dead' ~ 
                                           str_sub(Date_of_Last_Visit, 6, 7))) %>%
  filter(!is.na(Death_Month)) %>% 
  ggplot(mapping = aes(x = Death_Month)) +
  geom_bar() + 
  labs(x = 'Death Month',
       y = 'Count') +
  theme_minimal(base_family = "Avenir",
                base_size = 8)

ggsave(filename = 'helene_playground_DeathMonth_plot.png',
       path = 'R/Playground_Documents')



# Model data
# my_data_clean_aug %>% ...


# Visualise data ----------------------------------------------------------
# Density of protein expression level compared to tumour level.

# We seen that most of the patients have an expression level of 0 for protein
# 1, 3, and 4. 
# For protein 2, most patients have en expression level between 1 and 2.

p1 <- my_data_clean_aug %>%
  ggplot(mapping = aes(x = Protein1,
                       color = Tumour_Stage)) +
  geom_density() + 
  labs(x = 'Protein 1',
       y = 'Density') +
  theme_minimal(base_family = "Avenir",
                base_size = 8) +
  theme(legend.position="none")

p2 <- my_data_clean_aug %>%
  ggplot(mapping = aes(x = Protein2,
                       color = Tumour_Stage)) +
  geom_density() + 
  labs(x = 'Protein 2',
       y = 'Density') +
  theme_minimal(base_family = "Avenir",
                base_size = 8) +
  theme(legend.position="none")

p3 <- my_data_clean_aug %>%
  ggplot(mapping = aes(x = Protein3,
                       color = Tumour_Stage)) +
  geom_density() + 
  labs(x = 'Protein 3',
       y = 'Density') +
  theme_minimal(base_family = "Avenir",
                base_size = 8) +
  theme(legend.position="none")

p4 <- my_data_clean_aug %>%
  ggplot(mapping = aes(x = Protein4,
                       color = Tumour_Stage)) +
  geom_density() + 
  labs(x = 'Protein 4',
       y = 'Density') +
  theme_minimal(base_family = "Avenir",
                base_size = 8)

(p1+p2) / (p3+p4)

# Barplot of the tumour stages filled by patient status 
# Most patients have tumour stage II. Most of the patients are alive.
my_data_clean_aug %>% 
  ggplot(mapping = aes(x = Tumour_Stage,
         fill = Patient_Status)) + 
  geom_bar() + 
  labs(x = 'Tumour Stage',
       y = 'Count',
       legend = 'Patient Status') +
  theme_minimal(base_family = 'Avenir',
                base_size = 10)

# Tumour stage VS Histology: One of the patient in stage III have Mucinous Carcinoma 
my_data_clean_aug %>% 
  ggplot(mapping = aes(x = Tumour_Stage,
                       fill = Histology)) + 
  geom_bar() + 
  labs(x = 'Tumour Stage',
       y = 'Count',
       legend = 'Histology') +
  theme_minimal(base_family = 'Avenir',
                base_size = 10)


# Tumour stage VS ER.status: 
my_data_clean_aug %>% 
  ggplot(mapping = aes(x = Patient_Status,
                       fill = Tumour_Stage)) + 
  geom_bar() + 
  labs(x = 'Tumour Stage',
       y = 'Count',
       legend = 'ER.status') +
  theme_minimal(base_family = 'Avenir',
                base_size = 10)

# Age
# The age of the patient group is roughly normal distributed.
# Mean is a little under 60
my_data_clean_aug %>% 
  ggplot(mapping = aes(x = Age)) + 
  geom_boxplot() + 
  labs(x = 'Age',
       y = 'Count') +
  theme_minimal(base_family = 'Avenir',
                base_size = 10)

ggsave(filename = 'helene_playground_AgePlot.png',
       path = 'R/Playground_Documents')

# Boxplot of difference in date of surgery to date of last visit
my_data_clean_aug %>% 
  ggplot(mapping = aes(x = Diff_Time_Days)) + 
  geom_boxplot() + 
  labs(x = 'Difference in date of sugrgery to date of last visit',
       y = 'Count') +
  theme_minimal(base_family = 'Avenir',
                base_size = 10)

ggsave(filename = 'helene_playground_Time_Diff_plot.png',
       path = 'R/Playground_Documents')


# Write data --------------------------------------------------------------
write_tsv(...)
ggsave(...)