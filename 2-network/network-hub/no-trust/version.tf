terraform {
  required_version = ">= 1.0.0"
  required_providers {
    awsutils = {
      source  = "cloudposse/awsutils"
      version = ">= 0.18.0"
    }
  }
  backend "s3" {
    key = "2-network/network-hub/no-trust/terraform.tfstate"
  }
}
