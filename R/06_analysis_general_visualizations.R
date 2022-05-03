# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")


# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_csv(file = "data/03_my_data_clean_aug.csv")


# Wrangle data ------------------------------------------------------------
#my_data_clean_aug %>% ...


# Model data
#my_data_clean_aug %>% ...


# Visualise data ----------------------------------------------------------
#my_data_clean_aug %>% ...



#Recreation of plot from Kaggle:
my_data_clean_aug %>% 
  mutate(Age_Group = case_when(25 <= Age & Age < 30 ~ '25 to 30',
                               30 <= Age & Age < 35 ~ '30 to 35',
                               35 <= Age & Age < 40 ~ '35 to 40',
                               40 <= Age & Age < 45 ~ '40 to 45',
                               45 <= Age & Age < 50 ~ '45 to 50',
                               50 <= Age & Age < 55 ~ '50 to 55',
                               55 <= Age & Age < 60 ~ '55 to 60',
                               60 <= Age & Age < 65 ~ '60 to 65',
                               65 <= Age & Age < 70 ~ '65 to 70',
                               70 <= Age & Age < 75 ~ '70 to 75',
                               75 <= Age & Age < 80 ~ '75 to 80',
                               80 <= Age & Age < 85 ~ '80 to 85',
                               85 <= Age & Age < 90 ~ '85 to 90',
                               90 <= Age & Age < 95 ~ '90 to 95')) %>% 
  ggplot(mapping = aes(x = Age_Group,
                       fill = Histology)) +
  geom_bar() +
  facet_wrap(~ Histology) +
  scale_fill_manual(values=c("#1f77b4", "#fb0100", "#128001")) +
  labs(title = 'Age ranges for each cancer type',
       x = 'Age ranges',
       y = 'Count') +
  theme_minimal(base_family = 'Avenir',
                base_size = 10) +
  theme(axis.text.x = element_text(angle = 45, hjust=1),
        legend.position = 'none',
        plot.title = element_text(hjust = 0.5)) +
  theme(panel.grid.minor = element_line(colour="white", size=0.5)) +
  scale_y_continuous(breaks = seq(0, 100, 5))

ggsave(filename = 'helene_playground_Time_Diff_plot.png',
       path = 'R/Playground_Documents')



# Write data --------------------------------------------------------------
write_tsv(...)
ggsave(...)