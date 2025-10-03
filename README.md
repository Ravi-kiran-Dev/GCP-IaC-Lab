# GCP Multi-Tier Terraform Infrastructure

This repository contains a modular Terraform configuration for deploying a multi-tier application on Google Cloud Platform.

## Architecture

- **Frontend**: Static website hosted on Cloud Storage
- **API Layer**: Cloud Functions
- **Application Layer**: Managed Instance Group with Compute Engine
- **Database**: Cloud SQL (PostgreSQL)
- **Network**: Custom VPC with firewall rules
- **Monitoring**: Cloud Logging and Monitoring

## Features

- ✅ Free tier friendly (uses f1-micro instances and db-f1-micro)
- ✅ Modular Terraform code
- ✅ Multi-environment support
- ✅ Auto-scaling compute instances
- ✅ Load balancing
- ✅ Monitoring and logging
- ✅ Infrastructure as Code

## Prerequisites

1. Google Cloud Project with billing enabled
2. Terraform >= 1.0
3. gcloud CLI installed and authenticated

## Quick Start

```bash
# Initialize Terraform
terraform init

# Plan the deployment
terraform plan -var-file=environments/dev/terraform.tfvars

# Apply the configuration
terraform apply -var-file=environments/dev/terraform.tfvars

```
## Clean Up

```bash
terraform destroy -var-file=environments/dev/terraform.tfvars
```


## Usage Instructions

1. **Clone the repository**
2. **Set up your GCP project** with billing enabled
3. **Update the terraform.tfvars** files with your project details
4. **Run the setup script**: `./scripts/setup.sh`
5. **Deploy**: `./scripts/deploy.sh dev`
6. **View outputs** to access your infrastructure

This setup is optimized for GCP's free tier and provides a comprehensive portfolio showcase of modern cloud infrastructure patterns including networking, compute, storage, databases, serverless functions, and monitoring.