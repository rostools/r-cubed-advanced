# Load necessary packages -------------------------------------------------

library(tidyverse)
library(readxl)
library(here)

# Download dataset --------------------------------------------------------

# From DOI: 10.5281/zenodo.23222305
# Direct URL: https://zenodo.org/records/23222305

new_diabetes_dir <- here("data-raw/new-diabetes")
fs::dir_create(new_diabetes_dir)

if (!fs::dir_exists(new_diabetes_dir)) {
  download.file(
    "https://zenodo.org/records/23222305/files/Deposit_dataset_deidentified.xlsx",
    destfile = here(new_diabetes_dir, "new-diabetes.xlsx"),
    mode = "wb"
  )
}

# Minor processing of data into simpler format ----------------------------

new_diabetes <- read_excel(here(new_diabetes_dir, "new-diabetes.xlsx")) |>
  select(
    -matches("^dkq_[0-9]"),
    -bmi_cat,
    -bp_raised,
    -famdm_n,
    -bedcat,
    -wakecat,
    -central_ob,
    -whr_high,
    -ends_with("_clock"),
    -short_sleep,
    -short_sleep_calc,
    -dur_calc,
    -Hyperglycemia
  ) |>
  rename_with(
    \(x) {
      str_remove(x, "(_bl|_l)$") |>
        snakecase::to_snake_case()
    }
  ) |>
  rename(
    glycemia_status = group,
    random_glucose = rbg,
    age_group = agegrp,
    marital_status = mar,
    education = edu,
    occupation = occ,
    waist_circumference = waist_circ,
    hip_circumference = hip_circ,
    waist_to_hip_ratio = whr,
    systolic_blood_pressure = bp_sys,
    diastolic_blood_pressure = bp_dia,
    has_hypertension = htn,
    family_history_hypertension = famhtn,
    number_family_diabetes = famdm_cat,
    exercises = ex,
    stressed = str,
    satisfied_socially = soc,
    hba1c = hba_1_c,
    body_mass_index = bmi,
    diabetes_knowledge_score = dkq_score
  )

# Save to `data/` ---------------------------------------------------------

write_csv(new_diabetes, here::here("data/new-diabetes.csv"))
