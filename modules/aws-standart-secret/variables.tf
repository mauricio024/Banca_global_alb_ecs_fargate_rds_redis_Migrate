variable "create" {
  description = "Boolean indicating whether the resource is created"
  type        = bool
  default     = false
}

variable "name" {
  description = "Specifies the friendly name of the new secret. The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: /_+=.@- Spaces are not permitted."
  type        = string
}

variable "value" {
  description = "Specifies text data that you want to encrypt and store in this version of the secret."
  type        = string
  default     = ""
}

variable "description" {
  description = "A description of the secret."
  type        = string
  default     = ""
}

variable "recovery_window_in_days" {
  description = "specifies the number of days the secret is waiting for deletion"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Specifies a key-value map of user-defined tags that are attached to the secret."
  type        = map(string)
  default     = {}
}