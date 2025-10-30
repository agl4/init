#!/usr/bin/env bash

# Get the -local or whatever from the current script name, to use it for folder naming
name=$(basename "$0")
local_part="${name#pass-}"
local_part="${local_part%.sh}"

PASSWORD_STORE_DIR=${PASSWORD_STORE_DIR:="$HOME/.password-store-${local_part}"}
export PASSWORD_STORE_DIR
pass "$@"
