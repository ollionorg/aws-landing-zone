package rules.waf_wafv2_logging_enabled

import data.fugue

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	            "DSS05.01.2"
	        ],
	        "COBIT_IMPLEMENTATION": [
	           "DSS05.07.5"
	        ],
	        "COBIT_DEFINITION": [
	            "BAI07.05.6"
	        ],
	    },
		"severity": "Medium",
	},
	"id": "FR18",
	"title": "WAFV2 ACL logging should be enabled",
	"description": "Logging should be enabled on AWS Web Application Firewall (WAFV2) regional and global web access control list (ACLs). The rule is NON_COMPLIANT if the logging is enabled but the logging destination does not match the value of the parameter.",
}

resource_type = "MULTIPLE"

# every wafv2 acl log config in the template
wafv2_acl_log_configs = fugue.resources("aws_wafv2_web_acl_logging_configuration")

# every wafv2 acl in the template
wafv2_acls = fugue.resources("aws_wafv2_web_acl")

# WAFV2 ACL is valid if there is an associated logging config
is_valid_wafv2_acl(wafv2_acl) {
	wafv2_acl.id == wafv2_acl_log_configs[_].resource_arn
}

is_valid_wafv2_acl(wafv2_acl) {
	wafv2_acl.arn == wafv2_acl_log_configs[_].resource_arn
}

policy[p] {
	resource = wafv2_acls[_]
	not is_valid_wafv2_acl(resource)
	p = fugue.deny_resource(resource)
}

policy[p] {
	resource = wafv2_acls[_]
	is_valid_wafv2_acl(resource)
	p = fugue.allow_resource(resource)
}
