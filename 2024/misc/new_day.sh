#!/bin/bash
#==============================================================================
# Description:   Helper command to create a new day directory
# Author:        Kasia Kedzierska
# Date:          December 4th, 2024
#==============================================================================
#!/bin/sh

# Get the directory of this script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
SCRIPT_NAME="${0##*/}"

# Error function for standardized error messages
error() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') -- ERROR: $*" 1>&2
  usage_and_exit 1
}

# Display usage information
usage() {
  cat <<EOF
Usage: ${SCRIPT_NAME} [day_number]

Description:
  Helper command to create a new day directory for the Advent of Code 2024.

Arguments:
  day_number  The number of the day to create a directory for. If not provided, 
              the next day number will be used.
EOF
}

# Exit with usage information
usage_and_exit() {
  usage
  exit "$1"
}

# Parse the provided day number or determine the next day number
if [ -z "$1" ]; then
  # Find the highest existing day number
  last_day=$(
    find . -maxdepth 1 -type d -name 'day_*' |
      grep -o '[0-9]*' |
      sort -n |
      tail -n 1
  )
  # Default to day 1 if no days exist
  last_day=${last_day:-0}
  new_day=$((10#${last_day} + 1))
else
  # Validate input is a positive integer
  case "$1" in
  '' | *[!0-9]*) error "Invalid day number: $1. Must be a positive integer." ;;
  *) new_day=$1 ;;
  esac
fi

# Format the day number with leading zeros
new_day_w0=$(printf "%02d" "${new_day}")

# Notify user of the directory being created
echo "Creating day_${new_day_w0} directory..."

# Create the new day directory, fail if it already exists
if ! mkdir "day_${new_day_w0}"; then
  error "Directory day_${new_day_w0} already exists."
fi

# Symlink the misc directory
if ! ln -s ../misc "day_${new_day_w0}/misc"; then
  error "Failed to create symlink for 'misc'."
fi

# Copy the template notebook
notebook_target="day_${new_day_w0}/notebook.ipynb"
if ! cp "${DIR}/template.ipynb" "${notebook_target}"; then
  error "Failed to copy template notebook to ${notebook_target}."
fi

# Replace placeholders in the notebook (use a temporary file for safety)
tmp_file=$(mktemp) || error "Failed to create temporary file."
sed -e "s/<TITLE>/Day ${new_day}/g" \
  -e "s/<DATE>/$(date +'%B %d, %Y')/g" \
  "${notebook_target}" >"${tmp_file}" ||
  error "Failed to process template placeholders."

# Move the temporary file back to the original location
if ! mv "${tmp_file}" "${notebook_target}"; then
  error "Failed to update notebook file with processed template."
fi

msg="Day ${new_day_w0} directory created successfully."
# Final success message
if command -v cowsay &>/dev/null; then
  cowsay "${msg}"
else
  echo "${msg}"
fi
