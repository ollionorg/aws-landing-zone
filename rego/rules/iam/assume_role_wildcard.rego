package rules.tf_aws_iam_assume_role_wildcard

import data.fugue
import data.aws.iam.policy_document_library as lib



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
    "severity": "Medium"
  },
  "description": "IAM role trust policies should not allow all principals to assume the role. Using a wildcard in the Principal element in a role's trust policy would allow any IAM user in any account to access the role. This is a significant security gap and can be used to gain access to sensitive data.",
  "id": "FR5",
  "title": "IAM role trust policies should not allow all principals to assume the role"
}

policies = fugue.resources("aws_iam_role")

# All wildcard policies.
wildcard_policies[id] = p {
  #inline policies only
  p = policies[id]
  is_wildcard_policy(p.assume_role_policy)
}

# Determine if a trust policy enables everyone/anonymous to access the role with a wildcard. This occurs in a trust policy that has all of:
# - Effect: "Allow"
# - Principal: "*"
# - Action: "sts:AssumeRole"
is_wildcard_policy(pol) {
  doc = lib.to_policy_document(pol)
  statements = as_array(doc.Statement)
  statement = statements[_]

  statement.Effect == "Allow"

  principals = as_array(statement.Principal)
  principal = principals[_]
  principal_is_wildcard(principal)

  actions = as_array(statement.Action)
  action = actions[_]
  action_is_assume_role(action)
}

# Check if Principal is a wildcard
principal_is_wildcard(principal) {
    entry_or_entries = principal[_]
    entries = as_array(entry_or_entries)
    entry = entries[_]
    entry == "*"
}

action_is_assume_role(action) {
    action == "*"
} {
    action == "sts:AssumeRole"
}

# Judge policies and wildcard policies.
resource_type = "MULTIPLE"

policy[j] {
  pol = wildcard_policies[id]
  j = fugue.deny_resource(pol)
} {
  pol = policies[id]
  not wildcard_policies[id]
  j = fugue.allow_resource(pol)
}

# Utility: turns anything into an array, if it's not an array already.
as_array(x) = [x] {not is_array(x)} else = x {true}