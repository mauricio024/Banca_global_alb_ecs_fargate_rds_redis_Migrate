# GitHub Actions Setup Guide

## Required Secrets

Configure the following secrets in your GitHub repository:

### Settings → Secrets and variables → Actions → New repository secret

#### For Dev Environment:
- `AWS_ACCESS_KEY_ID` - AWS Access Key for dev account
- `AWS_SECRET_ACCESS_KEY` - AWS Secret Key for dev account

#### For Prod Environment:
- `AWS_ACCESS_KEY_ID_PROD` - AWS Access Key for prod account
- `AWS_SECRET_ACCESS_KEY_PROD` - AWS Secret Key for prod account

## Environment Setup

### Create Environments in GitHub:

1. Go to **Settings → Environments**
2. Create `dev` environment
3. Create `prod` environment
4. Add protection rules for `prod`:
   - Required reviewers
   - Wait timer (optional)

## Workflow Triggers

- **Push to `develop`**: Validates and applies to dev environment
- **Push to `main`**: Validates and applies to prod environment
- **Pull Request**: Runs validation and plan only
- **Manual**: Can be triggered manually from Actions tab

## AWS IAM Policy for GitHub Actions

Create an IAM user with the following policy:

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
        "ssm:*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": "arn:aws:s3:::pragma-migracion-bkt-terraform-tfstate/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "arn:aws:dynamodb:*:*:table/db-terraform-lock"
    }
  ]
}
```

## Testing GitHub Actions Locally

Use [act](https://github.com/nektos/act) to test workflows locally:

```bash
# Install act
brew install act

# Run workflow
act -j validate
```

## Monitoring

- Check workflow runs in **Actions** tab
- Review logs for each job
- Set up notifications for failed workflows

## Troubleshooting

### Workflow fails on init
- Verify AWS credentials are correct
- Check S3 bucket and DynamoDB table exist
- Ensure IAM permissions are sufficient

### Workflow fails on apply
- Review Terraform plan output
- Check for resource conflicts
- Verify workspace is correct

### State lock issues
- Check DynamoDB for existing locks
- Manually unlock if needed (with caution)
