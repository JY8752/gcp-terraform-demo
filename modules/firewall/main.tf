// firewallモジュール
resource "google_compute_firewall" "default" {
  name    = var.name
  network = var.network

  allow {
    protocol = "tcp"
    ports    = var.ports
  }

  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}
