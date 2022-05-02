# Load libraries ----------------------------------------------------------
library("tidyverse")
library('broom')
library('cowplot')

# Define functions --------------------------------------------------------
source(file = "/cloud/project/R/99_project_functions.R")


# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_csv(file = "/cloud/project/data/03_my_data_clean_aug.csv")


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
  select(Age,Protein1,Protein2,Protein3,Protein4,outcome) %>% 
  mutate(outcome = case_when(outcome == 0 ~ '0',
                             outcome == 1 ~ '1')) %>% 
  mutate_at(c("Protein1", "Protein2","Protein3","Protein4","Age"), ~(scale(.) %>% as.vector))


# Model data
pca_fit <- data_wide %>% 
  select(where(is.numeric)) %>% # retain only numeric columns
  prcomp(scale = TRUE) # do PCA on scaled data



# Visualise data ----------------------------------------------------------

pca_fit %>%
  augment(data_wide) %>% # add original dataset back in
  ggplot(aes(.fittedPC1, .fittedPC2, color = outcome)) + 
  geom_point(size = 1.5) +
  theme_half_open(12) + background_grid()



# define arrow style for plotting
arrow_style <- arrow(
  angle = 20, ends = "first", type = "closed", length = grid::unit(8, "pt")
)

# plot rotation matrix
pca_fit %>%
  tidy(matrix = "rotation") %>%
  pivot_wider(names_from = "PC", names_prefix = "PC", values_from = "value") %>%
  ggplot(aes(PC1, PC2)) +
  geom_segment(xend = 0, yend = 0, arrow = arrow_style) +
  geom_text(
    aes(label = column),
    hjust = 1, nudge_x = -0.02, 
    color = "#904C2F") +
  coord_fixed() + # fix aspect ratio to 1:1
  theme_minimal_grid(12)
ggsave(filename = "PCA_Rotation_Matrix.png")


pca_fit %>%
  tidy(matrix = "eigenvalues") %>%
  filter(PC <= 10) %>% 
  ggplot(aes(PC, percent)) +
  geom_col(fill = "#56B4E9", alpha = 0.8) +
  scale_x_continuous(breaks = 1:10) +
  scale_y_continuous(
    labels = scales::percent_format(),
    expand = expansion(mult = c(0, 0.01))
  ) +
  theme_minimal_grid(12)
ggsave(filename = "PCA_Percentages.png")


# Write data --------------------------------------------------------------
#write_tsv(...)
#ggsave(...)