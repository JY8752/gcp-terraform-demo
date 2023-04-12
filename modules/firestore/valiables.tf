variable "name" {
  type        = string
  default     = "(default)"
  description = "Database name."
}

variable "location_id" {
  type        = string
  default     = "nam5"
  description = "The location ID of the database. Possible values are: asia-east1, asia-east2, asia-northeast1, asia-northeast2, asia-northeast3, asia-south1, asia-southeast1, australia-southeast1, europe-north1, europe-west1, europe-west2, europe-west3, europe-west4, europe-west6, northamerica-northeast1, southamerica-east1, us-central1, us-east1, us-east4, us-west1, us-west2, us-west3, us-west4"
}

variable "type" {
  type        = string
  default     = "FIRESTORE_NATIVE"
  description = "The type of the database. Possible values are: FIRESTORE_NATIVE, CLOUD_FIRESTORE"
}

variable "concurrency_mode" {
  type        = string
  default     = "OPTIMISTIC"
  description = "The concurrency mode of the database. Possible values are: OPTIMISTIC, PESSIMISTIC, OPTIMISTIC_WITH_ENTITY_GROUPS"
}

variable "app_engine_integration_mode" {
  type        = string
  default     = "DISABLED"
  description = "The App Engine integration mode of the database. Possible values are: DISABLED, READ_ONLY, READ_WRITE"
}
