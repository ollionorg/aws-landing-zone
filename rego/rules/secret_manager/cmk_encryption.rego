package rules.tf_aws_sm_cmk
import data.fugue


__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	            "DSS05.06.6"
	        ],
	        "COBIT_IMPLEMENTATION": [
	           "DSS05.06.2"
	        ],
	        "COBIT_DEFINITION": [
	            "DSS05.03.10"
	        ],
	        },
		"severity": "Medium",
	},
	"description": "Checks whether Secret manager is encrypted using cmk.",
	"id": "FR43",
	"title": "Secret Manager encryption using cmk",
}


resource_type = "MULTIPLE"

secret_manager := fugue.resources("aws_secretsmanager_secret")
cmk := fugue.resources("aws_kms_key")

policy[p] {
  sm = secret_manager[_]
  sm.kms_key_id == cmk.key_id
  p = fugue.allow_resource(sm)
} {
  sm = secret_manager[_]
  sm.kms_key_id != cmk.key_id
  p = fugue.deny_resource(sm)
}