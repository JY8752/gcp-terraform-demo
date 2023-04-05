variable "name" {
  type        = string
  default     = ""
  description = "The name of project."
}

variable "machine_type" {
  type        = string
  default     = "e2-micro"
  description = "The machine type of instance."
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "The tags of instance."
}

variable "network" {
  type        = string
  default     = "default"
  description = "The network of instance."
}

variable "subnet" {
  type        = string
  default     = ""
  description = "The subnet of instance."
}

variable "service_account_email" {
  type        = string
  default     = ""
  description = "Email of the service account to be attached to the instance."
}

variable "service_account_scopes" {
  type        = list(string)
  default     = ["cloud-platform"]
  description = "Access scope to be set for the service account."
}

variable "metadata_startup_script" {
  type        = string
  default     = ""
  description = "The metadata startup script of instance."
}

variable "zone" {
  type        = string
  default     = "asia-northeast1-c"
  description = "The zone of instance."
}

# variable "target_size" {
#   type        = number
#   default     = 3
#   description = "The target size of autoscaling."
# }

# variable "region" {
#   type        = string
#   default     = "asia-northeast1"
#   description = "The region of autoscaling."
# }
