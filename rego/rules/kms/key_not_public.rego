package rules.tf_aws_kms_key_not_public

import data.fugue

# KMS master keys should not be publicly accessible
# 
# aws_kms_key

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
	          "DSS05.04.5"
	        ],
        },
	 "severity": "Critical",
  },
  "description": "KMS master keys should not be publicly accessible. KMS keys are used for encrypting and decrypting data which may be sensitive. Publicly accessible KMS keys may allow anyone to perform decryption operations which may reveal data.",
  "id": "FR6",
  "title": "KMS master keys should not be publicly accessible"
}

resource_type := "aws_kms_key"

default deny = false

all_principals(statement) {
    principals = as_array(statement.Principal)
    effects = as_array(statement.Effect)
    principal = principals[_]
    effect = effects[_]
    principal.AWS == "*"; effect == "Allow"
}

is_nonempty_string(str) {
    is_string(str)
    count(str) > 1
}

is_nonempty_array(arr) {
    is_array(arr)
    count([element | element = arr[_]; is_nonempty_string(element)]) == count(arr)
}

valid_condition(condition) {
    is_nonempty_string(condition.StringEquals["kms:CallerAccount"])
} {
    is_nonempty_string(condition.StringEquals["aws:PrincipalOrgID"])
} {
    is_nonempty_array(condition.StringEquals["kms:CallerAccount"])
} {
    is_nonempty_array(condition.StringEquals["aws:PrincipalOrgID"])
}

statement_conditions(statement) = ret {
    ret := as_array(object.get(statement, "Condition", []))
}

statement_missing_caller_condition(statement) {
    count(statement_conditions(statement)) == 0
} {
    condition := statement_conditions(statement)[_]
    not valid_condition(condition)
}

deny {
    json.unmarshal(input.policy, doc)
    statements = as_array(doc.Statement)
    statement = statements[_]

    all_principals(statement)
    statement_missing_caller_condition(statement)
}

as_array(x) = [x] {not is_array(x)} else = x {true}