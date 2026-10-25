# Load necessary packages -------------------------------------------------

library(tidyverse)
library(here)

# Download dataset --------------------------------------------------------

# From DOI: 10.5281/zenodo.22996512
# Direct URL: https://zenodo.org/records/22996512

cv_risk_dir <- here("data-raw/cv-risk")
fs::dir_create(cv_risk_dir)

if (!fs::dir_exists(cv_risk_dir)) {
  download.file(
    "https://zenodo.org/records/22996512/files/cardiovascular-risk-heart-failure-cohort-sample.rar",
    destfile = here(cv_risk_dir, "cv-risk.rar"),
    mode = "wb"
  )
  archive::archive_extract(here(cv_risk_dir, "cv-risk.rar"), dir = cv_risk_dir)
}

# Minor processing of data into simpler format ----------------------------

outcomes <- read_csv(here(cv_risk_dir, "sample_outcomes.csv")) |>
  # Don't need to keep all the other variables for this workshop.
  select(patient_id, outcome_any_cv_event = any_cv_event, outcome_death = died)

# Trim down on the number of variables, many of them are also mostly empty.
predictors <- read_csv(here(cv_risk_dir, "sample_patients.csv")) |>
  select(
    -stratum,
    -race_ethnicity,
    -starts_with("med_"),
    -hf_subtype,
    -ef,
    -nyha,
    -hf_duration_years,
    -prior_hf_hosp,
    -ntprobnp,
    -ckd,
    -copd,
    -egfr
  ) |>
  # Make the variable names clearer.
  rename(
    age = age_enrollment,
    systolic_blood_pressure = sbp,
    total_cholesterol = total_chol,
    high_density_lipoprotein = hdl,
    low_density_lipoprotein = ldl,
    body_mass_index = bmi,
    gender = sex
  )

cv_risk <- full_join(
  predictors,
  outcomes
) |>
  # These should be logical, they are read as double from the source files.
  mutate(across(
    c(
      smoking,
      diabetes,
      hypertension,
      atrial_fibrillation,
      family_history_cvd,
      alcohol_use,
      starts_with("outcome_")
    ),
    as.logical
  ))

# Save to `data/` ---------------------------------------------------------

write_csv(cv_risk, here::here("data/cv-risk.csv"))
