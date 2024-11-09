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
    "sessions/stats-analyses-basic.qmd",
    "sessions/stats-analyses-multiple.qmd"
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
  fs::file_copy(
    here::here("R/project-build-functions.R"),
    "~/Desktop",
    overwrite = TRUE
  )

  combined_r_file <- here::here("_ignore/code-to-build-project.R")
  fs::dir_create("_ignore")
  r_files |>
    purrr::map(readr::read_lines) |>
    purrr::map2(basename(r_files), ~ append(.x, glue::glue("# From {.y} -----"), after = 0)) |>
    purrr::flatten_chr() |>
    purrr::discard(~ .x == "") |>
    stringr::str_remove("^## ") |>
    append("pak::pak('rostools/r3')", after = 3) |>
    append("fs::file_copy('~/Desktop/project-functions.R', 'R/functions.R')", after = 3) |>
    append("source('../project-build-functions.R')", after = 3) |>
    readr::write_lines(combined_r_file)
  fs::file_copy(combined_r_file, "~/Desktop", overwrite = TRUE)
}

#' Extract code blocks from a Markdown file that have a label that contains a specific string.
#'
#' @param md_file The markdown file to extract from.
#' @param string_match The string to look for that is inside the label. For
#'   instance, if the label has word "function" inside the label.
#'
#' @return
#' @export
#'
extract_code_block_with_label_string <- function(md_file, string_match) {
  md_as_xml <- md_file |>
    readr::read_lines() |>
    commonmark::markdown_xml(extensions = TRUE) |>
    xml2::read_xml()
  # d1 is the "namespace" of the xml spec, so need this
  # to access the nodes that are called code_block,
  # and within those code blocks, only keep those
  # where the attribute "info" (@ means attribute) has
  # the `pattern` in it.
  label_pattern <- glue::glue(".//d1:code_block[contains(@info, '{string_match}')]")
  md_as_xml |>
    xml2::xml_find_all(
      label_pattern,
      # Need this to force to use `d1` as namespace.
      xml2::xml_ns(md_as_xml)
    ) |>
    xml2::xml_text()
}

extract_functions_from_qmd <- function() {
  here::here() |>
    fs::dir_ls(recurse = TRUE, glob = "*.qmd") |>
    purrr::map(extract_code_block_with_label_string,
      string_match = "new-function"
    ) |>
    purrr::compact() |>
    unlist() |>
    readr::write_lines(here::here("R/project-functions.R"))
}
