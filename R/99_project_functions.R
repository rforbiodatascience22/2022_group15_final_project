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


