#!/bin/bash

# Script to prepare a demo change for CI/CD demonstration
# This script applies a pre-defined change to the codebase and commits it

echo "=== CI/CD Demo Change Preparation Script ==="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed. Please install git first."
    exit 1
fi

# Check if the demo-changes directory exists
if [ ! -d "demo-changes" ]; then
    echo "Error: demo-changes directory not found. Please make sure it exists."
    exit 1
fi

# Check if the button color change diff exists
if [ ! -f "demo-changes/button-color-change.diff" ]; then
    echo "Error: button-color-change.diff not found in demo-changes directory."
    exit 1
fi

# Check if the target file exists
TARGET_FILE="system-vue/src/components/OwnersList.vue"
if [ ! -f "$TARGET_FILE" ]; then
    echo "Error: Target file $TARGET_FILE not found."
    exit 1
fi

# Ask which platform to prepare the change for
echo "Which platform are you demonstrating today?"
echo "1. GitHub Actions"
echo "2. GitLab CI/CD"
read -p "Enter your choice (1 or 2): " platform_choice

case $platform_choice in
    1)
        PLATFORM="GitHub"
        REMOTE="github"
        ;;
    2)
        PLATFORM="GitLab"
        REMOTE="gitlab"
        ;;
    *)
        echo "Invalid choice. Please enter 1 for GitHub or 2 for GitLab."
        exit 1
        ;;
esac

# Apply the change using patch
echo "Applying button color change to $TARGET_FILE..."
patch "$TARGET_FILE" "demo-changes/button-color-change.diff"

if [ $? -ne 0 ]; then
    echo "Error: Failed to apply the patch. The file may have been modified already."
    exit 1
fi

# Commit the change
echo "Committing the change..."
git add "$TARGET_FILE"
git commit -m "Demo: Enhance button styling for better user experience"

# Ask if the user wants to push the change
echo ""
echo "Would you like to push this change to $PLATFORM now? (y/n)"
read -p "" push_now

if [ "$push_now" = "y" ] || [ "$push_now" = "Y" ]; then
    echo "Pushing to $PLATFORM..."
    git push $REMOTE
    
    echo ""
    echo "Change pushed successfully!"
    echo "Go to your $PLATFORM repository to see the CI/CD pipeline in action:"
    
    if [ "$PLATFORM" = "GitHub" ]; then
        echo "1. Navigate to the 'Actions' tab"
    else
        echo "1. Navigate to 'CI/CD' → 'Pipelines'"
    fi
    
    echo "2. You should see a new workflow/pipeline running"
    echo "3. Click on it to see the details of each job/stage"
else
    echo ""
    echo "You can push the change later with: git push $REMOTE"
fi

echo ""
echo "=== Demo Change Preparation Complete ===" 