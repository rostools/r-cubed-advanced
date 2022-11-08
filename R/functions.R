#' Convert contents of Qmd files into a single R scripts of only purl chunks.
#'
#' This is used to build the project that the participants will make, so we can
#' see how it goes and what it will look like in the end.
#'
#' @return Nothing. Converts Qmd files to R scripts.
#'
extract_chunks <- function() {
  knitr::opts_chunk$set(
    purl = FALSE
  )

  fs::dir_ls(here::here("R"), regexp = ".*[0-9][0-9]-.*\\.R$") |>
    fs::file_delete()

  qmd_files <- fs::dir_ls("content", regexp = "[0][1-4]|0-pre-course")
  r_files <- fs::path_temp(fs::path_file(qmd_files))
  r_files <- fs::path_ext_set(r_files, ".R")
  purrr::walk2(qmd_files, r_files, knitr::purl, documentation = 0L, quiet = TRUE)

  combined_r_file <- here::here("_ignore/code-to-build-project.R")
  fs::dir_create("_ignore")
  r_files |>
    purrr::map(readr::read_lines) |>
    purrr::flatten_chr() |>
    purrr::discard(~ .x == "") |>
    stringr::str_remove("^## ") |>
    readr::write_lines(combined_r_file)
  fs::file_copy(combined_r_file, "~/Desktop")
}
