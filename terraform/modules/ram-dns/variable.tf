variable "resource_share_name" {
  type        = string
  default     = "env-resolver-rule"
  description = "Resource share name for resolver"
}

variable "accounts_id" {
  type        = list(string)
  description = "Account's ID in which resolver will be shared."
}

variable "resolver_rule_arn" {
  type        = string
  description = "Resolver Rule arn."
}
