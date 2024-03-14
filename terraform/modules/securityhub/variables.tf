variable "sechub_delegated_admin_acc_id" {
  description = "The account id of the delegated admin."
}

variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  default     = false
}

####
variable "aggregate_findings" {
  description = "Boolean whether to enable finding aggregator for every region"
  type        = bool
  default     = false
}

variable "agg_enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  type        = bool
  default     = false
}

variable "enable_cis_standard_v_1_2_0" {
  description = "Boolean whether CIS standard is enabled."
  type        = bool
  #  default     = false
}

variable "enable_cis_standard_v_1_4_0" {
  description = "Boolean whether CIS standard is enabled."
  type        = bool
  #  default     = false
}

variable "enable_pci_dss_standard" {
  description = "Boolean whether PCI DSS standard is enabled."
  type        = bool
  #  default     = false
}

variable "enable_aws_foundations_security" {
  description = "Boolean whether AWS Foundations standard is enabled."
  type        = bool
  #  default     = false
}

variable "enable_nist_standard" {
  description = "Boolean whether NIST SP 800-53 Rev. 5 standard is enabled."
  type        = bool
  #  default     = false
}


variable "sechub_my_org" {
  description = "The AWS Organization with all the accounts"
}

