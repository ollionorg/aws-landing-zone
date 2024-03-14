variable "name" {
  description = "(Required) A name to identify the domain list."
  type        = string
}

variable "domains" {
  description = "(Optional) A list of domains for the firewall domain list."
  type        = list(string)
  default     = []
  nullable    = false

  validation {
    condition = alltrue([
      for domain in var.domains :
      substr(domain, -1, 1) == "."
    ])
    error_message = "Each domain should have a dot at the end by following the definition of FQDN(Fully Qualified Domain Name)."
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
