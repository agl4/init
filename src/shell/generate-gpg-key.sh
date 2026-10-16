#!/usr/bin/env bash

set -eu

_help() {
    cat <<EOF
Usage: $0 [-h] [-p]

Generates a machine-local OpenPGP key and stores the public key in the password store.

Options:
  -h  show this help
  -p  print the key ID of the existing machine-local key and exit
EOF
}

PRINT_ONLY=
while getopts "hp" opt; do
    case "$opt" in
        h) _help; exit 0 ;;
        p) PRINT_ONLY=1 ;;
        *) _help >&2; exit 2 ;;
    esac
done
shift $((OPTIND - 1))

THIS_DOMAIN=mmegh.local
THIS_HOSTNAME="$(hostname | cut -d'.' -f1)"
KEY_EMAIL="${USER}@${THIS_HOSTNAME}.${THIS_DOMAIN}"

_key_id() {
    gpg --list-keys --with-colons "$KEY_EMAIL" 2>/dev/null | awk -F: '/^pub/ {print $5}' | tail -n1
}

if [ -n "$PRINT_ONLY" ]; then
    KEY_ID="$(_key_id)"
    if [ -z "$KEY_ID" ]; then
        >&2 echo "ERROR: no key found for $KEY_EMAIL"
        exit 1
    fi
    echo "0x$KEY_ID"
    exit 0
fi

PASSWORD_STORE_DIR=${PASSWORD_STORE_DIR:="$HOME/.local/share/gopass/stores/root"}
export PASSWORD_STORE_DIR

if [ ! -d "${PASSWORD_STORE_DIR}" ] ; then
    >&2 echo "ERROR: Password store is not initiated yet: $PASSWORD_STORE_DIR"
    exit 1
fi

gpg -k "$KEY_EMAIL" 2>/dev/null && {
    echo "ERROR: key already generated for this email, not generating a new one."
    exit 1
}

PASS_PREFIX="gpg/machine-local/${KEY_EMAIL}"
gopass generate "${PASS_PREFIX}/passphrase" 45
PASSPHRASE="$(gopass show -o "${PASS_PREFIX}/passphrase")"
if [ -z "$PASSPHRASE" ] ; then
    >&2 echo "ERROR: empty passphrase in ${PASS_PREFIX}/passphrase"
    exit 1
fi

gpg --batch --generate-key - <<EOF
%echo Generating a local OpenPGP key
Key-Type: eddsa
Key-Curve: ed25519
Key-Usage: sign
Name-Real: Attila GOLONCSER
Name-Comment: machine-local
Name-Email: $KEY_EMAIL
Expire-Date: 0
Subkey-Type: ecdh
Subkey-Curve: cv25519
Subkey-Usage: encrypt
Passphrase: $PASSPHRASE
%commit
%echo done
EOF

KEY_ID="$(_key_id)"

if [ -z "$KEY_ID" ] ; then
    >&2 echo "ERROR: cannot find generated key ID"
    exit 1
fi

gpg -k "$KEY_ID"
