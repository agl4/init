#!/usr/bin/env bash

set -eu

PASSWORD_STORE_DIR=${PASSWORD_STORE_DIR:="$HOME/.password-store"}
export PASSWORD_STORE_DIR

if [ ! -d "${PASSWORD_STORE_DIR}" ] ; then
    >&2 echo "ERROR: Password store is not initiated yet: $PASSWORD_STORE_DIR"
    exit 1
fi

THIS_DOMAIN=mmegh.local
THIS_HOSTNAME="$(hostname | cut -d'.' -f1)"
KEY_EMAIL="${USER}@${THIS_HOSTNAME}.${THIS_DOMAIN}"

gpg -k "$KEY_EMAIL" 2>/dev/null && {
    echo "ERROR: key already generated for this email, not generating a new one."
    exit 1
}

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
%commit
%echo done
EOF

KEY_ID="$(gpg --list-keys --with-colons "$KEY_EMAIL"| awk -F: '/^pub/ {print $5}' | tail -n1)"

if [ -z "$KEY_ID" ] ; then
    >&2 echo "ERROR: cannot find generated key ID"
    exit 1
fi

gpg --export --armor "$KEY_ID" | pass insert -m "gpg/machine-local/${KEY_EMAIL}/${KEY_ID}-pub.asc"

echo
gpg -k "$KEY_ID"
