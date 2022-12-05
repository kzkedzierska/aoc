#!/bin/bash
input_file=$1
# create the stacks input
grep -v ^move ${input_file} | 
  # remove empty lines
  awk 'NF' |
    # treat all 4 spaces as empty position in stacks
    sed -r 's/ {4}/0/g' |
      # remove all spaces & [], each character should be stack
      sed -r 's/ //g;s/\[//g; s/\]//g' > ${input_file/.txt/_stacks.txt}

# create instructions input
grep ^move ${input_file} > ${input_file/.txt/_inst.txt}