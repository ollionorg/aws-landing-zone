variable "org_account_name" {
  type        = string
  description = "Organization Account Name"
}
variable "org_account_email" {
  type        = string
  description = "Email ID for account"
}

# variable close_on_deletion {
#   type        = bool
#   default     = true
#   description = "If true, a deletion event will close the account. Otherwise, it will only remove from the organization."
# }

variable "ous" {
  type        = any
  description = "ous"
}

variable "parent_id" {
  type        = string
  description = "Parent OU/Root's ID"
}

variable "attached_policy" {
  type        = any
  default     = []
  description = "Policies that needs to be attached"
}
variable "policies" {
  type        = any
  description = "Policies available in your organization"
}

# variable tags {
#   type        = map
#   default     = {}
#   description = "tags if required"
# }


