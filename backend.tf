// tfstate用のバケット作成
# module "backend_gcs" {
#   source = "./modules/gcs"
#   name   = "${local.input.project_id}-backend"
# }

# terraform {
#   backend "gcs" {
#     bucket = "gcp-test-project-20230329-backend"
#     prefix = "terraform/state"
#   }
# }

terraform {
  backend "local" {
  }
}
