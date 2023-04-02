// CloudSQLのモジュール
resource "google_sql_database_instance" "private" {
  name             = var.name
  database_version = var.database_version
  region           = var.region

  settings {
    tier = var.tier

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network
    }
  }
}

// sql database
resource "google_sql_database" "default" {
  name      = "${var.name}-db"
  instance  = google_sql_database_instance.private.name
  charset   = "utf8mb4"
  collation = "utf8mb4_bin"
}

// sql user
resource "google_sql_user" "default" {
  name     = "${var.name}-user"
  instance = google_sql_database_instance.private.name
  host     = "%" // 任意のホストからの接続を許可
  password = var.password
}
