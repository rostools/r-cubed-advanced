git_ci <- function(files, message) {
  gert::git_add(files)
  gert::git_commit(message)
}

write_to_file <- function(text, file, append = FALSE) {
  readr::write_lines(text, here::here(file), append = append)
}
