# sig2dot2 - a wrapper for sig2dot-custom GPG Key Signature Visualization Tool

## Overview
sig2dot2 is a bash shell script that uses sig2dot-custom, a Perl script that generates DOT graph visualizations of GPG key signature relationships. It processes GPG key data and creates a graph where nodes represent GPG keys and edges represent signatures between keys.

## Features
- Processes GPG's colon-delimited output format
- Generates GraphViz DOT format output
- Supports visualization of key signature relationships
- Handles both regular signatures and self-signatures (optional)
- Provides clear node labeling with key owner information

## Prerequisites
- Perl
- GPG (GnuPG)
- GraphViz (for rendering the DOT output)

## Usage

```bash
$ sig2dot2 
```

## Current Implementation Details

### Input Processing
- Reads GPG's colon-delimited format
- Processes pub, uid, and sig record types
- Extracts key IDs and user information
- Tracks signature relationships between keys

### Graph Generation
- Creates nodes for each unique key ID
- Labels nodes with user information (name and email)
- Generates edges for signature relationships
- Supports optional inclusion of self-signatures

### Data Structures
- Uses hash tables for efficient key-value lookups
- Maintains separate structures for:
  - Key IDs
  - User names/labels
  - Signature relationships
  - Temporary signature storage

## Current Limitations
1. The script currently requires a keyring with cross-signatures between different keys to generate meaningful graphs
2. Self-signatures are excluded by default to reduce visual clutter
3. The current implementation focuses on basic signature relationships and doesn't yet visualize:
   - Trust levels
   - Key validity periods
   - Signature timestamps
   - Revocation certificates

## Testing Notes
During testing, we discovered that a typical personal GPG keyring often contains primarily self-signatures. To generate more interesting visualizations, you should:

1. Create multiple GPG keys
2. Exchange and sign keys with other users
3. Import signed keys back into your keyring

This will create the cross-signature relationships needed for meaningful visualization.

## Future Enhancements
1. Add support for trust visualization
2. Implement signature timestamp visualization
3. Add filtering options for different types of signatures
4. Include key validity period information
5. Add support for revocation certificate visualization
6. Implement more advanced graph styling options
7. Add configuration file support for customization

## Contributing
Contributions are welcome! Please feel free to submit pull requests or open issues for:
- Bug reports
- Feature requests
- Documentation improvements
- Code optimizations

## License
[Insert appropriate license information]
