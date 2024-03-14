# variable "delegated_admin_acc_id" {
#   description = "The account id of the management account."
# }

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
  }
}

# variable "default_region" {
#   description = "Default region of operation"
# }

# variable "role_to_assume_for_role_creation" {
#   description = "Terraform will assume this IAM role to create the infra in this module"
# }

# variable "logging_acc_id" {
#   description = "The account id of the management account."
# }

variable "assume_role_name" {
  description = "The role to assume in the delegated admin account."
  default     = "OrganizationAccountAccessRole"
  #  default     = "GuardDutyTerraformOrgRole"
}

# variable "guardduty_accesslog_bucket_region" {
#   description = "Default region to create the bucket"
# }

# variable "s3_accesslog_bucket_name" {
#   type        = string
#   description = "Bucket to store access logs for GD bucket"
#   default     = "s3-gdaccesslogs"
# }



# variable "guardduty_findings_bucket_region" {
#   description = "Default region to create the bucket and key"
# }

variable "security_acc_kms_key_alias" {
  description = "Alias of the KMS key in security account, to be used for encrypting logs at rest in s3 bucket"
  default     = "ST-gd-kms"
}

variable "logging_acc_s3_bucket_name" {
  description = "Name of S3 bucket to store logs in the logging account"
  default     = "log-gd-bucket"
}

variable "lifecycle_policy_days" {
  description = "Specifies the number of days after which items are moved to Glacier."
  default     = 365
}

# variable "target_regions" {
#   description = "A list of regions to set up with this module."
# }


# variable "finding_publishing_frequency" {
#   description = "Specifies the frequency of notifications sent for subsequent finding occurrences."
# }



variable "security_logs_account_name" {
  type        = string
  default     = "Security Logs"
  description = "Account for Security logs purpose"
}

variable "security_tools_account_name" {
  type        = string
  default     = "Security Tools"
  description = "Account for Security tools purpose"
}

############### KMS KEY MODULE ###################
variable "deletion_window_in_days" {
  description = "The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between `7` and `30`, inclusive. If you do not specify a value, it defaults to `30`"
  type        = number
  default     = 7
}

variable "description" {
  description = "The description of the key as viewed in AWS console"
  type        = string
  default     = "Shared Key for specific organization accounts"
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled. Defaults to `true`"
  type        = bool
  default     = true
}

variable "key_usage" {
  description = "Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`. Defaults to `ENCRYPT_DECRYPT`"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "multi_region" {
  description = "Indicates whether the KMS key is a multi-Region (`true`) or regional (`false`) key. Defaults to `false`"
  type        = bool
  default     = false
}

variable "object_lock_enabled" {
  description = "Whether S3 bucket should have an Object Lock configuration enabled."
  type        = bool
  default     = true
}

variable "object_lock_configuration" {
  description = "Map containing S3 object locking configuration."
  type        = any
  default = {
    rule = {
      default_retention = {
        mode = "COMPLIANCE"
        days = 1
      }
    }
  }
}