variable "macie_delegated_admin_acc_id" {
  description = "The account id of the delegated admin."
}

variable "macie_my_org" {
  description = "The AWS Organization with all the accounts"
}

variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  default     = false
}

variable "autoenablemode" {
  type        = string
  description = "Auto enable option to enable macie automatically for new accounts"
  default     = "yes"
}