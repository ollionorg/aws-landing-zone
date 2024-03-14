variable "vpc_id" {
  description = "(Required) The ID of the VPC which the firewall belongs to."
  type        = string
  nullable    = false
}

variable "fail_open_enabled" {
  description = "(Optional) Determines how Route 53 Resolver handles queries during failures, for example when all traffic that is sent to DNS Firewall fails to receive a reply. By default, fail open is disabled, which means the failure mode is closed. This approach favors security over availability. DNS Firewall blocks queries that it is unable to evaluate properly. If you enable this option, the failure mode is open. This approach favors availability over security. DNS Firewall allows queries to proceed if it is unable to properly evaluate them."
  type        = bool
  default     = false
  nullable    = false
}

variable "rule_groups" {
  description = <<EOF
  (Optional) A list of rule groups associated with the firewall. Each value of `rule_group` block as defined below.
    (Required) `id` - The ID of the firewall rule group.
    (Required) `priority` - The setting that determines the processing order of the rule group among the rule groups that you associate with the specified VPC. DNS Firewall filters VPC traffic starting from the rule group with the lowest numeric priority setting.
    (Optional) `mutation_protection_enabled` - If enabled, this setting disallows modification or removal of the association, to help prevent against accidentally altering DNS firewall protections.
  EOF
  type = list(object({
    id       = string
    priority = number

    mutation_protection_enabled = optional(bool, false)
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for rule_group in var.rule_groups :
      alltrue([
        rule_group.priority > 100,
        rule_group.priority < 9900
      ])
    ])
    error_message = "Not valid parameters for `rule_groups`."
  }
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
