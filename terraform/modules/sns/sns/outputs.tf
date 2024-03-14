output "this_sns_topic_arn" {
  value       = concat([local.sns_topic_arn], [""])[0]
  description = "SNS topic arn"
}