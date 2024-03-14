variable "delegated_admin_acc_id" {
  description = "The account id of the delegated admin account."
}

variable "management_id" {
  description = "The account id of the management account."
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
  }
}

variable "default_region" {
  description = "Default region of operation"
}

variable "role_to_assume_for_role_creation" {
  description = "Terraform will assume this IAM role to create the infra in this module"
}
