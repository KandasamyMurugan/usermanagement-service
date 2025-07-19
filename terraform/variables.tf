variable "cluster_name" {
  description = "COP usermanagement deployment"
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
}

variable "ecr_repo_url" {
  description = "ECR repository URL"
  type        = string
}