# Load libraries ----------------------------------------------------------
library("tidyverse")
library("fs")
library("patchwork")
library("broom")
library("ggplot2")
library("cowplot")

# Load data
my_data_clean_aug <- read.csv(file = "/cloud/project/data/03_my_data_clean_aug.csv",
                              na.strings = '',
                              colClasses = c('character',
                                             'numeric',
                                             'factor',
                                             'numeric',
                                             'numeric',
                                             'numeric',
                                             'numeric',
                                             'factor',
                                             'factor',
                                             'factor',
                                             'factor',
                                             'Date',
                                             'Date',
                                             'factor',
                                             'numeric'))

#my_data_clean_aug <- read.csv(file = "/cloud/project/data/03_my_data_clean_aug.csv")

# Function for main plot theme
our_theme <- function(legend_position = 'right', 
                      x_angle = 0){
  theme_minimal(base_family = 'Avenir',
                base_size = 10) +
  theme(axis.text.x = element_text(angle = x_angle, hjust=1),
          legend.position = legend_position,
          plot.title = element_text(hjust = 0.5),
          panel.grid.minor = element_line(colour="white", 
                                          size=0.5))
}

# Plotting an atribute 
histrogram_count <- function(data, atribute){
  output <- ggplot(data, mapping = aes(x = {{atribute}})) + 
    geom_bar(fill = 'dodgerblue4') + 
    labs(y = 'Count') +
    our_theme()
  
  return(output)
}
#histrogram_count(data = my_data_clean_aug, atribute = Patient_Status)

# Plotting protein expression vs. type of cancer
dens_protein_BRCA <- function(data, proteins, attribute){
  data %>%
    select({{proteins}},{{attribute}}) %>%
    pivot_longer(cols = 1:length({{proteins}}),
                 names_to = 'Protein',
                 values_to = 'Expression_Level') %>%
    ggplot(data = .,
           mapping = aes_string(x = "Expression_Level",
                                color = attribute)) +
    ggplot2::labs(x = "Expression Level",
                  y = "Density") +
    geom_density() +
    facet_wrap(~Protein,
               nrow=4) +
    theme_classic() +
    theme(legend.position = "bottom")
}

### Old version below - can properly be removed
# Plotting protein expression vs. type of cancer
# dens_protein_BRCA <- function(data, proteins, attribute){
#   data %>%
#     select({{proteins}},{{attribute}}) %>%
#     pivot_longer(cols = 1:length({{proteins}}),
#                  names_to = 'Protein',
#                  values_to = 'Expression_Level') %>% 
#     ggplot(data = .,
#            mapping = aes(x = Expression_Level,
#                          color = {{attribute}})) + 
#     geom_density() + 
#     facet_wrap(~Protein,
#                nrow=4) +
#     our_theme()
# }


#### PCA ANALYSIS ####

pca_vis_BRCA <- function(data, PC1, PC2, Attribute="Patient_Status"){
  # Renaming PC inputs
  PC_1 = str_c(".fitted",PC1)
  PC_2 = str_c(".fitted",PC2)
  
  # Select and scale data
  data_wide <- my_data_clean_aug %>% 
    select("Age",matches("Protein"),Attribute) %>% 
    mutate_at(c("Age","Protein1","Protein2","Protein3","Protein4"), 
              ~(scale(.) %>% as.vector))
  
  # Perform PCA and visualize
  data_wide %>% 
    select(where(is.numeric)) %>%
    prcomp(scale = TRUE) %>% 
    augment(data_wide) %>% 
    ggplot(aes_string(x = PC_1, 
                      y = PC_2,
                      color = Attribute)) + 
    geom_point(size = 1.5) +
    scale_color_discrete() + 
    our_theme(legend_position = "bottom") +
    background_grid()
}

# pca_vis_BRCA <- function(data, PC1, PC2){
#   data_wide <- data %>%
#     select(Age,matches("Protein"),Patient_Status_Binary) %>%
#     mutate(Patient_Status_Binary = case_when(Patient_Status_Binary == 0 ~ '0',
#                                              Patient_Status_Binary == 1 ~ '1')) %>%
#     mutate_at(c("Age","Protein1","Protein2","Protein3","Protein4"),
#               ~(scale(.) %>%  as.vector))
#   
#   data_wide %>%
#     select(where(is.numeric)) %>%
#     prcomp(scale = TRUE) %>%
#     augment(data_wide) %>%
#     ggplot(aes(x = .fittedPC1,
#                y = .fittedPC2,
#                color = Patient_Status_Binary)) +
#     geom_point(size = 1.5) +
#     scale_color_discrete() +
#     theme_classic() +
#     background_grid() +
#     theme(legend.position = "bottom")
# }

### Old version below - can properly be removed
# pca_vis_BRCA <- function(data, PC1, PC2){
#   data_wide <- data %>% 
#     select(Age,matches("Protein"),Patient_Status_Binary) %>% 
#     mutate(Patient_Status_Binary = case_when(Patient_Status_Binary == 0 ~ '0',
#                                              Patient_Status_Binary == 1 ~ '1')) %>% 
#     mutate_at(c("Age","Protein1","Protein2","Protein3","Protein4"), 
#               ~(scale(.) %>%  as.vector))
#   
#   data_wide %>% 
#     select(where(is.numeric)) %>%
#     prcomp(scale = TRUE) %>% 
#     augment(data_wide) %>% 
#     ggplot(aes(x = .fittedPC1, 
#                y = .fittedPC2, 
#                color = Patient_Status_Binary)) + 
#     geom_point(size = 1.5) +
#     scale_color_discrete() +
#     theme_classic() + 
#     background_grid()
# }


# Boxplot - factorial as x, nummeric as y.
boxplot_BRCA <- function(data, attribute1, attribute2, attribute3){
  my_plot <- data %>%
    ggplot2::ggplot(ggplot2::aes_string(x = attribute1,
                                        y = attribute2,
                                        color = attribute3)) +
    ggplot2::geom_boxplot() +
    ggplot2::labs(x = stringr::str_replace(attribute1,'_',' '),
                  y = attribute2) +
    ggplot2::theme_classic() +
    ggplot2::theme(legend.position = "bottom")
  return(my_plot)
}

# Violin - factorial as x, nummeric as y.
violin_BRCA <- function(data, attribute1, attribute2, attribute3){
  my_plot <- data %>%
    ggplot2::ggplot(ggplot2::aes_string(x = attribute1,
                                        y = attribute2,
                                        color = attribute3)) +
    ggplot2::geom_violin() +
    ggplot2::labs(x = stringr::str_replace(attribute1,'_',' '),
                  y = attribute2) +
    ggplot2::theme_classic() +
    ggplot2::theme(legend.position = "bottom")
  return(my_plot)
}

# barplot - factorial as x
barplot_BRCA <- function(data, attribute1, attribute2){
  my_plot <- data %>%
    ggplot2::ggplot(ggplot2::aes_string(x = attribute1,
                                        fill = attribute2)) +
    ggplot2::geom_bar() +
    ggplot2::labs(x = stringr::str_replace(attribute1,'_',' '),
                  y = "Count") +
    ggplot2::theme_classic() +
    ggplot2::theme(legend.position = "bottom")
  return(my_plot)
}

