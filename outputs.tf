output "vpc_network" {
  description = "VPC Network name"
  value       = module.vpc.network_name
}

output "compute_external_ip" {
  description = "External IP of compute instances"
  value       = module.compute.external_ip
}

output "cloud_sql_connection_name" {
  description = "Cloud SQL connection name"
  value       = module.cloud_sql.connection_name
}

output "storage_bucket_url" {
  description = "Static website URL"
  value       = module.storage.website_url
}

output "api_function_url" {
  description = "Cloud Function endpoint URL"
  value       = module.api_function.function_url
}

output "project_id" {
  description = "GCP Project ID"
  value       = var.project_id
}

output "environment" {
  description = "Environment"
  value       = var.environment
}