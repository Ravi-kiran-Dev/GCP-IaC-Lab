resource "google_storage_bucket" "function_bucket" {
  name          = "${var.project_id}-${var.environment}-function-bucket"
  location      = var.region
  project       = var.project_id
  storage_class = "STANDARD"
}

resource "google_storage_bucket_object" "function_zip" {
  name   = "function-${var.environment}.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = "${path.module}/../../functions/function.zip"
}

resource "google_cloudfunctions_function" "api_function" {
  name        = "${var.environment}-api-function"
  project     = var.project_id
  region      = var.region

  runtime = "nodejs18"
  entry_point = "http"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.function_zip.name

  trigger_http = true
  https_trigger_security_level = "SECURE_OPTIONAL"

  environment_variables = {
    PROJECT_ID = var.project_id
    ENVIRONMENT = var.environment
  }

  depends_on = [google_storage_bucket_object.function_zip]
}

# Add IAM policy to allow public access
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.api_function.project
  region         = google_cloudfunctions_function.api_function.region
  cloud_function = google_cloudfunctions_function.api_function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}