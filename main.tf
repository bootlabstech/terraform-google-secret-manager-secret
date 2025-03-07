resource "google_secret_manager_secret" "secret" {
  secret_id = var.secret_id
  labels    = length(keys(var.labels)) < 0 ? null : var.labels
  project   = var.project

  dynamic "replication" {
    for_each = var.replication_automatic ? [1] : []
    content {
      automatic = false
    }
  }

  dynamic "replication" {
    for_each = !var.replication_automatic && length(var.replication_user_managed_replicas) != 0 ? [1] : []
    content {
      user_managed {
        dynamic "replicas" {
          for_each = var.replication_user_managed_replicas
          content {
            location = replicas.value.location
            customer_managed_encryption {
              kms_key_name = replicas.value.customer_managed_encryption
            }
          }
        }
      }
    }
  }

  depends_on = [
    google_project_service_identity.si
  ]
}

resource "google_secret_manager_secret_version" "secret-version" {
  secret      = google_secret_manager_secret.secret.id
  secret_data = var.secret_data
}

resource "google_project_service_identity" "si" {
  count = !var.replication_automatic && length(var.replication_user_managed_replicas) != 0 ? 1 : 0
  provider = google-beta
  project = var.project
  service = "secretmanager.googleapis.com"
}