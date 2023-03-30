// 変数情報
locals {
  input = {
    project_id            = var.project_id
    service_account_email = var.service_account_email
  }
}

variable "project_id" {
  type        = string
  default     = ""
  description = "It's a GCP project id."
}

variable "service_account_email" {
  type        = string
  default     = ""
  description = "It's a GCP service account email."
}
