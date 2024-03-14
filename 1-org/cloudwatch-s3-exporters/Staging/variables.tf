#multi-region
# variable "target_regions" {
#   description = "Regions to enable module in"
# }

################## Variables for s3 sync ###############

# variable "source_bucket" {
#     type = string  
# }

# variable "destination_bucket" {
#     type = string  
# }

variable "dest_bkt_subdir" {
  type    = string
  default = "STAGING/"
}

variable "datasync_taskname" {
  type    = string
  default = "S3-DataSync-From-StagingMasterAccount-to-OperationalAccount"
}

# variable "target_regions" {
#   description = "A list of regions to set up with this module."
# }

# variable "bucket_region" {
#   # default = "us-east-1"
#   description = "AWS Region to deploy to"
# }

variable "iam_role_policy_env_name" {
  default     = "STAGING"
  description = "env for which policy and role are created"
}