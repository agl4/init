#!/usr/bin/env bash

set -eu

# Default values
LENGTH=4
PREFIX="L-"
INCLUDE_NUMBERS=
LOWER_CASE=
UPPER_CASE=

# Function to display help message
show_help() {
  cat <<EOF
Usage: $0 [OPTIONS]

Generate a random uppercase alphanumerical string with a configurable prefix.

Options:
  -l LENGTH   Set the length of the random string (default: 4)
  -p PREFIX   Set the prefix for the output string (default: 'L-')
  -n          Exclude numerical characters from the random string
  -h          Show this help message and exit

Example Usage:
  $0 -l 6 -p CUSTOM-    Generates a string like CUSTOM-XFJRT2
  $0 -n                 Generates a string like L-WJKM (letters only)
EOF
}

# Parse command-line options
while getopts l:p:n:hLU opt; do
  case "$opt" in
    l)
      if [[ "$OPTARG" =~ ^[0-9]+$ ]]; then
        LENGTH=$OPTARG
      else
        echo "Error: Length must be a numeric value."
        exit 1
      fi
      ;;
    U) UPPER_CASE=1 ;;
    L) LOWER_CASE=1 ;;
    p) PREFIX=$OPTARG ;;
    n) INCLUDE_NUMBERS=1 ;;
    h) show_help; exit 0 ;;
    *) echo "Error: Invalid option -$OPTARG"; exit 1 ;;
  esac
done

# Define character set
if [ -n "$INCLUDE_NUMBERS" ]; then
  CHARSET="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
else
  CHARSET="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
fi

# Generate random string (macOS & FreeBSD use jot, Linux uses tr)
if command -v jot >/dev/null 2>&1; then
  RANDOM_STRING=$(jot -r "$LENGTH" 65 90 | awk '{printf "%c", $1}')
  if [ "$INCLUDE_NUMBERS" = true ]; then
    RANDOM_STRING=$(jot -r "$LENGTH" 48 90 | awk '{printf "%c", ($1 < 58 || $1 > 64) ? $1 : ($1 + 7)}')
  fi
else
  RANDOM_STRING=$( tr -dc "$CHARSET" < /dev/urandom | head -c "$LENGTH")
fi

# Output final result
if [ -n "$UPPER_CASE" ] ; then
    echo "$PREFIX$RANDOM_STRING" | tr '[:lower:]' '[:upper:]'
elif [ -n "$LOWER_CASE" ] ; then
    echo "$PREFIX$RANDOM_STRING" | tr '[:upper:]' '[:lower:]'
else
    echo "$PREFIX$RANDOM_STRING"
fi
