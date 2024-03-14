package rules.tf_aws_lb_elb_logging_enabled

import data.fugue

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	            "DSS01.03.4"
	        ],
	        "COBIT_IMPLEMENTATION": [
	           "DSS05.07.5"
	        ],
	        "COBIT_DEFINITION": [
	            "DSS01.03.4"
	        ],
	        },
		"severity": "Medium",
	},
	"description": "Checks if the Application Load Balancer and the Classic Load Balancer have logging enabled.",
	"id": "FR25",
	"title": "Ensure ALB logging enabled",
}

resource_type := "aws_lb"

default allow = false

allow {
	is_boolean(input.access_logs[_].enabled)
	input.access_logs[_].enabled != false
}