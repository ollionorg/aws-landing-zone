package rules.nlb_public_private_ip_new
import data.fugue
import future.keywords
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
    "description": "Checks whether NLB is configured with public and private IP assignment",
    "id": "FR50",
    "title": "NLB Public and Private IP configured"
}

resource_type = "MULTIPLE"


lbs = fugue.resources("aws_lb")

is_nlb(lb) {
    lb.load_balancer_type == "network"
    lb.internal == true
	count(lb.subnet_mapping) == count(all_private_ips(lb))
}

is_nlb(lb){
    lb.load_balancer_type == "network"
    lb.internal == false
	count(lb.subnet_mapping) == count(all_eip(lb))
}

all_eip(lb) = x {
	x = [p.subnet_id | p := lb.subnet_mapping[_]; p.allocation_id != ""]
}

all_private_ips(lb) = x {
	x = [p.subnet_id | p := lb.subnet_mapping[_]; p.private_ipv4_address != ""]
}

policy[p] {
    lb = lbs[_]
    is_nlb(lb)
	p = fugue.allow_resource(lb)
}

policy[p] {
    lb = lbs[_]
	not is_nlb(lb)
	p = fugue.deny_resource(lb)
}





