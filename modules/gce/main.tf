# GCEモジュール
resource "google_compute_address" "default" {
  name         = "gce-static-ip-address"
  address_type = "EXTERNAL"
}

resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags

  // 起動ディスク
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "test"
      }
    }
  }

  // インスタンスにアタッチするネットワーク
  network_interface {
    network    = var.network
    subnetwork = var.subnet

    access_config {
      // 静的IPを指定
      nat_ip = google_compute_address.default.address
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = var.metadata_startup_script

  // サービスアカウントを通してのアクセス権限付与
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }

}
