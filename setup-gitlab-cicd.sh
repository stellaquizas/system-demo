#!/bin/bash

# Setup script for GitLab CI/CD demo
# This script helps you set up a GitLab repository for CI/CD demo

echo "=== GitLab CI/CD Demo Setup Script ==="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed. Please install git first."
    exit 1
fi

# Get GitLab username
read -p "Enter your GitLab username: " gitlab_username
if [ -z "$gitlab_username" ]; then
    echo "GitLab username cannot be empty."
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

# Ensure the CI/CD configuration file exists
if [ ! -f ".gitlab-ci.yml" ]; then
    echo "GitLab CI/CD configuration file not found. Please make sure it exists at .gitlab-ci.yml"
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
    git commit -m "Setup GitLab CI/CD configuration"
fi

# Setup GitLab remote
echo ""
echo "=== Setting up GitLab remote ==="
echo "1. Create a new project named '$repo_name' on GitLab (https://gitlab.com/projects/new)"
echo "2. Do NOT initialize it with README, .gitignore, or license"
echo "3. Press Enter when ready"
read -p "" ready

# Check if gitlab remote already exists
if git remote | grep -q "gitlab"; then
    echo "GitLab remote already exists. Updating URL..."
    git remote set-url gitlab https://gitlab.com/$gitlab_username/$repo_name.git
else
    echo "Adding GitLab remote..."
    git remote add gitlab https://gitlab.com/$gitlab_username/$repo_name.git
fi

# Push to GitLab
echo ""
echo "Would you like to push to GitLab now? (y/n)"
read -p "" push_now

if [ "$push_now" = "y" ] || [ "$push_now" = "Y" ]; then
    echo "Pushing to GitLab..."
    git push -u gitlab master || git push -u gitlab main
    echo "Push completed."
else
    echo "You can push to GitLab later with: git push -u gitlab master"
fi

echo ""
echo "=== GitLab CI/CD Demo Setup Complete ==="
echo ""
echo "Next steps:"
echo "1. If you haven't pushed yet: git push -u gitlab master"
echo "2. Set up GitLab CI/CD Variables in your project:"
echo "   - Go to your GitLab project → Settings → CI/CD → Variables"
echo "   - Add the following variables:"
echo "     - SSH_PRIVATE_KEY: SSH private key for deployment"
echo "     - SSH_KNOWN_HOSTS: SSH known hosts for the deployment server"
echo "     - SSH_USER: Username for SSH connection"
echo "     - SSH_HOST_STAGING: Hostname for staging server"
echo "     - SSH_HOST_PROD: Hostname for production server"
echo "3. Make a small change, commit, and push to trigger the pipeline"
echo "4. Go to the 'CI/CD' → 'Pipelines' tab to see the pipeline running"
echo ""
echo "GitLab repository: https://gitlab.com/$gitlab_username/$repo_name"
echo ""
echo "Good luck with your demo!" 