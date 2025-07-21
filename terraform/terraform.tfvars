# Database configuration
AWS_RDS_PASSWORD = "redhat"
db_name = "usermanagement"
AWS_RDS_USERNAME = "root"

# ECS configuration
cluster_name = "usermanagement-cluster"
service_name = "usermanagement-service"
container_name = "usermanagement-container"
container_port = 8095
desired_count = 1

# AWS configuration
aws_region = "us-east-1"