locals {

  lz_config = yamldecode(file("../../../lzconfig.yaml"))
  # name   = "sns-${basename(path.cwd)}"
  name = "sns-shared-services"
  #  shared_services_account_id = [for a in data.terraform_remote_state.remote.outputs.accounts : a.id if a.name == local.lz_config.org.shared_service.shared_services_account_name][0]
  shared_services_account_id = data.terraform_remote_state.remote.outputs.accounts_id_map.shared_services
  tags = {
    Name       = local.name
    Managed_By = "terraform"
  }
}

################################################################################
# SNS Module
################################################################################

module "default_sns" {
  source = "../../../terraform/modules/sns"

  name                        = "${local.name}-default"
  create_topic_policy         = true
  enable_default_topic_policy = true
  # topic_policy_statements = {
  #   sub = {
  #     actions = [
  #       "sns:Subscribe",
  #       "sns:Receive",
  #     ]

  #     principals = [{
  #       type        = "AWS"
  #       identifiers = ["arn:aws:iam::091443282288:root"]
  #     }]

  #     conditions = [{
  #       test     = "StringLike"
  #       variable = "sns:Endpoint"
  #       values   = [module.sqs.queue_arn]
  #     }]
  #   }
  # }

  # subscriptions = {
  #   sqs = {
  #     protocol = "lambda"
  #     endpoint = "arn:aws:lambda:us-east-1:091443282288:function:test-function"
  #   }
  # }

  tags = local.tags
}