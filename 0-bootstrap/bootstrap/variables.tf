variable "lz-cicd-scp" {
  default     = []
  description = "LZCICD account scp policies"
}

variable "scp" {
  type = list(object({
    name        = string
    policy_file = string
  }))
  default     = []
  description = "list of policies which you want to create"
}