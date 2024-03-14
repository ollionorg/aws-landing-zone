terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    awsutils = {
      source  = "cloudposse/awsutils"
      version = ">= 0.1.0"
    }
  }
}