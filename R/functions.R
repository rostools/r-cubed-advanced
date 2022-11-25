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

  qmd_files <- fs::path_abs(c(
    "preamble/pre-course.qmd",
    "sessions/smoother-collaboration.qmd",
    "sessions/pipelines.qmd",
    "sessions/stats-analyses-basic.qmd"
  ))

  r_files <- fs::path_temp(fs::path_file(qmd_files))
  r_files <- fs::path_ext_set(r_files, ".R")
  purrr::walk2(qmd_files,
    r_files,
    knitr::purl,
    documentation = 0L,
    quiet = TRUE
  )

  functions_r_file <- here::here("R/project-functions.R")
  extract_functions_from_qmd()
  fs::file_copy(functions_r_file, "~/Desktop", overwrite = TRUE)

  combined_r_file <- here::here("_ignore/code-to-build-project.R")
  fs::dir_create("_ignore")
  r_files |>
    purrr::map(readr::read_lines) |>
    purrr::flatten_chr() |>
    purrr::discard(~ .x == "") |>
    stringr::str_remove("^## ") |>
    purrr::prepend("fs::file_copy('~/Desktop/project-functions.R', 'R/functions.R')") |>
    readr::write_lines(combined_r_file)
  fs::file_copy(combined_r_file, "~/Desktop", overwrite = TRUE)
}

extract_functions_from_qmd <- function() {
  here::here() |>
    fs::dir_ls(recurse = TRUE, glob = "*.qmd") |>
    purrr::map(r3admin::extract_code_block_with_label_string,
               string_match = "new-function") |>
    purrr::compact() |>
    unlist() |>
    readr::write_lines(here::here("R/project-functions.R"))
}

run_styler_text <- '`{styler}` (`Ctrl-Shift-P`, then type "style file")'
run_lintr_text <- '`{lintr}` (`Ctrl-Shift-P`, then type "lint file")'
run_tar_make_text <- '`targets::tar_make()` (`Ctrl-Shift-P`, then type "targets run")' # nolint
run_tar_vis_text <- '`targets::tar_visnetwork()` (`Ctrl-Shift-P`, then type "targets visual")' # nolint
run_roxygen_comments <- 'Roxygen comments (have the cursor inside the function, type `Ctrl-Shift-P`, then type "roxygen")' # nolint
