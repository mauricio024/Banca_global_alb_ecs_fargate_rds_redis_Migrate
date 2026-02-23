# 🚀 Quick Start - Subir a GitHub

## Opción 1: Script Automático (Recomendado)

```bash
cd /Users/mauricio.obando/Projects_iac/Banca_global_alb_ecs_fargate_rds_redis_Migrate
./github-setup.sh
```

Sigue las instrucciones del script.

## Opción 2: Manual (5 Pasos)

### 1️⃣ Crear Repositorio en GitHub Web

1. Ve a https://github.com/new
2. Nombre: `Banca_global_alb_ecs_fargate_rds_redis_Migrate`
3. Private
4. NO marcar nada más
5. Create repository

### 2️⃣ Subir Código

```bash
cd /Users/mauricio.obando/Projects_iac/Banca_global_alb_ecs_fargate_rds_redis_Migrate

# Inicializar (si no existe)
git init

# Agregar archivos
git add .
git commit -m "feat: initial commit - ECS Fargate infrastructure"

# Conectar con GitHub (reemplaza <tu-usuario>)
git remote add origin https://github.com/<tu-usuario>/Banca_global_alb_ecs_fargate_rds_redis_Migrate.git

# Subir
git branch -M main
git push -u origin main
```

### 3️⃣ Crear Rama Develop

```bash
git checkout -b develop
git push -u origin develop
git checkout main
```

### 4️⃣ Configurar Secrets en GitHub

Ve a: **Settings → Secrets and variables → Actions**

Agregar:
- `AWS_ACCESS_KEY_ID` (para dev)
- `AWS_SECRET_ACCESS_KEY` (para dev)
- `AWS_ACCESS_KEY_ID_PROD` (para prod)
- `AWS_SECRET_ACCESS_KEY_PROD` (para prod)

### 5️⃣ Configurar Environments

Ve a: **Settings → Environments**

Crear:
- Environment `dev`
- Environment `prod` (con protection rules)

## ✅ Verificación

1. Ve a la pestaña **Actions**
2. Deberías ver el workflow "Terragrunt CI/CD"
3. Si hay un push reciente, verás una ejecución

## 📚 Documentación Completa

- **Guía Detallada**: `GITHUB_SETUP_GUIDE.md`
- **GitHub Actions Setup**: `.github/GITHUB_ACTIONS_SETUP.md`
- **Contributing**: `CONTRIBUTING.md`

## 🆘 Ayuda

Si tienes problemas, revisa la sección Troubleshooting en `GITHUB_SETUP_GUIDE.md`

---

**Tiempo estimado**: 10-15 minutos
