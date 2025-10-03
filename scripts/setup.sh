#!/bin/bash

# Setup script for GCP multi-tier infrastructure

echo "Setting up GCP Multi-Tier Infrastructure..."

# Enable required APIs
gcloud services enable compute.googleapis.com \
    container.googleapis.com \
    sqladmin.googleapis.com \
    storage.googleapis.com \
    cloudfunctions.googleapis.com \
    vpcaccess.googleapis.com \
    monitoring.googleapis.com \
    logging.googleapis.com \
    cloudtrace.googleapis.com

echo "Setup complete!"