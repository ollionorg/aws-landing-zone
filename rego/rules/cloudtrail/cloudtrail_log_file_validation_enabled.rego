package rules.cloudtrail_log_file_validation_enabled

import data.fugue

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	          "DSS05.06.1"
	        ],
	        "COBIT_IMPLEMENTATION": [
	          "APO07.06.8"
	        ],
	        "COBIT_DEFINITION": [
	          "DSS05.04.5"
	        ],
         },
	    "severity": "High",
	},
	"id": "FR12",
	"title": "CloudTrail log file validation should be enabled",
	"description": "CloudTrail log file validation should be enabled. It is recommended that file validation be enabled on all CloudTrail logs because it provides additional integrity checking of the log data.",
}

resource_type := "aws_cloudtrail"

default allow = false

allow {
	input.enable_log_file_validation == true
}
