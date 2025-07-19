variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "usermanagement-cluster"
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "usermanagement-service"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "usermanagement-container"
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 8095
}

variable "desired_count" {
  description = "Desired number of instances of the task definition"
  type        = number
  default     = 1
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "usermanagement"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "usermanagement"  # or whatever your app name is
}