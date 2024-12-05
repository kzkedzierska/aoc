#!/bin/bash
#==============================================================================
# Description:   Solutions for Day 1 of the Advent of Code 2024
# Author:        Kasia Kedzierska
# Date:          December 1st, 2024
# Usage:         bash Day01.sh
#==============================================================================

# Read in the helper functions
source ./misc/helper.sh

# Define file paths
example_input_file="inputs/example_day_01.txt"
input_file="inputs/day_01.txt"

# Save example input to the file
echo -e "3   4\n4   3\n2   5\n1   3\n3   9\n3   3" >"${example_input_file}"

# Define the expected test results
test_answer_p1=11
test_answer_p2=31

# Welcome message for Day 1 tasks
cat <<"EOF"

                               _    _               _   _  _       
  /\   _|     _  ._ _|_    _ _|_   /   _   _|  _     ) / \  ) |_|_ 
 /--\ (_| \/ (/_ | | |_   (_) |    \_ (_) (_| (/_   /_ \_/ /_   |  
  _                 __                                             
 | \  _.      /|   (_   _  |    _|_ o  _  ._   _                   
 |_/ (_| \/    |   __) (_) | |_| |_ | (_) | | _>                   
         /                                                         
EOF

cat <<"EOF"

  _                 
 |_) _. ._ _|_   /| 
 |  (_| |   |_    | 
                    
EOF

# Function to calculate Part 1 answer
part_one() {
  local input_file=$1
  paste \
    <(tr -s ' ' <"${input_file}" | cut -f1 -d' ' | sort) \
    <(tr -s ' ' <"${input_file}" | cut -f2 -d' ' | sort) |
    awk -v FS=" " 'function abs(x) {
      return ((x < 0.0) ? -x : x)
    } {print abs($1 - $2)}' |
    paste -sd+ - |
    bc
}

# Run test for Part 1
my_test_answer_p1=$(part_one "${example_input_file}")
test_check "${my_test_answer_p1}" "${test_answer_p1}" "Part 1 - example"

# Calculate and display the answer for Part 1
answer_p1=$(part_one "${input_file}")
print_answer "${answer_p1}" "1"

cat <<"EOF"

  _              _  
 |_) _. ._ _|_    ) 
 |  (_| |   |_   /_ 
                    
EOF

# Function to calculate Part 2 answer
part_two() {
  local input_file=$1
  join -j 1 \
    <(tr -s ' ' <"${input_file}" | cut -f1 -d' ' | sort | uniq -c |
      tr -s ' ' | awk '{print $2, $1}') \
    <(tr -s ' ' <"${input_file}" | cut -f2 -d' ' | sort | uniq -c |
      tr -s ' ' | awk '{print $2, $1}') |
    awk '{printf $1 "*" $2 "*" $3 "+"} END {print "0"}' |
    bc
}

# Run test for Part 2
my_test_answer_p2=$(part_two "${example_input_file}")
test_check "${my_test_answer_p2}" "${test_answer_p2}" "Part 2 - example"

# Calculate and display the answer for Part 2
answer_p2=$(part_two "${input_file}")
print_answer "${answer_p2}" "2"
