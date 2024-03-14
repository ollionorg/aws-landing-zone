variable "minimum_length" {
  description = "The minimum length of a password"
  default     = 16
}

variable "require_lowercase" {
  description = "Do we require lowercase characters in the password"
  default     = true
}

variable "require_uppercase" {
  description = "Do we require uppercase characters in the password"
  default     = true
}

variable "require_numbers" {
  description = "Do we require numbers in the password"
  default     = true
}

variable "require_symbols" {
  description = "Do we require symbols in the password"
  default     = true
}

variable "allow_user_change" {
  description = "Do we allow people to change their own password?"
  default     = true
}

variable "hard_expiry" {
  description = "Do we allow people to change passwords that have expired?"
  default     = false
}

variable "maximum_age" {
  description = "The maximum age of a password (in days)"
  default     = 30
}

variable "reuse_history" {
  description = "The number of previous passwords that users are prevented from reusing."
  default     = 24
}

variable "assumed_role" {
  default = null
}


####

variable "support_iam_role_name" {
  description = "The name of the the support role."
  type        = string
  default     = "AWSSupportRole"
}


variable "create_support_role" {
  description = "Define if the support role should be created."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  type        = map(string)
  default = {
  }
}