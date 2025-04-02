#!/usr/bin/env bash

set -euxv

DIR_OUTPUT=.

while getopts o: options
do
    case $options in
        o) DIR_OUTPUT=$OPTARG ;;
        *) exit 1;
    esac
done

while read -r url ; do
    name=$(basename "$url")
    echo "$url"
    git clone --mirror "$url" "${DIR_OUTPUT}/${name}" || {
        git -C "${DIR_OUTPUT}/${name}" fetch --prune --verbose
        git -C "${DIR_OUTPUT}/${name}" gc --prune=now
        git -C "${DIR_OUTPUT}/${name}" repack -d
    }
done < <(gh repo list --json  url  --limit 600 | jq -r .[].url)
