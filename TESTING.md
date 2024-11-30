# Testing Guide for sig2dot-custom

## Setting Up a Test Environment

### 1. Creating Test Keys
To properly test sig2dot-custom, you'll need multiple GPG keys with cross-signatures. Here's how to create a test environment:

```bash
# Create test key 1
gpg --batch --generate-key <<EOF
Key-Type: RSA
Key-Length: 2048
Name-Real: Test User One
Name-Email: test1@example.com
Expire-Date: 0
%no-protection
%commit
EOF

# Create test key 2
gpg --batch --generate-key <<EOF
Key-Type: RSA
Key-Length: 2048
Name-Real: Test User Two
Name-Email: test2@example.com
Expire-Date: 0
%no-protection
%commit
EOF

# Create test key 3
gpg --batch --generate-key <<EOF
Key-Type: RSA
Key-Length: 2048
Name-Real: Test User Three
Name-Email: test3@example.com
Expire-Date: 0
%no-protection
%commit
EOF
```

### 2. Creating Cross-Signatures
After creating the test keys, create signature relationships between them:

```bash
# Export public keys
gpg --export -a "test1@example.com" > key1.asc
gpg --export -a "test2@example.com" > key2.asc
gpg --export -a "test3@example.com" > key3.asc

# Import and sign keys
gpg --import key1.asc
gpg --import key2.asc
gpg --import key3.asc

# Create cross-signatures
gpg --sign-key test2@example.com
gpg --sign-key test3@example.com

# Switch to second key and sign others
gpg --default-key test2@example.com --sign-key test1@example.com
gpg --default-key test2@example.com --sign-key test3@example.com

# Switch to third key and sign others
gpg --default-key test3@example.com --sign-key test1@example.com
gpg --default-key test3@example.com --sign-key test2@example.com
```

## Test Cases

### 1. Basic Functionality
```bash
# Test with empty keyring
gpg --list-sigs --with-colons | ./sig2dot-custom > empty.dot

# Test with single key (self-signatures only)
gpg --list-sigs --with-colons test1@example.com | ./sig2dot-custom > single.dot

# Test with multiple keys and cross-signatures
gpg --list-sigs --with-colons | ./sig2dot-custom > full.dot
```

### 2. Edge Cases
```bash
# Test with expired keys
gpg --list-sigs --with-colons --include-expired | ./sig2dot-custom > expired.dot

# Test with revoked keys
gpg --list-sigs --with-colons --include-revoked | ./sig2dot-custom > revoked.dot

# Test with invalid signatures
# (Create this by modifying a key after it's been signed)
```

### 3. Performance Testing
```bash
# Test with large keyring
# (Import a public keyserver's keys first)
time gpg --list-sigs --with-colons | ./sig2dot-custom > large.dot
```

## Expected Results

### 1. Empty Keyring
- Should generate valid DOT file
- No nodes or edges should be present

### 2. Single Key
- One node should be present
- Self-signature should be shown only if --all flag is used

### 3. Multiple Keys with Cross-Signatures
- All keys should appear as nodes
- Signatures should appear as directed edges
- Node labels should show user information
- Graph should be connected if all keys have signed each other

### 4. Error Cases
- Invalid input should produce appropriate error messages
- Script should not crash on malformed input
- Empty lines should be handled gracefully
- Missing fields should be handled gracefully

## Verification Steps

1. Generate DOT file:
```bash
gpg --list-sigs --with-colons | ./sig2dot-custom > test.dot
```

2. Verify DOT syntax:
```bash
dot -Tpng test.dot -o /dev/null
```

3. Generate visualization:
```bash
dot -Tpng test.dot -o test.png
```

4. Visual verification:
- Check that all keys are represented
- Verify signature relationships are correct
- Confirm node labels are readable
- Ensure graph layout is clear and understandable

## Known Issues

1. Current Keyring Status
- The current implementation shows limited visualization with only self-signatures
- Cross-signatures need to be created for meaningful graph generation

2. Edge Cases
- Expired keys handling needs improvement
- Revoked signature handling needs testing
- Large keyring performance needs optimization

## Troubleshooting

If the graph appears empty:
1. Verify that the keyring contains multiple keys
2. Confirm that cross-signatures exist between keys
3. Check GPG output format is correct (--with-colons)
4. Verify that sig2dot-custom is processing signature records correctly

If the graph is unclear:
1. Try adjusting GraphViz layout engine (dot, neato, fdp)
2. Modify node spacing in the DOT output
3. Adjust node and edge attributes for better visibility
