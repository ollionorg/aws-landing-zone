package rules.tf_aws_s3_block_public_access

import data.fugue
import data.aws.s3.s3_library as lib


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
    "severity": "High"
  },  
  "description": "S3 buckets should have all `block public access` options enabled. AWS's S3 Block Public Access feature has four settings: BlockPublicAcls, IgnorePublicAcls, BlockPublicPolicy, and RestrictPublicBuckets. All four settings should be enabled to help prevent the risk of a data breach.",
  "id": "FR10,FR14,FR18",
  "title": "S3 buckets should have all `block public access` options enabled"
}

resource_type := "MULTIPLE"

policy[j] {
  b = buckets[bucket_id]
  bucket_is_blocked(b)
  j = fugue.allow_resource(b)
} {
  b = buckets[bucket_id]
  not bucket_is_blocked(b)
  j = fugue.deny_resource(b)
}

buckets = fugue.resources("aws_s3_bucket")
bucket_access_blocks = fugue.resources("aws_s3_bucket_public_access_block")

# Using the `bucket_access_blocks`, we construct a set of bucket IDs that have
# the public access blocked.
blocked_buckets[bucket_name] {
    block = bucket_access_blocks[_]
    bucket_name = block.bucket
    block.block_public_acls == true
    block.ignore_public_acls == true
    block.block_public_policy == true
    block.restrict_public_buckets == true
}

bucket_is_blocked(bucket) {
  fugue.input_type != "tf_runtime"
  blocked_buckets[bucket.id]
} {
  blocked_buckets[bucket.bucket]
}