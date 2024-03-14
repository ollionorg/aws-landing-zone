package rules.kms_access_key_rotation

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	          "DSS01.01.5"
	        ],
	        "COBIT_IMPLEMENTATION": [
	          "DSS02.02.1"
	        ],
        },
		"severity": "High",
	},
	"description": "KMS CMK rotation should be enabled. It is recommended that users enable rotation for the customer created AWS Customer Master Key (CMK). Rotating encryption keys helps reduce the potential impact of a compromised key as users cannot use the old key to access the data.",
	"id": "FR35",
	"title": "KMS CMK rotation should be enabled.",
}

resource_type := "aws_kms_key"

deny[msg] {
	not input.enable_key_rotation
	msg = "KMS Key rotation should be enabled"
}