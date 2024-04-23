resource "google_storage_bucket" "Cloud_function_bucket" {
  name          = "cf-${var.project_id}"
  location      = var.region
  project       = var.project_id
  force_destroy = true
}

resource "google_storage_bucket" "input_bucket" {
  name          = "input-${var.project_id}"
  location      = var.region
  project       = var.project_id
  force_destroy = true
}