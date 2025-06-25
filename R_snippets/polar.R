
# --------------------------------------------------------------------------------------------------- #
# This is a code snippet for a beautifully rendered polar bar chart for primary diagnosis
# Find the data here -->
# https://github.com/VidishaVac/healthcare-analytics/tree/main/dataset_diabetes
# Run this to read in, clean and pre-process your data first -->
# https://github.com/VidishaVac/healthcare-analytics/blob/main/R_snippets/cleanDiabetic_data.R
# See here for the actual visual you will get after this code -->
# https://github.com/VidishaVac/healthcare-analytics/blob/main/R_snippets/polar.png
# --------------------------------------------------------------------------------------------------- #

# --------------------------------------------- #
# Load necessary libraries
# --------------------------------------------- #
library(dplyr)
library(ggplot2)
library(tidyr)

# --------------------------------------------- #
# Re-shape primary diagnosis
# --------------------------------------------- #
summary_primary_diag <- D %>% 
  group_by(primary_diag) %>%
  summarise(count = n(), percent = n() / nrow(D) * 100) %>%
  arrange(desc(percent))

df <- summary_primary_diag
df <- df %>% mutate(
  label=c(paste(round(df$percent[1:4]), "%", sep=""),rep(NA,nrow(df)-4)))


ggplot(data=df, aes(x=reorder(primary_diag,count), y=count, fill=percent)) +
  geom_bar(stat="identity", color="black") + 
  coord_polar() +
  # New fill and legend title for % patients to which meds prescribed
  scale_fill_gradientn(
    "Percent prescribed",
    colours = c( "#6C5B7B","#C06C84","#F67280","#F8B195")) +
  geom_text(aes(x=primary_diag, y=count/2,label = label), size=3.5, color="black",
            fontface="bold") +
  # Make the guide for the fill discrete
  guides(fill = guide_colorsteps(barwidth = 15, barheight = .5, 
                                 title.position = "top", title.hjust = .5)) +
  theme(
    # Remove axis ticks and text
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.text.y = element_blank(),
    # Use gray text for the region names
    axis.text.x = element_text(color = "gray12", size = 10),
    # Move the legend to the bottom
    legend.position = "bottom",
  ) +
  # Add labels
  labs(
    title = "\nPatient primary diagnoses",
    subtitle = paste(
      "\nThis visualization shows us the primary diagnosis,",
      "of each patient encounter in our diabetes data set.\n",
      "This is the very initial diagnosis made, so even though",
      "the encounter is diabetic, this first diagnosis could be",
      "something else, e.g. heart disease (circulatory).",      
      sep = "\n"
    ),
    caption = "\nData visualisation by Vidisha Vachharajani\nLink to data: https://github.com/VidishaVac/healthcare-analytics/tree/main/dataset_diabetes\nOriginal inspiration here: https://r-graph-gallery.com/web-circular-barplot-with-R-and-ggplot2.html"
    ) +
  # Customize general theme
  theme(
    # Customize the text in the title, subtitle, and caption
    plot.title = element_text(face = "bold", size = 15, hjust = 0.05),
    plot.subtitle = element_text(size = 10, hjust = 0.05),
    plot.caption = element_text(size = 7, hjust = .5)
  )
