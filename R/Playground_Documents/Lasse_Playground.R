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

clean4 %>% 
  ggplot(mapping = aes(
    x = Protein4,
    y = Patient_Status,
    color = Surgery_type)) + 
  geom_violin()




### PCA
Clean5 <- my_data_clean_aug %>%
  bind_cols %>%
  as_tibble %>%
  relocate(Patient_Status) %>%
  rename(outcome = Patient_Status) %>%
  mutate(outcome = case_when(outcome == "Alive" ~ 0,
                             outcome == "Dead" ~ 1))


data_long <- Clean5 %>% 
  select(Age,Protein1,Protein2,Protein3,Protein4,outcome) %>% 
  pivot_longer(cols = -outcome,
               names_to = "Protein", 
               values_to = "expr_level")

data_long_nested <- data_long %>% 
  group_by(Protein) %>% 
  nest() %>% 
  ungroup()

data_wide <- Clean5 %>%
  select(outcome, pull(data_long_nested, Protein)) %>% 
  mutate(outcome = case_when(outcome == 0 ~ '0',
                             outcome == 1 ~ '1')) %>% 
  mutate_at(c("Protein1", "Protein2","Protein3","Protein4","Age"), ~(scale(.) %>% as.vector))
           

data_wide <- Clean5 %>% 
  select(Age,Protein1,Protein2,Protein3,Protein4,outcome) %>% 
  mutate(outcome = case_when(outcome == 0 ~ '0',
                             outcome == 1 ~ '1')) %>% 
  mutate_at(c("Protein1", "Protein2","Protein3","Protein4","Age"), ~(scale(.) %>% as.vector))


library('tidyverse')
library('broom')
library('cowplot')


pca_fit <- data_wide %>% 
  select(where(is.numeric)) %>% # retain only numeric columns
  prcomp(scale = TRUE) # do PCA on scaled data

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


# Write data --------------------------------------------------------------
write_tsv(...)
ggsave(...)