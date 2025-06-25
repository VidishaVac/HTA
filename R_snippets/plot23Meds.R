# ------------------------------------------------------------------------------------------------------------ #
# This is a code snippet for 2 plots that allow us to visualize the 23 medications in the diabetes dataset
# Find the data here -->
# https://github.com/VidishaVac/healthcare-analytics/tree/main/dataset_diabetes
# Run this to read in, clean and pre-process your data first -->
# https://github.com/VidishaVac/healthcare-analytics/blob/main/R_snippets/cleanDiabetic_data.R
# ------------------------------------------------------------------------------------------------------------ #

# --------------------------------------------- #
# Load necessary libraries
# --------------------------------------------- #
library(dplyr)
library(ggplot2)
library(tidyr)
library(gridExtra)

# --------------------------------------------- #
# Reshaping wide to get a better view of medications
# --------------------------------------------- #
meds <- D %>%
  select(metformin:metformin.pioglitazone) %>%
  gather(key = "medication", value = "value") %>%
  group_by(medication, value) %>% summarise(n=n()) %>% mutate(pct = (n / sum(n))*100)

# ------------------------------------------------------------------- #
# Plots - make sure to fully expand your plot window to get a good view!
# ------------------------------------------------------------------- #
p0 <- ggplot(data=meds, aes(x=medication, y=pct, fill=value)) + 
  geom_col() +
 labs(title = "Diabetes medications bar plot",
  x = "Medication name",y = "pct prescribed", fill="Medication value") + 
  theme_minimal() + coord_flip() +
  theme(plot.title = element_text(hjust = 0.5))

p1 <- ggplot(data=meds, aes(x=value, y=medication, fill=pct)) + 
  geom_tile() + labs(title = "Diabetes medication heatmap",
  x = "Medication value",y = "Medication name", fill="pct prescribed") + 
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

grid.arrange(p0, p1, ncol=2)