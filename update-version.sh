#!/bin/bash

# Script to update version number across all components
# Usage: ./update-version.sh <new-version>

if [ -z "$1" ]; then
  echo "Error: No version specified"
  echo "Usage: ./update-version.sh <new-version>"
  echo "Example: ./update-version.sh 1.0.0"
  exit 1
fi

NEW_VERSION=$1

# Update main VERSION.txt file
echo "Updating main VERSION.txt to $NEW_VERSION"
echo "$NEW_VERSION" > VERSION.txt

# Update frontend version
echo "Updating frontend version to $NEW_VERSION"
sed -i.bak "s/export const VERSION = '.*';/export const VERSION = '$NEW_VERSION';/" system-vue/src/config/version.js
rm -f system-vue/src/config/version.js.bak

# Update backend version
echo "Updating backend version to $NEW_VERSION"
sed -i.bak "s/version=.*/version=$NEW_VERSION/" system-rest/src/main/resources/config/version.properties
rm -f system-rest/src/main/resources/config/version.properties.bak

echo "Version updated to $NEW_VERSION across all components"
echo "Don't forget to commit these changes with:"
echo "git add VERSION.txt system-vue/src/config/version.js system-rest/src/main/resources/config/version.properties"
echo "git commit -m \"Bump version to $NEW_VERSION\"" 