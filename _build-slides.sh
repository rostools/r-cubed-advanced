cp slides/introduction.qmd _introduction.qmd

quarto render _*.qmd --to r3-theme-revealjs

rm _introduction.qmd
mv _introduction.html slides/introduction.html
