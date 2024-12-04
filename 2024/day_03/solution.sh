#!/bin/bash
#==============================================================================
# Description:   Solutions for Day 3 of the Advent of Code 2024
# Author:        Kasia Kedzierska
# Date:          December 3rd, 2024
# Usage:         bash Day03.sh
#==============================================================================

# Read in the helper functions
source ../misc/helper.sh

# Define inputs
read -r example_input_p1 <<'EOF'
xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
EOF

read -r example_input_p2 <<'EOF'
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
EOF

# Define the expected test results
test_answer_p1=161
test_answer_p2=48

input_file="inputs/Day03.txt"

# Welcome message for Day 1 tasks
cat <<"EOF"

                               _    _               _   _  _       
  /\   _|     _  ._ _|_    _ _|_   /   _   _|  _     ) / \  ) |_|_ 
 /--\ (_| \/ (/_ | | |_   (_) |    \_ (_) (_| (/_   /_ \_/ /_   |  
  _           _     __                                             
 | \  _.      _)   (_   _  |    _|_ o  _  ._   _                   
 |_/ (_| \/   _)   __) (_) | |_| |_ | (_) | | _>                   
         /                                                                                                              

EOF

cat <<"EOF"

  _                 
 |_) _. ._ _|_   /| 
 |  (_| |   |_    | 
                    
EOF

# Function to calculate Part 1 answer
part_one() {
  local input="${1:-/dev/stdin}"

  cat "${input}" |
    grep -o 'mul([0-9]\{1,3\},*[0-9]\{1,3\})' |
    sed 's/mul(//g;s/)//g;s/,/*/g' |
    xargs |
    sed 's/ /+/g' |
    bc
}

# Run test for Part 1
my_test_answer_p1=$(echo "${example_input_p1}" | part_one)
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
  local input="${1:-/dev/stdin}"

  cat "${input}" |
    grep -o "mul([0-9]\{1,3\},*[0-9]\{1,3\})\|don't()\|do()" |
    sed 's/mul(//g;s/)//g;s/,/*/g;s/(//g' |
    awk '
BEGIN { go = 1 }
{
    if ($1 == "don'\''t") {
        go = 0
    } else if ($1 == "do") {
        go = 1
    } else if (go) {
        print $1
    }
}' |
    xargs |
    sed 's/ /+/g' |
    bc
}

# Run test for Part 2
my_test_answer_p2=$(echo "${example_input_p2}" | part_two)
test_check "${my_test_answer_p2}" "${test_answer_p2}" "Part 2 - example"
test_check "${my_test_answer_p1}" "${test_answer_p1}" "Part 2 - example from Part 1"

# Calculate and display the answer for Part 2
answer_p2=$(part_two "${input_file}")
print_answer "${answer_p2}" "2"
