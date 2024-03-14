variable "aws_region" {
  default     = "us-east-1"
  description = "AWS Region to deploy to"
}

variable "operationallogs_acc_id" {
  type = string
}


variable "master_acc_id" {
  type = string
}

variable "account_id_bu1_app" {
  type = string
}


variable "source_bucket" {
  type = string
}

variable "destination_bucket" {
  type = string
}

variable "dest_bkt_subdir" {
  type = string
}

variable "datasync_taskname" {
  type = string
}

variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  default     = false
}

variable "bucket_region" {
  # default = "us-east-1"
  description = "AWS Region to deploy to"
}

variable "iam_role_policy_env" {
  # default = "us-east-1"
  description = "Role and Policy name for env"
}

variable "organization_id" {
  type        = string
  default     = ""
  description = "Organization ID if enable_organization_user is true."
}

variable "source_s3_bucket_kms_key" {
  type    = string
  default = ""
}

variable "dest_s3_bucket_kms_key" {
  type    = string
  default = ""
}