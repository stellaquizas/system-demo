#!/bin/bash

# Setup script for GitHub Actions CI/CD demo
# This script helps you set up a GitHub repository for CI/CD demo

echo "=== GitHub Actions CI/CD Demo Setup Script ==="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed. Please install git first."
    exit 1
fi

# Get GitHub username
read -p "Enter your GitHub username: " github_username
if [ -z "$github_username" ]; then
    echo "GitHub username cannot be empty."
    exit 1
fi

# Get repository name
read -p "Enter repository name (default: system-demo): " repo_name
repo_name=${repo_name:-system-demo}

# Check if .git directory exists
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
fi

# Check if GitHub workflow directory exists, create if not
if [ ! -d ".github/workflows" ]; then
    echo "Creating GitHub Actions workflow directory..."
    mkdir -p .github/workflows
fi

# Ensure the CI/CD configuration file exists
if [ ! -f ".github/workflows/ci-cd.yml" ]; then
    echo "GitHub Actions workflow file not found. Please make sure it exists at .github/workflows/ci-cd.yml"
    exit 1
fi

# Stage all files
echo "Staging files for commit..."
git add .

# Check if there are any changes to commit
if git diff-index --quiet HEAD --; then
    echo "No changes to commit."
else
    echo "Committing changes..."
    git commit -m "Setup GitHub Actions CI/CD configuration"
fi

# Setup GitHub remote
echo ""
echo "=== Setting up GitHub remote ==="
echo "1. Create a new repository named '$repo_name' on GitHub (https://github.com/new)"
echo "2. Do NOT initialize it with README, .gitignore, or license"
echo "3. Press Enter when ready"
read -p "" ready

# Check if github remote already exists
if git remote | grep -q "github"; then
    echo "GitHub remote already exists. Updating URL..."
    git remote set-url github https://github.com/$github_username/$repo_name.git
else
    echo "Adding GitHub remote..."
    git remote add github https://github.com/$github_username/$repo_name.git
fi

# Push to GitHub
echo ""
echo "Would you like to push to GitHub now? (y/n)"
read -p "" push_now

if [ "$push_now" = "y" ] || [ "$push_now" = "Y" ]; then
    echo "Pushing to GitHub..."
    git push -u github master || git push -u github main
    echo "Push completed."
else
    echo "You can push to GitHub later with: git push -u github master"
fi

echo ""
echo "=== GitHub Actions CI/CD Demo Setup Complete ==="
echo ""
echo "Next steps:"
echo "1. If you haven't pushed yet: git push -u github master"
echo "2. Set up GitHub Secrets in your repository:"
echo "   - Go to your GitHub repository → Settings → Secrets and variables → Actions"
echo "   - Add the following secrets:"
echo "     - DOCKER_HUB_USERNAME: Your Docker Hub username"
echo "     - DOCKER_HUB_TOKEN: Your Docker Hub access token"
echo "3. Make a small change, commit, and push to trigger the workflow"
echo "4. Go to the 'Actions' tab to see the workflow running"
echo ""
echo "GitHub repository: https://github.com/$github_username/$repo_name"
echo ""
echo "Good luck with your demo!" 