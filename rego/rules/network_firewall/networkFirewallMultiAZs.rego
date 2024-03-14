package rules.tf_aws_nfw_multiple_azs
import data.fugue
import future.keywords.in

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	            "DSS01.03.4"
	        ],
	        },
		"severity": "Medium",
	},
	"id": "NFR1",
	"title": "Network Firewall in Multiple AZs",
	"description": "Ensure AWS Network Firewall firewalls are deployed across multiple Availability Zones",
}
resource_type = "MULTIPLE"
firewalls = fugue.resources("aws_networkfirewall_firewall")

policy[j] {
	firewall = firewalls[_]
	firewall.subnet_mapping != []
	count(firewall.subnet_mapping) >= 1
    j = fugue.allow_resource(firewall)
}