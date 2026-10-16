#!/usr/bin/env bats

SCRIPT="src/shell/ca-ssh-sign-user-pubkey-with-pass.sh"

setup() {
    TEST_DIR="$(mktemp -d)"
    ssh-keygen -q -t ed25519 -N '' -f "$TEST_DIR/ca"
    ssh-keygen -q -t ed25519 -N '' -f "$TEST_DIR/user"
    # Throwaway agent holding the throwaway CA, signed against with -P
    eval "$(ssh-agent -s -a "$TEST_DIR/agent.sock")" > /dev/null
    ssh-add -q "$TEST_DIR/ca"
}

teardown() {
    ssh-agent -k > /dev/null
    rm -rf "$TEST_DIR"
}

@test "defaults: own user only, pty only" {
    run bash "$SCRIPT" -P "$TEST_DIR/ca.pub" -f "$TEST_DIR/user" <<< y
    echo "$output"
    [ "$status" -eq 0 ]
    cert="$(ssh-keygen -Lf "$TEST_DIR/user-cert.pub")"
    [[ "$cert" == *"permit-pty"* ]]
    [[ "$cert" != *"root"* ]]
    [[ "$cert" != *"forwarding"* ]]
    [[ "$cert" != *"permit-user-rc"* ]]
}

@test "request file values are applied" {
    printf '# comment\nCERT_PRINCIPALS=alice,bob\nCERT_EXTENSIONS=clear,permit-port-forwarding\n' > "$TEST_DIR/user.req"
    run bash "$SCRIPT" -P "$TEST_DIR/ca.pub" -f "$TEST_DIR/user" <<< y
    [ "$status" -eq 0 ]
    cert="$(ssh-keygen -Lf "$TEST_DIR/user-cert.pub")"
    [[ "$cert" == *"alice"* ]]
    [[ "$cert" == *"bob"* ]]
    [[ "$cert" == *"permit-port-forwarding"* ]]
    [[ "$cert" != *"permit-pty"* ]]
}

@test "request file is never executed" {
    printf 'CERT_PRINCIPALS=$(touch %s/pwned)\n' "$TEST_DIR" > "$TEST_DIR/user.req"
    run bash "$SCRIPT" -P "$TEST_DIR/ca.pub" -f "$TEST_DIR/user" <<< y
    [ "$status" -ne 0 ]
    [[ "$output" == *"ERROR: $TEST_DIR/user.req"* ]]
    [ ! -e "$TEST_DIR/pwned" ]
    [ ! -e "$TEST_DIR/user-cert.pub" ]

    printf 'touch %s/pwned\n' "$TEST_DIR" > "$TEST_DIR/user.req"
    run bash "$SCRIPT" -P "$TEST_DIR/ca.pub" -f "$TEST_DIR/user" <<< y
    [ "$status" -ne 0 ]
    [[ "$output" == *"ERROR: $TEST_DIR/user.req"* ]]
    [ ! -e "$TEST_DIR/pwned" ]
    [ ! -e "$TEST_DIR/user-cert.pub" ]
}

@test "request file cannot override settings outside the allowlist" {
    printf 'CERT_VALID=forever\n' > "$TEST_DIR/user.req"
    run bash "$SCRIPT" -P "$TEST_DIR/ca.pub" -f "$TEST_DIR/user" <<< y
    [ "$status" -ne 0 ]
    [[ "$output" == *"ERROR: $TEST_DIR/user.req"* ]]
    [ ! -e "$TEST_DIR/user-cert.pub" ]
}

@test "CA from pass is used in a private agent, not the caller's" {
    mkdir "$TEST_DIR/mocks"
    cat <<EOF > "$TEST_DIR/mocks/gopass"
#!/bin/bash
case \$1 in
    ca-ssh/testca/public) cat "$TEST_DIR/ca.pub" ;;
    ca-ssh/testca/private) cat "$TEST_DIR/ca" ;;
    *) exit 1 ;;
esac
EOF
    cp src/shell/ca-ssh-add-key-to-agent-from-pass.sh "$TEST_DIR/mocks/"
    chmod +x "$TEST_DIR/mocks/"*
    ssh-add -q -D
    agents_before="$(pgrep -x ssh-agent | sort)"

    PATH="$TEST_DIR/mocks:$PATH" run bash "$SCRIPT" -C testca -f "$TEST_DIR/user" <<< y
    echo "$output"
    [ "$status" -eq 0 ]
    ssh-keygen -Lf "$TEST_DIR/user-cert.pub" | grep -q "$(ssh-keygen -lf "$TEST_DIR/ca.pub" | awk '{print $2}')"
    # the caller's agent never saw the CA key, and no agent is left behind
    run ssh-add -l
    [[ "$output" == *"no identities"* ]]
    [ "$(pgrep -x ssh-agent | sort)" = "$agents_before" ]
}

@test "nothing is signed without an explicit y" {
    run bash "$SCRIPT" -P "$TEST_DIR/ca.pub" -f "$TEST_DIR/user" <<< n
    [ "$status" -ne 0 ]
    [[ "$output" == *"$(ssh-keygen -lf "$TEST_DIR/user.pub")"* ]]
    [ ! -e "$TEST_DIR/user-cert.pub" ]

    run bash "$SCRIPT" -P "$TEST_DIR/ca.pub" -f "$TEST_DIR/user" < /dev/null
    [ "$status" -ne 0 ]
    [ ! -e "$TEST_DIR/user-cert.pub" ]
}
