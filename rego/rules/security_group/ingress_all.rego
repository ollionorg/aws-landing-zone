package rules.tf_aws_security_groups_ingress_all

import data.aws.security_groups.library
import data.fugue


__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	          "DSS05.02.6",
            "DSS05.03.5"
	        ],
	        "COBIT_IMPLEMENTATION": [
	          "DSS05.02.6",
            "DSS05.03.5"
	        ],
	        "COBIT_DEFINITION": [
	          "DSS05.02.2",
            "DSS05.02.3"
	        ],
    },
		"severity": "High",
	},
  "id": "FR50,FR51",
  "description": "VPC security group inbound rules should not permit ingress from '0.0.0.0/0' to all ports and protocols. Security groups provide stateful filtering of ingress/egress network traffic to AWS resources. AWS recommends that no security group allows unrestricted ingress access from 0.0.0.0/0 to all ports. Removing unfettered connectivity to remote console services reduces a server's exposure to risk.",
  "title": "VPC security group inbound rules should not permit ingress from '0.0.0.0/0' to all ports and protocols"
}

security_groups = fugue.resources("aws_security_group")

invalid_security_group(sg) {
  ingress = sg.ingress[_]
  library.rule_all_ports(ingress)
  library.rule_zero_cidr(ingress)
}

resource_type := "MULTIPLE"

policy[j] {
  sg = security_groups[_]
  invalid_security_group(sg)
  j = fugue.deny_resource(sg)
} {
  sg = security_groups[_]
  not invalid_security_group(sg)
  j = fugue.allow_resource(sg)
}