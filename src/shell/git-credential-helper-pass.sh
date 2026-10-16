#!/bin/sh

# git-credential-pass: A Git credential helper using pass(1)
set -eu

# Namespace inside pass where credentials will be stored
PASS_NAMESPACE="local/git-credential-helper"
# PASSWORD_STORE_DIR=${PASSWORD_STORE_DIR:="$HOME/.local/share/gopass/stores/local"}
# export PASSWORD_STORE_DIR
# Read key=value pairs from stdin into variables
protocol=""
host=""
username=""
password=""

while IFS='=' read -r key value; do
    case "$key" in
        "") break ;;
        protocol) protocol="$value" ;;
        host) host="$value" ;;
        username) username="$value" ;;
        password) password="$value" ;;
    esac
done

# Build the pass key path: host/username
make_pass_path() {
    pass_path="$PASS_NAMESPACE/$protocol/$host"
    [ -n "$username" ] && pass_path="$pass_path/$username"
    echo "$pass_path/token"
}

# Check without decrypting, so a missing entry does not wait for gpg
pass_exists() {
    gopass ls --flat | grep -qFx "$1"
}

case "$1" in
    get)
        pass_path="$(make_pass_path)"
        if ! pass_exists "$pass_path" ; then
            >&2 echo "Password not found for $pass_path"
            exit 1
        fi
        >&2 echo "Waiting for gpg..."
        password="$(gopass show -o "$pass_path")"
        echo "username=$username"
        echo "password=$password"
        ;;
    store)
        pass_path="$(make_pass_path)"
        # Store password (first line only)
        if ! pass_exists "$pass_path" ; then
            printf '%s\n' "$password" | gopass insert -m "$pass_path" >/dev/null
        fi
        ;;
    erase)
        pass_path="$(make_pass_path)"
        gopass rm -f "$pass_path" >/dev/null 2>&1 || true
        ;;
    *)
        echo "Usage: $(basename "$0") {get|store|erase}" >&2
        exit 1
        ;;
esac
