# # 1. Install and load necessary infrastructure packages
# if (!require("pacman")) {
#   install.packages("pacman")
# }
# pacman::p_load("targets", "tarchetypes")
# 
# # 2. Load your custom analysis functions
# source("functions.R")
# 
# # 3. Tell the pipeline which packages your custom functions need
# tar_option_set(packages = c("dplyr", "tidyverse", "janitor", "quarto"))
# 
# # 4. Define the pipeline steps
# list(
#   tar_target(raw_file_path, "C:/Users/.../survey.csv", format = "file"),
#   tar_target(raw_qualtrics_data, read.csv(raw_file_path))
#   # ... the rest of your tar_target() steps ...
# )