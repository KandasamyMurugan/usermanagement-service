# variables.tf
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

/*variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "cop-cluster"
}*/

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
  description = "Port exposed by the docker image to redirect traffic to"
  type        = number
  default     = 8095
}

variable "desired_count" {
  description = "Number of instances of the task definition to place and keep running"
  type        = number
  default     = 1
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}

# IMPORTANT: This should match your Jenkins IMAGE_NAME
variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "nagendren/usermanagement-microservice"
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
  default     = ""
}

# Database variables
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "usermanagement"
}

variable "AWS_RDS_USERNAME" {
  description = "Database username"
  type        = string
  }

variable "AWS_RDS_PASSWORD" {
  description = "Database password"
  type        = string
  sensitive   = true
}