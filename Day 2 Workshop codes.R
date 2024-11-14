

#===================================================
# SETTING WORKING DIRECTORIES IN R
#===================================================

getwd()  # Check the current working directory

# Set the working directory (note: adjust the path for your system)
setwd("C:/Users/musta/OneDrive - Queen Mary, University of London/PCTU R Workshop 2024/Workshop")

# The setwd path uses double backslashes in Windows; the following line will throw an error due to single backslashes:
# setwd("C:\Users\musta\OneDrive - Queen Mary, University of London\PCTU R Workshop 2024\Day 2")

# List files in the current working directory
list.files()
list.files(pattern = ".csv")  # List only .csv files
list.dirs()  # List directories and subdirectories




#===================================================
# INSTALLING AND LOADING PACKAGES in R
#===================================================

# Install the 'tidyverse' package if it’s not already installed.
# 'tidyverse' is a collection of packages used for data manipulation, visualization, and more.
# 'dependencies = TRUE' ensures that any packages required by tidyverse are also installed.
install.packages("tidyverse", dependencies = TRUE)

# Load the 'tidyverse' package into your R session.
# This step makes all functions from tidyverse packages available for use.
library(tidyverse)

#---------------------------------------------------
# List of core packages included in tidyverse:
#---------------------------------------------------
# 1. ggplot2   - For data visualization
# 2. dplyr     - For data manipulation (e.g., filter, select, mutate)
# 3. tidyr     - For data tidying (e.g., pivot_longer, pivot_wider)
# 4. readr     - For data import, specifically for reading CSV files
# 5. purrr     - For functional programming (e.g., map functions)
# 6. tibble    - Provides a modern version of data frames with improved printing
# 7. stringr   - For working with strings (e.g., str_detect, str_replace)
# 8. forcats   - For handling factors, or categorical data (e.g., fct_reorder)

#---------------------------------------------------
# Additional tidyverse-related packages (optional):
#---------------------------------------------------
# 1. lubridate - For working with dates and times
# 2. readxl    - For reading Excel files
# 3. writexl   - For writing Excel files
# 4. haven     - For reading and writing SPSS, Stata, and SAS files
# 5. modelr    - For modeling workflows, especially with ggplot2


install.packages("haven", dependencies = TRUE)
library(haven)





#============================================
# IMPORTING DATA (csv, excel, tsv)
#============================================

clinical_trial_data <- read_csv("clinical_trial_data.csv")  # Load CSV file


# Read the Stata file  into R (reads dta files from Stata 8 and above)
clinical_trial_data_imported <- read_dta("clinical_trial_data.dta")

# you can also use read_stata() -- more compatible with older stata files especially when
# the above throws an error due to character encoding
# clinical_trial_data_imported <- read_stata("clinical_trial_data.dta")

# View the imported Stata dataset in the console to confirm it loaded correctly
print(clinical_trial_data_imported)






#============================================
# PIPE OPERATOR (%>%)
#============================================

# We use the PIPE OPERATOR (%>%) to chain operations for cleaner code.





#============================================
# FILTER: Selecting rows based on conditions
#============================================

# Filter for patients in the Treatment group
treatment_group <- clinical_trial_data %>% 
  filter(TreatmentGroup == "Treatment")
head(treatment_group)  # View the first few rows





#============================================
# SELECT: Selecting specific columns
#============================================

# Select columns PatientID, Age, and Outcome
selected_columns <- clinical_trial_data %>% 
  select(PatientID, Age, Outcome)
head(selected_columns)  # View the selection





#============================================
# MUTATE: Creating or transforming columns
#============================================

# Create a new column with the difference between FollowUpScore and BaselineScore
with_difference <- clinical_trial_data %>% 
  mutate(ScoreDifference = FollowUpScore - BaselineScore)
head(with_difference)  # View the dataset with new column




#============================================
# ARRANGE: Sorting rows
#============================================

# Sort data by Age in ascending order
arranged_by_age_ascending <- clinical_trial_data %>% 
  arrange(Age)
# Sort data by Age in descending order
arranged_by_age_descending <- clinical_trial_data %>% 
  arrange(desc(Age))




#============================================
# GROUP BY and SUMMARISE: Grouping data and calculating summary statistics
#============================================

# Calculate the average FollowUpScore for each TreatmentGroup
average_followup <- clinical_trial_data %>% 
  group_by(TreatmentGroup) %>% 
  summarise(AvgFollowUpScore = mean(FollowUpScore, na.rm = TRUE))

