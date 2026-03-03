# 🔐 Configuración OIDC + IAM Role para GitHub Actions

## ⚠️ IMPORTANTE
Este método es más seguro que usar Access Keys estáticas y funciona mejor con Terragrunt.

## 📋 Paso 1: Crear IAM OIDC Provider en AWS

1. Ve a **IAM** en AWS Console
2. Click en **Identity providers** (menú izquierdo)
3. Click en **Add provider**
4. Configurar:
   - Provider type: **OpenID Connect**
   - Provider URL: `https://token.actions.githubusercontent.com`
   - Audience: `sts.amazonaws.com`
5. Click **Add provider**

## 📋 Paso 2: Crear IAM Role

1. Ve a **IAM** → **Roles** → **Create role**
2. Select trusted entity: **Web identity**
3. Configurar:
   - Identity provider: `token.actions.githubusercontent.com`
   - Audience: `sts.amazonaws.com`
4. Click **Next**
5. Attach permissions policies (selecciona las que necesites):
   - `AdministratorAccess` (para laboratorio)
   - O crea una política personalizada con permisos específicos
6. Click **Next**
7. Role details:
   - Role name: `GitHubActionsRole`
   - Description: "Role for GitHub Actions to deploy infrastructure"
8. Click **Create role**

## 📋 Paso 3: Editar Trust Relationship

1. Ve al rol recién creado: `GitHubActionsRole`
2. Click en la pestaña **Trust relationships**
3. Click en **Edit trust policy**
4. Reemplaza con esto (ajusta el repo):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::TU_ACCOUNT_ID:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:mauricio024/Banca_global_alb_ecs_fargate_rds_redis_Migrate:*"
        }
      }
    }
  ]
}
```

5. Reemplaza `TU_ACCOUNT_ID` con tu AWS Account ID
6. Click **Update policy**

## 📋 Paso 4: Copiar ARN del Role

1. En la página del rol, copia el **ARN**
2. Se ve así: `arn:aws:iam::123456789012:role/GitHubActionsRole`

## 📋 Paso 5: Agregar Secret en GitHub

1. Ve a tu repositorio en GitHub
2. **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Configurar:
   - Name: `AWS_ROLE_ARN`
   - Secret: `arn:aws:iam::123456789012:role/GitHubActionsRole` (tu ARN)
5. Click **Add secret**

## ✅ Verificación

Después de configurar:
- ✅ OIDC Provider creado
- ✅ IAM Role creado con permisos
- ✅ Trust policy configurado
- ✅ Secret `AWS_ROLE_ARN` agregado en GitHub

## 🚀 Ejecutar Workflow

Ahora puedes:
1. Hacer push a `main`
2. O ejecutar manualmente desde Actions

El workflow usará OIDC para autenticarse sin necesidad de Access Keys.

## 🔒 Ventajas de OIDC

- ✅ No necesitas Access Keys estáticas
- ✅ Más seguro (tokens temporales)
- ✅ Mejor para CI/CD
- ✅ Funciona perfectamente con Terragrunt
- ✅ Rotación automática de credenciales

## 📝 Política IAM Mínima (Opcional)

Si no quieres usar AdministratorAccess, aquí hay una política mínima:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "ecs:*",
        "rds:*",
        "elasticache:*",
        "s3:*",
        "lambda:*",
        "iam:*",
        "kms:*",
        "secretsmanager:*",
        "wafv2:*",
        "elasticloadbalancing:*",
        "logs:*",
        "ssm:*",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "*"
    }
  ]
}
```

---

**¡Listo!** Con OIDC configurado, el workflow debería funcionar correctamente. 🎯
