#!/bin/bash

# Check for tags
if [ -z "$(git tag)" ]; then
    echo "No tags found. Please create a tag first."
    exit 1
fi

# Generate a changelog from the last tag to HEAD
last_tag=$(git describe --tags --abbrev=0)
echo "Generating changelog from $last_tag to HEAD..."
git log $last_tag..HEAD --pretty=format:"* %s (%h)" > CHANGELOG.md

# Check if changelog is empty
if [ ! -s CHANGELOG.md ]; then
    echo "No new commits since the last tag ($last_tag)."
    exit 0
fi

# Output success message
echo "Changelog generated successfully."
