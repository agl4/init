#!/usr/bin/env bash

set -eu

KEYWORD="BW"
FORCE=

while getopts Fd: options
do
    case $options in
        d) DIR_WORK=$OPTARG ;;
        F) FORCE=1 ;;
        *) exit 1 ;;
    esac
done

if [ ! -d "$DIR_WORK" ] ; then
    echo "$DIR_WORK is not a directory"
    exit 1
fi

# Function to verify conditions
verify_conditions() {
  local file
  local camera_model_name
  local picture_control_name
  local saturation

  file="$1"
  camera_model_name=$(exiftool -Model -b "$file")
  picture_control_name=$(exiftool -PictureControlName -b "$file")
  saturation=$(exiftool -Saturation -b "$file")

  if [[ "$camera_model_name" == "NIKON D750" && "$picture_control_name" == "MONOCHROME" ]]; then
    return 0  # Conditions met for NIKON D750
  elif [[ "$camera_model_name" == "X-T2" && "$saturation" == "1282" ]]; then
    return 0  # Conditions met for X-T2
  else
    return 1  # Conditions not met
  fi
}

# Function to add "BW" label if conditions are met
add_bw_label() {
  local file
  local label
  file="$1"
  label=$(exiftool -Keywords -b "$file")

  # Check if "BW" label already exists
  if [[ "$label" == *"$KEYWORD"* ]]; then
      echo "Skipping file, keyword already set: $file"
      return
  fi

  if verify_conditions "$file"; then
    # Update the label without modifying the original metadata
    # echo exiftool -m -Label="$new_label" -overwrite_original "$file"
    echo "File MATCHES: $file"
    if [ -n "$FORCE" ] ; then
        exiftool -keywords+="BW" -overwrite_original "$file" && echo "Added 'BW' label to $file"
    fi
  else
    echo "File does not match: $file"
  fi
}

# Process all files in DIR_WORK directory
find "$DIR_WORK" -name "*.JPG" -o -name "*.jpg" -type f | while read -r file; do
  add_bw_label "$file"
done

if [ -z "$FORCE" ] ; then
    echo "This was just a dry-run, run the command with -F to write the keywords to files."
fi
