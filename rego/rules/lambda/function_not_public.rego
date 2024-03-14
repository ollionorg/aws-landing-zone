package rules.tf_aws_lambda_function_not_public

import data.fugue
import data.aws.lambda.permissions_library as lib

# Lambda function policies should not allow global access
#
# aws_lambda_permission
# aws_lambda_function

__rego__metadoc__ := {
  "custom": {
    "controls": {
			"COBIT_DETAILS": [
	          "DSS05.02.6",
            "DSS05.03.5"
	        ],
	        "COBIT_IMPLEMENTATION": [
	          "DSS05.02.6",
            "DSS05.03.5"
	        ],
	        "COBIT_DEFINITION": [
	          "DSS05.02.2",
            "DSS05.02.3"
	        ],
    },
    "severity": "High"
  },
  "description": "Lambda function policies should not allow global access. Publicly accessible lambda functions may be runnable by anyone and could drive up your costs, disrupt your services, or leak your data.",
  "id": "FR50,FR51",
  "title": "Lambda function policies should not allow global access"
}

resource_type := "MULTIPLE"

message = "Lambda function policies should not allow global access"

valid_permission(permission) {
    is_string(permission.principal)
    permission.principal != "*"
}

policy[j] {
  func = lib.funcs_by_key[k][_]
  not lib.perm_by_key[k]
  j = fugue.allow_resource(func)
} {
  permission = lib.permissions[_]
  valid_permission(permission)
  k = lib.permission_key(permission)
  f = lib.funcs_by_key[k][_]
  j = fugue.allow_resource(f)
} {
  permission = lib.permissions[_]
  not valid_permission(permission)
  k = lib.permission_key(permission)
  f = lib.funcs_by_key[k][_]
  j = fugue.deny_resource_with_message(f, message)
}