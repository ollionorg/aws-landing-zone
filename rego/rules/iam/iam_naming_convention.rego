package rules.iam_naming_convension

import data.fugue
import future.keywords

__rego__metadoc__ := {
	"custom": {
      "controls": {
	  		"COBIT_DETAILS": [
	          "DSS05.05.5"
	        ],
	        "COBIT_IMPLEMENTATION": [
	          "DSS05.05.5"
	        ],
	        "COBIT_DEFINITION": [
	          "DSS06.02.3"
	        ],
      },
	  "severity": "Low"
	},
	"title": "Ensure iam role or policy should follow Approved Naming Conventions",
	"description": "Check iam role or policy should follow Approved Naming Conventions.",
	"id": "FR5"
}

resource_type = "MULTIPLE"

#naming convension allowded , you can pass comma seprated values
role_list = { "Role" }
policy_list = { "Policy" }


roles = fugue.resources("aws_iam_role")
policies  = fugue.resources("aws_iam_policy")

#We have used endswith, you can use as per your requirement - https://www.openpolicyagent.org/docs/latest/policy-reference/#strings
has_valid_role_name(role) {
    endswith(role.name,role_list[_])
}

has_valid_policy_name(pol) {
    endswith(pol.name,policy_list[_])
}

policy[p] {
	role = roles[_]
	has_valid_role_name(role)
	p = fugue.allow_resource(role)
}

policy[p] {
	role = roles[_]
	not has_valid_role_name(role)
	p = fugue.deny_resource_with_message(role, concat("",{"Role name should be end with ", concat(",",role_list)}))
}

policy[p] {
    pol = policies[_]
    has_valid_policy_name(pol)
	p = fugue.allow_resource(pol)
}

policy[p] {
	pol = policies[_]
	not has_valid_policy_name(pol)
	p = fugue.deny_resource_with_message(pol, concat("",{"Policy name should be end with " , concat(",",policy_list)}))
}
