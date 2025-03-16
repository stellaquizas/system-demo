# Version Management

This project uses a centralized versioning approach where the main `system-demo` repository controls the version for the entire system.

## Current Version

**0.1.0** (Initial prototype)

## Version Files

The version is stored in several places to ensure consistency:

1. `VERSION.txt` - The main version file in the root directory
2. `system-vue/src/config/version.js` - Frontend version configuration
3. `system-rest/src/main/resources/config/version.properties` - Backend version configuration

## Updating the Version

To update the version across all components, use the provided script:

```bash
./update-version.sh <new-version>
```

Example:

```bash
./update-version.sh 1.0.0
```

This will update all version files and provide instructions for committing the changes.

## Versioning Strategy

We follow [Semantic Versioning](https://semver.org/) (MAJOR.MINOR.PATCH):

- **MAJOR** version for incompatible API changes
- **MINOR** version for new functionality in a backward compatible manner
- **PATCH** version for backward compatible bug fixes

## Version Display

The version number is displayed in the UI as a tooltip when hovering over the application logo, and is included in API responses from the backend.
