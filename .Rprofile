options(
  repos = c(RSPM = "https://packagemanager.rstudio.com/all/latest"),
  browserNLdisabled = TRUE,
  deparse.max.lines = 2,
  renv.settings.snapshot.type = "explicit",
  renv.config.auto.snapshot = TRUE,
  styler.cache_root = "styler",
  Ncpus = 3,
  dplyr.summarize.inform = FALSE,
  todor_patterns = c("FIXME", "TODO", "IDEA", "NOTE"),
  warnPartialMatchArgs = TRUE,
  warnPartialMatchDollar = TRUE,
  warnPartialMatchAttr = TRUE,
  digits = 3,
  width = 68,
  knitr.kable.NA = ""
)
options(renv.config.repos.override = getOption("repos"))

if (interactive()) {
  suppressMessages(require(devtools))
  suppressMessages(require(usethis))
  suppressMessages(require(gert))
  try(rspm::enable(), silent = TRUE)
  source("renv/activate.R")
}

# Do it this way to fix a GitHub Action build issue.
# Since the Action runs this profile first *before*
# installing packages (before desc gets installed), it
# throws an error about not finding desc. So this needs
# to be put in this if condition at first.
if (requireNamespace("desc", quietly = TRUE)) {
  options(
    downlit.attached = desc::desc_get_deps()$package[-1]
  )
}
