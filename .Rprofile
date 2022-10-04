options(
    repos = c(RSPM = "https://packagemanager.rstudio.com/all/latest"),
    browserNLdisabled = TRUE,
    deparse.max.lines = 2,
    dplyr.summarize.inform = FALSE,
    todor_patterns = c("FIXME", "TODO", "IDEA", "NOTE"),
    warnPartialMatchArgs = TRUE,
    warnPartialMatchDollar = TRUE,
    warnPartialMatchAttr = TRUE
)

if (interactive()) {
    suppressMessages(require(devtools))
    suppressMessages(require(usethis))
    suppressMessages(require(gert))
}

if (interactive()) {
    source("renv/activate.R")
    options(Ncpus = 3)
}
