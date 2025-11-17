# Load necessary packages -------------------------------------------------

library(readxl)
library(dplyr)
library(tidyr)
library(stringr)
library(here)

# Download dataset --------------------------------------------------------

# From DOI: 10.5281/zenodo.6597902
# Direct URL: https://zenodo.org/record/6597902

# Create a variable to store the path to `data-raw/nmr-omics/`,
# then create a directory so we can store the raw data there.
nmr_omics_dir <- here("data-raw/nmr-omics")
fs::dir_create(nmr_omics_dir)

# Download the README.
download.file(
  "https://zenodo.org/record/6597902/files/README.txt",
  destfile = here(nmr_omics_dir, "README.txt")
)

# Download the Lipidomics dataset. If you want, you can open this file
# to see what it looks like and to better understand why we need to
# process it the way we do below.
download.file(
  "https://zenodo.org/record/6597902/files/NMR_Integration_Data_Lipidomics.xlsx",
  destfile = here(nmr_omics_dir, "lipidomics.xlsx"),
  mode = "wb"
)

# Wrangle dataset into tidy long format -----------------------------------

# Get all the data from the lipidomics sheet.
# Column names are not provided, so we just use generic names
# for now.
lipidomics_full <- read_xlsx(
  here(nmr_omics_dir, "lipidomics.xlsx"),
  col_names = paste0("V", 1:40)
)

# There are actually two sets of data in this dataset that we need to split:
# - Subject level data (first four rows).
# - Lipidomic data (all other rows).

# Keep only lipidomic values
lipidomics_only <- lipidomics_full |>
  # Want to remove columns 2, 3, and 4 since they are "limits"
  # (we don't need them for this workshop).
  select(-2:-4) |>
  # Remove the subject data rows (the first four rows).
  slice(-1:-4) |>
  # Convert all the metabolite values to numeric (they were read as
  # character because of the headers in the first four rows).
  mutate(across(-V1, as.numeric)) |>
  # Make it so the metabolite values are all in one column, rather
  # than spread across multiple columns. This will make it easier to
  # join with the subject data later. Don't include V1, since it
  # contains the metabolite names.
  pivot_longer(-V1) |>
  rename(metabolite = V1) |>
  # Fix spelling of 'internal' (from `interntal`)
  mutate(metabolite = str_replace(metabolite, "interntal", "internal"))

# Keep only subject data, which is the first four rows of the spreadsheet.
subject_only <- lipidomics_full |>
  # Remove the first metabolic name and limit columns, as we don't need
  # them for this part.
  select(-1:-3) |>
  # Keep only the subject data raw (first four rows).
  slice(1:4) |>
  # V4 contains the variable names, so we pivot it longer so each
  # data value is aligned with the variable name.
  pivot_longer(cols = -V4) |>
  # We want to pivot wider, so that each variable name (right now
  # duplicated multiple times in the long format) becomes its own
  # column. That way we have 4 columns (from the first four rows):
  # Code (subject ID), Gender, Age, Class (treatment group).
  pivot_wider(names_from = V4, values_from = value) |>
  # There is a weird "​" before some of the numbers, so we have
  # extract just the number first before converting to numeric.
  mutate(Age = as.numeric(str_extract(Age, "\\d+"))) |>
  # Align naming so variables are in `snake_case`.
  rename_with(snakecase::to_snake_case)

# Now we join the two datasets together to get a tidy lipidomics dataset.
lipidomics <- full_join(
  subject_only,
  lipidomics_only
) |>
  # Don't need anymore.
  select(-name)

# Save to `data/` ---------------------------------------------------------

readr::write_csv(lipidomics, here::here("data/lipidomics.csv"))
