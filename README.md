# Reproducible Research in R: An advanced workshop on creating collaborative and automated analysis pipelines <img src="images/apple-touch-icon.png" align="right" height="100/"/>

[![License: CC BY
4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

## Description

Reproducibility and open scientific practices are increasingly being
requested or required of scientists and researchers, but training on
these practices has not kept pace. This course intends to help bridge
that gap and covers the fundamentals and workflow of data analysis in R.

This repository contains the lesson, lecture, and assignment material
for the course, including the website source files and other associated
course administration files.

For more detail on the course, check out the
[syllabus](https://r-cubed-advanced.rostools.org/content/00-syllabus.html).

## Instructional Design

The lectures and lessons in this course are designed to be presented
primarily with a participatory live-coding approach. This involves an
instructor typing and running code in
[RStudio](https://www.rstudio.com/) in front of the class, while the
class follows along using their own computers. Challenges are
interspersed in the lesson material, allowing participants to
collaboratively work on smaller coding problems for a few minutes. All
lesson materials are provided ahead of time on the course website for
participants to refer to during lectures. Throughout the course,
participants are in small groups and are encouraged to help each other
out in completing the exercises.

## Lesson content

The teaching material is found mainly in the main project folder:

-   `content/00-syllabus.qmd`: Contains the syllabus file.
-   Files in `content/` starting with a number: Contains the code-along
    teaching material.

The website is generated from [Quarto](https://quarto.org/), so it
follows the file and folder structure conventions from that package.

## Installing necessary packages

Packages used and depended on for this course are included in the
`DESCRIPTION` file. To install the packages, run this function in the
root directory (where the `r-cubed-advanced.Rproj` file is located:

``` r
# install.packages("remotes")
remotes::install_deps()
```

Or by using `{renv}`:

``` r
# install.packages("renv")
renv::restore()
```

You might need to connect to GitHub via a personal access token if you
encounter a "rate limit" when installing packages:

``` r
# usethis::create_github_token()
Sys.setenv(GITHUB_PAT = readline())
```

## Contributing

If you are interested in contributing to the course material, please
refer to the [contributing guidelines](CONTRIBUTING.md). Please note
that the project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree
to abide by its terms.
