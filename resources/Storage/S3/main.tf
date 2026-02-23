/**
* # Module for S3 deployment
* * This module creates a private S3 Bucket
*/

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket        = local.workspace["bucket_name"]
  force_destroy = local.workspace["force_destroy"]

  versioning = {
    enabled = var.versioning
  }

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  server_side_encryption_configuration = local.workspace["server_side_encryption_configuration"]

  tags = local.workspace["tags"]
}

module "store_ssm" {
  source  = "cloudposse/ssm-parameter-store/aws"
  version = "0.13.0"

  parameter_write = [
    {
      name        = "/${var.project}/${terraform.workspace}/s3/bucket_arn"
      value       = module.s3-bucket.s3_bucket_arn
      type        = "String"
      overwrite   = "true"
      description = "S3 Bucket ARN for ${terraform.workspace} environment"
    }
  ]
}
