resource "google_storage_bucket" "default" {
  name     = var.name
  location = "US"
  // オブジェクトがあっても強制削除
  force_destroy = true
  // ストレージクラス
  storage_class = var.storage
}
