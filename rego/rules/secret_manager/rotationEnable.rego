package rules.secret_manager_rotation_policy

import data.fugue
import future.keywords.in

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	            "DSS05.06.2"
	        ],
	        "COBIT_IMPLEMENTATION": [
	           "DSS05.06.2"
	        ],
	        },
		"severity": "Medium",
	},
	"title": "Ensure secretsmanager rotation policy in place",
	"description": "Checks if AWS Secrets Manager secret has rotation enabled.",
	"id": "FR71",
}

resource_type = "MULTIPLE"

secret_ids = fugue.resources("aws_secretsmanager_secret")

secret_managers = fugue.resources("aws_secretsmanager_secret_rotation")

has_rotation_enabled(resource_id) {
	resource_id == secret_managers[_].secret_id
	
}

policy[p] {
	resource = secret_ids[_]
	has_rotation_enabled(resource.id)
	p = fugue.allow_resource(resource)
}

policy[p] {
	resource = secret_ids[_]
	not has_rotation_enabled(resource.id)
	p = fugue.deny_resource(resource)
}