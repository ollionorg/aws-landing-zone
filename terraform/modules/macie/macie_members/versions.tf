terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.member_accounts,
      ]
    }
  }
}