variable "ou_name" {
  type        = string
  description = "Organization Unit Name"
}
# variable ou_accounts {
#   type        = any
#   description = "accounts to create in this ou"
# }
variable "parent_id" {
  type        = string
  description = "Organization ID"
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
