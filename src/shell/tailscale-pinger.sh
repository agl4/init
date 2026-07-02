#!/usr/bin/env bash

set -eu

declare -a TARGETS
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="${HOME}/.config"}
NAME="tailscale-pinger"
FILE_CONFIG="${XDG_CONFIG_HOME}/${NAME}.conf"

while getopts c:t: options
do
    case "$options" in
        c) FILE_CONFIG="$OPTARG" ;;
        t) TARGETS+=("$OPTARG") ;;
    esac
done

if [ -f "${FILE_CONFIG}" ] ; then
    source "${FILE_CONFIG}"
else
    echo "ERROR: Config file missing: $FILE_CONFIG"
    exit 1
fi

_tailscale_ping(){
    TARGET="$1"
    COOLDOWN_FILE="/dev/shm/${NAME}-cooldown-${TARGET}"
    CUTOFF="/dev/shm/${NAME}-cutoff-${TARGET}"
    if [ -f "$COOLDOWN_FILE" ] ; then
        # Create cutoff timestamp
        touch -d "59 minutes ago" "$CUTOFF"
        # If cooldown active → exit
        if [ "$COOLDOWN_FILE" -nt "$CUTOFF" ]; then
            exit 0
        fi
    fi
    tailscale ping --c 3 --timeout 10s "$TARGET" > /dev/null 2>&1 || true
    ONLINE=$(tailscale status --json | jq -r ".Peer[] | select(.HostName==\"$TARGET\") | .Online")
    if [ "$ONLINE" != "true" ]; then
        curl -s \
            -F "token=$PUSHOVER_TOKEN" \
            -F "user=$PUSHOVER_USER" \
            -F "message=Host $TARGET is DOWN" \
            https://api.pushover.net/1/messages.json

        # Start cooldown
        touch "$COOLDOWN_FILE"
    fi
}

for i in "${TARGETS[@]}"; do
    _tailscale_ping $i
done
