variable "name" {
  type        = string
  default     = ""
  description = "It's a cloudsql instance name."
}

variable "database_version" {
  type        = string
  default     = "MYSQL_8_0"
  description = "It's a cloudsql instance database version."
}

variable "region" {
  type        = string
  default     = "asia-northeast1"
  description = "It's a cloudsql instance region."
}

variable "tier" {
  type        = string
  default     = "db-f1-micro"
  description = "It's a cloudsql instance tier."
}

variable "network" {
  type        = string
  default     = "default"
  description = "It's a cloudsql instance network."
}

variable "password" {
  type        = string
  default     = ""
  description = "It's a cloudsql instance password."
}
