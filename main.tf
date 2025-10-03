terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.78.0"
    }
    
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Enable required APIs first
module "api_services" {
  source = "./modules/api-services"
  
  project_id = var.project_id
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  project_id = var.project_id
  region     = var.region
  environment = var.environment

  vpc_name = "${var.project_id}-${var.environment}-iac-lab-vpc"
}

# Cloud Storage for static website
module "storage" {
  source = "./modules/cloud-storage"

  project_id    = var.project_id
  environment   = var.environment
  bucket_name   = "${var.project_id}-${var.environment}-static-site"
  region        = var.region
}

# Cloud SQL (PostgreSQL) - Free tier eligible
module "cloud_sql" {
  source = "./modules/cloud-sql"

  project_id    = var.project_id
  region        = var.region
  environment   = var.environment
  tier          = var.cloud_sql_tier
}

# Compute Engine instances (managed instance group)
module "compute" {
  source = "./modules/compute"

  project_id        = var.project_id
  region            = var.region
  zone              = var.zone
  environment       = var.environment
  vpc_network       = module.vpc.network_name
  subnet            = module.vpc.subnet_name
  cloud_sql_proxy   = module.cloud_sql.connection_name
  instance_count    = var.instance_count
}

# Cloud Function for API endpoint
module "api_function" {
  source = "./modules/cloud-function"

  project_id    = var.project_id
  region        = var.region
  environment   = var.environment
  vpc_network   = module.vpc.network_name
  source_dir    = "${path.module}/functions/api"
}

# Monitoring and logging
module "monitoring" {
  source = "./modules/monitoring"

  project_id    = var.project_id
  environment   = var.environment
  project_name  = var.project_name
}