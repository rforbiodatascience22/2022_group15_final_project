# group-15-git-FinalProject

## Description of project

Authors:

-   s174586: Mikkel Swartz
-   s173686: Søren Sandgaard
-   s165827: Helene Wegener
-   s183448: Lasse Rene
-   s212956: Aldis Helga Björgvinsdóttir

This project works with visualizations and analysis on the dataset [Real Breast Cancer Data](https://www.kaggle.com/datasets/amandam1/breastcancerdataset/discussion?resource=download&fbclid=IwAR0XJfeVbma_2KhCVVmfCBzy2i7bya_TTCP7LWwK-8PWMkE1watNLZyu3wg) from www.kaggle.com.
The analysis and visualizations are written in Tidyverse R.

Furthermore, the repository is linked to a [shiny-app repository](https://github.com/rforbiodatascience22/group_15_final_project_app) handling the same dataset, but for dynamic visualizations with user inputs.
The app contains three visualization panels, related to 'General data', 'Principal component analysis' and 'Density of protein expression'. It also contains a main page with a description of usage (see also Operation in README).
The app is linked, by downloading the relevant functions and data wrangling files from this repository, and then running this analysis before launching.

**LINK TO APP REPOSITORY:** https://github.com/rforbiodatascience22/group_15_final_project_app

Date of creation: *20th of April 2022*\
Last updated: *5th of May 2022*

## Operation

**Main repository**
To run the project, run the R/00_doit.R script, which will run the relevant files and generate results in the results/ folder.

**App repository**
The app is launched by running dev/run_dev.R.
The app contains four panels:
- **Home:** Purely descriptive.
- **Variable overview:** Has two display areas, one for box-/violin plots and one for histograms.
    - *Box-/violin plots:*
        - Numeric variables: Protein1 to Protein4 and Age
        - Discrete variables: None, Tumour stage, Histology, HER2 status, Surgery type, and Patient status.
        - Color grouping: None, Tumour stage, Histology, HER2 status, Surgery type, and Patient status.
    - *Histogram:*
        - Discrete variable: Tumour stage, Histology, HER2 status, Surgery type, and Patient status.
        - Colour grouping: None, Tumour stage, Histology, HER2 status, Surgery type, and Patient status.
- **Density plot:** Has one display area, with a density plot with up to four subplots.
    - *Density plot:*
        - Numeric variables: Protein1 to Protein4
        - Discrete variables: Tumour Stage, Histology, Surgery type, and Patient Status
- **PCA plot:** Has one display area, with a 2D scatter plot of different principal components chosen by the user. The plot can be colored according to discrete variables.
    - *Scatter plot:*
        - Numeric variables for X: Principal component 1 to 5
        - Numeric variables for Y: Principal component 1 to 5
        - Discrete variables: Tumour Stage, Histology, HER2 Status, Surgery type, and Patient Status


## File Structure

-   [data](./data)
    -   [\_raw](./data/_raw)
        -   [BRCA2.csv](./data/_raw/BRCA2.csv)
    -   [01_my_data.csv](./data/01_my_data.csv)
    -   [02_my_data_clean.csv](./data/01_my_data_clean.csv)
    -   [03_my_data_clean_aug.csv](./data/01_my_data_clean_aug.csv)
-   [R](./R)
    -   [00_doit.R](./R/00_doit.R)\
    *Runs all subsequent R documents*
    -   [01_load.R](./R/01_load.R)\
    *Loads raw data*
    -   [02_clean.R](./R/02_clean.R)\
    *Cleans data for NAs, and irrelevant columns*
    -   [03_augment.R](./R/03_augment.R)\
    *Augments data with addition of new columns*
    -   [04_analysis_PCA.R](./R/04_analysis_PCA.R)\
    *Performs a PCA analysis on Protein expression compared to Patient status*
    -   [05_analysis_Logistic_Regression.R](./R/05_analysis_Logistic_Regression.R)\
    *Performs logistic regression on Protein expression compared to patient status*
    -   [06_analysis_general_visualizations.R](./R/06_analysis_general_visualizations.R)\
    *Contains general visualization*
    -   [99_project_functions.R](./R/99_project_functions.R)\
    *Defines functions that are used for visualizations in the shiny app*
-   [results](./results)
    -   [Manhattan_Plot_Logistic.png](./results/Manhattan_Plot_Logistic.png)
    -   [p-value_table.csv](./results/p-value_table.csv)
-   [doc](./doc)
    -   [Presentation.Rmd](./doc/Presentation.Rmd)
