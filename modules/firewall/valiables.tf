variable "name" {
  type        = string
  default     = ""
  description = "It's a firewall name."
}

variable "network" {
  type        = string
  default     = "default"
  description = "It's a firewall network."
}

variable "ports" {
  type        = list(string)
  default     = []
  description = "It's a firewall ports."
}

variable "source_ranges" {
  type        = list(string)
  default     = []
  description = "It's a firewall source ranges."
}

variable "target_tags" {
  type        = list(string)
  default     = []
  description = "It's a firewall target tags."
}
