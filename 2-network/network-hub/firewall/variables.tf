variable "log_destination_type" {
  type        = string
  default     = "S3"
  description = "The location to send logs to. Valid values: S3, CloudWatchLogs, KinesisDataFirehose. Defaults to CloudWatchLogs."
}

variable "deletion_protection" {
  type        = string
  description = "(Optional) A boolean flag indicating whether it is possible to change the associated subnet(s)"
  default     = false
}