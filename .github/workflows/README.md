# GitHub Actions Workflows

## Available Workflows

### 1. Terragrunt CI/CD (`terragrunt-ci.yml`)

Workflow principal para validación y despliegue de infraestructura.

#### Jobs:

- **validate**: Valida formato y sintaxis de Terragrunt
- **plan-dev**: Ejecuta plan para ambiente dev (en PRs)
- **apply-dev**: Aplica cambios en dev (push a develop)
- **apply-prod**: Aplica cambios en prod (push a main)

#### Triggers:

- Push a `main` o `develop`
- Pull requests a `main` o `develop`
- Manual dispatch

## Environment Variables

Configuradas en el workflow:

- `TF_VERSION`: 1.5.7
- `TG_VERSION`: 0.50.17
- `AWS_REGION`: us-east-1

## Required Secrets

Ver [GITHUB_ACTIONS_SETUP.md](../GITHUB_ACTIONS_SETUP.md) para detalles completos.

## Workflow Execution Flow

```
┌─────────────────┐
│   Push/PR       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Validate      │
│  - Format check │
│  - Syntax check │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Plan (PR)     │
│  - Init modules │
│  - Run plan     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Apply (Push)  │
│  - Deploy infra │
│  - Update state │
└─────────────────┘
```

## Customization

Para modificar el workflow:

1. Edita `.github/workflows/terragrunt-ci.yml`
2. Ajusta versiones de herramientas
3. Modifica triggers según necesidad
4. Agrega/remueve jobs

## Testing Locally

```bash
# Install act
brew install act

# Run specific job
act -j validate

# Run with secrets
act -j plan-dev --secret-file .secrets
```

## Monitoring

- View workflow runs: **Actions** tab
- Check logs for each step
- Set up notifications in Settings → Notifications

## Best Practices

1. Always test in dev before prod
2. Review plan output before apply
3. Use branch protection rules
4. Require PR reviews for main
5. Monitor workflow execution times
6. Keep secrets secure and rotated
