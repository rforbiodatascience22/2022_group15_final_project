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

ggsave(filename = 'recreation_age_groups_by_cancer_type.png',
       path = '/cloud/project/results')

#Percent of histology recreation from kaggle:
# Percentage of histology
my_data_clean %>%     
  group_by(Histology) %>% 
  summarise(N = 100*(n() / nrow(my_data_raw))) %>%
  ggplot(aes(x = Histology,
             y = N)) +
  geom_bar(stat="identity",
           color = 'black',
           fill = 'skyblue1') +
  labs(y = 'Percentage of patients') +
  geom_text(aes(label=str_c(round(N,
                                  digits = 2),'%')),
            position = position_dodge(width=0.4),
            vjust=-0.2) +
  ylim(0,80) +
  theme_minimal(base_family = 'Avenir',
                base_size = 10) +
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1))

ggsave(filename = 'percent_histology.png',
       path = '/Cloud/project/results')

# Write data --------------------------------------------------------------
write_tsv(...)
ggsave(...)