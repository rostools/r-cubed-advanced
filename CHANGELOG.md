# Changelog

Since we follow [Conventional
Commits](https://decisions.seedcase-project.org/why-conventional-commits),
we're able to automatically create a release based on the commit message
by using
[Commitizen](https://decisions.seedcase-project.org/why-semantic-release-with-commitizen).
This means that releases can happen quite often, sometimes several in
a day. It also means any individual release will not have many changes
within it. Below is a list of releases along with what was changed
within it.

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
