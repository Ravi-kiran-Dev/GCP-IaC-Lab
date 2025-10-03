variable "project_id" {
  type        = string
}

variable "region" {
  type        = string
}

variable "environment" {
  type        = string
}

variable "tier" {
  type        = string
  default     = "db-f1-micro"
}