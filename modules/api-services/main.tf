variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

resource "google_project_service" "required_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "container.googleapis.com",
    "sqladmin.googleapis.com",
    "storage.googleapis.com",
    "cloudfunctions.googleapis.com",
    "vpcaccess.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "cloudtrace.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbuild.googleapis.com"
  ])
  
  service = each.value
  project = var.project_id
  disable_on_destroy = false
  
  timeouts {
    create = "30m"
    update = "40m"
  }
}

output "enabled_apis" {
  value = [for api in google_project_service.required_apis : api.service]
}