terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.45.0"
      configuration_aliases = [
        aws,
        aws.bucket_auditlogs,
        aws.shared_service,
      ]
    }
  }
}
