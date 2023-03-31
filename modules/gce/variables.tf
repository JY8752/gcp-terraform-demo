variable "name" {
  type        = string
  default     = ""
  description = "It's a gce instance name."
}

variable "machine_type" {
  type        = string
  default     = "e2-micro"
  description = "It's a gce instance machine type."
}

variable "zone" {
  type        = string
  default     = "asia-northeast1-c"
  description = "Its's a gce instacne zone."
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "It's a gce instance tags."
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
  description = "It's a gce instance metadata startup script."
}
