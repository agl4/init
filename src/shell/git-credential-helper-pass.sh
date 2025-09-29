#!/bin/sh

# git-credential-pass: A Git credential helper using pass(1)
set -eu

# Namespace inside pass where credentials will be stored
PASS_NAMESPACE="git-credential-helper"
PASSWORD_STORE_DIR=${PASSWORD_STORE_DIR:="$HOME/.password-store"}
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
    local pass_path="$PASS_NAMESPACE/$protocol/$host"
    [ -n "$username" ] && pass_path="$pass_path/$username"
    echo "$pass_path/token"
}

get_or_read_password(){
    local pass_path="$1"
    if [ ! -e "${PASSWORD_STORE_DIR}/${pass_path}.gpg" ] ; then
        >&2 echo -n "Password not found for $pass_path, please type in: "
        read -rs USER_INPUT
        if [ -z "$USER_INPUT" ] ; then
            >&2 echo "ERROR: No empty passphrase is supported."
            exit 1
        fi
        echo -n "$USER_INPUT" | pass insert -m $pass_path 2>&1 >/dev/null


    fi
    pass show "$pass_path"
}

case "$1" in
    get)
        pass_path="$(make_pass_path)"
        if [ ! -e "${PASSWORD_STORE_DIR}/${pass_path}.gpg" ] ; then
            >&2 echo "Password not found for $pass_path"
            exit 1
        fi
        password="$(pass show "$pass_path")"
        echo "username=$username"
        echo "password=$password"
        ;;
    store)
        pass_path="$(make_pass_path)"
        # Store password (first line only)
        if [ ! -e "${PASSWORD_STORE_DIR}/${pass_path}.gpg" ] ; then
            printf '%s\n' "$password" | pass insert -m "$pass_path" >/dev/null
        fi
        ;;
    erase)
        pass_path="$(make_pass_path)"
        pass rm "$pass_path" >/dev/null 2>&1 || true
        ;;
    *)
        echo "Usage: $(basename "$0") {get|store|erase}" >&2
        exit 1
        ;;
esac
