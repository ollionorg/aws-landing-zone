# provider "aws" {
#   region = local.lz_config.global.home_region
# }

# # Also create a new sns topic
# module "with-new-sns-topic" {
#   source               = "../../terraform/modules/sns/sns"
#   email_addresses_list = ["arshad@cldcvr.com"]
#   sns_topic = {
#     topic_name   = "mytest-tf"
#     display_name = "mytest-tf"
#     policy       = null
#     kms_key_id   = "myKmsKeyId"
#   }
#   tags = { "global.env" = "test" }
# }

# # Use an existing topic
# /* module "with-existing-sns-topic" {
#   source               = "../main/sns"
#   email_addresses_list = ["my.test@mail.com", "my.test2@mail.com"]
#   sns_topic_arn        = "mySnsTopicArn"
#   tags                 = { "global.env" = "test" }
# } */


# module "eventbridge_rule" {
#   source = "../../terraform/modules/sns/eventbridge/rule"

#   rule_name = "eventbridge-email"

#   event_pattern = <<EOF
#   {
#     "source": ["aws.securityhub"],
#     "detail": {
#       "findings": {
#         "ProductName": ["Inspector"],
#         "Severity": {
#         "Label": ["HIGH", "CRITICAL"]
#         }
#       }
#     }
#   }
#   EOF
# }


# module "eventtarget" {
#   source = "../../terraform/modules/sns/eventbridge/target"
#   sns_topic_arn =module.with-new-sns-topic.this_sns_topic_arn
#   event_rule =  module.eventbridge_rule.rule_name
# }