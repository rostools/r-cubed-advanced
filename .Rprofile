options(
    repos = c(RSPM = "https://packagemanager.rstudio.com/all/latest"),
    browserNLdisabled = TRUE,
    deparse.max.lines = 2,
    renv.settings.snapshot.type = "explicit",
    styler.addins_style_transformer = "styler::tidyverse_style(indent_by = 4)",
    renv.config.auto.snapshot = TRUE,
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
    suppressMessages(rspm::enable())
    source("renv/activate.R")
    options(Ncpus = 3)
}
