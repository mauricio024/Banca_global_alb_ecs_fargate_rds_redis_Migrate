variable "vpc_id" {
  description = "VPC id where the load balancer and other resources will be deployed"
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private subnet id list"
}

variable "sg_alb_id" {
  description = "Security Group ID for load Balancer"
  type        = string
}

# variable "acm_certificate_arn" {
#   description = "The ARN of the certificate ACM"
#   type        = string
#   default     = ""
# } 