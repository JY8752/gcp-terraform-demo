locals {
  // webとして公開するためのfirewallタグ
  web_firewall_tag = "web"
}

module "gcs" {
  source = "./modules/gcs"
  name   = "${local.input.project_id}-test-bucket"
}

module "private_network" {
  source        = "./modules/vpc"
  name          = "${local.input.project_id}-network"
  ip_cidr_range = "10.0.0.0/16"
}

module "gce" {
  source                  = "./modules/gce"
  name                    = "gcp-test-instance"
  service_account_email   = local.input.service_account_email
  tags                    = [local.web_firewall_tag]
  network                 = module.private_network.self_link
  subnet                  = module.private_network.subnet
  metadata_startup_script = <<-EOF
    # gcsfuseをパッケージに追加
    export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
    echo "deb https://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

    # パッケージインストール
    sudo apt update
    sudo apt install nginx gcsfuse mariadb-client -y

    # nginxのインストールと起動
    sudo systemctl start nginx

    # GCSをマウント
    sudo mkdir -p /var/www/html/gcs
    sudo gcsfuse --implicit-dirs ${module.gcs.bucket_name} /var/www/html/gcs
  EOF
  depends_on              = [module.gcs, module.private_network]
}

module "web_firewall" {
  source        = "./modules/firewall"
  name          = "web-firewall"
  network       = module.private_network.self_link
  ports         = ["80", "443"]
  source_ranges = ["0.0.0.0/0"]
  target_tags   = [local.web_firewall_tag]
  depends_on = [
    module.private_network
  ]
}

module "ssh_firewall" {
  source        = "./modules/firewall"
  name          = "ssh-firewall"
  network       = module.private_network.self_link
  ports         = ["22"]
  source_ranges = ["0.0.0.0/0"]
  # target_tags   = [local.web_firewall_tag]
  depends_on = [
    module.private_network
  ]
}

module "db" {
  source   = "./modules/cloudsql"
  name     = "gcp-test-db"
  network  = module.private_network.id
  password = local.input.mysql_password
  depends_on = [
    module.private_network
  ]
}
