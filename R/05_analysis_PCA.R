# Load libraries ----------------------------------------------------------
library("tidyverse")
library('broom')
library('cowplot')

# Define functions --------------------------------------------------------
source(file = "/cloud/project/R/99_project_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_csv(file = "/cloud/project/data/03_my_data_clean_aug.csv",
                              show_col_types = FALSE)
# Wrangle data ------------------------------------------------------------

outcome_data <- my_data_clean_aug %>%
  bind_cols %>%
  as_tibble %>%
  relocate(Patient_Status) %>%
  rename(outcome = Patient_Status) %>%
  mutate(outcome = case_when(outcome == "Alive" ~ 0,
                             outcome == "Dead" ~ 1))


#Collect and scale the relevant data 
data_wide <- outcome_data %>% 
  select(Age,
         Protein1,
         Protein2,
         Protein3,
         Protein4,
         outcome) %>% 
  mutate(outcome = case_when(outcome == 0 ~ '0',
                             outcome == 1 ~ '1')) %>% 
  mutate_at(c("Age","Protein1", "Protein2","Protein3","Protein4"), ~(scale(.) %>% as.vector))

# Model data
pca_fit <- data_wide %>% 
  select(where(is.numeric)) %>% # retain only numeric columns
  prcomp(scale = TRUE) # do PCA on scaled data

# Visualise data ----------------------------------------------------------

pca_fit %>%
  augment(data_wide) %>% # add original dataset back in
  ggplot(aes(.fittedPC1, .fittedPC2,
             color = outcome)) + 
  geom_point(size = 1.5) +
  our_theme() +
  scale_color_manual(values = c("0" = "#1f77b4",
                                "1" = "#fb0100"))

ggsave(filename = 'PCA_fitted_PCs.png',
       width = 8,
       height = 3,
       units = "in",
       path = '/cloud/project/results')

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
