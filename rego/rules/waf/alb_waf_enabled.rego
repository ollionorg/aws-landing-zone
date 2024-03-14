package rules.tf_aws_lb_waf_enabled_rules
import data.fugue

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"COBIT_DETAILS": [
	           "DSS01.01.5"
	        ],
	        "COBIT_IMPLEMENTATION": [
	           "DSS02.02.1"
	        ],
	    },
		"severity": "Medium",
	},
	"description": "Checks whether WAF is enabled for application load balancer or not",
	"id": "FR35",
}

resource_type = "MULTIPLE"

# every alb in the template
alb = fugue.resources("aws_lb")

# every wafv2 acl in the template
wafv2_acls = fugue.resources("aws_wafv2_web_acl_association")

# WAFV2 ACL is valid if it is associated with an ALB
is_valid_wafv2_acl(wafv2_acl) {
	alb.arn == wafv2_acls[_].resource_arn
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
