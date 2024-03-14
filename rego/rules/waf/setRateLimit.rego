package rules.waf_wafv2_set_rate_limit

import data.fugue

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	            "DSS05.02.6"
	        ],
	        "COBIT_IMPLEMENTATION": [
	           "DSS05.02.6"
	        ],
	        "COBIT_DEFINITION": [
	            "DSS05.02.2"
	        ],
	    },
		"severity": "Low",
	},
	"id": "FR50",
	"title": "Set rate Limiting Thresholds for WAF.Either in acl or in rule group.",
	"description": "Rate Limiting Thresholds for Application Firewall (WAFV2) regional and global web access control list (ACLs). The rule is NON_COMPLIANT if rate limit is not set for acl or rule group.",
}

resource_type = "MULTIPLE"

# every wafv2 acl in the template
wafv2_acls = fugue.resources("aws_wafv2_web_acl")

# every wafv2 rule_group in the template
wafv2_rule_groups = fugue.resources("aws_wafv2_rule_group")

is_valid_wafv2_acl(wafv2_acl) {
    count(wafv2_rule_groups[_]) > 0
    wafv2_rule_group = wafv2_rule_groups[_]
    is_valid_rule_group(wafv2_acl,wafv2_rule_group)
}

is_valid_rule_group(wafv2_acl,wafv2_rule_group) {
    wafv2_acl.rule[_].statement[_].rule_group_reference_statement[_].arn == wafv2_rule_group.id
    count(wafv2_rule_group.rule[_].statement[_].rate_based_statement[_]) > 0
}

is_valid_rule_group(wafv2_acl,wafv2_rule_group) {
    wafv2_acl.rule[_].statement[_].rule_group_reference_statement[_].arn == wafv2_rule_group.arn
    count(wafv2_rule_group.rule[_].statement[_].rate_based_statement[_]) > 0
}

is_valid_wafv2_acl(wafv2_acl) {
	count(wafv2_acl.rule[_].statement[_].rate_based_statement[_]) > 0
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