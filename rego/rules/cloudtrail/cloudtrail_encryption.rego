package rules.tf_aws_cloudtrail_encryption

import data.fugue


__rego__metadoc__ := {
  "custom": {
		"controls": {
			  "COBIT_DETAILS": [
	         "DSS05.03.10"
	      ],
    },
    "severity": "High"
  },
  "description": "CloudTrail log files should be encrypted with customer managed KMS keys. By default, the log files delivered by CloudTrail to your bucket are encrypted with Amazon S3-managed encryption keys (SSE-S3). To get control over key rotation and obtain auditing visibility into key usage, use SSE-KMS to encrypt your log files with customer managed KMS keys.",
  "id": "NFR8",
  "title": "CloudTrail log files should be encrypted with customer managed KMS keys"
}

# Is a cloudtrail encrypted using a KMS CMK?
valid_kms_arn_prefix = {
  "arn:aws:kms:",
  "arn:aws-us-gov:kms:"
}

is_encrypted(ct) {
  ct.kms_key_id != null
  ct.kms_key_id != ""
  valid_kms_arn_prefix[k]
  startswith(ct.kms_key_id, k)
} {
  fugue.input_type != "tf_runtime"
  ct.kms_key_id != null
  ct.kms_key_id != ""
}

cloudtrails = fugue.resources("aws_cloudtrail")

resource_type := "MULTIPLE"

policy[j] {
  ct = cloudtrails[_]
  is_encrypted(ct)
  j = fugue.allow_resource(ct)
} {
  ct = cloudtrails[_]
  not is_encrypted(ct)
  j = fugue.deny_resource(ct)
}
