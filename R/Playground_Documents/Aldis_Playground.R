# Load libraries ----------------------------------------------------------
library("tidyverse")


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
# Model data
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
my_data_clean %>%     
  group_by(Histology) %>% 
  summarise(N = 100*(n() / nrow(my_data_raw))) %>%
  ggplot(aes(x = Histology,
             y = N)) +
  geom_bar(stat="identity",
           color = 'black',
           fill = 'skyblue1') +
  labs(y = 'Percentage of patients') +
  geom_text(aes(label=paste0(round(N,
                                   digits = 2),'%')),
            position = position_dodge(width=0.4),
            vjust=-0.2) +
  ylim(0,80) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45,
                                   hjust = 1))

#Plotting up the boxplot for each protein
ggplot(BRCA_data_long,
       aes(x = Protein,
           y = Expression_Level,
           color = Protein)) +
  geom_boxplot() +
  theme_bw() +
  labs(y = 'Expression Level') +
  theme(axis.text.x=element_blank(),
        axis.title.x = element_blank())

# Write data --------------------------------------------------------------
write_tsv(...)
ggsave(...)