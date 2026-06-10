#!/usr/bin/env bash

# This scripts wraps rclone command so it always uses pass as a backend for
# configuration passphrase

PASS_RCLONE_PATH="rclone/config-password"
PASSWORD_COMMAND="pass-local ${PASS_RCLONE_PATH}"

# Generate password if it does not exist
$PASSWORD_COMMAND >/dev/null 2>&1 ||\
    pass-local generate -n "$PASS_RCLONE_PATH" 64 > /dev/null 2>&1

RCLONE_PATH=
case $(uname) in
    Darwin) RCLONE_PATH=/opt/homebrew/bin/rclone ;;
    Linux) RCLONE_PATH=/usr/bin/rclone ;;
    *)
        echo "ERROR: Unsupported system."
        exit 1
    ;;
esac
exec "$RCLONE_PATH" --password-command="$PASSWORD_COMMAND" "$@"
