#!/bin/bash

# Script para configurar OIDC + IAM Role para GitHub Actions
# Ejecuta este script después de configurar tus credenciales AWS

PROFILE="sh-gencloudtest"
REGION="us-east-1"
ROLE_NAME="GitHubActionsRole"
REPO="mauricio024/Banca_global_alb_ecs_fargate_rds_redis_Migrate"

echo "🔐 Configurando OIDC + IAM Role para GitHub Actions"
echo "=================================================="

# Paso 1: Obtener Account ID
echo "📋 Paso 1: Obteniendo AWS Account ID..."
ACCOUNT_ID=$(aws sts get-caller-identity --profile $PROFILE --region $REGION --query Account --output text)

if [ -z "$ACCOUNT_ID" ]; then
    echo "❌ Error: No se pudo obtener el Account ID. Verifica tus credenciales."
    exit 1
fi

echo "✅ Account ID: $ACCOUNT_ID"

# Paso 2: Crear OIDC Provider (si no existe)
echo ""
echo "📋 Paso 2: Creando OIDC Provider..."

aws iam create-open-id-connect-provider \
    --url https://token.actions.githubusercontent.com \
    --client-id-list sts.amazonaws.com \
    --thumbprint-list 6938fd4d98bab03faadb97b34396831e3780aea1 \
    --profile $PROFILE \
    --region $REGION 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ OIDC Provider creado"
else
    echo "⚠️  OIDC Provider ya existe o error al crear (esto es normal si ya existe)"
fi

# Paso 3: Crear Trust Policy
echo ""
echo "📋 Paso 3: Creando Trust Policy..."

cat > /tmp/trust-policy.json << EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${ACCOUNT_ID}:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:${REPO}:*"
        }
      }
    }
  ]
}
EOF

echo "✅ Trust Policy creada"

# Paso 4: Crear IAM Role
echo ""
echo "📋 Paso 4: Creando IAM Role..."

aws iam create-role \
    --role-name $ROLE_NAME \
    --assume-role-policy-document file:///tmp/trust-policy.json \
    --description "Role for GitHub Actions to deploy infrastructure" \
    --profile $PROFILE \
    --region $REGION

if [ $? -eq 0 ]; then
    echo "✅ IAM Role creado: $ROLE_NAME"
else
    echo "❌ Error al crear el rol (puede que ya exista)"
fi

# Paso 5: Attach AdministratorAccess Policy (para laboratorio)
echo ""
echo "📋 Paso 5: Adjuntando política AdministratorAccess..."

aws iam attach-role-policy \
    --role-name $ROLE_NAME \
    --policy-arn arn:aws:iam::aws:policy/AdministratorAccess \
    --profile $PROFILE \
    --region $REGION

if [ $? -eq 0 ]; then
    echo "✅ Política adjuntada"
else
    echo "⚠️  Error al adjuntar política (puede que ya esté adjuntada)"
fi

# Paso 6: Mostrar ARN del Role
echo ""
echo "=================================================="
echo "✅ CONFIGURACIÓN COMPLETADA"
echo "=================================================="
echo ""
echo "🔑 ARN del Role:"
ROLE_ARN="arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}"
echo "$ROLE_ARN"
echo ""
echo "📋 Próximos pasos:"
echo "1. Copia el ARN del role de arriba"
echo "2. Ve a GitHub → Settings → Secrets and variables → Actions"
echo "3. Crea un nuevo secret:"
echo "   Name: AWS_ROLE_ARN"
echo "   Value: $ROLE_ARN"
echo ""
echo "🚀 Después de agregar el secret, el workflow funcionará con OIDC!"

# Limpiar
rm /tmp/trust-policy.json
