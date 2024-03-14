package rules.tf_aws_s3_network_firewall_logging_enabled

import data.fugue
import future.keywords.in

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	            "DSS05.01.2"
	        ],
	        "COBIT_IMPLEMENTATION": [
	           "DSS05.07.5"
	        ],
	        "COBIT_DEFINITION": [
	            "BAI07.05.6"
	        ],
	        },
		"severity": "Medium",
	},
	"description": " Network Firewall has Logging enabled, by default. The rule is NON_COMPLIANT if the Logging is not enabled.",
	"id": "FR18",
	"title": "Network Firewall Logging should be enabled",
}


firewalls = fugue.resources("aws_networkfirewall_firewall")

firewall_logging = fugue.resources("aws_networkfirewall_logging_configuration")

firewall_logging_arns = {firewall_arn | firewall_arn = firewall_logging[_].firewall_arn}


resource_type := "MULTIPLE"

policy[j] {
  firewall = firewalls[_]
  print(firewall)
  firewall_logging_arns[firewall.id]
  j = fugue.allow_resource(firewall)
} {
  firewall = firewalls[_]
  print(firewall)
  not firewall_logging_arns[firewall.id]
  j = fugue.deny_resource(firewall)
}