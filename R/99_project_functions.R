# Load libraries ----------------------------------------------------------
library("tidyverse")
library("fs")
library("patchwork")

my_data_clean_aug <- read.csv(file = "/cloud/project/data/03_my_data_clean_aug.csv")

# Plotting an atribute 
histrogram_count <- function(data, atribute){
  output <- ggplot(data, mapping = aes(x = {{atribute}})) + 
    geom_bar(fill = 'dodgerblue4') + 
    labs(y = 'Count')
    theme_minimal(base_family = 'Avenir',
                  base_size = 10) 
  
  return(output)
}

histrogram_count(data = my_data_clean_aug, atribute = Patient_Status)

# Plotting protein expression vs. type of cancer
dens_protein_BRCA <- function(data, proteins, attribute){
  data %>%
    select({{proteins}},{{attribute}}) %>%
    pivot_longer(cols = 1:length({{proteins}}),
                 names_to = 'Protein',
                 values_to = 'Expression_Level') %>% 
    ggplot(data = .,
           mapping = aes(x = Expression_Level,
                         color = {{attribute}})) + 
    geom_density() + 
    facet_wrap(~Protein,
               nrow=4) +
    theme_classic()
}


#### PCA ANALYSIS ####
pca_vis_BRCA <- function(data, PC1, PC2){
  data <- my_data_clean_aug
  
  data_wide <- data %>% 
    select(Age,matches("Protein"),Patient_Status_Binary) %>% 
    mutate(Patient_Status_Binary = case_when(Patient_Status_Binary == 0 ~ '0',
                                             Patient_Status_Binary == 1 ~ '1')) %>% 
    mutate_at(c("Age","Protein1","Protein2","Protein3","Protein4"), 
              ~(scale(.) %>%  as.vector))
  
  data_wide %>% 
    select(where(is.numeric)) %>%
    prcomp(scale = TRUE) %>% 
    augment(data_wide) %>% 
    ggplot(aes(x = .fittedPC1, 
               y = .fittedPC2, 
               color = Patient_Status_Binary)) + 
    geom_point(size = 1.5) +
    scale_color_discrete() +
    theme_classic() + 
    background_grid()
}


