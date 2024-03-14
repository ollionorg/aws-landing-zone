terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.45.0"
    }
  }
  backend "s3" {
    key = "2-network/network-hub/firewall/terraform.tfstate"
  }
}
