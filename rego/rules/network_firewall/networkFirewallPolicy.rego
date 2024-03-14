package rules.tf_aws_s3_network_firewall_rule_group

import data.fugue
import future.keywords.in

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	            "DSS05.04.7"
	        ],
	        },
		"severity": "Medium",
	},
	"description": " Network Firewall has Logging enabled, by default. The rule is NON_COMPLIANT if the Logging is not enabled.",
	"id": "FR18",
	"title": "Network Firewall Logging should be enabled",
}

resource_type = "MULTIPLE"

netfw_resource_policies = fugue.resources("aws_networkfirewall_resource_policy")

policy[p] {
  rp = netfw_resource_policies[_]
  rp.resource_arn != ""
  p = fugue.allow_resource(rp)
}

policy[p] {
  rp = netfw_resource_policies[_]
  rp.resource_arn == ""
  p = fugue.deny_resource(rp)
}