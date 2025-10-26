# Changelog {.unnumbered}

Since we follow [Conventional
Commits](https://decisions.seedcase-project.org/why-conventional-commits),
we're able to automatically create a release based on the commit message
by using
[Commitizen](https://decisions.seedcase-project.org/why-semantic-release-with-commitizen).
This means that releases can happen quite often, sometimes several in
a day. It also means any individual release will not have many changes
within it. Below is a list of releases along with what was changed
within it.

## 1.2.1 (2025-10-26)

### Refactor

- **sessions**: :art: match exercise section's format with other workshops
- **sessions**: :art: match discussion activities format from other workshops
- **sessions**: :fire: no longer need start of workshop tasks
- **sessions**: :truck: move learning objectives into includes files
- **sessions**: :recycle: convert reading sections into standalone sections
- **sessions**: :recycle: revise to using Quarto snippets rather than includes

## 1.2.0 (2025-09-06)

### Feat

- **pre-workshop**: :sparkles: put workshop Code of Conduct into repo from guides

### Fix

- **sessions**: :pencil2: don't need explicit `label`, it's duplicate in chunk label
- **overview**: :pencil2: `analyses` for link, not `analysis`
- :bug: should be spelled `internal`, not `interntal`
- :pencil2: use `rostools-theme` extension name, not `r3`
- :pencil2: correct link to `_contributors.yml`
- :pencil2: replace to normal single quote
- **sessions**: :bug: use `rostools-theme` for revealjs slides
- **pre-workshop**: :bug: wrong link to pre-workshop tasks

### Refactor

- **pre-workshop**: :recycle: don't eval the pre-workshop docs
- **overview**: :pencil2: simplify learning design, from template
- **pre-workshop**: :pencil2: simplify code of conduct, from template
- :pencil2: minor fixes after update from template
- **overview**: :recycle: list sessions in syllabus
- **pre-workshop**: :truck: rename file to `overview.qmd` in tasks
- **pre-workshop**: :recycle: edits and corrections to tasks in overview
- **pre-workshop**: :fire: don't need R code chunks in pre-workshop overview
- **pre-workshop**: :recycle: revise last task, mostly reformatting
- **pre-workshop**: :truck: split out 'pre-reading' tasks into own page
- **pre-workshop**: :truck: split out 'download data' tasks into own page
- **pre-workshop**: :truck: split 'create project' into own page
- **pre-workshop**: :truck: split "setup git" into own page
- **pre-workshop**: :truck: split installing programs into own files
- **overview**: :recycle: split 'is this for you' into own file
- **overview**: :recycle: replace survey link with shortcode to link

## 1.1.0 (2025-08-28)

### Feat

- **overview**: :sparkles: add learning design page to overview
- :memo: add badges to landing page
- :sparkles: have own page for pre-workshop survey
- :sparkles: add suvery button includes
- :sparkles: add a section specifically for teachers to appendix
- :sparkles: add `star-us` includes block

### Fix

- :fire: these were moved out of samwise

### Refactor

- :recycle: split reading website into includes
- :wrench: update `_quarto.yml` to match template changes
- **overview**: :recycle: simplified text in schedule
- :recycle: improve landing page, with changes from template
- :recycle: fill out CONTRIBUTING with more details
- :page_facing_up: switch to full Markdown version of CC-BY
- :recycle: small edits to syllabus file
- :pencil2: rename "course" to "workshop"

## v2024.12.10 (2024-12-12)

### Feat

- :sparkles: add a "code used" section to the sessions

### Fix

- **sessions**: :pencil2: should be "up" not "notes"
- **sessions**: :bug: the output is a message, so need to set message to true
- :bug: the code appendix wasn't working correctly, needed to use clearer regex
- :bug: references weren't printing, this fixes that
- **preamble**: :bug: can't have section refs start with `-`
- :bug: the logos weren't rendering properly
- **preamble**: :bug: downlit didn't seem to work, but this seems to fix it
- :bug: mermaid arrows had disappeared, fixed it
- clarify that the exercise has two parts!

### Refactor

- :recycle: this shouldn't be called `functions.R` [skip ci]
- **sessions**: :recycle: split out instructor review note into includes doc
- :recycle: use base pipe instead
- :recycle: moved some old code from r3admin into functions

## v2023.11.08 (2023-11-12)

### Fix

- typo in link. Closes #109

## v2022.12.07 (2022-12-12)
