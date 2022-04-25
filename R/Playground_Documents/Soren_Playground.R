##### NOTES #####
# I will perform a logistic regression model to see if there is a correlation between,
#  the patient status, and the corresponding protein levels.
# If this is the case for multiple proteins, then maybe we should do a PCA of these, 
#  to make some nice illustrations. 
# 
# Sidenote: I do not have high hopes for good results here, but bad results are still results.
#################

# Load libraries ----------------------------------------------------------
library("tidyverse")
library("patchwork")
library("fs")
library("vroom")
library("broom")
library("purrr")


# Define functions --------------------------------------------------------
source(file = "R/99_project_functions.R")


# Load data ---------------------------------------------------------------
# my_data_clean <- read.csv(file = "data/02_my_data_clean.csv")


# Wrangle data ------------------------------------------------------------

# Logistic Regression model
modeldat <- my_data_clean %>% 
  mutate(outcome = case_when(Patient_Status == "Alive" ~ 0,
                             Patient_Status == "Dead" ~ 1)) %>% 
  filter(is.na(outcome) == FALSE) %>% 
  select(outcome, Protein1, Protein2, Protein3, Protein4)

temp <- modeldat %>% 
  pivot_longer(data = .,
               cols = -outcome,
               names_to = "Protein",
               values_to = "Expr_level") %>% 
  group_by(Protein) %>% 
  nest() %>% 
  ungroup()

## Model data
models <- temp %>% 
  mutate(mu_group = map(data,
                        ~glm(outcome ~ Expr_level,
                             data = .,
                             family = binomial(link = "logit"))),
         tidied = map(.x = mu_group,
                      .f = tidy,
                      conf.int = TRUE)) %>% 
  unnest(tidied) %>% 
  filter(term != "(Intercept)")

## Visualise data
models %>% 
  select(Protein,p.value) %>% 
  ggplot(data = .,
         mapping = aes(x = Protein,
                       y = p.value,
                       color = p.value)) + 
  geom_point(mapping = aes(color = p.value)) + 
  geom_hline(mapping = aes(yintercept = 0.05),
             color = "Red",
             alpha = 0.5) + 
  theme_classic()

# Protein expression vs. Cancer type, density map
BRCA_data_long <- my_data_raw %>%
  drop_na() %>%
  select(matches('Protein'),Histology) %>%
  pivot_longer(cols = 1:4,
               names_to = 'Protein',
               values_to = 'Expression_Level')

BRCA_data_long %>% 
  ggplot(data = .,
         mapping = aes(x = Expression_Level,
                       color = Histology)) + 
  geom_density() + 
  facet_wrap(~Protein,
             nrow=4) +
  theme_classic()

# Heatmap
my_data_clean_count <- my_data_clean %>% 
  select(Histology,Surgery_type) %>% 
  group_by(Histology,Surgery_type) %>% 
  count() %>% 
  ungroup() %>% 
  group_by(Histology) %>% 
  mutate(nc = n/sum(n)) %>% 
  ungroup()

my_data_clean_count %>% 
  ggplot(data = .,
         mapping = aes(x = Histology,
                       y = Surgery_type,
                       fill = nc)) + 
  geom_tile() + 
  scale_fill_gradient(low = "Black",
                      high="White",
                      limits = c(0.0,0.5)) + 
  theme_classic()

