#!/bin/bash
#==============================================================================
# Description:   Helper functions for the Advent of Code 2024
# Author:        Kasia Kedzierska
# Date:          December 3rd, 2024
#==============================================================================

# Function to check if a test passed
test_check() {
  local actual=$1
  local expected=$2
  local comment=$3
  local msg

  if [ "${actual}" -ne "${expected}" ]; then
    msg="${comment} Test failed: ${actual} != ${expected}"
    command -v cowsay >/dev/null &&
      cowsay -f mutilated "${msg}" ||
      echo "❌ ${msg}"
    echo "Test failed, exiting..."
    exit 1
  else
    msg="${comment} test passed!"
    command -v cowsay >/dev/null &&
      cowsay -f tux "${msg}" ||
      echo "✔️ ${msg}"
  fi
}

# Print the answer
print_answer() {
  local answer=$1
  local part=$2
  local msg="Part ${part} answer is: ${answer}"
  command -v cowsay >/dev/null &&
    cowsay -f default "${msg}" ||
    echo -e "${msg}"
}
