package main

import data.fugue
import future.keywords.in
import future.keywords.every

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
		"severity": "High",
	},
	"description": "Ensure that the ssl policy for tls is must be from the given list",
	"id": "FR50",
	"title": "SSL policy for tls verions 1.2+",
}

supported_policy_application := [
    "ELBSecurityPolicy-TLS13-1-2-2021-06",
    "ELBSecurityPolicy-TLS13-1-3-2021-06",
    "ELBSecurityPolicy-TLS13-1-2-Res-2021-06",
    "ELBSecurityPolicy-TLS13-1-2-Ext1-2021-06",
    "ELBSecurityPolicy-TLS13-1-2-Ext2-2021-06",
    "ELBSecurityPolicy-TLS13-1-1-2021-06",
    "LBSecurityPolicy-TLS13-1-0-2021-06",
]
supported_policy_network := [
    "ELBSecurityPolicy-TLS13-1-2-2021-06",
    "ELBSecurityPolicy-TLS13-1-3-2021-06",
    "ELBSecurityPolicy-TLS13-1-2-Res-2021-06",
    "ELBSecurityPolicy-TLS13-1-2-Ext1-2021-06",
    "ELBSecurityPolicy-TLS13-1-2-Ext2-2021-06",
    "ELBSecurityPolicy-TLS13-1-1-2021-06",
    "ELBSecurityPolicy-TLS13-1-0-2021-06",
]

resource_type = "MULTIPLE"

lb := fugue.resources("aws_lb")
lb_listener := fugue.resources("aws_lb_listener")

default allow := false

allow {
    lb_instance := lb[_]
    listener_instance := lb_listener[_]
    lb_instance.load_balancer_type == "application"
    listener_instance.protocol == "HTTPS"
    every policy in supported_policy_application {
        policy == listener_instance.ssl_policy
    }
}

allow {
    lb_instance := lb[_]
    listener_instance := lb_listener[_]
    lb_instance.load_balancer_type == "network"
    listener_instance.protocol == "HTTPS"
    every policy in supported_policy_network {
        policy == listener_instance.ssl_policy
    }
}
