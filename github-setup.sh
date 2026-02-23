#!/bin/bash

# GitHub Setup Helper Script
# Este script ayuda a preparar y subir el proyecto a GitHub

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== GitHub Setup Helper ===${NC}\n"

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Verificar Git
if ! command_exists git; then
    echo -e "${RED}Error: Git no está instalado${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Git instalado${NC}"

# Verificar si ya es un repositorio Git
if [ -d .git ]; then
    echo -e "${YELLOW}⚠ Ya existe un repositorio Git${NC}"
    read -p "¿Deseas continuar? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    echo -e "${GREEN}Inicializando repositorio Git...${NC}"
    git init
fi

# Configurar usuario Git si no está configurado
if [ -z "$(git config user.name)" ]; then
    echo -e "${YELLOW}Configurando usuario Git...${NC}"
    read -p "Ingresa tu nombre: " git_name
    git config user.name "$git_name"
fi

if [ -z "$(git config user.email)" ]; then
    read -p "Ingresa tu email: " git_email
    git config user.email "$git_email"
fi

echo -e "${GREEN}✓ Usuario Git configurado${NC}"
echo "  Nombre: $(git config user.name)"
echo "  Email: $(git config user.email)"

# Verificar archivos a incluir
echo -e "\n${GREEN}Archivos a incluir en el commit:${NC}"
git add .
git status --short

read -p "¿Continuar con el commit? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Operación cancelada${NC}"
    exit 1
fi

# Crear commit inicial
echo -e "${GREEN}Creando commit inicial...${NC}"
git commit -m "feat: initial commit - ECS Fargate infrastructure with Terragrunt" || echo "Commit ya existe o no hay cambios"

# Configurar remote
echo -e "\n${GREEN}Configurando remote...${NC}"
read -p "Ingresa tu usuario de GitHub: " github_user
repo_name="Banca_global_alb_ecs_fargate_rds_redis_Migrate"
remote_url="https://github.com/${github_user}/${repo_name}.git"

if git remote | grep -q "origin"; then
    echo -e "${YELLOW}Remote 'origin' ya existe${NC}"
    git remote set-url origin "$remote_url"
else
    git remote add origin "$remote_url"
fi

echo -e "${GREEN}✓ Remote configurado: ${remote_url}${NC}"

# Renombrar rama a main
current_branch=$(git branch --show-current)
if [ "$current_branch" != "main" ]; then
    echo -e "${GREEN}Renombrando rama a 'main'...${NC}"
    git branch -M main
fi

# Instrucciones finales
echo -e "\n${GREEN}=== Próximos Pasos ===${NC}"
echo -e "1. Crea el repositorio en GitHub:"
echo -e "   ${YELLOW}https://github.com/new${NC}"
echo -e "   Nombre: ${repo_name}"
echo -e "   Visibilidad: Private (recomendado)"
echo -e "   NO inicialices con README, .gitignore o license"
echo -e ""
echo -e "2. Ejecuta el siguiente comando para subir el código:"
echo -e "   ${YELLOW}git push -u origin main${NC}"
echo -e ""
echo -e "3. Crea la rama develop:"
echo -e "   ${YELLOW}git checkout -b develop${NC}"
echo -e "   ${YELLOW}git push -u origin develop${NC}"
echo -e ""
echo -e "4. Configura GitHub Actions secrets en:"
echo -e "   ${YELLOW}https://github.com/${github_user}/${repo_name}/settings/secrets/actions${NC}"
echo -e ""
echo -e "5. Lee el archivo ${YELLOW}GITHUB_SETUP_GUIDE.md${NC} para más detalles"
echo -e ""
echo -e "${GREEN}✓ Preparación completada${NC}"
