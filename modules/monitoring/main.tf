resource "google_project_service" "monitoring" {
  for_each = toset([
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "cloudtrace.googleapis.com",
    "vpcaccess.googleapis.com",  
    "cloudfunctions.googleapis.com",  
    "compute.googleapis.com",  
    "sqladmin.googleapis.com",  
    "storage.googleapis.com"   
  ])
  
  service = each.value
  project = var.project_id
  disable_on_destroy = false
}

resource "google_logging_project_sink" "logging_sink" {
  name        = "${var.environment}-logging-sink"
  project     = var.project_id
  destination = "bigquery.googleapis.com/projects/${var.project_id}/datasets/${var.environment}_logs"
  filter      = "resource.type=\"gce_instance\""

  unique_writer_identity = true
}

resource "google_bigquery_dataset" "logging_dataset" {
  dataset_id    = "${var.environment}_logs"
  project       = var.project_id
  friendly_name = "${var.environment} Logs"
  description   = "Dataset for storing logs from ${var.environment}"
  location      = "US"
}