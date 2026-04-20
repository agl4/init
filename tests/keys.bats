#!/usr/bin/env bats

setup() {
    # Create a temporary directory for the test environment
    TEST_DIR="$(mktemp -d)"
    MOCK_DIR="${TEST_DIR}/mocks"
    mkdir -p "$MOCK_DIR"
    
    # Copy the script to test
    cp src/shell/keys.sh "$TEST_DIR/"
    chmod +x "$TEST_DIR/keys.sh"
    
    # Mock HOME to control where .ssh is looked for
    export HOME_MOCK="${TEST_DIR}/home"
    mkdir -p "$HOME_MOCK/.ssh"
    export HOME="$HOME_MOCK"
    
    # Add mocks to PATH
    export PATH="${MOCK_DIR}:$PATH"
    
    # Create mock scripts
    cat <<EOF > "${MOCK_DIR}/ssh-add"
#!/bin/bash
echo "ssh-add \$*" >> "${TEST_DIR}/calls.log"
EOF
    chmod +x "${MOCK_DIR}/ssh-add"

    cat <<EOF > "${MOCK_DIR}/ssh-keygen"
#!/bin/bash
echo "ssh-keygen \$*" >> "${TEST_DIR}/calls.log"
# If checking certificate, return a fixed validity
if [[ "\$*" == *"-Lf"* ]]; then
    # Return a format that grep 'Valid:' | awk '{print \$5}' will match
    # keys.sh: pubkey_valid=\$(ssh-keygen -Lf "\$cert_name" | grep 'Valid:' | awk '{print \$5}')
    # example output: Valid: from 2024-01-01T00:00:00 to 2026-05-01T00:00:00
    echo "        Valid: from 2026-04-01T00:00:00 to 2026-05-01T00:00:00"
fi
EOF
    chmod +x "${MOCK_DIR}/ssh-keygen"

    # Mock date to a fixed point in time
    cat <<EOF > "${MOCK_DIR}/date"
#!/bin/bash
if [[ "\$*" == "+%Y-%m-%dT%H:%M:%S" ]]; then
    cat "${TEST_DIR}/now" 2>/dev/null || echo "2026-04-13T12:00:00"
else
    /bin/date "\$@"
fi
EOF
    chmod +x "${MOCK_DIR}/date"

    # Mock add-ssh-key-to-agent-with-passphrase.sh in the same directory as keys.sh
    cat <<EOF > "$TEST_DIR/add-ssh-key-to-agent-with-passphrase.sh"
#!/bin/bash
echo "add-ssh-key-to-agent-with-passphrase.sh \$*" >> "${TEST_DIR}/calls.log"
EOF
    chmod +x "$TEST_DIR/add-ssh-key-to-agent-with-passphrase.sh"
}

teardown() {
    rm -rf "$TEST_DIR"
}

@test "keys.sh with no arguments calls ssh-add -l" {
    run "$TEST_DIR/keys.sh"
    [ "$status" -eq 0 ]
    grep -q "ssh-add -l" "${TEST_DIR}/calls.log"
}

@test "keys.sh with argument adds key with default timeout" {
    # Create a dummy key file
    touch "$HOME/.ssh/id_rsa"
    
    run "$TEST_DIR/keys.sh" id_rsa
    [ "$status" -eq 0 ]
    grep -q "add-ssh-key-to-agent-with-passphrase.sh -p ssh/id_rsa/passphrase -t 28800 -k $HOME/.ssh/id_rsa" "${TEST_DIR}/calls.log"
}

@test "keys.sh as keys_week adds key with 7 days timeout" {
    # Create a dummy key file
    touch "$HOME/.ssh/id_rsa"
    
    # We need to call it as keys_week
    ln -s "$TEST_DIR/keys.sh" "$TEST_DIR/keys_week"
    
    run "$TEST_DIR/keys_week" id_rsa
    [ "$status" -eq 0 ]
    grep -q "add-ssh-key-to-agent-with-passphrase.sh -p ssh/id_rsa/passphrase -t 604800 -k $HOME/.ssh/id_rsa" "${TEST_DIR}/calls.log"
}

@test "keys.sh with valid certificate adds key" {
    touch "$HOME/.ssh/id_rsa"
    touch "$HOME/.ssh/id_rsa-cert.pub"
    
    # Mock date to be before certificate expiration (which is 2026-05-01 in our mock)
    echo "2026-04-13T12:00:00" > "${TEST_DIR}/now"
    
    run "$TEST_DIR/keys.sh" id_rsa
    [ "$status" -eq 0 ]
    grep -q "ssh-keygen -Lf $HOME/.ssh/id_rsa-cert.pub" "${TEST_DIR}/calls.log"
    grep -q "add-ssh-key-to-agent-with-passphrase.sh" "${TEST_DIR}/calls.log"
}

@test "keys.sh with expired certificate shows error and exits" {
    touch "$HOME/.ssh/id_rsa"
    touch "$HOME/.ssh/id_rsa-cert.pub"
    
    # Mock date to be AFTER certificate expiration
    echo "2026-06-01T12:00:00" > "${TEST_DIR}/now"
    
    run "$TEST_DIR/keys.sh" id_rsa
    [ "$status" -eq 1 ]
    [[ "$output" == *"Key certificate expired, not adding."* ]]
}
