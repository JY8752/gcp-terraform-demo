# GCEモジュール
resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = "aaaa"
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
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  // サービスアカウントを通してのアクセス権限付与
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }
}
