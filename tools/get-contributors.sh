#!/usr/bin/env bash

# Get a list of contributors to this repository and save it to
# _contributors.qmd file (will overwrite if it exists). It also:
#
# - Formats users into Markdown links to their GitHub profiles.
# - Removes any usernames with the word "bot" in them.
# - Removes the trailing comma from the list.
repo_spec=${1}
echo "These are the people who have contributed by submitting changes through pull requests :tada:\n\n" > _contributors.qmd
gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/$repo_spec/contributors \
  --template '{{range .}} [\@{{.login}}]({{.html_url}}){{"\n"}}{{end}}' | \
  grep -v "\[bot\]" | \
  tr '\n' ', ' | \
  sed -e 's/,$//' >> _contributors.qmd
