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

  qmd_files <- fs::path_abs(c(
    "preamble/pre-course.qmd",
    "sessions/smoother-collaboration.qmd",
    "sessions/pipelines.qmd",
    "sessions/statistical-analyses.qmd"
  ))

  r_files <- fs::path_temp(fs::path_file(qmd_files))
  r_files <- fs::path_ext_set(r_files, ".R")
  purrr::walk2(qmd_files,
    r_files,
    knitr::purl,
    documentation = 0L,
    quiet = TRUE
  )

  project_custom_functions <- qmd_files |>
    purrr::map(extract_function_labels_from_qmd) |>
    purrr::compact() |>
    stringr::str_c(collapse = "\n") %>%
    append('"') %>%
    prepend('" |> readr::write_lines("R/functions.R", append = TRUE)')

  combined_r_file <- here::here("_ignore/code-to-build-project.R")
  fs::dir_create("_ignore")
  r_files |>
    purrr::map(readr::read_lines) |>
    purrr::flatten_chr() |>
    purrr::discard(~ .x == "") |>
    stringr::str_remove("^## ") |>
    append(project_custom_functions) |>
    prepend(readr::write_lines(here::here("R/build-project-functions.R"))) |>
    readr::write_lines(combined_r_file)
  fs::file_copy(combined_r_file, "~/Desktop")
}


extract_function_labels_from_qmd <- function(file) {
  qmd_as_xml <- file |>
    readr::read_lines() |>
    commonmark::markdown_xml(extensions = TRUE) |>
    xml2::read_xml()

  qmd_as_xml |>
    xml2::xml_find_all(
      # d1 is the "namespace" of the xml spec, so need this
      # to access the nodes that are called code_block,
      # and within those code blocks, only keep those
      # where the attribute "info" (@ means attribute) has
      # the pattern 'new-function' in it.
      ".//d1:code_block[contains(@info, 'new-function')]",
      # Need this to force to use `d1` as namespace.
      xml2::xml_ns(qmd_as_xml)
    ) |>
    xml2::xml_text()
}

run_styler_text <- '`{styler}` (`Ctrl-Shift-P`, then type "style file")'
run_lintr_text <- '`{lintr}` (`Ctrl-Shift-P`, then type "lint file")'
run_tar_make_text <- '`targets::tar_make()` (`Ctrl-Shift-P`, then type "targets run")'
run_tar_vis_text <- '`targets::tar_visnetwork()` (`Ctrl-Shift-P`, then type "targets visual")'
run_roxygen_comments <- 'Roxygen comments (have the cursor inside the function, type `Ctrl-Shift-P`, then type "roxygen")'

# This might need to be inside the file?
# knitr::all_labels() |>
#   stringr::str_detect("new-function") |>
#   purrr::map(~knitr::knit_code$get(.x)) |>
#   purrr::flatten_chr() |>
#   readr::write_csv(...?)
