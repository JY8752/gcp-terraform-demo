module "gce" {
  source                = "./modules/gce"
  name                  = "gcp-test-instance"
  service_account_email = local.input.service_account_email
}
