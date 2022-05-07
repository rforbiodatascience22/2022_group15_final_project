#This script is to manually split and merge/join it again on a specific variable

# Splitting and Joining on ID--------------------------------------------------------------

###########
#Example 1#
###########

#Dataset1 with ID and protein
my_data_protein <- my_data_clean_aug %>%
  select(Patient_ID,
         matches('Protein'))

#Dataset2 with ID and histology
my_data_histology <- my_data_clean %>%
  select(Patient_ID,
         Histology)

#Dataset3 merged on ID
my_data_joined1 <- my_data_protein %>%
  inner_join(my_data_histology,
             by = 'Patient_ID')

###########
#Example 2#
###########

#Dataset1 with ID, Protein and Expression level
my_data_protein_long <- my_data_protein %>%
  pivot_longer(cols = matches('Protein'),
               names_to = 'Protein',
               values_to = 'Expression_Level')

#Merging long data with histology
my_data_joined2 <- my_data_protein_long %>%
  outer_join(my_data_histology,
             by = 'Patient_ID')
###########
#Example 3#
###########

#Dataset5 with empty cells
subset1 <- my_data_clean[1:100, 1:4]
subset2 <- my_data_clean[101:200, c(1,5:8)]

#A dataset that is empty by inner joining
my_data_joined3 <- subset1 %>%
  inner_join(subset2,
             by = 'Patient_ID')

#Only subset1
my_data_joined4 <- subset1 %>%
  left_join(subset2,
            by = 'Patient_ID')

#subset1 and subset 2 have only patient ID in common
my_data_joined5 <- subset1 %>%
  full_join(subset2,
            by = 'Patient_ID')
