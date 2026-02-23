# 🎯 EMPIEZA AQUÍ - Subir a GitHub

## ✅ Todo está preparado para subir a GitHub

Este proyecto incluye toda la configuración necesaria para GitHub y GitHub Actions.

## 🚀 Elige tu método:

### 1️⃣ Script Automático (Más Fácil) ⭐
```bash
./github-setup.sh
```
El script te guiará paso a paso.

### 2️⃣ Quick Start (5 minutos)
Lee: `QUICKSTART_GITHUB.md`

### 3️⃣ Guía Completa (Paso a Paso)
Lee: `GITHUB_SETUP_GUIDE.md`

### 4️⃣ Solo Comandos
Lee: `GITHUB_COMMANDS_CHEATSHEET.md`

## 📚 Documentación Disponible

| Archivo | Descripción |
|---------|-------------|
| `QUICKSTART_GITHUB.md` | Inicio rápido en 5 pasos |
| `GITHUB_SETUP_GUIDE.md` | Guía completa con 12 pasos detallados |
| `GITHUB_COMMANDS_CHEATSHEET.md` | Comandos Git útiles |
| `GITHUB_FILES_SUMMARY.md` | Resumen de todos los archivos |
| `CONTRIBUTING.md` | Guía de contribución |
| `.github/GITHUB_ACTIONS_SETUP.md` | Setup de GitHub Actions |
| `github-setup.sh` | Script de setup automático |

## ⚡ Quick Start (Copiar y Pegar)

```bash
# 1. Crear repo en GitHub: https://github.com/new
#    Nombre: Banca_global_alb_ecs_fargate_rds_redis_Migrate

# 2. Ejecutar (reemplaza <tu-usuario>):
git init
git add .
git commit -m "feat: initial commit - ECS Fargate infrastructure"
git remote add origin https://github.com/<tu-usuario>/Banca_global_alb_ecs_fargate_rds_redis_Migrate.git
git branch -M main
git push -u origin main

# 3. Crear rama develop:
git checkout -b develop
git push -u origin develop

# 4. Configurar secrets en GitHub:
#    Settings → Secrets and variables → Actions
#    Agregar: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY (dev y prod)

# 5. Configurar environments:
#    Settings → Environments
#    Crear: dev y prod
```

## 🔐 Secrets Requeridos

En GitHub → Settings → Secrets and variables → Actions:

- `AWS_ACCESS_KEY_ID` (dev)
- `AWS_SECRET_ACCESS_KEY` (dev)
- `AWS_ACCESS_KEY_ID_PROD` (prod)
- `AWS_SECRET_ACCESS_KEY_PROD` (prod)

## ✨ Características Incluidas

✅ GitHub Actions CI/CD workflow  
✅ Validación automática de Terragrunt  
✅ Deploy automático a dev y prod  
✅ Branch protection configurado  
✅ Documentación completa  
✅ Scripts de ayuda  

## 📋 Checklist

- [ ] Leer este archivo
- [ ] Elegir método de setup
- [ ] Crear repositorio en GitHub
- [ ] Subir código
- [ ] Configurar secrets
- [ ] Configurar environments
- [ ] Verificar GitHub Actions

## 🆘 ¿Necesitas Ayuda?

1. **Problemas con Git**: Ver `GITHUB_COMMANDS_CHEATSHEET.md`
2. **Problemas con GitHub Actions**: Ver `.github/GITHUB_ACTIONS_SETUP.md`
3. **Dudas generales**: Ver `GITHUB_SETUP_GUIDE.md` (sección Troubleshooting)

## ⏱️ Tiempo Estimado

- Con script: 10 minutos
- Manual: 15-20 minutos

---

**💡 Recomendación**: Usa `./github-setup.sh` para el setup más rápido y fácil.

**🎯 Siguiente paso**: Ejecuta `./github-setup.sh` o lee `QUICKSTART_GITHUB.md`
