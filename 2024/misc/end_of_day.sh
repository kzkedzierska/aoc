#!/bin/bash

for d in day_*/; do

  [ -f "$d/notebook.ipynb" -a -f "$d/index.html" ] &&
    [ "$d/notebook.ipynb" -nt "$d/index.html" ] &&
    (cd "$d" && quarto render notebook.ipynb -o index.html)

done

aoc_website="${HOME}/github/website_project/resources/aoc/2024/"

for d in day_*/; do

  [ -f "$d/index.html" -a -f "${aoc_website}/$d/index.html" ] &&
    [ "$d/index.html" -nt "${aoc_website}/$d/index.html" ] &&
    cp "$d/index.html" "${aoc_website}/$d/index.html"

done

# check with git if there are changes

git -C "${aoc_website}" status