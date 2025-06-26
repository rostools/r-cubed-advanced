# Reproducible Research in R: An advanced workshop on creating collaborative and automated analysis pipelines

[![License: CC BY
4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

## Description

Reproducibility and open scientific practices are increasingly being
requested or required of scientists and researchers, but training on
these practices has not kept pace. This workshop intends to help bridge
that gap and covers the fundamentals and workflow of data analysis in R.

This repository contains the lesson, lecture, and assignment material
for the workshop, including the website source files and other associated
workshop administration files.

For more detail on the workshop, check out the
[syllabus](https://r-cubed-advanced.rostools.org/preamble/syllabus.html).

## Instructional Design

The lectures and lessons in this workshop are designed to be presented
primarily with a participatory live-coding approach. This involves an
instructor typing and running code in
[RStudio](https://www.rstudio.com/) in front of the class, while the
class follows along using their own computers. Challenges are
interspersed in the lesson material, allowing participants to
collaboratively work on smaller coding problems for a few minutes. All
lesson materials are provided ahead of time on the workshop website for
participants to refer to during lectures. Throughout the workshop,
participants are in small groups and are encouraged to help each other
out in completing the exercises.

## Lesson content

The teaching material is found mainly in the project folders:

- `preamble/`: Contains the syllabus and the schedule files.
- `sessions/`: Contains the code-along teaching material, as well as
    associated links to the lecture slides.
- `slides/`: Contains the slides, created as Revealjs HTML slides by
    using Quarto.
- `appendix/`: Contains the supplemental or secondary content.

The website is generated from [Quarto](https://quarto.org), so follows
the file and folder structure conventions from that package.

## Installing necessary packages

Packages used and depended on for this workshop are included in the
`DESCRIPTION` file. To install the packages, run this function in the
root directory (where the `r-cubed-advanced.Rproj` file is located:

``` r
# install.packages("pak")
pak::pak()
```

You might need to connect to GitHub via a personal access token if you
encounter a "rate limit" when installing packages:

``` r
# usethis::create_github_token()
gitcreds::gitcreds_set()
```

For Linux users (and maybe Mac?), you will probably need to install
extra dependencies:

``` bash
sudo apt install libglpk-dev libpoppler-cpp-dev
```

## Contributing

If you are interested in contributing to the workshop material, please
refer to the [contributing guidelines](CONTRIBUTING.md). Please note
that the project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree
to abide by its terms.
