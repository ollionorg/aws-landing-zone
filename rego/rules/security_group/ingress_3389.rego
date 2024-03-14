package rules.tf_aws_security_groups_ingress_3389

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
  "description": "VPC security group rules should not permit ingress from '0.0.0.0/0' to port 3389 (Remote Desktop Protocol). Removing unfettered connectivity to remote console services, such as Remote Desktop Protocol, reduces a server's exposure to risk.",
  "id": "FR50,FR51",
  "title": "VPC security group rules should not permit ingress from '0.0.0.0/0' to port 3389 (Remote Desktop Protocol)"
}

security_groups = fugue.resources("aws_security_group")

resource_type := "MULTIPLE"

policy[j] {
  sg = security_groups[_]
  library.security_group_ingress_zero_cidr_to_port(sg, 3389)
  j = fugue.deny_resource(sg)
} {
  sg = security_groups[_]
  not library.security_group_ingress_zero_cidr_to_port(sg, 3389)
  j = fugue.allow_resource(sg)
}