# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- (Coordinator) GitFlow-inspired branching strategy for enterprise development
- (Coordinator) Comprehensive documentation for branching strategy in README.md
- (Coordinator) CI/CD pipeline updates to support GitFlow branching strategy
- (Coordinator) Release branch validation in CI/CD pipelines
- (Backend) Updated CI/CD pipelines for GitHub Actions and GitLab to support branching strategy
- (Frontend) Updated CI/CD pipelines for GitHub Actions and GitLab to support branching strategy
- (Coordinator) Development environment deployment pipeline for develop branch
- (Coordinator) Staging environment deployment pipeline for release branches
- (Coordinator) Production environment deployment pipeline for version tags

### Changed

- (Coordinator) CI/CD architecture from monorepo to multi-repository approach
- (Backend) CI/CD pipeline now supports feature, develop, release, and main branches
- (Frontend) CI/CD pipeline now supports feature, develop, release, and main branches
- (Coordinator) Docker image tagging strategy to include branch-specific versions
- (Coordinator) Renamed all components from "spring-petclinic-_" to "system-_"
- (Backend) Updated context paths from "/petclinic" to "/system"
- (Frontend) Modernized UI with Tailwind CSS and Font Awesome icons

### Fixed

- (Coordinator) Docker Compose configuration to ensure proper component communication
- (Coordinator) README.md to accurately reflect the three-repository structure
- (Frontend) Frontend build process for production deployment

## How to Update This Changelog

When making changes to any component (frontend, backend, or coordinator), please update this changelog in the main system-demo repository. This ensures we have a single source of truth for all changes across the system.

### For Frontend Changes (system-vue)

Add entries under the appropriate section with a "(Frontend)" prefix.

### For Backend Changes (system-rest)

Add entries under the appropriate section with a "(Backend)" prefix.

### For Coordinator Changes (system-demo)

Add entries under the appropriate section with a "(Coordinator)" prefix or no prefix for system-wide changes.

### Example:

```
### Added
- (Frontend) New user profile component
- (Backend) REST API endpoint for user preferences
- Improved documentation for deployment process
```

## [0.1.0] - 2025-05-15

### Added

- (Coordinator) Initial project setup with three-repository architecture
- (Coordinator) Docker Compose configuration for all components
- (Coordinator) CI/CD setup for GitHub Actions and GitLab
- (Frontend) Vue.js 3 frontend with Tailwind CSS
- (Backend) Spring Boot backend with PostgreSQL database
- (Coordinator) Centralized versioning system
- (Frontend) Version display in UI (tooltip on hover over logo)
- (Backend) Version information in API responses
- (Coordinator) Comprehensive documentation in README.md
- (Coordinator) Version management documentation in VERSION-README.md
- (Coordinator) Scripts for version updates and CI/CD demos

### Changed

- (Coordinator) Docker image tagging strategy to include branch-specific versions

### Fixed

- (Coordinator) Docker Compose configuration to ensure proper component communication
- (Coordinator) README.md to accurately reflect the three-repository structure
- (Frontend) Frontend build process for production deployment
