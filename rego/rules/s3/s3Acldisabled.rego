package rules.tf_aws_s3_bucket_acl_disabled

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
	"description": "Ensure that S3 Storage buckets have uniform bucket-level access enabled. ACLs should be disabled, by default. The rule is NON_COMPLIANT if the object_ownership is not set to BucketOwnerEnforced.",
	"id": "FR10,FR14,FR18",
	"title": "S3 bucket has object_ownership not set to BucketOwnerEnforced",
}

resource_type = "MULTIPLE"

buckets = fugue.resources("aws_s3_bucket")

bucket_acl_disabled = fugue.resources("aws_s3_bucket_ownership_controls")  

blocked_buckets[bucket_name] {
    block = bucket_acl_disabled[_]
    bucket_name = block.bucket
    block.rule[_].object_ownership == "BucketOwnerEnforced"
}

bucket_acl_is_disabled(bucket) {
  fugue.input_type != "tf_runtime"
  blocked_buckets[bucket.id]
} {
  blocked_buckets[bucket.bucket]
}

policy[j] {
  b = buckets[bucket_id]
  bucket_acl_is_disabled(b)
  j = fugue.allow_resource(b)
} {
  b = buckets[bucket_id]
  not bucket_acl_is_disabled(b)
  j = fugue.deny_resource(b)
}