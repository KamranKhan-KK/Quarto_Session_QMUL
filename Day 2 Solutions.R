
# Load necessary libraries
library(tidyverse)

# List files in the working directory and check if HereR_trial_data is available
list.files()

# Filter the data to find patients in the Treatment group who are older than 50
treatment_over_50 <- HereR_trial_data %>% 
  filter(TreatmentGroup == "Treatment" & Age > 50)
print(treatment_over_50)

# Select specific columns: Extract only the PatientID, Age, and BloodPressure columns
selected_columns <- HereR_trial_data %>% 
  select(PatientID, Age, BloodPressure)
print(selected_columns)

# Rename PatientID to participant_id and Outcome to Clinical_Outcome
renamed_data <- HereR_trial_data %>% 
  rename(participant_id = PatientID, Clinical_Outcome = Outcome)
print(renamed_data)

# Relocate BloodPressure to be between Gender and TreatmentGroup
relocated_data <- HereR_trial_data %>% 
  relocate(BloodPressure, .after = Gender)
print(relocated_data)






# Add a new column ScoreDifference showing the difference between FollowUpScore and BaselineScore
HereR_trial_data <- HereR_trial_data %>% 
  mutate(ScoreDifference = FollowUpScore - BaselineScore)
print(HereR_trial_data)


# Add a new column Standardised_Difference calculated as (FollowUpScore - mean(FollowUpScore)) / sd(FollowUpScore)
HereR_trial_data <- HereR_trial_data %>% 
  mutate(Standardised_Difference = (FollowUpScore - mean(FollowUpScore)) / sd(FollowUpScore))
print(HereR_trial_data)



# Calculate the average Blood Pressure by TreatmentGroup
average_bp <- HereR_trial_data %>% 
  group_by(TreatmentGroup) %>% 
  summarise(AverageBP = mean(BloodPressure, na.rm = TRUE))
print(average_bp)

# Count the number of patients in each new renamed Outcome category
outcome_counts <- HereR_trial_data %>% 
  count(Outcome)
print(outcome_counts)









# Use pivot_longer to reshape BaselineScore and FollowUpScore columns to a long format
HereR_long <- HereR_trial_data %>%
  pivot_longer(cols = c(BaselineScore, FollowUpScore), names_to = "Timepoint", values_to = "Score")
print(HereR_long)

# Use pivot_wider to reshape the data back to its original wide format
HereR_wide <- HereR_long %>%
  pivot_wider(names_from = "Timepoint", values_from = "Score")
print(HereR_wide)






# Load ggplot2 (part of tidyverse)
library(ggplot2)

# Create a basic scatter plot to show the relationship between Age and FollowUpScore
ggplot(HereR_trial_data, aes(x = Age, y = FollowUpScore)) + 
  geom_point() + 
  labs(title = "Age vs Follow-Up Score", x = "Age", y = "Follow-Up Score")

# Add color to the scatter plot based on Outcome
ggplot(HereR_trial_data, aes(x = Age, y = FollowUpScore, color = Outcome)) +
  geom_point() +
  labs(title = "Scatter Plot of Age vs Follow-Up Score by Outcome", x = "Age", y = "Follow-Up Score")

# Create a bar chart showing the count of patients in each TreatmentGroup
ggplot(HereR_trial_data, aes(x = TreatmentGroup)) +
  geom_bar() +
  labs(title = "Bar Chart of Treatment Groups", x = "Treatment Group", y = "Count")

# Plot a histogram of Age with binwidth = 5
ggplot(HereR_trial_data, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Histogram of Age", x = "Age", y = "Frequency")





# Create a box plot to compare BaselineScore across different Outcome categories
ggplot(HereR_trial_data, aes(x = Outcome, y = BaselineScore, fill = Outcome)) +
  geom_boxplot() +
  labs(title = "Box Plot of Baseline Score by Outcome", x = "Outcome", y = "Baseline Score")

# Add a regression line to the scatter plot of Age vs. Standardised_Difference
ggplot(HereR_trial_data, aes(x = Age, y = Standardised_Difference)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatter Plot of Age vs Standardised Difference with Regression Line", x = "Age", y = "Standardised Difference")

