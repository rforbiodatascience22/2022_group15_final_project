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
my_data_clean %>% 
  filter(Age < 50) %>% 
  ggplot(mapping = aes(
    y = Protein4,
    x = Patient_Status,
    fill = Tumour_Stage)) + 
  geom_boxplot(colour="#FF9999")

p2 <- my_data_clean %>% 
  filter(Age < 50) %>% 
  ggplot(mapping = aes(
    y = Protein4,
    x = Patient_Status,
    fill = Tumour_Stage)) + 
  geom_boxplot(colour="#FF9999")

p1+p2


my_data_clean %>% 
  ggplot(mapping = aes(
    x = Patient_Status,
    y = Surgery_type,
    color = Tumour_Stage)) + 
  geom_point()


library("dplyr")
#Creating average expression variable
clean2 <- my_data_clean %>% 
  (mutate(average_expression = ((my_data_clean[,"Protein1"]) + (my_data_clean[,"Protein2"]) + (my_data_clean[,"Protein3"]) + (my_data_clean[,"Protein4"]))/4)) %>% 
  as_tibble()

avg_vector <- (average_expression = ((my_data_clean[,"Protein1"]) + (my_data_clean[,"Protein2"]) + (my_data_clean[,"Protein3"]) + (my_data_clean[,"Protein4"]))/4) %>% 
  as_tibble()
clean3 <- tibble(my_data_clean,avg_vector)

clean2[,"average_expression"] %>% as_tibble()
as_tibble(clean2[,"average_expression"],validate=TRUE)

clean3 %>% filter(,Tumour_Stage == "III") %>% 
  ggplot(mapping = aes(
    x = Protein1,
    y = Protein4,
    color=average_expression)) +
  scale_y_continuous(expand = c(0,0)) + 
  geom_smooth()


clean4 %>% group_by(Tumour_Stage) %>%  ggplot(aes(x  = Protein1, fill = Tumour_Stage)) + 
  geom_histogram()
clean4

#clean4 <- clean3 %>% filter(Date_of_Last_Visit < '2022-01-01')

Augment_var = my_data_clean_aug %>% filter(,Tumour_Stage == "III") %>% filter(,Histology == "Infiltrating Ductal Carcinoma")


# Write data --------------------------------------------------------------
write_tsv(...)
ggsave(...)