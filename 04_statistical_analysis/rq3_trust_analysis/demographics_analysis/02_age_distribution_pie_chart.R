# =======================================================================================
# Script: 02_age_distribution_pie_chart.R
# Purpose: Generate Categorical Age Group Pie Chart for Demographics
#
# This script takes the continuous 'Age' variable from the cleaned demographics 
# dataset and categorizes it into standard academic brackets (18-25, 26-35, etc.). 
# 
# It generates a percentage pie chart using polar coordinates,
# utilizing the `ggrepel` package to ensure the percentage labels dynamically push 
# away from each other to prevent text overlap in dense clusters.
#
# Prerequisite: Execute 01_participant_demographics_summary.R first to load `demo_clean`.
# =======================================================================================

# Step 1: Install and load the ggrepel package for non-overlapping labels
if(!require(ggrepel)) install.packages("ggrepel")
library(ggrepel)

# ==============================================================================
# PHASE 1: DATA BUCKETING & AGGREGATION
# ==============================================================================
# Create Age Groups and calculate exact percentages for the visualization
age_summary <- demo_clean %>%
  filter(!is.na(Age)) %>%
  mutate(
    # Bucket continuous ages into categorical groups using case_when
    Age_Group = case_when(
      Age >= 18 & Age <= 25 ~ "18-25",
      Age >= 26 & Age <= 35 ~ "26-35",
      Age >= 36 & Age <= 45 ~ "36-45"
    ),
    # Lock the factor levels to ensure they appear sequentially in the plot legend
    Age_Group = factor(Age_Group, levels = c("18-25", "26-35", "36-45"))
  ) %>%
  count(Age_Group) %>%
  # Calculate proportion relative to the total N
  mutate(Percentage = n / sum(n) * 100)

# ==============================================================================
# PHASE 2: GENERATE THE PIE CHART
# ==============================================================================
# Create the pie chart by plotting a stacked bar chart and wrapping it into a solid circle
plot_age <- ggplot(age_summary, aes(x = 1, y = Percentage, fill = Age_Group)) +
  geom_col(color = "black", width = 1) + 
  
  # coord_polar mathematically bends the y-axis into a solid circle (pie)
  coord_polar(theta = "y") +
  
  # Add dynamic boxed labels using ggrepel. 
  # Inherits 'fill' from global aes(), automatically matching the box color to the slice.
  geom_label_repel(aes(label = paste0(round(Percentage), "%")), 
                   position = position_stack(vjust = 0.5), 
                   size = 5, 
                   fontface = "bold", 
                   color = "black",      # Black text and black border for readability
                   label.padding = unit(0.3, "lines"), 
                   label.size = 0.5,     # Thickness of the black border
                   show.legend = FALSE) +
  
  # Apply a custom color palette 
  scale_fill_manual(values = c("18-25" = "#6582B3",   # Soft Blue
                               "26-35" = "#B17270",   # Earthy Red/Brown
                               "36-45" = "#56C98F"    # Corrected Green
  )) +
  labs(
    fill = "") +
  theme_void() + 
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 16, margin = margin(b = 15)),
    legend.position = "right",
    legend.text = element_text(size = 12),
    legend.key = element_rect(color = "black")
  )

# Print to the RStudio viewer for immediate visual confirmation
print(plot_age)

# ==============================================================================
# PHASE 3: SILENT STORAGE TO TARGET DIRECTORY
# ==============================================================================
# Save the high-resolution plot to the designated outputs folder
ggsave(file.path(output_dir, "Plot_1_Age_Groups_Pie.png"), plot_age, width = 8, height = 6, dpi = 300)

