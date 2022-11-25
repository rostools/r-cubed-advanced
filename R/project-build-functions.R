git_ci <- function(files, message) {
  gert::git_add(files)
  gert::git_commit(message)
}

write_to_file <- function(text, file, append = FALSE) {
  readr::write_lines(text, here::here(file), append = append)
}

revise_by_text <- function(path, original, replacement) {
  readr::read_lines(here::here(path)) |>
    stringr::str_replace(original, replacement) |>
    readr::write_lines(here::here(path))
}

revise_by_line_num <-
  function(path,
           insert_text,
           remove_original_lines,
           insert_at_line) {
    old_text <- readr::read_lines(here::here(path))

    if (!missing(remove_original_lines)) {
      old_text <- old_text[remove_original_lines]
    }

    if (!missing(insert_at_line)) {
      insert_at_line <- length(old_text)
    }

    old_text |>
      append(insert_text, after = insert_at_line) |>
      readr::write_lines(here::here(path))
  }

print_lines <- function(path) {
  readr::read_lines(here::here(path))
}
