# Change Log

## v0.3.0 [current]
FEATURES:
- Added logic to create content from template files via the new files submodule
- Content generated dynamically, using the highly opinionated configurations.
- The following content is managed by the bootstrap
  - GitAttributes and GitIgnore configuration
  - Code of Conduct
  - Code Owners
  - PR template
  - Support template
  - terraform-docs workflow and configuration
  - Semver and Release workflow and configuration
  - Examples skeleton with sample configuration, terratest and worklow

BUG FIXES:
- Fixed wrong key generation for labels, secrets and vars
- Fixed repos merge commit message and title unnecessary update trigger, by setting the correct API defaults

## v0.2.0
FEATURES:
- Significantly simplified module logic, only focusing on a single hive creation to enforce separation of concerns

ENHANCEMENTS:
- Updated go task to v5, which supports sum caching
- Updated terraform task to v3
- Updated checkout task to v4
- Updated setup-terraform to v3
- Updated terraform-docs to v1.1.0
- Updated gittools to v1.1.1

## v0.1.0
FEATURES:
- Initial version