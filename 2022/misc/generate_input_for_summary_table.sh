#!/bin/bash

# get all day headers
grep -E "^## Day|^### Part" answers.qmd |
  sed 's/## //g; s/### //g' | 
    tr '[:upper:]' '[:lower:]' | 
      sed 's/://g; s/ /-/g; s/^/#/g' > misc/solved_days

# # get all part headers
# grep "^### Part " answers.qmd  | 
#   cut -f4 -d' ' > misc/stars