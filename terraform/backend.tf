terraform {
  backend "s3" {
    bucket  = "cop-assessment-backend"
    key     = "ecs/usermanagementservice/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}