# 🧪 Configuración Rápida - Laboratorio DEV

## ✅ Workflow Simplificado

El workflow ha sido configurado para:
- ✅ Desplegar solo ambiente DEV
- ✅ Activarse con push a rama `main`
- ✅ Activarse manualmente desde GitHub Actions
- ✅ Usar solo 2 secrets (no 4)

## 🔐 Secrets Necesarios (Solo 2)

### 1. AWS_ACCESS_KEY_ID
```
Name:  AWS_ACCESS_KEY_ID
Value: AKIA... (tu Access Key ID de AWS)
```

### 2. AWS_SECRET_ACCESS_KEY
```
Name:  AWS_SECRET_ACCESS_KEY
Value: wJal... (tu Secret Access Key de AWS)
```

## 📋 Pasos para Configurar

### 1️⃣ Agregar Secrets en GitHub

1. Ve a tu repositorio en GitHub
2. Click en **Settings**
3. Click en **Secrets and variables** → **Actions**
4. Click en **New repository secret**
5. Agrega el primer secret:
   - Name: `AWS_ACCESS_KEY_ID`
   - Secret: Tu Access Key ID
6. Click en **Add secret**
7. Repite para el segundo secret:
   - Name: `AWS_SECRET_ACCESS_KEY`
   - Secret: Tu Secret Access Key

### 2️⃣ Subir el Workflow Actualizado

```bash
cd /Users/mauricio.obando/Projects_iac/Banca_global_alb_ecs_fargate_rds_redis_Migrate

# Agregar cambios
git add .github/workflows/terragrunt-ci.yml
git add LAB_SETUP.md

# Commit
git commit -m "feat: simplify workflow for DEV lab deployment"

# Push
git push origin main
```

### 3️⃣ Activar el Workflow

**Opción A - Automático (con el push):**
El workflow se ejecutará automáticamente al hacer push a `main`

**Opción B - Manual:**
1. Ve a la pestaña **Actions** en GitHub
2. Click en **Terragrunt Deploy - DEV Lab**
3. Click en **Run workflow**
4. Selecciona rama `main`
5. Click en **Run workflow**

## 🎯 Qué Hace el Workflow

```
1. Checkout del código
   ↓
2. Configura credenciales AWS
   ↓
3. Instala Terraform (v1.5.7)
   ↓
4. Instala Terragrunt (v0.50.17)
   ↓
5. Terragrunt Init (inicializa módulos)
   ↓
6. Terragrunt Plan (muestra cambios)
   ↓
7. Terragrunt Apply (despliega infraestructura)
```

## 📊 Monitorear el Despliegue

1. Ve a **Actions** en GitHub
2. Click en el workflow en ejecución
3. Verás los pasos ejecutándose en tiempo real
4. Revisa los logs de cada paso

## ⏱️ Tiempo Estimado

- Configuración de secrets: 2 minutos
- Push del código: 1 minuto
- Ejecución del workflow: 15-30 minutos (dependiendo de los recursos)

## 🆘 Troubleshooting

### El workflow no se ejecuta
- Verifica que hiciste push a la rama `main`
- O ejecuta manualmente desde Actions

### Error de autenticación AWS
- Verifica que los secrets estén correctamente configurados
- Verifica que el Access Key ID sea correcto
- Verifica que el Secret Access Key sea correcto

### Error en Terragrunt Init
- Verifica que el bucket S3 del backend exista
- Verifica que la tabla DynamoDB exista
- Verifica los permisos del usuario IAM

### Error en Terragrunt Apply
- Revisa los logs del workflow
- Verifica que no haya conflictos de recursos
- Verifica los permisos del usuario IAM

## ✅ Verificación

Después del despliegue exitoso:

1. Ve a AWS Console
2. Verifica los recursos creados:
   - VPC
   - ECS Cluster
   - RDS
   - ElastiCache
   - S3
   - Lambda
   - ALB
   - Security Groups

## 🔄 Para Destruir los Recursos

Si quieres eliminar todo lo desplegado:

```bash
# Localmente
cd /Users/mauricio.obando/Projects_iac/Banca_global_alb_ecs_fargate_rds_redis_Migrate
terragrunt run-all destroy --terragrunt-exclude-dir .
```

## 📝 Resumen

```
┌─────────────────────────────────────────────────────────┐
│ CONFIGURACIÓN MÍNIMA PARA LABORATORIO                  │
├─────────────────────────────────────────────────────────┤
│ ✓ 2 Secrets (AWS_ACCESS_KEY_ID + AWS_SECRET_ACCESS_KEY)│
│ ✓ Push a rama main                                      │
│ ✓ Workflow se ejecuta automáticamente                   │
│ ✓ Despliega ambiente DEV en AWS                         │
└─────────────────────────────────────────────────────────┘
```

---

**¡Listo para desplegar!** 🚀
