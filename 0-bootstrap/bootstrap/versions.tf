terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.45.0"
    }
  }
  backend "s3" {
    key = "0-bootstrap/lz-ci-cd-bootstrap/terraform.tfstate"
  }
}