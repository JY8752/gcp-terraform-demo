// GCPのプライベートサービス接続用のVPCを作成
resource "google_compute_network" "private_network" {
  name                    = var.name
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "${var.name}-private-subnet"
  region        = var.region
  network       = google_compute_network.private_network.self_link
  ip_cidr_range = var.ip_cidr_range
}

resource "google_compute_global_address" "private_address" {
  name          = "${var.name}-private-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.self_link
}

resource "google_service_networking_connection" "private_service_connection" {
  network                 = google_compute_network.private_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_address.name]
  depends_on = [
    google_compute_network.private_network,
    google_compute_global_address.private_address
  ]
}
