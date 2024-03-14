terraform {
  required_providers {
    awsutils = {
      source  = "cloudposse/awsutils"
      version = ">= 0.18.0"
    }
  }
  backend "s3" {
    key = "1-org/shared-services/ses/terraform.tfstate"
  }
}