# マシンイメージを作成する
resource "google_compute_instance_template" "template" {
  name_prefix  = var.name
  machine_type = var.machine_type

  tags = var.tags

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
  }

  // インスタンスにアタッチするネットワーク
  network_interface {
    network    = var.network
    subnetwork = var.subnet

    access_config {
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

# インスタンスグループを作成する
resource "google_compute_instance_group_manager" "group_manager" {
  name               = "${var.name}-instance-group"
  base_instance_name = var.name
  zone               = var.zone

  target_size = var.target_size

  version {
    name              = "app"
    instance_template = google_compute_instance_template.template.self_link
  }

  # ロードバランサーを設定する
  # named_port {
  #   name = "http"
  #   port = 80
  # }
  # named_port {
  #   name = "https"
  #   port = 443
  # }

  target_pools = [
    google_compute_target_pool.pool.self_link
  ]
}

# 前提条件を作成する
resource "google_compute_target_pool" "pool" {
  name = "${var.name}-target-pool"
  # instances = [
  #   google_compute_instance_group_manager.group_manager.instance_group_link
  # ]
  health_checks = [
    google_compute_http_health_check.health_check.self_link
  ]
}

# autoscalingの設定
resource "google_compute_autoscaler" "default" {
  name   = "${var.name}-autoscaler"
  target = google_compute_instance_group_manager.group_manager.id
  autoscaling_policy {
    min_replicas    = 1
    max_replicas    = 5
    cooldown_period = 60
  }
}

# resource "google_compute_backend_service" "default" {
#   name = "${var.name}-backend-service"
#   backend {
#     group = google_compute_instance_group_manager.group_manager.self_link
#   }
#   health_checks    = [google_compute_http_health_check.health_check.self_link]
#   session_affinity = "NONE"
# }

resource "google_compute_http_health_check" "health_check" {
  name         = "${var.name}-health-check"
  request_path = "/"
  port         = "80"
}

# resource "google_compute_global_forwarding_rule" "default" {
#   name       = "${var.name}-forwarding-rule"
#   target     = google_compute_backend_service.default.self_link
#   port_range = "80"
#   ip_address = "0.0.0.0"
# }
