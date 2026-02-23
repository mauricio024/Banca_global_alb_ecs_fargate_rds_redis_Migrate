# Configuración OIDC + GitHub Actions - Completada ✅

## Recursos creados en AWS (Cuenta: 996617614114)

### 1. OIDC Provider (Ya existía)
- **ARN**: `arn:aws:iam::996617614114:oidc-provider/token.actions.githubusercontent.com`
- **URL**: `https://token.actions.githubusercontent.com`
- **Audience**: `sts.amazonaws.com`

### 2. IAM Role (Recién creado)
- **Nombre**: `GitHubActions-Terragrunt-Role`
- **ARN**: `arn:aws:iam::996617614114:role/GitHubActions-Terragrunt-Role`
- **Política**: Permisos completos para ECS, RDS, ElastiCache, S3, DynamoDB, IAM, etc.

## Cambios realizados

### 1. common.hcl
- ✅ Actualizado el provider AWS para usar `try()` en el profile
- ✅ Ahora funciona con perfil local Y con OIDC en GitHub Actions

### 2. GitHub Actions Workflow
- ✅ Configurado con el ARN del role: `arn:aws:iam::996617614114:role/GitHubActions-Terragrunt-Role`
- ✅ Agregado flag `--terragrunt-non-interactive` para apply automático
- ✅ Apply solo se ejecuta en branch `main`

## Cómo funciona

### Desarrollo Local
```bash
# Usa el perfil sh-gencloudtest
terragrunt plan
terragrunt apply
```

### GitHub Actions
1. GitHub Actions solicita credenciales temporales a AWS STS
2. AWS valida el token OIDC de GitHub
3. AWS asume el role `GitHubActions-Terragrunt-Role`
4. Terragrunt se ejecuta con las credenciales temporales (sin profile)

## Próximos pasos

1. **Hacer push del código a GitHub**
2. **El workflow se ejecutará automáticamente** en push a `main` o manualmente
3. **Verificar la ejecución** en la pestaña Actions de GitHub

## Seguridad

- ✅ Sin credenciales hardcodeadas
- ✅ Sin secrets de AWS en GitHub
- ✅ Credenciales temporales (1 hora de duración)
- ✅ Role con permisos específicos
- ✅ Trust policy permite cualquier repo (puedes restringirlo después)

## Restricción de repositorio (Opcional)

Para mayor seguridad, puedes restringir el role a un repositorio específico:

```bash
# Editar la trust policy para cambiar:
"token.actions.githubusercontent.com:sub": "repo:*:*"

# Por:
"token.actions.githubusercontent.com:sub": "repo:TU_ORG/TU_REPO:*"
```

## Comandos útiles

```bash
# Verificar el role
aws iam get-role --role-name GitHubActions-Terragrunt-Role --profile sh-gencloudtest

# Ver políticas adjuntas
aws iam list-role-policies --role-name GitHubActions-Terragrunt-Role --profile sh-gencloudtest

# Ver la política
aws iam get-role-policy --role-name GitHubActions-Terragrunt-Role --policy-name GitHubActions-Terragrunt-Policy --profile sh-gencloudtest
```
