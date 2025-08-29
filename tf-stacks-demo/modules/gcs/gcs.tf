resource "google_storage_bucket" "bucket" {
  location = var.location
  name     = var.name
}