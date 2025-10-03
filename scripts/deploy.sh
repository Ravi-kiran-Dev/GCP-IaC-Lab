#!/bin/bash

ENVIRONMENT=${1:-dev}

echo "Deploying to $ENVIRONMENT environment..."

cd environments/$ENVIRONMENT

terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars -auto-approve

echo "Deployment to $ENVIRONMENT complete!"