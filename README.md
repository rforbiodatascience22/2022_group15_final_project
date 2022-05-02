# group-15-git-FinalProject

## Description of project

Authors:

-   s174586: Mikkel Swartz
-   s173686: Søren Sandgaard
-   s165827: Helene Wegener
-   s183448: Lasse Rene
-   s212956: Aldis Helga Björgvinsdóttir

This project works with visualizations and analysis on the dataset 'Real Breast Cancer Data' from www.kaggle.com [1](https://www.kaggle.com/datasets/amandam1/breastcancerdataset/discussion?resource=download&fbclid=IwAR0XJfeVbma_2KhCVVmfCBzy2i7bya_TTCP7LWwK-8PWMkE1watNLZyu3wg). \\ The analysis and visualizations are written in Tidyverse R.

Furthermore, the repository is linked to a shiny-app repository handling the same dataset, but for dynamic visualizations with user inputs.

## Operation

To run the project, run the /project/R/00_doit.R script, which will run the relevant files and generate results in the /project/results/ folder.

MIKKEL NEEDS TO WRITE SHINY APP OPERATION

## File Structure

- [data](./data)
    - [_raw](./data/_raw)
        - [BRCA2.csv](./data/_raw/BRCA2.csv)
    - [01_my_data.csv](./data/01_my_data.csv)
    - [02_my_data_clean.csv](./data/01_my_data_clean.csv)
    - [03_my_data_clean_aug.csv](./data/01_my_data_clean_aug.csv)
- [R](./R)
    - [00_doit.R](./R/00_doit.R)
    - [01_load.R](./R/01_load.R)
    - [02_clean.R](./R/02_clean.R)
    - [03_augment.R](./R/03_augment.R)
    - [04_analysis_PCA.R](./R/04_analysis_PCA.R)
    - [05_analysis_Logistic_Regression.R](./R/05_analysis_Logistic_Regression.R)
    - [06_analysis_general_visualizations.R](./R/06_analysis_general_visualizations.R)
    - [99_project_functions.R](./R/99_project_functions.R)
- [results](./results)
    - [Manhatten_Plot_Logistic.png](./results/Manhatten_Plot_Logistic.png)
    - [p-value_table.csv](./results/p-value_table.csv)
- [doc](./doc)
    - [Presentation.Rmd](./doc/Presentation.Rmd)



