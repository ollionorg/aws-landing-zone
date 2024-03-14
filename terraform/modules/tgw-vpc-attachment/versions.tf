terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.4"
      configuration_aliases = [
        aws.network_hub
      ]
    }
  }
}