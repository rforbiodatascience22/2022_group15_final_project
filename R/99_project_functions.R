# Load libraries ----------------------------------------------------------
# Libraries are loaded in the 01_load.R script

# Load data
load_data_clean_aug <- function(){
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
  
  return(my_data_clean_aug)
}

# Function for main plot theme
our_theme <- function(legend_position = 'right', 
                      x_angle = 0){
  if(x_angle != 0){
    x_hjust = 1
  }else{
    x_hjust = 0.5
  }
  
  theme_minimal(base_family = 'Avenir',
                base_size = 10) +
  theme(axis.text.x = element_text(angle = x_angle, hjust=x_hjust),
          legend.position = legend_position,
          plot.title = element_text(hjust = 0.5),
          panel.grid.minor = element_line(colour="white", 
                                          size=0.5))
}

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
    our_theme(legend_position = "bottom")
}

#### PCA ANALYSIS ####
pca_analysis <- function(data, Attribute="Patient_Status"){
  
  pca_fit <- data %>% 
    select("Age",matches("Protein")) %>% 
    prcomp(scale = TRUE)
  
  return(pca_fit)
}

# 
pca_vis_BRCA <- function(data, PC1, PC2, Attribute="Patient_Status"){
  pca_fit <- pca_analysis(data = data, Attribute = Attribute)
  
  PC_1 = str_c(".fitted",PC1)
  PC_2 = str_c(".fitted",PC2)
  
  pca_fit %>% 
    augment(data %>% select(Attribute)) %>% 
    ggplot(aes_string(x = PC_1, 
                      y = PC_2,
                      color = Attribute)) + 
    geom_point(size = 1.5) +
    scale_color_discrete() + 
    our_theme(legend_position = "bottom") +
    background_grid()
}


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
    ggplot2::geom_bar(position="dodge") +
    ggplot2::labs(x = stringr::str_replace(attribute1,'_',' '),
                  y = "Count") +
    ggplot2::theme_classic() +
    ggplot2::theme(legend.position = "bottom")
  return(my_plot)
}

