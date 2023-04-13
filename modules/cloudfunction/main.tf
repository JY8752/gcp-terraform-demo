# ソースコードの配置バケット
resource "google_storage_bucket" "bucket" {
  name                        = "${var.project}-gcf-source" # Every bucket name must be globally unique
  location                    = "US"
  uniform_bucket_level_access = true
  force_destroy               = true
}

# resource "null_resource" "build" {
#   provisioner "local-exec" {
#     working_dir = "./functions/${var.function_name}"
#     command     = <<-EOF
#       go build -ldflags '-s -w' -o cloud_function main.go
#       upx -9 cloud_function
#       zip -9 ${var.function_name}.zip cloud_function
#     EOF
#   }
# }

data "archive_file" "function_got_archive" {
  type        = "zip"
  source_dir  = "functions/${var.function_name}"
  output_path = "${var.function_name}.zip"
}

resource "google_storage_bucket_object" "object" {
  name   = "${var.function_name}.zip"
  bucket = google_storage_bucket.bucket.name
  source = data.archive_file.function_got_archive.output_path # Add path to the zipped function source code
  depends_on = [
    google_storage_bucket.bucket,
    # null_resource.build
  ]
}

resource "google_cloudfunctions2_function" "function" {
  name        = var.function_name
  location    = "us-central1"
  description = "a new function"

  build_config {
    runtime     = "go120"
    entry_point = "ConnectFirestore" # Set the entry point 
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.object.name
      }
    }
  }

  service_config {
    max_instance_count    = 1
    available_memory      = "256M"
    timeout_seconds       = 60
    service_account_email = var.service_account_email
  }

}
