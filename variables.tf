// 変数情報
locals {
  input = {
    project_id            = var.project_id
    service_account_email = var.service_account_email
    mysql_password        = var.mysql_password
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

variable "mysql_password" {
  type        = string
  default     = ""
  description = "It's a GCP cloudsql mysql password."
}
