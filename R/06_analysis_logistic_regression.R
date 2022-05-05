# Load libraries ----------------------------------------------------------
# Libraries are loaded in the 01_load.R script.

# Define functions --------------------------------------------------------
source(file = "/cloud/project/R/99_project_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_csv(file = "/cloud/project/data/03_my_data_clean_aug.csv",
                              show_col_types = FALSE)


# Wrangle data ------------------------------------------------------------
models <- my_data_clean_aug %>% 
  select(Patient_Status_Binary,
         Protein1, 
         Protein2,
         Protein3, 
         Protein4) %>% 
  pivot_longer(data = .,
               cols = -Patient_Status_Binary,
               names_to = "Protein",
               values_to = "Expr_level") %>% 
  group_by(Protein) %>% 
  nest() %>% 
  ungroup() %>% 
  mutate(mu_group = map(data,
                        ~glm(Patient_Status_Binary ~ Expr_level,
                             data = .,
                             family = binomial(link = "logit"))),
         tidied = map(.x = mu_group,
                      .f = tidy,
                      conf.int = TRUE)) %>% 
  unnest(tidied) %>% 
  filter(term != "(Intercept)") %>% 
  mutate(Significant = case_when(p.value < 0.05 ~ TRUE,
                                 p.value >= 0.05 ~ FALSE),
         neglog10p = -log10(p.value))


# Visualise data ----------------------------------------------------------
models %>% 
  select(Protein,
         neglog10p,
         Significant) %>% 
  ggplot(data = .,
         mapping = aes(x = Protein,
                       y = neglog10p)) + 
  geom_point(mapping = aes(color = Significant),
             size = 2,
             alpha = 1) + 
  geom_hline(mapping = aes(yintercept = -log10(0.05)),
             color = "Black",
             alpha = 0.5,
             linetype = "dashed") + 
  geom_polygon(mapping = aes(x = c(0.4,0.4,4.6,4.6),
                             y = c(-log10(0.05),1.75,1.75,-log10(0.05))),
               fill = "Green",
               alpha = 0.1) +
  geom_polygon(mapping = aes(x = c(0.4,0.4,4.6,4.6),
                             y = c(-0,-log10(0.05),-log10(0.05),0)),
               fill = "Red",
               alpha = 0.1) +
  annotate(geom = "text",
           x = 1,
           y = 1.7,
           label = "Significant",
           size = 2,
           color = "Darkgreen") +
  annotate(geom = "text",
           x=1,
           y=1.25,
           label = "Insignificant",
           size = 2,
           color = "Darkred") +
  our_theme(legend_position = "bottom",
            x_angle = 45) +
  labs(x = "",
       y = "Negative log10 of p-value",
       title = "Manhattan plot")

ggsave(filename = "manhattan_plot_logistic_regression.png",
       width = 4,
       height = 3,
       units = "in",
       path = "/cloud/project/results")

# p-value table
models %>% 
  select(-data, 
         -mu_group) %>% 
  write_csv(x = .,
            file = "/cloud/project/results/p-value_table.csv")
