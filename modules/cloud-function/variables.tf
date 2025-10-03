terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.78.0"
    }
  }
}

variable "project_id" {
  type        = string
}

variable "region" {
  type        = string
}

variable "environment" {
  type        = string
}

variable "vpc_network" {
  type        = string
}

variable "source_dir" {
  type        = string
}