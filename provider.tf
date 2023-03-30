// プロバイダー情報
provider "google" {
  project = local.input.project_id
  region  = "asia-northeast1"
  zone    = "asia-northeast1-c"
}
