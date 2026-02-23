# 🔐 Guía: Configurar Secrets de AWS en GitHub Actions

## 📍 Ubicación

Estás en: **Settings → Secrets and variables → Actions → New repository secret**

## 🎯 Secrets Requeridos (4 en total)

Debes crear **4 secrets** con los siguientes nombres y valores:

---

## 1️⃣ Secret para DEV - Access Key ID

### Name (Nombre):
```
AWS_ACCESS_KEY_ID
```

### Value (Valor):
```
AKIA... (tu AWS Access Key ID de la cuenta DEV)
```

**Ejemplo de formato**:
- Comienza con: `AKIA`
- Longitud: 20 caracteres
- Ejemplo: `AKIAIOSFODNN7EXAMPLE`

**¿Dónde obtenerlo?**
- AWS Console → IAM → Users → Tu usuario → Security credentials → Access keys
- O pregunta a tu administrador de AWS

---

## 2️⃣ Secret para DEV - Secret Access Key

### Name (Nombre):
```
AWS_SECRET_ACCESS_KEY
```

### Value (Valor):
```
wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY (tu AWS Secret Access Key de DEV)
```

**Ejemplo de formato**:
- Longitud: 40 caracteres
- Mezcla de letras mayúsculas, minúsculas, números y símbolos
- Ejemplo: `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY`

**⚠️ IMPORTANTE**: 
- Solo se muestra UNA VEZ cuando creas el Access Key
- Si no lo guardaste, debes crear uno nuevo

---

## 3️⃣ Secret para PROD - Access Key ID

### Name (Nombre):
```
AWS_ACCESS_KEY_ID_PROD
```

### Value (Valor):
```
AKIA... (tu AWS Access Key ID de la cuenta PROD)
```

**Nota**: Debe ser de una cuenta AWS diferente a DEV (cuenta de producción)

---

## 4️⃣ Secret para PROD - Secret Access Key

### Name (Nombre):
```
AWS_SECRET_ACCESS_KEY_PROD
```

### Value (Valor):
```
wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY (tu AWS Secret Access Key de PROD)
```

**Nota**: Corresponde al Access Key ID de producción

---

## 📋 Resumen Visual

```
┌─────────────────────────────────────────────────────────────┐
│ Secret 1 (DEV)                                              │
├─────────────────────────────────────────────────────────────┤
│ Name:  AWS_ACCESS_KEY_ID                                    │
│ Value: AKIAIOSFODNN7EXAMPLE                                 │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ Secret 2 (DEV)                                              │
├─────────────────────────────────────────────────────────────┤
│ Name:  AWS_SECRET_ACCESS_KEY                                │
│ Value: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY             │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ Secret 3 (PROD)                                             │
├─────────────────────────────────────────────────────────────┤
│ Name:  AWS_ACCESS_KEY_ID_PROD                               │
│ Value: AKIAZZZZZZZZZEXAMPLE                                 │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ Secret 4 (PROD)                                             │
├─────────────────────────────────────────────────────────────┤
│ Name:  AWS_SECRET_ACCESS_KEY_PROD                           │
│ Value: anotherSecretKeyForProdEXAMPLE                       │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔍 ¿Cómo Obtener las Credenciales de AWS?

### Opción 1: Desde AWS Console

1. Inicia sesión en AWS Console
2. Ve a **IAM** (Identity and Access Management)
3. Click en **Users** (Usuarios)
4. Selecciona tu usuario
5. Ve a la pestaña **Security credentials**
6. En la sección **Access keys**, click en **Create access key**
7. Selecciona **Use case**: "Command Line Interface (CLI)"
8. Click **Next** → **Create access key**
9. **¡IMPORTANTE!** Copia ambos valores:
   - Access key ID
   - Secret access key
10. Guárdalos en un lugar seguro

### Opción 2: Desde AWS CLI

```bash
# Si ya tienes configurado AWS CLI
aws configure list

# Ver el Access Key ID actual
aws configure get aws_access_key_id --profile sh-gencloudtest

# Nota: El Secret Access Key NO se puede recuperar, solo crear uno nuevo
```

### Opción 3: Preguntar al Administrador

Si no tienes permisos para crear Access Keys, solicita al administrador de AWS que te proporcione:
- Access Key ID
- Secret Access Key

---

## ✅ Verificación

Después de agregar los 4 secrets, deberías ver en GitHub:

```
Repository secrets (4)

AWS_ACCESS_KEY_ID                 Updated X minutes ago
AWS_SECRET_ACCESS_KEY             Updated X minutes ago
AWS_ACCESS_KEY_ID_PROD            Updated X minutes ago
AWS_SECRET_ACCESS_KEY_PROD        Updated X minutes ago
```

---

## ⚠️ Seguridad

### ✅ HACER:
- Usar usuarios IAM con permisos mínimos necesarios
- Rotar las credenciales periódicamente (cada 90 días)
- Usar diferentes credenciales para dev y prod
- Nunca compartir las credenciales por email o chat

### ❌ NO HACER:
- Usar credenciales de root account
- Compartir las mismas credenciales entre dev y prod
- Commitear credenciales en el código
- Usar credenciales personales para CI/CD

---

## 🧪 Probar la Configuración

Después de agregar los secrets:

1. Ve a la pestaña **Actions**
2. Click en **Run workflow** (si está disponible)
3. O haz un push a la rama `main` o `develop`
4. Verifica que el workflow se ejecute sin errores de autenticación

---

## 🆘 Troubleshooting

### Error: "InvalidClientTokenId"
- El Access Key ID es incorrecto
- Verifica que copiaste el valor completo
- Asegúrate de no tener espacios al inicio o final

### Error: "SignatureDoesNotMatch"
- El Secret Access Key es incorrecto
- Verifica que copiaste el valor completo
- Puede que necesites crear un nuevo Access Key

### Error: "AccessDenied"
- El usuario IAM no tiene los permisos necesarios
- Revisa la política IAM del usuario
- Agrega los permisos necesarios (ver GITHUB_ACTIONS_SETUP.md)

---

## 📝 Ejemplo Completo

```
Paso 1: Click en "New repository secret"

Paso 2: Llenar el formulario
┌─────────────────────────────────────────┐
│ Name *                                  │
│ ┌─────────────────────────────────────┐ │
│ │ AWS_ACCESS_KEY_ID                   │ │
│ └─────────────────────────────────────┘ │
│                                         │
│ Secret *                                │
│ ┌─────────────────────────────────────┐ │
│ │ AKIAIOSFODNN7EXAMPLE                │ │
│ └─────────────────────────────────────┘ │
│                                         │
│ [Add secret]                            │
└─────────────────────────────────────────┘

Paso 3: Click en "Add secret"

Paso 4: Repetir para los otros 3 secrets
```

---

## ✅ Checklist

- [ ] Secret 1: AWS_ACCESS_KEY_ID agregado
- [ ] Secret 2: AWS_SECRET_ACCESS_KEY agregado
- [ ] Secret 3: AWS_ACCESS_KEY_ID_PROD agregado
- [ ] Secret 4: AWS_SECRET_ACCESS_KEY_PROD agregado
- [ ] Verificado que aparecen los 4 secrets en la lista
- [ ] Probado ejecutando un workflow

---

**¡Listo!** Tus secrets están configurados y GitHub Actions puede desplegar a AWS 🚀
