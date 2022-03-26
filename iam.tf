resource "google_secret_manager_secret_iam_binding" "binding" {
  count     = var.secretAccessorMembers != null && length(var.secretAccessorMembers) != 0 ? length(var.secretAccessorMembers) : 0
  project   = google_secret_manager_secret.secret.project
  secret_id = google_secret_manager_secret.secret.secret_id
  role      = "roles/secretmanager.secretAccessor"
  members   = var.secretAccessorMembers
}