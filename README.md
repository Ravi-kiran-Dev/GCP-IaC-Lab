# GCP-IaC-Lab

A comprehensive multi-tier application infrastructure deployed on Google Cloud Platform using Terraform. This project demonstrates Infrastructure as Code principles with modular design, suitable for portfolio showcase and learning purposes.

## 🏗️ Architecture Overview

This multi-tier application consists of:

- **Frontend Layer**: Static website hosted on Cloud Storage
- **API Layer**: Serverless Cloud Functions
- **Application Layer**: Managed Instance Group with Compute Engine (auto-scaling)
- **Database Layer**: Cloud SQL (PostgreSQL)
- **Network Layer**: Custom VPC with firewall rules and load balancing
- **Observability**: Cloud Monitoring and Logging

## ✨ Key Features

- ✅ **Free Tier Friendly**: Optimized for GCP free tier usage (e2-micro instances, db-f1-micro SQL)
- ✅ **Modular Terraform**: Reusable, well-organized modules for each service
- ✅ **Multi-Environment**: Supports dev/prod configurations
- ✅ **Auto-Scaling**: Managed instance groups with health checks
- ✅ **Load Balanced**: Global load balancer for high availability
- ✅ **Secure Networking**: Custom VPC with proper firewall configurations
- ✅ **Observability**: Integrated monitoring and logging setup
- ✅ **Production Ready**: Real-world infrastructure patterns

## 🛠️ Technologies Used

- **Infrastructure as Code**: Terraform (HCL)
- **Cloud Platform**: Google Cloud Platform (GCP)
- **Compute**: Compute Engine, Managed Instance Groups
- **Serverless**: Cloud Functions
- **Database**: Cloud SQL for PostgreSQL
- **Storage**: Cloud Storage (static website hosting)
- **Networking**: VPC, Load Balancer, Firewall Rules
- **Monitoring**: Cloud Monitoring, Cloud Logging

## 📁 Project Structure

```
GCP-IaC-Lab/
├── modules/
│   ├── api-services/          # API service management
│   ├── cloud-function/        # Cloud Functions module
│   ├── cloud-sql/            # Cloud SQL database
│   ├── cloud-storage/        # Static website storage
│   ├── compute/              # Compute Engine & load balancer
│   ├── monitoring/           # Monitoring setup
│   └── vpc/                  # VPC networking
├── functions/
│   └── api/                  # Cloud Function source code
├── environments/
│   ├── dev/                  # Development environment config
│   └── prod/                 # Production environment config
├── scripts/
└── terraform files...
```

## 🚀 Quick Start

### Prerequisites

1. Google Cloud Project with billing enabled
2. Terraform >= 1.0 installed
3. `gcloud` CLI configured and authenticated

### Setup & Deployment

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/GCP-IaC-Lab.git
   cd GCP-IaC-Lab
   ```

2. **Update environment variables:**
   - Edit `environments/dev/terraform.tfvars` with your project details

3. **Initialize and deploy:**
   ```bash
   # Initialize Terraform
   terraform init

   # Plan the deployment
   terraform plan -var-file=environments/dev/terraform.tfvars

   # Apply the infrastructure
   terraform apply -var-file=environments/dev/terraform.tfvars
   ```

4. **Access your deployed resources:**
   - View outputs: `terraform output -var-file=environments/dev/terraform.tfvars`
   - Visit your load balancer IP and static website URL

## 🧪 Testing

After deployment, verify functionality:

- **Web Application**: `http://<load_balancer_ip>`
- **API Endpoint**: `https://<region>-<project_id>.cloudfunctions.net/<function_name>`
- **Static Website**: `https://<bucket_name>.storage.googleapis.com`

## 🔧 Troubleshooting

Common issues and solutions:

- **Startup Script Failures**: Ensure proper line endings in heredoc scripts (Unix-style `\n` not Windows `\r\n`)
- **API Not Enabled**: Check that all required APIs are enabled in your GCP project
- **Resource Conflicts**: Clean up existing resources if applying to a previously used project
- **Permission Issues**: Verify IAM permissions for the Terraform service account

## 🗂️ Outputs

The deployment provides key information through Terraform outputs:

- `compute_external_ip`: External IP of the load balancer
- `api_function_url`: Cloud Function endpoint URL
- `storage_bucket_url`: Static website URL
- `cloud_sql_connection_name`: Connection name for Cloud SQL
- `vpc_network`: VPC network name

## 🧹 Cleanup

To avoid unnecessary charges, destroy the infrastructure when done:

```bash
terraform destroy -var-file=environments/dev/terraform.tfvars
```

## 🤝 Contributing

Contributions are welcome! Feel free to submit issues, fork the repository, and create pull requests for improvements.

## 🌟 Portfolio Highlights

This project demonstrates:
- Advanced Terraform practices (modular, reusable)
- Multi-tier application architecture
- Cloud-native service integration
- Infrastructure troubleshooting skills
- Cost-optimized cloud deployment
- Production-ready configurations