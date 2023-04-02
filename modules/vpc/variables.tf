variable "name" {
  type        = string
  default     = ""
  description = "It's a vpc name."
}

variable "region" {
  type        = string
  default     = "asia-northeast1"
  description = "It's a vpc region."
}

variable "ip_cidr_range" {
  type        = string
  default     = ""
  description = "It's a vpc ip cidr range."
}
