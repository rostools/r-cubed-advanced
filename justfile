@_default:
  just --list --unsorted

# Run all recipes
run-all: install-deps format-all check-all build-all

# List all TODO items in the repository
list-todos:
  grep -R -n \
  --exclude-dir=.quarto \
  --exclude-dir=_book \
  --exclude-dir=_site \
  --exclude-dir=.git \
  --exclude=justfile \
  --exclude=copier.yaml \
  "TODO" .

# Install or update the pre-commit hooks
install-precommit:
  # Install pre-commit hooks
  uvx pre-commit install
  uvx pre-commit run --all-files
  uvx pre-commit autoupdate

# Install workshop's package dependencies
install-deps:
  #!/usr/bin/Rscript
  pak::pak(ask = FALSE)

# Install development dependencies
install-dev-deps:
  uv tool install jarl-linter
  uv tool install air-formatter

# Update the Quarto rostools-theme extension
update-quarto-theme:
  # Will also add if it isn't already installed.
  quarto update rostools/rostools-theme --no-prompt
  # Soft link so Revealjs slides can use the extension.
  ln -s _extensions/ slides/

# Run all formatters
format-all: format-md format-r

# Format Markdown files
format-md:
  # Use both rumdl and panache, for different purposes
  uvx rumdl fmt --silent
  uvx --from panache-cli panache format . --quiet

# Format R code
format-r:
  uvx --from air-formatter air format .

# Run all check recipes
check-all: check-spelling check-urls check-r

# Check for spelling errors in files
check-spelling:
  uvx typos --config .config/typos.toml

# Check that URLs work
check-urls:
    lychee . --config .config/lychee.toml

# Lint R code for any potential issues
check-r:
  uvx --from jarl-linter jarl check .

# Run all build recipes
build-all: build-contributors build-readme build-website

# Re-build the README file from the Quarto version
build-readme:
  uvx --from quarto quarto render README.qmd --to gfm

# Generate a Quarto include file with the contributors
build-contributors:
  sh ./tools/get-contributors.sh rostools/r-cubed-advanced > includes/_contributors.qmd

# Build Quarto website
build-website:
  quarto render

# Preview the website with automatic reload on changes
preview-website:
  quarto preview

# Check for and apply updates from the template
update-from-template:
  uvx copier update --defaults

# Reset repo changes to match the template
reset-from-template:
  uvx copier recopy --defaults
