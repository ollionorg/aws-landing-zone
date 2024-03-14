package rules.tf_aws_s3_bucket_default_lock_enabled

import data.fugue
import future.keywords.in

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	          "DSS01.03.1",
              "DSS05.01.2"
	        ],
	        "COBIT_IMPLEMENTATION": [
	          "MEA02.04.3",
			  "DSS02.02.1",
              "DSS05.07.5"
	        ],
	        "COBIT_DEFINITION": [
	          "DSS01.03.4",
			  "DSS01.03.6",
              "BAI07.05.6"
	        ],
        },
		"severity": "Medium",
	},
	"description": " S3 bucket has lock enabled, by default. The rule is NON_COMPLIANT if the lock is not enabled.",
	"id": "FR10,FR14,FR18",
	"title": "S3 bucket bucket lock should be enabled",
}

resource_type = "MULTIPLE"

buckets = fugue.resources("aws_s3_bucket")

object_lock_enabled = fugue.resources("aws_s3_bucket_object_lock_configuration")


to_array(x) = x {
	is_array(x)
}

else = [x] {
	true
}


has_object_lock_enabled(resource_id) {
	sel = to_array(object_lock_enabled[_].bucket)
	resource_id in sel
}

policy[p] {
	resource = buckets[_]
	has_object_lock_enabled(resource.id)
	p = fugue.allow_resource(resource)
}

policy[p] {
	resource = buckets[_]
	not has_object_lock_enabled(resource.id)
	p = fugue.deny_resource(resource)
}
