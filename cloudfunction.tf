resource "google_project_service" "cf" {
  project = var.project_id
  service = "cloudfunctions.googleapis.com"
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [google_project_service.cf]

  create_duration = "30s"
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.root}/src"
  output_path = "${path.module}/function.zip"
}


resource "google_storage_bucket_object" "zip" {
  source       = data.archive_file.source.output_path
  content_type = "application/zip"
  name         = "src-${data.archive_file.source.output_md5}.zip"
  bucket       = google_storage_bucket.Cloud_function_bucket.name
  depends_on = [
    google_storage_bucket.Cloud_function_bucket,
    data.archive_file.source,
    time_sleep.wait_30_seconds
  ]
}

resource "google_cloudfunctions_function" "Cloud_function" {
  name                  = "Cloud-function-trigger-using-terraform"
  description           = "Cloud-function will get trigger once file is uploaded in input-${var.project_id}"
  runtime               = "python39"
  project               = var.project_id
  region                = var.region
  source_archive_bucket = google_storage_bucket.Cloud_function_bucket.name
  source_archive_object = google_storage_bucket_object.zip.name
  entry_point           = "fileUpload"
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = "input-${var.project_id}"
  }
  depends_on = [
    google_storage_bucket.Cloud_function_bucket,
    google_storage_bucket_object.zip,
    time_sleep.wait_30_seconds,
  ]
}