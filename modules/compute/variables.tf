variable "project_id" {
  type        = string
}

variable "region" {
  type        = string
}

variable "zone" {
  type        = string
}

variable "environment" {
  type        = string
}

variable "vpc_network" {
  type        = string
}

variable "subnet" {
  type        = string
}

variable "cloud_sql_proxy" {
  type        = string
}

variable "instance_count" {
  type        = number
  default     = 1
}