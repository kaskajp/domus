# Contributing to Domus

Thank you for your interest in contributing to Domus! This guide will help you understand our development process and contribution standards.

## Conventional Commits

We use [Conventional Commits](https://www.conventionalcommits.org/) for all commit messages. This enables automated versioning and changelog generation.

### Commit Message Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types

- **feat**: A new feature (triggers minor version bump)
- **fix**: A bug fix (triggers patch version bump)
- **perf**: A performance improvement (triggers patch version bump)
- **refactor**: A code change that neither fixes a bug nor adds a feature (triggers patch version bump)
- **docs**: Documentation only changes (no version bump)
- **style**: Changes that do not affect the meaning of the code (no version bump)
- **test**: Adding missing tests or correcting existing tests (no version bump)
- **build**: Changes that affect the build system or external dependencies (no version bump)
- **ci**: Changes to our CI configuration files and scripts (no version bump)
- **chore**: Other changes that don't modify src or test files (no version bump)
- **revert**: Reverts a previous commit (triggers patch version bump)

### Breaking Changes

For breaking changes, add `BREAKING CHANGE:` in the footer or add `!` after the type:

```
feat!: remove deprecated authentication method

BREAKING CHANGE: The old authentication method has been removed. 
Users must migrate to the new JWT-based authentication.
```

### Examples

```bash
# Features
feat: add task assignment to family members
feat(auth): implement OAuth2 integration
feat!: remove legacy API endpoints

# Bug fixes
fix: resolve user session timeout issue
fix(ui): correct mobile navigation overflow

# Performance
perf: optimize database queries for dashboard

# Refactoring
refactor: extract user validation logic

# Documentation
docs: update installation instructions
docs(api): add endpoint documentation

# Tests
test: add integration tests for authentication

# Chores
chore: update dependencies
chore(deps): bump rails to 8.0.3
```

## Development Workflow

1. **Fork the repository** and create a feature branch from `develop`
2. **Make your changes** following our coding standards
3. **Write tests** for new functionality
4. **Use conventional commits** for all commit messages
5. **Submit a pull request** to the `develop` branch

## Automated Releases

- Releases are automatically generated from the `main` branch
- Version numbers follow [Semantic Versioning](https://semver.org/)
- Changelogs are automatically generated from commit messages
- Only conventional commits with the right types will trigger releases

## Code Standards

- Follow the existing code style
- Run `bin/rubocop` before committing
- Ensure all tests pass with `bin/rails test`
- Add tests for new features

## Branch Strategy

- `main`: Production-ready code, protected branch
- `develop`: Integration branch for features
- `feature/*`: Feature development branches
- `hotfix/*`: Emergency fixes for production

## Questions?

Feel free to open an issue if you have questions about contributing! 