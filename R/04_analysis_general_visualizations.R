# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")


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
  summarise(N = 100*(n() / nrow(my_data_raw))) %>%
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
  

ggsave(filename = 'percent_histology.png',
       path = '/cloud/project/results')

#Protein expression by histology



BRCA_data_long <- my_data_clean_aug %>%
  select(matches('Protein'),Histology) %>%
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
  theme_classic()

# Write data --------------------------------------------------------------
write_tsv(...)
ggsave(...)