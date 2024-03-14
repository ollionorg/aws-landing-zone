terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.key,
      ]
    }
    awsutils = {
      source  = "cloudposse/awsutils"
      version = ">= 0.1.0"
    }
  }
}

