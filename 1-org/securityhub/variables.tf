# variable "sechub_delegated_admin_acc_id" {
#   description = "The account id of the delegated admin."
# }

variable "target_regions" {
  description = "A list of regions to set up with this module."
  default     = "ap-south-1,us-east-1"
}

variable "securityhub_enabled" {
  description = "Boolean whether the securityhub-baseline module is enabled or disabled"
  type        = bool
  default     = false
}

variable "aggr_enable_region" {
  description = "Boolean whether to enable finding aggregator for every region"
  default     = "us-east-1"
}

variable "enable_cis_standard_v_1_2_0" {
  description = "Boolean whether CIS standard is enabled."
  type        = bool
  default     = false
}

variable "enable_cis_standard_v_1_4_0" {
  description = "Boolean whether CIS standard is enabled."
  type        = bool
  default     = false
}

variable "enable_pci_dss_standard" {
  description = "Boolean whether PCI DSS standard is enabled."
  type        = bool
  default     = false
}

variable "enable_aws_foundations_security" {
  description = "Boolean whether AWS Foundations standard is enabled."
  type        = bool
  default     = false
}