#!/bin/sh

#
# Wrapper script to add entries to known_hosts via ssh-keyscan
#

set -eu

_help() {
    cat <<EOF
Usage: $0 <hostname>

Wrapper script to add entries to known_hosts via ssh-keyscan.
EOF
}

if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    _help
    exit 1
fi

ssh-keyscan "$1" | tee -a "$HOME/.ssh/known_hosts"
