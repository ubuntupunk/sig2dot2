#!/bin/bash

# Fetch the latest tags
git fetch --tags

# Get the latest tag
LATEST_TAG=$(git describe --tags --abbrev=0)

# Get commit messages since the latest tag
COMMITS=$(git log ${LATEST_TAG}..HEAD --oneline)

# Determine the version bump
if echo "$COMMITS" | grep -q 'BREAKING CHANGE'; then
  VERSION_BUMP="major"
elif echo "$COMMITS" | grep -q 'feat:'; then
  VERSION_BUMP="minor"
else
  VERSION_BUMP="patch"
fi

# Extract the current version
CURRENT_VERSION=$(echo $LATEST_TAG | sed 's/^v//')

# Increment the version
IFS='.' read -r -a VERSION_PARTS <<< "$CURRENT_VERSION"
case $VERSION_BUMP in
  major)
    VERSION_PARTS[0]=$((VERSION_PARTS[0] + 1))
    VERSION_PARTS[1]=0
    VERSION_PARTS[2]=0
    ;;
  minor)
    VERSION_PARTS[1]=$((VERSION_PARTS[1] + 1))
    VERSION_PARTS[2]=0
    ;;
  patch)
    VERSION_PARTS[2]=$((VERSION_PARTS[2] + 1))
    ;;
esac

# Create the new version tag
NEW_TAG="${VERSION_PARTS[0]}.${VERSION_PARTS[1]}.${VERSION_PARTS[2]}"

# Tag the new version
git tag -a $NEW_TAG -m "Release $NEW_TAG"

# Push the new tag
git push origin $NEW_TAG
