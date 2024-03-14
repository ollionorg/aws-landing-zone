terraform {
  required_version = ">= 0.13.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
    }
  }
  backend "s3" {
    key = "1-org/kms/terraform.tfstate"
  }
}