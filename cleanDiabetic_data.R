
# --------------------------------------------------------------------------------------------------- #
# This is a code snippet to pre-processes and cleans up the diabetes dataset to render it more usable
# The output from this code is used for the HTA in this repo
# --------------------------------------------------------------------------------------------------- #

# --------------------------------------------- #
# Load necessary libraries
# --------------------------------------------- #
library(dplyr)
library(ggplot2)
library(tidyr)

# --------------------------------------------- #
# Read in the data
# --------------------------------------------- #
# set your working directory
setwd(dir = "Downloads/Work/Posit/Healthcare/Data/dataset_diabetes/")
D <- read.csv("diabetic_data.csv", sep=",")

# Large file that is 19MB locally, and 35MB in R
print(object.size(D), units = "MB", standard = "SI")

# -------------------------------------------------------- #
# Clean and re-define fields to be used for analysis
# -------------------------------------------------------- #

D <- D %>%
  mutate(a1c=ifelse(A1Cresult=="None", "not measured", "measured"), 
         primary_diag = case_when(
           diag_1 %in% c(390:459, 785) ~ "Circulatory",
           diag_1 %in% c(460:519, 786) ~ "Respiratory",
           diag_1 %in% c(520:579, 787) ~ "Digestive",
           diag_1 %in% c(580:629, 788) ~ "Genitourinary",
           diag_1 %in% c(630:679) ~ "Pregnancy",
           diag_1 %in% c(680:709, 782) ~ "Skin",
           diag_1 %in% c(710:739) ~ "Musculoskeletal",
           diag_1 %in% c(740:759) ~ "Congenital",
           diag_1 %in% c(800:999) ~ "Injury",
           grepl("^250", diag_1) ~ "Diabetes",
           is.na(diag_1) ~ "Missing",
           TRUE ~ "Other"
         ))

# Remove columns not used, patients with a discharge disposition of "expired" or "hospice"
# Also attribute a unique identifier for each encounter-patient combination
D <- D %>% select(7:9,25:52) %>% 
  filter(!discharge_disposition_id %in% c('11','13','14','19','20','21')) %>%
  mutate(uid=row_number(), .before = 1)

# A slightly smaller workable file that is 17MB locally, and 23MB in R
print(object.size(D), units = "MB", standard = "SI")

