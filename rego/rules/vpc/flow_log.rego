package rules.tf_aws_vpc_flow_log

import data.fugue

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
	"id": "FR18",
	"title": "VPC flow logging should be enabled",
	"description": "VPC flow logging should be enabled. AWS VPC Flow Logs provide visibility into network traffic that traverses the AWS VPC. Users can use the flow logs to detect anomalous traffic or insight during security workflows.",
	"custom": {"severity": "Medium"},
}

resource_type = "MULTIPLE"

# every flow log in the template
flow_logs = fugue.resources("aws_flow_log")

# every VPC in the template
vpcs = fugue.resources("aws_vpc")


# VPC is valid if there is an associated flow log
is_valid_vpc(vpc) {
	flow_logs_id = flow_logs[_]
	flow_logs_id.flow_log_destination_type != null
	flow_logs_id.flow_log_destination_type != ""
}


policy[p] {
	resource = flow_logs[_]
	not is_valid_vpc(resource)
	p = fugue.deny_resource_with_message(resource, sprintf("%v",[resource[0].id]))
}

policy[p] {
	resource = flow_logs[_]
	is_valid_vpc(resource)
	p = fugue.allow_resource(resource)
}
