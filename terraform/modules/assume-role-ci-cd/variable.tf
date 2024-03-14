variable "region" {
  type        = string
  default     = "us-east-1"
  description = "region"
}
variable "account_id" {
  type        = string
  description = "account id in which you want to create a role."
}

variable "main_account" {
  type        = string
  description = "account which can assume to another accounts."
}
