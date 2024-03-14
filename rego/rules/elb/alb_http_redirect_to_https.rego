	package rules.tf_aws_elb_alb_http_redirect_to_https

import data.fugue
import future.keywords.in

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
		"severity": "Medium",
	},
	"description": "Checks whether HTTP to HTTPS redirection is configured on all HTTP listeners of Application Load Balancers. The rule is NON_COMPLIANT if one or more HTTP listeners of Application Load Balancer do not have HTTP to HTTPS redirection configured.",
	"id": "FR50",
	"title": "ALB load balancer HTTP redirection to HTTPS should be configured",
}

resource_type = "MULTIPLE"

lbs = fugue.resources("aws_lb")
listeners = fugue.resources("aws_lb_listener")

is_alb(lb_arn){
	lb_arn in get_albs
}

get_albs = albs{
	albs = [p.id | p := lbs[_]; p.load_balancer_type == "application"]
}

policy[p] {
	listener = listeners[_]
	not all([is_alb(listener.load_balancer_arn), listener.protocol == "HTTPS"])
	p = fugue.deny_resource(listener)
}