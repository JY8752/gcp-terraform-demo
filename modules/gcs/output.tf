output "bucket_name" {
  value = google_storage_bucket.default.name
}

output "bucket" {
  value = google_storage_bucket.default
}
