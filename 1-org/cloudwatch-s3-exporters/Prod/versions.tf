terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.45.0"
    }
  }
  backend "s3" {

    key = "1-org/cloudwatch-logs-exporter/Prod/terraform.tfstate"
  }
}
