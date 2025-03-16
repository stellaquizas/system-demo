# Version Management

This project uses a centralized versioning approach where the main `system-demo` repository controls the version for the entire system.

## Current Version

**0.1.0** (Initial prototype)

## Versioning Strategy

We follow [Semantic Versioning](https://semver.org/) (MAJOR.MINOR.PATCH):

- **MAJOR** version for incompatible API changes
- **MINOR** version for new functionality in a backward compatible manner
- **PATCH** version for backward compatible bug fixes

## Version Files

The version is stored in several places to ensure consistency:

1. `VERSION.txt` - The main version file in the root directory
2. `system-vue/src/config/version.ts` - Frontend version configuration
3. `system-rest/src/main/resources/config/version.properties` - Backend version configuration

## Version Display

The version number is displayed in the UI as a tooltip when hovering over the application logo, and is included in API responses from the backend.

## Release Process

### 1. Updating the Version

To update the version across all components, use the provided script:

```bash
./update-version.sh <new-version>
```

Example:

```bash
./update-version.sh 1.0.0
```

This will update all version files and provide instructions for committing the changes.

### 2. Updating the Changelog

Update `CHANGELOG.md` in the system-demo repository with all changes for this version, following the established format with component prefixes.

### 3. Version Tagging Across Repositories

When releasing a new version, maintain consistency across all three repositories:

```bash
# In system-demo repository
git add VERSION.txt CHANGELOG.md
git commit -m "chore: bump version to <new-version>"
git tag -a v<new-version> -m "Release version <new-version>"
git push && git push --tags

# In system-rest repository
git tag -a v<new-version> -m "Release version <new-version>"
git push --tags

# In system-vue repository
git tag -a v<new-version> -m "Release version <new-version>"
git push --tags
```

### 4. Automated Release Notes

When the version tag is pushed to the system-demo repository, GitHub Actions will automatically:

- Extract the relevant section from CHANGELOG.md
- Create a GitHub Release with these notes
- Attach version files to the release

## Benefits

This versioning approach ensures that:

- All repositories maintain synchronized version numbers
- Release history is properly documented
- Each component can be referenced at specific version points
- Release notes are centralized in the coordinator repository
