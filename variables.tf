variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "project_name" {
  description = "GCP Project Name"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "instance_count" {
  description = "Number of compute instances"
  type        = number
  default     = 1
}

variable "cloud_sql_tier" {
  description = "Cloud SQL tier (free tier eligible)"
  type        = string
  default     = "db-f1-micro"
}

variable "enable_api_services" {
  description = "Enable required APIs"
  type        = bool
  default     = true
}