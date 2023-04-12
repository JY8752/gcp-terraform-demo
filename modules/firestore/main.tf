resource "time_sleep" "wait_60_seconds" {
  create_duration = "60s"
}

resource "google_project_service" "firestore" {
  service = "firestore.googleapis.com"

  # Needed for CI tests for permissions to propagate, should not be needed for actual usage
  depends_on = [time_sleep.wait_60_seconds]
}

resource "google_firestore_database" "database" {
  name                        = var.name
  location_id                 = var.location_id      # eur3 or nam5 ヨーロッパと米国のどちらか
  type                        = var.type             # FIRESTORE_NATIVE or CLOUD_FIRESTORE
  concurrency_mode            = var.concurrency_mode # 同時実行制御 OPTIMISTIC or PESSIMISTIC or OPTIMISTIC_WITH_ENTITY_GROUPS 
  app_engine_integration_mode = var.app_engine_integration_mode
}
