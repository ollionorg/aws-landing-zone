########################################
# General Vars
########################################

variable "bucket_suffix" {
  default     = "awsconfig"
  description = "Suffix to append to S3 bucket name"
  type        = string
}

variable "delivery_channel_name" {
  default     = "awsconfig-s3"
  description = "Name of the delivery channel"
  type        = string
}

variable "enabled_global_logging_regions" {
  description = "Regions to enable global logging in"
  type        = list(string)

  default = [
    "us-east-1"
  ]
}

variable "enabled_regions" {
  description = "Regions to enable module in"
  type        = list(string)

  default = [
    "us-east-1",
    "us-east-2",
    "us-west-1",
    "us-west-2",
    "ca-central-1",
    "eu-central-1",
    "eu-west-1",
    "eu-west-2",
    "eu-west-3",
    "eu-north-1",
    "ap-northeast-1",
    "ap-northeast-2",
    "ap-northeast-3",
    "ap-southeast-1",
    "ap-southeast-2",
    "ap-south-1",
    "sa-east-1"
  ]
}


variable "logging_bucket" {
  default     = null
  description = "Optional target for S3 access logging"
  type        = string
}

variable "logging_prefix" {
  default     = null
  description = "Optional target prefix for S3 access logging (only used if `s3_access_logging_bucket` is set)"
  type        = string
}

variable "recorder_name" {
  default     = "awsconfig"
  description = "Name of the config recorder"
  type        = string
}

variable "snapshot_delivery_frequency" {
  default     = "Six_Hours"
  description = "Deliery frequency: One_Hour, Three_Hours, Six_Hours, Twelve_Hours, TwentyFour_Hours"
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to add to resources that support it"
  type        = map(string)
}

variable "assumed_role" {
  default = null
}

variable "disable_sns" {
  default = false
}
