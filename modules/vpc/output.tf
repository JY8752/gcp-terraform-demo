output "self_link" {
  value = google_compute_network.private_network.self_link
}

output "id" {
  value = google_compute_network.private_network.id
}

output "subnet" {
  value = google_compute_subnetwork.private_subnet.self_link
}
