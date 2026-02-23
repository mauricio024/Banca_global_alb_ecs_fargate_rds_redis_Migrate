variable "force_destroy" {
  description = "Force destroy bucket"
  type        = bool
  default     = false
}

variable "versioning" {
  description = "enabled versioning"
  type        = bool
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to set for all resources"
  default     = {}
}
