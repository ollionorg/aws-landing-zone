variable "tags" {
  description = "The tags for the resources"
  type        = map(any)
  default     = {}
}

variable "description" {
  description = "Description for the resources"
  default     = ""
  type        = string
}

variable "fivetuple_stateful_rule_group" {
  description = "Config for 5-tuple type stateful rule group"
  default     = []
  type        = any
}

variable "domain_stateful_rule_group" {
  description = "Config for domain type stateful rule group"
  default     = []
  type        = any
}

variable "suricata_stateful_rule_group" {
  description = "Config for Suricata type stateful rule group"
  default     = []
  type        = any
}

variable "stateless_rule_group" {
  description = "Config for stateless rule group"
  type        = any
  default     = []
}

variable "firewall_name" {
  description = "firewall name"
  type        = string
  default     = "example"
}

variable "subnet_mapping" {
  description = "Subnet ids mapping to have individual firewall endpoint"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "stateless_default_actions" {
  description = "Default stateless Action"
  type        = string
  default     = "forward_to_sfe"
}

variable "stateless_fragment_default_actions" {
  description = "Default Stateless action for fragmented packets"
  type        = string
  default     = "forward_to_sfe"
}

variable "firewall_policy_change_protection" {
  type        = string
  description = "(Option) A boolean flag indicating whether it is possible to change the associated firewall policy"
  default     = false
}

variable "subnet_change_protection" {
  type        = string
  description = "(Optional) A boolean flag indicating whether it is possible to delete the firewall. Defaults to false"
  default     = false
}

variable "delete_protection" {
  type        = string
  description = "(Optional) A boolean flag indicating whether it is possible to change the associated subnet(s)"
  default     = false
}

variable "logging_config" {
  description = "logging config for cloudwatch logs created for network firewall"
  type        = map(any)
  default = {
    flow  = {},
    alert = {}
  }
}

variable "logging_group_prefix" {
  type        = string
  default     = "/aws/network-firewall"
  description = "Logging group prefix"
}

variable "aws_managed_rule_group" {
  description = "List of AWS managed rule group arn"
  type        = list(any)
  default     = []
}

variable "log_destination_type" {
  type        = string
  default     = "CloudWatchLogs"
  description = "The location to send logs to. Valid values: S3, CloudWatchLogs, KinesisDataFirehose. Defaults to CloudWatchLogs."
}

variable "log_destination_s3_bucket" {
  type        = string
  default     = ""
  description = "Log Bucket Name"
}

variable "log_destination_s3_prefix" {
  type        = string
  default     = "firewall-logs"
  description = "s3 prefix. Defaults to firewall-logs."
}

variable "kinesis_firehose_delivery_stream" {
  type        = string
  default     = ""
  description = "Delivery Stream Name , if log_destination_type is KinesisDataFirehose."
}


