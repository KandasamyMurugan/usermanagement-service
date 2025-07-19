# Add this to your existing Terraform configuration

# RDS Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.cluster_name}-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "${var.cluster_name}-db-subnet-group"
  }
}

# RDS Security Group
resource "aws_security_group" "rds" {
  name_prefix = "${var.cluster_name}-rds"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_tasks.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-rds-sg"
  }
}

# RDS Instance
resource "aws_db_instance" "main" {
  identifier             = "${var.cluster_name}-mysql"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  max_allocated_storage  = 100
  storage_type           = "gp2"
  storage_encrypted      = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"

  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    Name = "${var.cluster_name}-mysql"
  }
}

# Add variables for RDS
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "usermanagement"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "dbadmin"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  default     = "changeme123!" # Change this to a secure password
}

# Update your ECS task definition to include database environment variables
# Replace the existing aws_ecs_task_definition resource with this updated version:

resource "aws_ecs_task_definition" "app" {
  family                   = var.service_name
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = "${var.ecr_repository_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.app.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }

      environment = [
        {
          name  = "SPRING_PROFILES_ACTIVE"
          value = "prod"
        },
        {
          name  = "AWS_RDS_HOSTNAME"
          value = aws_db_instance.main.endpoint
        },
        {
          name  = "AWS_RDS_PORT"
          value = "3306"
        },
        {
          name  = "AWS_RDS_DB_NAME"
          value = var.db_name
        },
        {
          name  = "AWS_RDS_USERNAME"
          value = var.db_username
        },
        {
          name  = "AWS_RDS_PASSWORD"
          value = var.db_password
        }
      ]
    }
  ])

  tags = {
    Name = "${var.service_name}-task-definition"
  }
}

# Add RDS outputs
output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.main.endpoint
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.main.port
}
