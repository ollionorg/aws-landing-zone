# provider "aws" {
#   region  = "us-east-1"
#   assume_role {
#     role_arn = "arn:aws:iam::${var.operationallogs_acc_id}:role/OrganizationAccountAccessRole"
#   }
# }

# provider "aws" {
#   alias = "master"
#   region  = "us-east-1"
#   assume_role {
#     role_arn = "arn:aws:iam::${var.master_acc_id}:role/OrganizationAccountAccessRole"
#   }
# }
