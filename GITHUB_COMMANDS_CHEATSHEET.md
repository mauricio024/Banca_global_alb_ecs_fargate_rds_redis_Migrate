# 🎯 Comandos Rápidos - GitHub Setup

## 🚀 Setup Inicial (Copiar y Pegar)

```bash
# 1. Navegar al proyecto
cd /Users/mauricio.obando/Projects_iac/Banca_global_alb_ecs_fargate_rds_redis_Migrate

# 2. Inicializar Git (si no existe)
git init

# 3. Configurar usuario (reemplaza con tus datos)
git config user.name "Tu Nombre"
git config user.email "tu.email@ejemplo.com"

# 4. Agregar archivos
git add .

# 5. Primer commit
git commit -m "feat: initial commit - ECS Fargate infrastructure with Terragrunt"

# 6. Conectar con GitHub (reemplaza <tu-usuario>)
git remote add origin https://github.com/<tu-usuario>/Banca_global_alb_ecs_fargate_rds_redis_Migrate.git

# 7. Renombrar rama a main
git branch -M main

# 8. Subir a GitHub
git push -u origin main

# 9. Crear rama develop
git checkout -b develop
git push -u origin develop

# 10. Volver a main
git checkout main
```

## 📝 Comandos Útiles

### Ver estado
```bash
git status
```

### Ver historial
```bash
git log --oneline --graph --all
```

### Crear feature branch
```bash
git checkout -b feature/nombre-feature
```

### Actualizar desde GitHub
```bash
git pull origin main
```

### Ver ramas
```bash
git branch -a
```

### Cambiar de rama
```bash
git checkout develop
```

### Push de cambios
```bash
git add .
git commit -m "feat: descripción del cambio"
git push
```

## 🔧 Comandos de Corrección

### Cambiar último commit
```bash
git commit --amend -m "nuevo mensaje"
```

### Deshacer cambios no commiteados
```bash
git checkout -- archivo.tf
```

### Deshacer último commit (mantener cambios)
```bash
git reset --soft HEAD~1
```

### Actualizar remote URL
```bash
git remote set-url origin https://github.com/<tu-usuario>/Banca_global_alb_ecs_fargate_rds_redis_Migrate.git
```

### Forzar push (usar con cuidado)
```bash
git push --force-with-lease
```

## 🔐 Configurar Personal Access Token

```bash
# Cuando GitHub pida password, usa el token en lugar de password
# Generar token en: https://github.com/settings/tokens
```

## 🧪 Validar antes de Push

```bash
# Validar Terragrunt
terragrunt hclfmt
terragrunt run-all validate --terragrunt-exclude-dir .

# Ver qué se va a subir
git status
git diff
```

## 📊 Workflow Diario

```bash
# Actualizar develop
git checkout develop
git pull origin develop

# Crear feature
git checkout -b feature/mi-cambio

# Hacer cambios...
git add .
git commit -m "feat: mi cambio"

# Push
git push -u origin feature/mi-cambio

# Crear PR en GitHub web
```

## 🆘 Troubleshooting Rápido

### Error: remote origin already exists
```bash
git remote remove origin
git remote add origin https://github.com/<tu-usuario>/Banca_global_alb_ecs_fargate_rds_redis_Migrate.git
```

### Error: failed to push
```bash
git pull origin main --rebase
git push
```

### Error: Authentication failed
```bash
# Usa Personal Access Token como password
# O configura SSH keys
```

### Limpiar cache de Git
```bash
git rm -r --cached .
git add .
git commit -m "fix: clean git cache"
```

## 📋 URLs Importantes

- **Crear repo**: https://github.com/new
- **Tus repos**: https://github.com/<tu-usuario>?tab=repositories
- **Generar token**: https://github.com/settings/tokens
- **SSH keys**: https://github.com/settings/keys

## ✅ Verificación Post-Setup

```bash
# Verificar remote
git remote -v

# Verificar rama actual
git branch --show-current

# Verificar último commit
git log -1

# Verificar archivos ignorados
git status --ignored
```

---

**💡 Tip**: Guarda este archivo como referencia rápida!
