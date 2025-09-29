#!/usr/bin/env bash

# git-credential-pass: A Git credential helper using pass(1)
set -euo pipefail

# Namespace inside pass where credentials will be stored
PASS_NAMESPACE="git-credentials"

# Read all key=value pairs from stdin into an associative array
declare -A CREDS
while IFS='=' read -r key value; do
    [[ -z "$key" ]] && break
    CREDS["$key"]="$value"
done

# Build the pass key path: host[/path]/username
make_pass_path() {
    local protocol="${CREDS[protocol]}"
    local host="${CREDS[host]}"
    # local path="${CREDS[path]}"
    local username="${CREDS[username]}"

    local pass_path="$PASS_NAMESPACE/$protocol/$host"
    # [[ -n "$path" ]] && pass_path="$pass_path/$path"
    [[ -n "$username" ]] && pass_path="$pass_path/$username"
    echo "$pass_path/token"
}

case "$1" in
    get)
        pass_path="$(make_pass_path)"
        if pass show "$pass_path" >/dev/null 2>&1; then
            password="$(pass show "$pass_path" | head -n1)"
            echo "username=${CREDS[username]}"
            echo "password=$password"
        else
            exit 1
        fi
        ;;
    store)
        pass_path="$(make_pass_path)"
        # Store password (first line only)
        if [ "$(pass show "$pass_path")" != "${CREDS[password]}" ] ; then
            printf '%s\n' "${CREDS[password]}" | pass insert -m "$pass_path" >/dev/null
        fi
        ;;
    erase)
        pass_path="$(make_pass_path)"
        pass rm "$pass_path" >/dev/null 2>&1 || true
        ;;
    *)
        echo "Usage: $0 {get|store|erase}" >&2
        exit 1
        ;;
esac
