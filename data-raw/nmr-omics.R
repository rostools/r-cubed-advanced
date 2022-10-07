## code to prepare `nmr-omics` dataset goes here

library(readxl)
library(dplyr)
library(tidyr)
library(here)

# From DOI: 10.5281/zenodo.6597902
# Get both README and the Lipidomics dataset.
nmr_omics_dir <- here("data-raw/nmr-omics")
fs::dir_create(nmr_omics_dir)

download.file("https://zenodo.org/record/6597902/files/README.txt",
              destfile = here(nmr_omics_dir, "README.txt"))

download.file("https://zenodo.org/record/6597902/files/NMR_Integration_Data_Lipidomics.xlsx",
              destfile = here(nmr_omics_dir, "lipidomics.xlsx"))

lipidomics_full <- read_xlsx(
    here(nmr_omics_dir, "lipidomics.xlsx"),
    col_names = paste0("V", 1:40)
)

# There are actually two sets of data in this dataset that we need to split:
# - Lipidomic data
# - Subject level data

# Keep only lipidomic values
lipidomics_only <- lipidomics_full %>%
    # Want to remove columns 2, 3, and 4 since they are "limits"
    select(-2:-4) %>%
    # Remove the subject data
    slice(-1:-4) %>%
    pivot_longer(-V1) %>%
    rename(Metabolite = V1)

# Keep only subject data
subject_only <- lipidomics_full %>%
    # Want to remove the first metabolic columns
    select(-1:-3) %>%
    # Keep only the subject data
    slice(1:4) %>%
    pivot_longer(cols = -V4) %>%
    pivot_wider(names_from = V4, values_from = value) %>%
    rename_with(snakecase::to_snake_case)

lipidomics <- full_join(subject_only,
                        lipidomics_only) %>%
    # Don't need anymore
    select(-name)

usethis::use_data(lipidomics, overwrite = TRUE)
