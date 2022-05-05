# Load libraries ----------------------------------------------------------
# Loaded in 01_load.R script

# Define functions --------------------------------------------------------
source(file = "/cloud/project/R/99_project_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- load_data_clean_aug()

# Visualise data ----------------------------------------------------------

#Recreation of age group by cancer type from Kaggle
my_data_clean_aug %>% 
  ggplot(mapping = aes(x = Age_Group,
                       fill = Histology)) +
  geom_bar(color = "black") +
  facet_wrap(vars(Histology)) +
  scale_fill_manual(values=c("#1f77b4", "#fb0100", "#128001")) +
  labs(title = 'Age ranges for each cancer type',
       x = 'Age ranges',
       y = 'Count') +
  our_theme(legend_position = 'none',
            x_angle = 45) +
  scale_y_continuous(breaks = seq(0, 100, 5))

ggsave(filename = 'recreation_age_groups_by_cancer_type.png',
       width = 13.74,
       height = 4.33,
       units = "in",
       path = '/cloud/project/results')

#Percent of histology recreation from kaggle:
my_data_clean_aug %>%     
  group_by(Histology) %>% 
  summarise(percent = 100*(n() / nrow(my_data_clean_aug))) %>%
  ggplot(mapping = aes(x = Histology,
             y = percent)) +
  geom_bar(stat="identity",
           color = 'black',
           fill = '#1f77b4') +
  labs(title = 'Recreation: Total cancer types in dataset by percentage',
       x = 'Type of cancer',
       y = 'Percentage of patients [%]') +
  geom_text(aes(label=str_c(round(percent,
                                  digits = 2),
                            '%')),
            position = position_dodge(width=0.4),
            vjust=-0.2) +
  ylim(0,80) +
  our_theme(x_angle = 45) +
  scale_x_discrete(labels=c("Infiltrating Ductal Carcinoma" = "Infiltrating\nDuctal\nCarcinoma",
                            "Mucinous Carcinoma" = "Mucinous\nCarcinoma",
                            "Infiltrating Lobular Carcinoma" = "Infiltrating\nLobular\nCarcinoma"))

ggsave(filename = 'recreation_percent_histology.png',
       width = 3.82,
       height = 4.02,
       units = "in",
       path = '/cloud/project/results')

#Protein expression by histology

#Making new a new variable Protein
dens_protein_BRCA(data = my_data_clean_aug,
                  proteins = c('Protein1','Protein2','Protein3','Protein4'),
                  attribute = "Histology")

ggsave(filename = 'histology_density_by_protein.png',
       width = 8,
       height = 4,
       units = "in",
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
       width = 8,
       height = 4,
       units = "in",
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
       width = 8,
       height = 4,
       units = "in",
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
       width = 8,
       height = 4,
       units = "in",
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
            vjust =-0.15,
            ) +
  labs(title = 'Distribution of tumour stage and patient status',
       x = "Tumour Stage",
       y = '') +
  facet_wrap(vars(Patient_Status)) +
  scale_y_continuous(labels = scales::percent) +
  our_theme(legend_position = 'none')

ggsave(filename = 'distribution_of_tumour_stage_and_patient_status.png',
       width = 8,
       height = 3,
       units = "in",
       path = '/cloud/project/results')


#---- dead/alive plot
my_data_clean_aug %>%     
  group_by(Tumour_Stage,
           Patient_Status) %>% 
  summarise(n=n()) %>% 
  #group_by(Tumour_Stage) %>% 
  mutate(percent=100*n/sum(n)) %>% 
  ungroup() %>% 
  ggplot(mapping = aes(x = Tumour_Stage,
                       y = percent,
                       fill = Tumour_Stage)) + 
  geom_bar(stat="identity",
           color = 'black') +
  scale_fill_manual(name = 'Tumour_Stage',
                    values = c("#1f77b4", "#fb0100", "#128001")) +
  facet_wrap(vars(Patient_Status)) + 
  geom_text(aes(label=str_c(round(percent,
                                  digits = 2),
                            '%')),
            position = position_dodge(width=0.4),
            vjust=-0.2) +
  labs(title = 'Tumour stage vs. Patient Status',
       x = "Tumour Stage",
       y = 'Percent') +
  ylim(0,90) +
  our_theme(legend_position = 'none')

ggsave(filename = 'distribution_of_tumour_stage_and_patient_status.png',
       width = 8,
       height = 4,
       units = "in",
       path = '/cloud/project/results')

