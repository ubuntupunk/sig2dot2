#!/bin/bash

# Generate a changelog from the last tag to HEAD
git log $(git describe --tags --abbrev=0)..HEAD --pretty=format:"* %s (%h)" > CHANGELOG.md
