# Load libraries ----------------------------------------------------------
library("tidyverse")
library(dplyr)
library(stringr)


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")
#https://seantrott.github.io/binary_classification_R/

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv")


# Wrangle data ------------------------------------------------------------

#Long data with proteins and expressions
BRCA_data_long <- my_data_raw %>%
  drop_na() %>%
  select(matches('Protein')) %>%
  pivot_longer(cols = everything(),
               names_to = 'Protein',
               values_to = 'Expression_Level')

my_data_clean_aug <- my_data_raw %>%
  drop_na() %>%      
  mutate(Age_Group = case_when(Age <= 30 ~ "Under 30",
                               Age >= 31 & Age <= 40 ~ "31-40",
                               Age >= 41 & Age <= 50 ~ "41-50",
                               Age >= 51 & Age <= 60 ~ "51-60",
                               Age >= 61 & Age <= 70 ~ "61-70",
                               Age >= 71 & Age <= 80 ~ "71-80",
                               Age > 80 ~ "Over 80" )) %>% 
  mutate(Age_Group = factor(Age_Group,
                            levels = c("Under 30",
                                       "31-40",
                                       "41-50",
                                       "51-60",
                                       "61-70",
                                       "71-80",
                                       "Over 80")))
# Visualise data ----------------------------------------------------------

#Age distribution
ggplot(my_data_clean_aug, aes(x = Age_Group)) + 
  geom_bar(color = "black",
           fill = "skyblue1",
           width = 0.8) +
  labs(x = 'Age Group',
       y = 'Count') +
  theme_bw()

# Percentage of histology
myplot <- my_data_clean %>%     
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
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1))

ggsave(filename = 'percent_histology.png',
       path = '/Cloud/project/results')

ggsave(filename = 'helene_playground_Time_Diff_plot.png',
       path = 'R/Playground_Documents')
#Plotting up the boxplot for each protein
BRCA_data_long %>% 
ggplot(
       aes(x = Protein,
           y = Expression_Level)) +
  geom_boxplot() +
  theme_bw() +
  labs(y = str_replace(deparse(substitute(Expression_Level)),'_',' '))

# Splitting and Joining on ID--------------------------------------------------------------

#Dataset1
my_data_protein <- my_data_clean %>%
  select(Patient_ID,
         matches('Protein'))

#Dataset2
my_data_histology <- my_data_clean %>%
  select(Patient_ID,
         Histology)

#Dataset3 with ID, protein and histology
my_data_joined1 <- my_data_protein %>%
  inner_join(my_data_histology,
             by = 'Patient_ID')

#Dataset4 with ID, Protein and Expression level
my_data_protein_long <- my_data_protein %>%
  pivot_longer(cols = matches('Protein'),
               names_to = 'Protein',
               values_to = 'Expression_Level')

my_data_joined2 <- my_data_protein_long %>%
  outer_join(my_data_histology,
             by = 'Patient_ID')

#Dataset5 with empty cells
subset1 <- my_data_clean[1:100, 1:4]
subset2 <- my_data_clean[101:200, c(1,5:8)]

#A dataset that is empty by inner joining
my_data_joined3 <- subset1 %>%
  inner_join(subset2,
             by = 'Patient_ID')

#Only subset1
my_data_joined4 <- subset1 %>%
  left_join(subset2,
             by = 'Patient_ID')

#subset1 and subset 2 have only patient ID un common
my_data_joined5 <- subset1 %>%
  full_join(subset2,
            by = 'Patient_ID')

#-------

#Making functions
boxplot <- function(data, attribute1, attribute2){
  my_plot <- ggplot(data,
                    aes(x = {{attribute1}},
                        y = {{attribute2}})) +
    geom_boxplot() +
    theme_bw() +
    labs(x = str_replace(deparse(substitute(attribute1)),'_',' '),
         y = str_replace(deparse(substitute(attribute2)),'_',' '))
  
  return(my_plot)
}

boxplot(BRCA_data_long,
        Protein,
        Expression_Level)

scatterplot <- function(data, attribute1, attribute2){
  my_plot <- ggplot(data,
                    aes(x = {{attribute1}},
                        y = {{attribute2}})) +
    geom_point() +
    theme_bw() +
    labs(x = str_replace(deparse(substitute(attribute1)),'_',' '),
         y = str_replace(deparse(substitute(attribute2)),'_',' '))
  
  return(my_plot)
}

scatterplot(my_data,
        Protein1,
        Protein2)

histogram_count <- function(data, attribute){
  my_plot <- ggplot(data,
                    aes(x = {{attribute}})) +
    geom_bar() +
    theme_bw() +
    labs(x = str_replace(deparse(substitute(attribute)),'_',' '),
         y = 'Count')
  
  return(my_plot)
}

ggsave(filename = 'aldis_playground_percentage_lot.png',
       path = 'R/Doc')