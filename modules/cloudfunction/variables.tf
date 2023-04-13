variable "project" {
  type        = string
  description = "The project ID to deploy to."
  default     = ""
}

variable "function_name" {
  type        = string
  description = "The name of the function."
  default     = ""
}

variable "service_account_email" {
  type        = string
  description = "The service account email of the function."
  default     = ""
}
