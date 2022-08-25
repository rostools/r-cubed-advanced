if (interactive() & requireNamespace("usethis", quietly = TRUE)) {
    home_rprofile <- usethis:::scoped_path_r("user", ".Rprofile", envvar = "R_PROFILE_USER")
    source(home_rprofile, echo = FALSE)
}

if (interactive()) {
    source("renv/activate.R")
    options(Ncpus = 3)
}

# suppressMessages(bspm::enable())
