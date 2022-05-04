# Load libraries ----------------------------------------------------------
library("tidyverse")
library("fs")
library("patchwork")

# Define functions --------------------------------------------------------
source(file = "/cloud/project/R/99_project_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_csv(file = "/cloud/project/data/03_my_data_clean_aug.csv",
                              show_col_types = FALSE)

# Visualise data ----------------------------------------------------------

#Recreation of age group by cancer type from Kaggle
my_data_clean_aug %>% 
  ggplot(mapping = aes(x = Age_Group,
                       fill = Histology)) +
  geom_bar(color = "black") +
  facet_wrap(~ Histology) +
  scale_fill_manual(values=c("#1f77b4", "#fb0100", "#128001")) +
  labs(title = 'Age ranges for each cancer type',
       x = 'Age ranges',
       y = 'Count') +
  our_theme(legend_position = 'none',
            x_angle = 45) +
  scale_y_continuous(breaks = seq(0, 100, 5))

ggsave(filename = 'recreation_age_groups_by_cancer_type.png',
       path = '/cloud/project/results')

#Percent of histology recreation from kaggle:
my_data_clean_aug %>%     
  group_by(Histology) %>% 
  summarise(N = 100*(n() / nrow(my_data_clean_aug))) %>%
  ggplot(aes(x = Histology,
             y = N)) +
  geom_bar(stat="identity",
           color = 'black',
           fill = '#1f77b4') +
  labs(title = 'Total cancer types in dataset by percentage',
       y = 'Percentage of patients') +
  geom_text(aes(label=str_c(round(N,
                                  digits = 2),'%')),
            position = position_dodge(width=0.4),
            vjust=-0.2) +
  ylim(0,80) +
  our_theme(x_angle = 45)

ggsave(filename = 'recreation_percent_histology.png',
       path = '/cloud/project/results')

#Protein expression by histology

#Making new a new variable Protein
BRCA_data_long <- my_data_clean_aug %>%
  select(matches('Protein'), Histology) %>%
  pivot_longer(cols = 1:4,
               names_to = 'Protein',
               values_to = 'Expression_Level')

BRCA_data_long %>% 
  ggplot(data = .,
         mapping = aes(x = Expression_Level,
                       color = Histology)) + 
  geom_density() + 
  facet_wrap(~Protein,
             nrow=4) +
  our_theme() + 
  labs(title = 'Histology density by protein',
       x = 'Expression Level', 
       y = 'Density')

ggsave(filename = 'histology_density_by_protein.png',
       path = '/cloud/project/results')

# The distribution of the month that people die in.
my_data_clean_aug %>%
  filter(!is.na(Death_Month)) %>% 
  ggplot(mapping = aes(x = Death_Month)) +
  geom_bar(color = 'black',
           fill = '#1f77b4') +
  our_theme() +
  labs(title = 'Distribution of death month',
       x = 'Death Month',
       y = 'Count') 

ggsave(filename = 'death_month_distribution.png',
       path = '/cloud/project/results')

# Age distribution
# The age of the patients looks normal distributed in the boksplot.
my_data_clean_aug %>% 
  ggplot(mapping = aes(x = Age)) + 
  geom_boxplot(color = 'black',
               fill = '#1f77b4') + 
  labs(title = 'Boxplot of Age',
       x = 'Age',
       y = 'Count') +
  our_theme()

ggsave(filename = 'age_boxplot.png',
       path = '/cloud/project/results')

# Age distribution
my_data_clean_aug %>% 
  ggplot(mapping = aes(x = Age)) + 
  geom_bar(color = 'black',
               fill = '#1f77b4') + 
  labs(title = 'Distribution of Age',
       x = 'Age',
       y = 'Count') +
  our_theme()

ggsave(filename = 'age_bar_distribution.png',
       path = '/cloud/project/results')

# Barplot of the tumour stages filled by patient status 
# Most patients have tumour stage II. Most of the patients are alive.
my_data_clean_aug %>% 
  ggplot(aes(x = Tumour_Stage,
             group = Patient_Status)) + 
  geom_bar(aes(y = ..prop.., 
               fill = factor(..x..)), 
           stat="count",
           color = 'black') +
  scale_fill_manual(values=c("#1f77b4", "#fb0100", "#128001")) +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), 
            stat= "count", 
            vjust = -.2) +
  labs(title = 'Distribution of tumour stage and patient status',
       x = "Tumour Stage",
       y = '') +
  facet_grid(~Patient_Status) +
  scale_y_continuous(labels = scales::percent) +
  our_theme(legend_position = 'none')

ggsave(filename = 'distribution_of_tumour_stage_and_patient_status.png',
       path = '/cloud/project/results')



