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
  default     = "usermanagementservice"
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
  default     = "072950892534.dkr.ecr.us-east-1.amazonaws.com/usermanagementservice"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 2
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 8080
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}

# RDS Variables
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "usermanagement"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "dbadmin"
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  # Remove default password for security - should be provided via tfvars or environment
}
