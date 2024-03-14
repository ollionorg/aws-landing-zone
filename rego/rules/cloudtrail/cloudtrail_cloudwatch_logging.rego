package rules.tf_aws_cloudtrail_cloudwatch

import data.fugue


__rego__metadoc__ := {
  "custom": {
		"controls": {
			  "COBIT_DETAILS": [
	         "DSS01.03.1"
	      ],
	      "COBIT_IMPLEMENTATION": [
	         "MEA02.04.3"
	      ],
	      "COBIT_DEFINITION": [
	         "DSS01.03.4"
	      ],
    },
    "severity": "Medium"
  },
  "description": "CloudTrail trails should have CloudWatch log integration enabled. It is recommended that users configure CloudTrail to send log events to CloudWatch Logs. Users can then create CloudWatch Logs metric filters to search for specific terms such as a user or resource, or create CloudWatch alarms to trigger based on thresholds or anomalous activity.\r\n\r\nNote: CIS recognizes that there are alternative logging solutions instead of CloudWatch Logs. The intent of this recommendation is to capture, monitor, and appropriately alarm on an AWS account.",
  "id": "FR10",
  "title": "CloudTrail trails should have CloudWatch log integration enabled"
}

cloudtrails = fugue.resources("aws_cloudtrail")

has_log_integration(ct) {
  ct.cloud_watch_logs_group_arn != ""
  ct.cloud_watch_logs_role_arn != ""

}

resource_type := "MULTIPLE"

policy[j] {
  ct = cloudtrails[_]
  has_log_integration(ct)
  j = fugue.allow_resource(ct)
} {
  ct = cloudtrails[_]
  not has_log_integration(ct)
  j = fugue.deny_resource(ct)
}