# Count the number of observations in each TreatmentGroup
group_counts <- clinical_trial_data %>%
  group_by(TreatmentGroup) %>%
  summarise(Count = n())





#============================================
# RENAME: Renaming columns
#============================================

# Rename the column Outcome to ClinicalOutcome
renamed_data <- clinical_trial_data %>% 
  rename(ClinicalOutcome = Outcome)
head(renamed_data)  # Check the new column name





#============================================
# RELOCATE: Moving columns to a new position
#============================================

# Move the Outcome column to the start of the dataset
relocated_data <- clinical_trial_data %>% 
  relocate(Outcome, .before = PatientID)
head(relocated_data)  # Check the new column order






#============================================
# STARTS_WITH, ENDS_WITH, CONTAINS: Selecting columns based on names
#============================================

# Select columns starting with "Follow"
starts_with_example <- clinical_trial_data %>% 
                       select(starts_with("Follow"))

# Select columns ending with "Score"
ends_with_example <- clinical_trial_data %>% 
                     select(ends_with("Score"))

# Select columns that contain "Score"
contains_example <- clinical_trial_data %>% 
                    select(contains("Score"))






#============================================
# BIND_ROWS and BIND_COLS: Combining datasets by rows or columns
#============================================

# Example datasets for binding
data1 <- clinical_trial_data %>% 
         select(PatientID, Age, Gender)

data2 <- clinical_trial_data %>% 
         select(PatientID, TreatmentGroup, Outcome)

# Combine rows (bind_rows)
combined_rows <- bind_rows(data1, data2)  # Adds data2 rows below data1

# Combine columns (bind_cols)
combined_cols <- bind_cols(data1, data2)  # Adds data2 columns to the right of data1







#============================================
# RBIND and CBIND: Base R equivalents of bind_rows and bind_cols
#============================================

# Using rbind (only works if columns match exactly in name and type)
# combined_rbind <- rbind(data1, data2)  # This will throw an error if columns differ

# Using cbind (only works if row counts are identical)
combined_cbind <- cbind(data1, data2)  # Aligns columns side-by-side if row counts match
head(combined_cbind)  # Check combined data




# Reshape data from wide to long format
long_data <- clinical_trial_data %>%
  pivot_longer(cols = starts_with("Follow"), names_to = "Visit", values_to = "Score")

head(long_data)












#===================================================
# GGPLOT
#===================================================


# 1.0 BASIC SCATTER PLOT
ggplot(clinical_trial_data, aes(x = Age, y = FollowUpScore)) + 
  geom_point() + 
    labs(title = "Age vs Follow-Up Score", x = "Age", y = "Follow-Up Score")




# Scatter plot with color based on TreatmentGroup
ggplot(clinical_trial_data, aes(x = Age, y = BaselineScore, color = TreatmentGroup)) +
  geom_point() +
  labs(title = "Scatter Plot of Age vs Baseline Score by Treatment Group", x = "Age", y = "Baseline Score")




# Example Line plot (if you have time-series data)
ggplot(clinical_trial_data, aes(x = Age, y = BaselineScore, group = 1)) +
  geom_line() +
  labs(title = "Line Plot Example", x = "Age", y = "Baseline Score")



# Bar chart showing the frequency of each TreatmentGroup
ggplot(clinical_trial_data, aes(x = TreatmentGroup)) +
  geom_bar() +
  labs(title = "Bar Chart of Treatment Groups", x = "Treatment Group", y = "Count")




# Histogram of Age
ggplot(clinical_trial_data, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black") +
  labs(title = "Histogram of Age", x = "Age", y = "Frequency")



# Box plot of Baseline Score by Outcome
ggplot(clinical_trial_data, aes(x = Outcome, y = BaselineScore, fill = Outcome)) +
  geom_boxplot() +
  labs(title = "Box Plot of Baseline Score by Outcome", x = "Outcome", y = "Baseline Score")



# Violin plot of Baseline Score by Outcome
ggplot(clinical_trial_data, aes(x = Outcome, y = BaselineScore, fill = Outcome)) +
  geom_violin() +
  labs(title = "Violin Plot of Baseline Score by Outcome", x = "Outcome", y = "Baseline Score")




# Histogram of Age by TreatmentGroup
ggplot(clinical_trial_data, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  facet_wrap(~ TreatmentGroup) +
  labs(title = "Age Distribution by Treatment Group", x = "Age", y = "Count")




# Scatter plot with regression line
ggplot(clinical_trial_data, aes(x = Age, y = BaselineScore)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatter Plot with Regression Line", x = "Age", y = "Baseline Score")
