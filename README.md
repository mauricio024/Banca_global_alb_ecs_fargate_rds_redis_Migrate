# Banca_global_alb_ecs_fargate_rds_redis_Migrate
Aruitectrua de servcios Migrados a la Nube - Banca Global - Pragma

# Banca ECS Fargate Pattern - Migration

## **Table of Contents**

- [Description](#description)
  - [Architecture Overview](#architecture-overview)
  - [Resources Deployed](#resources-deployed)
- [Requirements](#requirements)
- [Project Structure](#project-structure)
- [Configuration](#configuration)
  - [Global Parameters](#global-parameters)
  - [Environment Configuration](#environment-configuration)
- [How to Use Terragrunt](#how-to-use-terragrunt)
  - [Initial Setup](#initial-setup)
  - [Workspace Management](#workspace-management)
  - [Deployment Commands](#deployment-commands)
  - [Individual Module Deployment](#individual-module-deployment)
  - [Destroy Resources](#destroy-resources)
- [Module Dependencies](#module-dependencies)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)

## Description

This project contains an Infrastructure as Code (IaC) template for deploying a containerized application architecture on AWS using ECS Fargate. The infrastructure is managed using Terraform and Terragrunt, following DevSecOps best practices.

### Architecture Overview

The architecture includes:
- **Network Layer**: VPC with public, private, and database subnets
- **Compute Layer**: ECS Fargate cluster with Application Load Balancer
- **Storage Layer**: S3 bucket for application data and Lambda functions
- **Database Layer**: RDS PostgreSQL and ElastiCache Valkey (Redis-compatible)
- **Security Layer**: WAF, KMS encryption, Secrets Manager, IAM policies, and Security Groups

### Resources Deployed

| Category | Resource | Description |
|----------|----------|-------------|
| **Network** | VPC | Multi-AZ VPC with public, private, and database subnets |
| | Security Groups | ALB, ECS, and RDS security groups |
| **Compute** | ALB | Application Load Balancer for traffic distribution |
| | ECS Cluster | Fargate cluster for containerized applications |
| | Lambda | Serverless functions for automation tasks |
| **Storage** | S3 | Private bucket for application data |
| **Database** | RDS PostgreSQL | Multi-AZ relational database |
| | ElastiCache Valkey | In-memory cache cluster |
| **Security** | KMS | Encryption keys for data at rest |
| | Secrets Manager | Database credentials storage |
| | WAF | Web Application Firewall rules |
| | IAM | Roles and policies for services |

## Requirements

- **AWS CLI** (v2.x or higher) - [Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- **Terraform** (v1.5.x or higher) - [Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- **Terragrunt** (v0.50.x or higher) - [Installation Guide](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- **AWS SSO Profile** configured with appropriate permissions
- Basic knowledge of Terraform and Terragrunt

## Project Structure

```
Banca_ecs_fargate_pattern_Migrate/
├── common/
│   ├── common.hcl          # Global configuration and backend settings
│   └── common.tfvars       # Common variables for all modules
├── resources/
│   ├── Network/
│   │   ├── VPC/
│   │   └── SecurityGroups/
│   ├── Compute/
│   │   ├── EC2/ALB_Main/
│   │   └── Lambda/
│   ├── Containers/
│   │   └── ECS/
│   ├── Database/
│   │   ├── RDS/Postgresql_Main/
│   │   └── ElastiCache/
│   ├── Storage/
│   │   └── S3/
│   └── Security/
│       ├── KMS/
│       ├── SecretsManager/
│       ├── WAF/
│       └── IAM/
└── terragrunt.hcl          # Root Terragrunt configuration
```

## Configuration

### Global Parameters

Edit `common/common.hcl` to configure global settings:

```hcl
locals {
  provider = "aws"
  client   = "Pragma"
  project  = "Banca-global-ecs-fargate-pattern"

  # Backend Configuration
  backend_profile       = "sh-gencloudtest"
  backend_region        = "us-east-1"
  backend_bucket_name   = "pragma-migracion-bkt-terraform-tfstate"
  backend_key           = "terraform.tfstate"
  backend-dynamodb-lock = "db-terraform-lock"
  backend_encrypt       = true
  project_folder        = "${local.provider}/${local.client}/${local.project}"
}
```

### Environment Configuration

Each module contains a `parameters.tf` file with environment-specific configurations:

```hcl
locals {
  env = {
    default = { /* default values */ }
    dev     = { /* dev overrides */ }
    prod    = { /* prod overrides */ }
    qa      = { /* qa overrides */ }
  }
}
```

## How to Use Terragrunt

### Initial Setup

1. **Configure AWS SSO Profile**
   ```bash
   aws configure sso --profile sh-gencloudtest
   aws sso login --profile sh-gencloudtest
   ```

2. **Verify Configuration**
   ```bash
   aws sts get-caller-identity --profile sh-gencloudtest
   ```

### Workspace Management

Terragrunt uses Terraform workspaces to manage multiple environments.

**Create a new workspace:**
```bash
# Create workspace for all modules
terragrunt run-all workspace new dev --terragrunt-exclude-dir .

# Available workspaces: dev, prod, qa
```

**List workspaces:**
```bash
terragrunt run-all workspace list
```

**Select workspace:**
```bash
terragrunt run-all workspace select dev
```

### Deployment Commands

**Plan all resources:**
```bash
# From project root
terragrunt run-all plan --terragrunt-exclude-dir .
```

**Apply all resources:**
```bash
# Deploy entire infrastructure
terragrunt run-all apply --terragrunt-exclude-dir .

# Auto-approve (use with caution)
terragrunt run-all apply --terragrunt-exclude-dir . --terragrunt-non-interactive
```

**Show deployment order:**
```bash
terragrunt graph-dependencies | dot -Tpng > dependency-graph.png
```

### Individual Module Deployment

Deploy specific modules in order:

**1. Network Layer (Foundation)**
```bash
# VPC first
cd resources/Network/VPC
terragrunt apply

# Security Groups
cd ../SecurityGroups/ALB
terragrunt apply
```

**2. Security Layer**
```bash
# KMS for encryption
cd resources/Security/KMS/KMS_Infrastructure
terragrunt apply

# Secrets Manager
cd ../../SecretsManager/SecretDBPostgreSQL
terragrunt apply
```

**3. Storage Layer**
```bash
cd resources/Storage/S3
terragrunt apply
```

**4. Database Layer**
```bash
# RDS PostgreSQL
cd resources/Database/RDS/Postgresql_Main
terragrunt apply

# ElastiCache Valkey
cd ../../ElastiCache
terragrunt apply
```

**5. Compute Layer**
```bash
# Lambda functions
cd resources/Compute/Lambda
terragrunt apply

# Application Load Balancer
cd ../EC2/ALB_Main
terragrunt apply
```

**6. Container Layer**
```bash
# ECS Cluster
cd resources/Containers/ECS/ECS_Cluster
terragrunt apply

# ECS Services
cd ../Services/default_service
terragrunt apply
```

### Destroy Resources

**Destroy all resources:**
```bash
# From project root
terragrunt run-all destroy --terragrunt-exclude-dir .
```

**Destroy specific module:**
```bash
cd resources/path/to/module
terragrunt destroy
```

**Destroy in reverse dependency order:**
```bash
terragrunt run-all destroy --terragrunt-exclude-dir . --terragrunt-non-interactive
```

## Module Dependencies

Terragrunt automatically manages dependencies between modules using the `dependency` block:

```hcl
dependency "vpc" {
  config_path = "../../Network/VPC"
  mock_outputs = {
    vpc_id = "vpc-12345678"
  }
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}
```

**Dependency Order:**
1. VPC → Security Groups
2. KMS → RDS, ElastiCache, S3
3. VPC + Security Groups → RDS, ElastiCache, ALB
4. ALB + VPC → ECS Cluster
5. ECS Cluster → ECS Services

## Troubleshooting

**Issue: Backend not initialized**
```bash
terragrunt init -reconfigure
```

**Issue: State lock**
```bash
# Check DynamoDB for locks
aws dynamodb scan --table-name db-terraform-lock --profile sh-gencloudtest

# Force unlock (use with caution)
terraform force-unlock <LOCK_ID>
```

**Issue: Dependency errors**
```bash
# Clear Terragrunt cache
find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;

# Re-run with dependencies
terragrunt run-all apply --terragrunt-exclude-dir .
```

**Issue: Module not found**
```bash
# Download modules
terragrunt init -upgrade
```

## Best Practices

1. **Always use workspaces** for environment separation
2. **Review plan output** before applying changes
3. **Use `run-all` commands** from project root for consistency
4. **Commit state changes** to version control (if using git backend)
5. **Tag resources** appropriately for cost tracking
6. **Use mock outputs** in dependencies for faster planning
7. **Test in dev** before deploying to prod
8. **Document custom changes** in module README files
9. **Keep Terraform/Terragrunt versions** consistent across team
10. **Use SSM Parameter Store** for cross-module data sharing

## Additional Resources

- [Terragrunt Documentation](https://terragrunt.gruntwork.io/docs/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS ECS Best Practices](https://docs.aws.amazon.com/AmazonECS/latest/bestpracticesguide/)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)

---

**Project**: Banca ECS Fargate Pattern Migration  
**Managed By**: Terraform + Terragrunt  
**Cloud Provider**: AWS  
**Last Updated**: 2024

