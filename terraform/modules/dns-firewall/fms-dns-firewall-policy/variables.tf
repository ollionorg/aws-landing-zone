variable "name" {
  description = "(Required) The friendly name of the AWS Firewall Manager Policy."
  type        = string
}

variable "pre_rule_groups" {
  description = <<EOF
  (Required) A list of rule groups to process first. Each item of `pre_rule_groups` block as defined below.
    (Required) `priority` - The setting that determines the processing order of the rule group among the rule groups that you associate with the specified VPC. DNS Firewall filters VPC traffic starting from the rule group with the lowest numeric priority setting. Valid values for `priority` are between 1 and 99.
    (Required) `rule_group` - The ID of the firewall rule group.
  EOF
  type = list(object({
    priority   = number
    rule_group = string
  }))
  nullable = false

  validation {
    condition     = length(var.pre_rule_groups) > 0
    error_message = "The `pre_rule_groups` should have at least one rule group."
  }

  validation {
    condition = alltrue([
      for rule_group in var.pre_rule_groups :
      rule_group.priority >= 1 && rule_group.priority <= 99
    ])
    error_message = "Valid values for `priority` are between 1 and 99."
  }
}

variable "post_rule_groups" {
  description = <<EOF
  (Optional) A list of rule groups to process last. Each item of `post_rule_groups` block as defined below.
    (Required) `priority` - The setting that determines the processing order of the rule group among the rule groups that you associate with the specified VPC. DNS Firewall filters VPC traffic starting from the rule group with the lowest numeric priority setting. Valid values for `priority` are between 9901 and 10000.
    (Required) `rule_group` - The ID of the firewall rule group.
  EOF
  type = list(object({
    priority   = number
    rule_group = string
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for rule_group in var.post_rule_groups :
      rule_group.priority >= 9901 && rule_group.priority <= 10000
    ])
    error_message = "Valid values for `priority` are between 9901 and 10000."
  }
}

variable "resource_types" {
  description = "(Optional) A list of resource types to protect."
  type        = list(string)
  default     = ["AWS::EC2::VPC"]
  nullable    = false
}

variable "resource_tags_filter" {
  description = <<EOF
  (Optional) A filter configuration to decide protections on resources based on the resource tags. `resourcee_tags_filter` block as defined below.
    (Optional) `type` - Whether to include or exclude resources that contain `tags` from protections by this policy. Valid values are `WHITELIST` and `BLACKLIST`.
    (Optional) `tags` - A map of resource tags to filter resources.
  EOF
  type = object({
    type = optional(string, "WHITELIST")
    tags = optional(map(string), {})
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["WHITELIST", "BLACKLIST"], var.resource_tags_filter.type)
    error_message = "The `resource_tags_filter.type` should be one of `WHITELIST`, `BLACKLIST`."
  }
}

variable "organization_filter" {
  description = <<EOF
  (Optional) A filter configuration to decide protections on resources based on the accounts and organization units. `organization_filter` block as defined below.
    (Optional) `type` - Whether to include or exclude resources that contain `accounts` or `organization_units` from protections by this policy. Valid values are `WHITELIST` and `BLACKLIST`.
    (Optional) `accounts` - A list of AWS Organization member accounts that you want to include or to exclude for this AWS FMS Policy.
    (Optional) `organization_units` - A list of AWS Organization Units that you want to include or to exclude for this AWS FMS Policy.
  EOF
  type = object({
    type               = optional(string, "WHITELIST")
    accounts           = optional(set(string), [])
    organization_units = optional(set(string), [])
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["WHITELIST", "BLACKLIST"], var.organization_filter.type)
    error_message = "The `organization_filter.type` should be one of `WHITELIST`, `BLACKLIST`."
  }
}

variable "auto_remediation_enabled" {
  description = "(Optional) Indicate if the policy should be automatically applied to new resources. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "resource_cleanup_on_leave_enabled" {
  description = "(Optional) Whether Firewall Manager will automatically remove protections from resources that leave the policy scope and clean up resources that Firewall Manager is managing for accounts when those accounts leave policy scope. For example, Firewall Manager will disassociate a Firewall Manager managed web ACL from a protected customer resource when the customer resource leaves policy scope. Defaults to `false`. This option is not available for Shield Advanced or AWS WAF Classic policies."
  type        = bool
  default     = false
  nullable    = false
}

variable "cascade_deletion_enabled" {
  description = <<EOF
  (Optional) Whether to cleanup resources which is managed by the policy on deletion. Defaults to `true`.

  If `true`, the request performs cleanup according to the policy type.

  For AWS WAF and Shield Advanced policies, the cleanup does the following:
  - Deletes rule groups created by AWS Firewall Manager
  - Removes web ACLs from in-scope resources
  - Deletes web ACLs that contain no rules or rule groups

  For security group policies, the cleanup does the following for each security group in the policy:
  - Disassociates the security group from in-scope resources
  - Deletes the security group if it was created through Firewall Manager and if it's no longer associated with any resources through another policy

  After the cleanup, in-scope resources are no longer protected by web ACLs in this policy. Protection of out-of-scope resources remains unchanged.
  EOF
  type        = bool
  default     = true
  nullable    = false
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
