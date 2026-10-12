#!/usr/bin/env bash

set -eu

# Disable SSH GUI prompts
export GPG_TTY=$(tty 2>/dev/null || echo "")
export SSH_ASKPASS_REQUIRE=none
unset SSH_ASKPASS
unset DISPLAY
unset WAYLAND_DISPLAY

KEY_TO_SIGN=""
CA_PATH_IN_PASS="ca-ssh"
CERT_VALID="+8h"
CA_PUBKEY_PATH=""
CA_NAME=""

CERT_IDENTITY_DEFAULT="${USER}@${HOSTNAME}"
CERT_EXTENSIONS_DEFAULT="clear,permit-pty"
CERT_PRINCIPALS_DEFAULT="${USER}"

_help(){
    cat <<EOF
$0 - Usage:

   $0 <options>

Options

-C NAME ........ CA name
-f PUBKEY ...... path to public key to sign
-V TIME ........ set the certificate validity (optional, default $CERT_VALID)
-P PATH ........ set the CA public key file, useful when CA is already added to agent
                 before signing

EOF

    exit 1
}

while getopts C:V:f:P:h options
do
    case $options in
        C) CA_NAME=$OPTARG ;;
        f) KEY_TO_SIGN=$OPTARG ;;
        V) CERT_VALID=$OPTARG ;;
        P) CA_PUBKEY_PATH=$OPTARG ;;
        h) _help ;;
        *) _help ;;
    esac
done

if [ -z "$KEY_TO_SIGN" ] ; then
    echo "ERROR: Missing option -f <KEY_TO_SIGN>"
    _help
fi



_sign_with_ca(){
    if [ -z "$CA_PUBKEY_PATH" ] ; then
        if [ -z "$CA_NAME" ] ; then
            echo "ERROR: CA_NAME must be defined."
            _help
        fi
        # Private throwaway agent: the CA key never enters the user's own
        # (possibly forwarded) agent, and dies with this script.
        _tmp_dir=$(mktemp -d)
        _ca_pubkey_path="${_tmp_dir}/ca.pub"
        eval "$(ssh-agent -s -a "${_tmp_dir}/agent.sock")" > /dev/null
        trap 'ssh-agent -k > /dev/null ; rm -rf "$_tmp_dir"' EXIT
        ca-ssh-add-key-to-agent-from-pass.sh \
            -t 10 \
            -p "${CA_PATH_IN_PASS}/${CA_NAME}" \
            -f "$_ca_pubkey_path"
    else
        _ca_pubkey_path="$CA_PUBKEY_PATH"
    fi

    echo "Sign the public key..."
    ssh-keygen \
        -Us "$_ca_pubkey_path" \
        -I "$CERT_IDENTITY" \
        -n "$CERT_PRINCIPALS" \
        -V "$CERT_VALID" \
        "${CERT_EXTENSIONS_OPTIONS[@]}" \
        "${KEY_TO_SIGN}.pub"

    echo
    echo "Show cert information..."
    ssh-keygen -Lf "${KEY_TO_SIGN}-cert.pub"
}

_request_file="${KEY_TO_SIGN}.req"

if [ -e "$_request_file" ] ; then
    # The request file is data, never code: KEY=VALUE lines, known keys only.
    # See share/samples/ca-ssh-sign-user-pubkey-with-pass/sample.req
    while IFS='=' read -r _key _value || [ -n "$_key" ] ; do
        case $_key in
            ''|'#'*) continue ;;
        esac
        case $_value in
            *'$'*|*'`'*)
                echo "ERROR: $_request_file: $_key: shell expansion is not supported"
                exit 1
                ;;
        esac
        case $_key in
            CA_NAME)
                case $_value in
                    */*) echo "ERROR: $_request_file: CA_NAME must not contain '/'" ; exit 1 ;;
                esac
                # -C on the command line wins
                CA_NAME=${CA_NAME:-$_value}
                ;;
            CERT_PRINCIPALS) CERT_PRINCIPALS=$_value ;;
            CERT_EXTENSIONS) CERT_EXTENSIONS=$_value ;;
            CERT_IDENTITY) CERT_IDENTITY=$_value ;;
            *) echo "ERROR: $_request_file: unknown key '$_key'" ; exit 1 ;;
        esac
    done < "$_request_file"
fi

CA_NAME=${CA_NAME:=""} # this is required
CERT_PRINCIPALS=${CERT_PRINCIPALS:="$CERT_PRINCIPALS_DEFAULT"}
CERT_EXTENSIONS=${CERT_EXTENSIONS:="$CERT_EXTENSIONS_DEFAULT"}
CERT_IDENTITY=${CERT_IDENTITY:="$CERT_IDENTITY_DEFAULT"}
CERT_EXTENSIONS_OPTIONS=( )
for ext  in $(echo "$CERT_EXTENSIONS" | tr "," "\n") ; do
    CERT_EXTENSIONS_OPTIONS+=( "-O" "$ext" )
done

_sign_with_ca
