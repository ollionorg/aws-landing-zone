package rules.tf_aws_s3_bucketpolicy_allowall

import data.fugue
import data.aws.s3.s3_library as lib
import data.aws.s3.s3_public_library as public
import data.aws.iam.policy_document_library as doclib

# S3 bucket policies should not allow all actions for all principals. S3 bucket policies - and access control policies in general - should not allow wildcard/all actions, except in very specific administrative situations. Allowing all principals to wildcard access is overly permissive.
# 
# aws_s3_bucket
# aws_s3_bucket_policy


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
  "description": "S3 bucket policies should not allow all actions for all IAM principals and public users. S3 bucket policies - and access control policies in general - should not allow wildcard/all actions, except in very specific administrative situations. Allowing all principals to wildcard access is overly permissive.",
  "id": "FR10,FR14,FR18",
  "title": "S3 bucket policies should not allow all actions for all IAM principals and public users"
}

resource_type = "MULTIPLE"

buckets = fugue.resources("aws_s3_bucket")

invalid_buckets[bucket_id] = bucket {
  bucket = buckets[bucket_id]
  policies = lib.bucket_policies_for_bucket(bucket)
  pol = policies[_]
  wildcard_all(pol)
}

# Determine if a bucket policy is a wildcard policy for all principals.  A wildcard policy is defined as
# a bucket policy having a statement that has all of:
# - Effect: Allow
# - Action: "*"
# - Principal: "*"
wildcard_all(pol) {
  doc = doclib.to_policy_document(pol)
  statements = as_array(doc.Statement)
  statement = statements[_]

  statement.Effect == "Allow"

  actions = as_array(statement.Action)
  action = actions[_]
  action == "*"

  principals = as_array(statement.Principal)
  principal = principals[_]
  public.invalid_principal(principal)
}

policy[j] {
  b = invalid_buckets[_]
  j = fugue.deny_resource(b)
} {
  b = buckets[id]
  not invalid_buckets[id]
  j = fugue.allow_resource(b)
}

# Utility: turns anything into an array, if it's not an array already.
as_array(x) = [x] {not is_array(x)} else = x {true}