options(
  repos = c(RSPM = "https://packagemanager.rstudio.com/all/latest"),
  browserNLdisabled = TRUE,
  deparse.max.lines = 2,
  renv.settings.snapshot.type = "explicit",
  renv.config.auto.snapshot = TRUE,
  downlit.attached = desc::desc_get_deps()$package[-1],
  Ncpus = 3,
  dplyr.summarize.inform = FALSE,
  todor_patterns = c("FIXME", "TODO", "IDEA", "NOTE"),
  warnPartialMatchArgs = TRUE,
  warnPartialMatchDollar = TRUE,
  warnPartialMatchAttr = TRUE,
  # crayon.enabled = FALSE #?
  digits = 3,
  width = 68,
  knitr.kable.NA = ""
)
options(renv.config.repos.override = getOption("repos"))

if (interactive()) {
  suppressMessages(require(devtools))
  suppressMessages(require(usethis))
  suppressMessages(require(gert))
}

try(rspm::enable(), silent = TRUE)
source("renv/activate.R")
