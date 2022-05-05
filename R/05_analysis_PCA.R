# Load libraries ----------------------------------------------------------
library("tidyverse")
library('broom')
library('cowplot')

# Define functions & load data --------------------------------------------
source(file = "/cloud/project/R/99_project_functions.R")

# Wrangle data ------------------------------------------------------------

pca_fit <- pca_analysis(data = my_data_clean_aug, Attribute = "Patient_Status")

# Visualise data ----------------------------------------------------------

# Visualize comparison between principal components
pca_vis_BRCA(data = my_data_clean_aug, PC1 = "PC1", PC2 = "PC2")

ggsave(filename = 'PCA_fitted_PCs.png',
       width = 8,
       height = 3,
       units = "in",
       path = '/cloud/project/results')


# Visualize impact of variables on principal components.

# define arrow style for plotting
arrow_style <- arrow(
  angle = 20, ends = "first",
  type = "closed",
  length = grid::unit(8, "pt")
)

# plot rotation matrix
pca_fit %>%
  tidy(matrix = "rotation") %>%
  pivot_wider(names_from = "PC",
              names_prefix = "PC",
              values_from = "value") %>%
  ggplot(aes(x = PC1,
             y = PC2)) +
  geom_segment(xend = 0,
               yend = 0,
               arrow = arrow_style) +
  geom_text(aes(label = column),
            hjust = 1,
            nudge_x = 0.15,
            nudge_y = 0.08,
            color = "#fb0100") +
  coord_fixed() +
  our_theme()

ggsave(filename = 'PCA_rotation_matrix.png',
       width = 8,
       height = 3,
       units = "in",
       path = '/cloud/project/results')

# Visualize variance explaned by each principal component
pca_fit %>%
  tidy(matrix = "eigenvalues") %>%
  filter(PC <= 10) %>% 
  ggplot(aes(x = PC,
             y = percent)) +
  geom_col(fill = "#1f77b4",
           color = 'black') +
  scale_x_continuous(breaks = 1:10) +
  scale_y_continuous(labels = scales::percent_format(),
                     expand = expansion(mult = c(0, 0.01))) +
  our_theme() +
  labs(y = 'Percentage')

ggsave(filename = 'PCA_barplot_PCAs.png',
       width = 8,
       height = 3,
       units = "in",
       path = '/cloud/project/results')
