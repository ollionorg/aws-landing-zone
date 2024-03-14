package rules.tf_aws_s3_versioning_lifecycle_enabled

import data.fugue
import data.aws.s3.s3_library as lib

__rego__metadoc__ := {
  "custom": {
		"controls": {
			"COBIT_DETAILS": [
	           "DSS05.07.5"
	        ],
	        "COBIT_IMPLEMENTATION": [
	           "DSS05.07.5",
             "DSS06.05.3"
	        ],
	        "COBIT_DEFINITION": [
	           "DSS05.07.5",
             "DSS06.05.3"
	        ],
	        },
		"severity": "Medium",
	},
  "title": "Ensure S3 bucket versioning is enabled",
	"description": "Checks whether versioning is enabled for your S3 buckets.",
  "id": "FR13,FR17,FR21",
}

resource_type := "MULTIPLE"

buckets := fugue.resources("aws_s3_bucket")




bucket_versioning = fugue.resources("aws_s3_bucket_versioning")

encrypted_buckets[bucket_name] {
    block = bucket_versioning[_]
    bucket_name = block.bucket
    block.versioning_configuration[_].status = "Enabled"
}

bucket_is_encrypted(bucket) {
  fugue.input_type != "tf_runtime"
  encrypted_buckets[bucket.id]
} {
  encrypted_buckets[bucket.bucket]
}


policy[j] {
  b = buckets[bucket_id]
  bucket_is_encrypted(b)
  j = fugue.allow_resource(b)
} {
  b = buckets[bucket_id]
  not bucket_is_encrypted(b)
  j = fugue.deny_resource(b)
}