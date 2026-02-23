# Contributing Guide

## Workflow

1. Create a feature branch from `develop`
2. Make your changes
3. Commit with descriptive messages
4. Push and create a Pull Request
5. Wait for CI/CD validation
6. Request review from team members

## Branch Strategy

- `main` - Production environment
- `develop` - Development environment
- `feature/*` - Feature branches
- `hotfix/*` - Hotfix branches

## Commit Messages

Follow conventional commits:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `refactor:` - Code refactoring
- `test:` - Test changes

## Testing

Before pushing, run:
```bash
terragrunt hclfmt
terragrunt run-all validate --terragrunt-exclude-dir .
```
