package rules.tf_aws_waf_wafv2_description

import data.fugue

__rego__metadoc__ := {
  "custom": {
    "controls": {
			"COBIT_DETAILS": [
	          "DSS01.01.5"
	        ],
	        "COBIT_IMPLEMENTATION": [
	          "DSS02.02.1"
	        ],
    },
    "severity": "Low"
  },
  "description": "Provide WAF Rule Descriptions (i.e actual intended use case of the Rule or a small verbiage around the same) for WAF",
  "id": "FR35",
  "title": "WAF Rule should have a description"
}

has_description {
	count([algorithm |
		algorithm = input.description
	]) >= 1
}

resource_type := "aws_wafv2_web_acl"

default allow = false

allow {
  has_description
  input.description != ""
}