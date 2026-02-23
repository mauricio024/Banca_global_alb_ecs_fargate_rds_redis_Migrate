# Guía Paso a Paso: Subir Proyecto a GitHub

## Paso 1: Preparar el Repositorio Local

```bash
# Navegar al directorio del proyecto
cd /Users/mauricio.obando/Projects_iac/Banca_global_alb_ecs_fargate_rds_redis_Migrate

# Inicializar repositorio Git (si no existe)
git init

# Verificar archivos a incluir
git status
```

## Paso 2: Crear Repositorio en GitHub Web

1. Ve a https://github.com
2. Click en el botón **"+"** (arriba derecha) → **"New repository"**
3. Configurar:
   - **Repository name**: `Banca_global_alb_ecs_fargate_rds_redis_Migrate`
   - **Description**: "Infrastructure as Code for ECS Fargate with RDS and Redis using Terragrunt"
   - **Visibility**: Private (recomendado) o Public
   - **NO marcar**: "Initialize this repository with a README"
   - **NO agregar**: .gitignore ni license (ya los tienes)
4. Click en **"Create repository"**

## Paso 3: Configurar Git Local

```bash
# Configurar usuario (si no está configurado)
git config user.name "Tu Nombre"
git config user.email "tu.email@ejemplo.com"

# Verificar configuración
git config --list
```

## Paso 4: Agregar Archivos al Repositorio

```bash
# Agregar todos los archivos (respetando .gitignore)
git add .

# Verificar archivos agregados
git status

# Crear primer commit
git commit -m "feat: initial commit - ECS Fargate infrastructure with Terragrunt"
```

## Paso 5: Conectar con GitHub

```bash
# Agregar remote (reemplaza <tu-usuario> con tu usuario de GitHub)
git remote add origin https://github.com/<tu-usuario>/Banca_global_alb_ecs_fargate_rds_redis_Migrate.git

# Verificar remote
git remote -v

# Renombrar rama a main (si es necesario)
git branch -M main
```

## Paso 6: Subir Código a GitHub

```bash
# Push inicial
git push -u origin main

# Si pide autenticación, usa Personal Access Token (no password)
```

## Paso 7: Crear Rama Develop

```bash
# Crear rama develop
git checkout -b develop

# Subir rama develop
git push -u origin develop

# Volver a main
git checkout main
```

## Paso 8: Configurar GitHub Actions Secrets

1. En GitHub, ve a tu repositorio
2. Click en **Settings** → **Secrets and variables** → **Actions**
3. Click en **"New repository secret"**
4. Agregar los siguientes secrets:

### Para Dev:
- **Name**: `AWS_ACCESS_KEY_ID`
  - **Value**: Tu AWS Access Key ID para dev
  
- **Name**: `AWS_SECRET_ACCESS_KEY`
  - **Value**: Tu AWS Secret Access Key para dev

### Para Prod:
- **Name**: `AWS_ACCESS_KEY_ID_PROD`
  - **Value**: Tu AWS Access Key ID para prod
  
- **Name**: `AWS_SECRET_ACCESS_KEY_PROD`
  - **Value**: Tu AWS Secret Access Key para prod

## Paso 9: Configurar Environments

1. En GitHub, ve a **Settings** → **Environments**
2. Click en **"New environment"**
3. Crear environment **"dev"**:
   - Name: `dev`
   - Click **"Configure environment"**
   - (Opcional) Agregar protection rules
   
4. Crear environment **"prod"**:
   - Name: `prod`
   - Click **"Configure environment"**
   - **Recomendado**: Agregar protection rules:
     - ✅ Required reviewers (selecciona revisores)
     - ✅ Wait timer: 5 minutes (opcional)

## Paso 10: Configurar Branch Protection (Recomendado)

1. Ve a **Settings** → **Branches**
2. Click en **"Add branch protection rule"**
3. Para rama **main**:
   - Branch name pattern: `main`
   - ✅ Require a pull request before merging
   - ✅ Require approvals: 1
   - ✅ Require status checks to pass before merging
   - ✅ Require branches to be up to date before merging
   
4. Repetir para rama **develop**

## Paso 11: Verificar GitHub Actions

1. Ve a la pestaña **Actions** en tu repositorio
2. Deberías ver el workflow "Terragrunt CI/CD"
3. Si hiciste push, verás una ejecución en progreso

## Paso 12: Crear Personal Access Token (si es necesario)

Si GitHub pide autenticación al hacer push:

1. Ve a GitHub → **Settings** (tu perfil) → **Developer settings**
2. Click en **Personal access tokens** → **Tokens (classic)**
3. Click en **"Generate new token"** → **"Generate new token (classic)"**
4. Configurar:
   - **Note**: "Terragrunt Project Access"
   - **Expiration**: 90 days (o lo que prefieras)
   - **Scopes**: 
     - ✅ repo (todos)
     - ✅ workflow
5. Click **"Generate token"**
6. **IMPORTANTE**: Copia el token (no podrás verlo de nuevo)
7. Usa este token como password al hacer push

## Comandos Útiles Post-Setup

```bash
# Ver estado del repositorio
git status

# Ver historial de commits
git log --oneline

# Crear nueva rama para feature
git checkout -b feature/nueva-funcionalidad

# Actualizar desde GitHub
git pull origin main

# Ver ramas
git branch -a

# Cambiar de rama
git checkout develop
```

## Estructura de Trabajo Recomendada

```
main (producción)
  ↑
  PR con aprobación
  ↑
develop (desarrollo)
  ↑
  PR
  ↑
feature/nueva-funcionalidad
```

## Workflow Diario

```bash
# 1. Actualizar develop
git checkout develop
git pull origin develop

# 2. Crear feature branch
git checkout -b feature/mi-cambio

# 3. Hacer cambios y commits
git add .
git commit -m "feat: descripción del cambio"

# 4. Push de la feature
git push -u origin feature/mi-cambio

# 5. Crear Pull Request en GitHub web
# 6. Esperar CI/CD y aprobación
# 7. Merge a develop
# 8. Cuando esté listo, PR de develop a main
```

## Troubleshooting

### Error: "remote origin already exists"
```bash
git remote remove origin
git remote add origin https://github.com/<tu-usuario>/Banca_global_alb_ecs_fargate_rds_redis_Migrate.git
```

### Error: "failed to push some refs"
```bash
git pull origin main --rebase
git push -u origin main
```

### Error: "Authentication failed"
- Usa Personal Access Token en lugar de password
- O configura SSH keys

### Archivos sensibles en Git
```bash
# Si subiste archivos sensibles por error
git rm --cached archivo-sensible
git commit -m "fix: remove sensitive file"
git push
```

## Verificación Final

✅ Repositorio creado en GitHub  
✅ Código subido correctamente  
✅ Rama main y develop creadas  
✅ GitHub Actions configurado  
✅ Secrets agregados  
✅ Environments configurados  
✅ Branch protection activado  
✅ Primer workflow ejecutado exitosamente  

## Próximos Pasos

1. Invitar colaboradores al repositorio
2. Configurar notificaciones de GitHub
3. Crear issues para tareas pendientes
4. Documentar en Wiki (opcional)
5. Configurar integración con Slack/Teams (opcional)

---

**¡Listo!** Tu proyecto está en GitHub con CI/CD configurado 🚀
