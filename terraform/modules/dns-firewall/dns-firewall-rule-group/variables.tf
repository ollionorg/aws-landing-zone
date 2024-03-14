variable "name" {
  description = "(Required) Friendly name of the firewall rule group."
  type        = string
}

variable "description" {
  description = "(Optional) The description of the firewall rule group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "rules" {
  description = <<EOF
  (Optional) The rules that you define for the firewall rule group determine the filtering behavior. Each rule consists of a priority, a domain list, and action. Each item of `rules` block as defined below.
    (Required) `priority` - Determine the processing order of the rule in the rule group. DNS Firewall processes the rules in a rule group by order of priority, starting from the lowest priority.
    (Required) `name` - A name that lets you identify the rule.
    (Optional) `description` - The description of the rule.
    (Required) `domain_list` - The ID of the domain list that you want to use in the rule.
    (Required) `action` - The action that DNS Firewall should take on a DNS query when it matches one of the domains in the rule's domain list. Valid values are `ALLOW`, `BLOCK`, `ALERT`.
    (Optional) `action_parameters` - The configuration block for the parameters of the rule action. Only required with `BLOCK` action. `action_parameters` block as defined below.
      (Required) `response` - The way that you want DNS Firewall to block the request. Valid values are `NODATA`, `NXDOMAIN`, `OVERRIDE`. `NODATA` indicates that this query was successful, but there is no response available for the query. `NXDOMAIN` indicates that the domain name that's in the query doesn't exist. `OVERRIDE` provides a custom override response to the query.
      (Optional) `override` - The configuration for a custom override response to the query. Only required with `OVERRIDE` block response.
        (Required) `type` - The DNS record's type. This determines the format of the record value that you provided in BlockOverrideDomain. Value values are `CNAME`.
        (Required) `value` - The custom DNS record to send back in response to the query.
        (Required) `ttl` - The recommended amount of time, in seconds, for the DNS resolver or web browser to cache the provided override record. Minimum value of `0`. Maximum value of `604800`.
  EOF
  type = list(object({
    priority    = number
    name        = string
    description = optional(string, "Managed by Terraform.")
    domain_list = string

    action = string
    action_parameters = optional(object({
      response = optional(string, null)
      override = optional(object({
        type  = string
        value = string
        ttl   = number
      }), null)
    }), null)
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for rule in var.rules :
      alltrue([
        rule.priority >= 0,
        rule.priority <= 10000,
      ])
    ])
    error_message = "Valid value for `rule.priority` from `rules` is between 0 and 10000."
  }

  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["ALLOW", "BLOCK", "ALERT"], rule.action)
    ])
    error_message = "Valid values for `rule.action` from `rules` are `ALLOW`, `BLOCK`, `ALERT`."
  }

  validation {
    condition = alltrue([
      for rule in var.rules :
      contains(["NODATA", "NXDOMAIN", "OVERRIDE"], rule.action_parameters.response)
      if rule.action == "BLOCK"
    ])
    error_message = "Valid values for `rule.action_parameters.response` from `rules` are `NODATA`, `NXDOMAIN`, `OVERRIDE`."
  }

  validation {
    condition = alltrue([
      for rule in var.rules :
      alltrue([
        for key in ["type", "value", "ttl"] :
        contains(try(keys(rule.action_parameters.override), []), key)
      ])
      if rule.action_parameters.response == "OVERRIDE"
    ])
    error_message = "`rule.action_parameters.override` from `rules` should have `type`, `value`, `ttl`."
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


###################################################
# Resource Sharing by RAM (Resource Access Manager)
###################################################

variable "shares" {
  description = "(Optional) A list of resource shares via RAM (Resource Access Manager)."
  type = list(object({
    name = optional(string)

    permissions = optional(set(string), ["AWSRAMDefaultPermissionResolverFirewallRuleGroup"])

    external_principals_allowed = optional(bool, false)
    principals                  = optional(set(string), [])

    tags = optional(map(string), {})
  }))
  default  = []
  nullable = false
}
