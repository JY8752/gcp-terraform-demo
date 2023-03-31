variable "name" {
  type        = string
  default     = ""
  description = "It's a GCS bucket name."
}

variable "storage" {
  type        = string
  default     = "STANDARD"
  description = "It's a GCS storage type.only specify `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`."
  validation {
    condition     = can(regex("[STANDARD|MULTI_REGIONAL|REGIONAL|NEARLINE|COLDLINE|ARCHIVE]", var.storage))
    error_message = "Only STANDARD|MULTI_REGIONAL|REGIONAL|NEARLINE|COLDLINE|ARCHIVE value."
  }
}
