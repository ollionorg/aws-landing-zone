<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_ec2_transit_gateway_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_vpn_connection.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_gateway_bgp_asn"></a> [customer\_gateway\_bgp\_asn](#input\_customer\_gateway\_bgp\_asn) | The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN) | `number` | `65000` | no |
| <a name="input_customer_gateway_ip_address"></a> [customer\_gateway\_ip\_address](#input\_customer\_gateway\_ip\_address) | The IP address of the gateway's Internet-routable external interface | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Default name | `string` | `"main"` | no |
| <a name="input_route_table_ids"></a> [route\_table\_ids](#input\_route\_table\_ids) | The IDs of the route tables for which routes from the Virtual Private Gateway will be propagated | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Set of tags to be added to the VPN Connection resource (only if `create_vpn_connection = true`). | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | The ID of the Transit Gateway. | `string` | `null` | no |
| <a name="input_transit_gateway_route_table_id"></a> [transit\_gateway\_route\_table\_id](#input\_transit\_gateway\_route\_table\_id) | The ID of the Transit Gateway Route Table Where We Need To Add Static Route. | `string` | `null` | no |
| <a name="input_vpn_connection_local_ipv4_network_cidr"></a> [vpn\_connection\_local\_ipv4\_network\_cidr](#input\_vpn\_connection\_local\_ipv4\_network\_cidr) | The IPv4 CIDR on the customer gateway (on-premises) side of the VPN connection. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_vpn_connection_remote_ipv4_network_cidr"></a> [vpn\_connection\_remote\_ipv4\_network\_cidr](#input\_vpn\_connection\_remote\_ipv4\_network\_cidr) | The IPv4 CIDR on the AWS side of the VPN connection. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_vpn_connection_static_routes_destinations"></a> [vpn\_connection\_static\_routes\_destinations](#input\_vpn\_connection\_static\_routes\_destinations) | List of CIDR blocks to be used as destination for static routes. Routes to destinations will be propagated to the route tables defined in `route_table_ids` | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_static_routes_only"></a> [vpn\_connection\_static\_routes\_only](#input\_vpn\_connection\_static\_routes\_only) | If set to `true`, the VPN connection will use static routes exclusively. Static routes must be used for devices that don't support BGP | `string` | `"true"` | no |
| <a name="input_vpn_connection_tunnel1_dpd_timeout_action"></a> [vpn\_connection\_tunnel1\_dpd\_timeout\_action](#input\_vpn\_connection\_tunnel1\_dpd\_timeout\_action) | The action to take after DPD timeout occurs for the first VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear \| none \| restart. | `string` | `"clear"` | no |
| <a name="input_vpn_connection_tunnel1_ike_versions"></a> [vpn\_connection\_tunnel1\_ike\_versions](#input\_vpn\_connection\_tunnel1\_ike\_versions) | The IKE versions that are permitted for the first VPN tunnel. Valid values are ikev1 \| ikev2. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_inside_cidr"></a> [vpn\_connection\_tunnel1\_inside\_cidr](#input\_vpn\_connection\_tunnel1\_inside\_cidr) | The CIDR block of the inside IP addresses for the first VPN tunnel | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel1_phase1_dh_group_numbers"></a> [vpn\_connection\_tunnel1\_phase1\_dh\_group\_numbers](#input\_vpn\_connection\_tunnel1\_phase1\_dh\_group\_numbers) | List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_phase1_encryption_algorithms"></a> [vpn\_connection\_tunnel1\_phase1\_encryption\_algorithms](#input\_vpn\_connection\_tunnel1\_phase1\_encryption\_algorithms) | List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_phase1_integrity_algorithms"></a> [vpn\_connection\_tunnel1\_phase1\_integrity\_algorithms](#input\_vpn\_connection\_tunnel1\_phase1\_integrity\_algorithms) | One or more integrity algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_phase2_dh_group_numbers"></a> [vpn\_connection\_tunnel1\_phase2\_dh\_group\_numbers](#input\_vpn\_connection\_tunnel1\_phase2\_dh\_group\_numbers) | List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_phase2_encryption_algorithms"></a> [vpn\_connection\_tunnel1\_phase2\_encryption\_algorithms](#input\_vpn\_connection\_tunnel1\_phase2\_encryption\_algorithms) | List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_phase2_integrity_algorithms"></a> [vpn\_connection\_tunnel1\_phase2\_integrity\_algorithms](#input\_vpn\_connection\_tunnel1\_phase2\_integrity\_algorithms) | One or more integrity algorithms that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_preshared_key"></a> [vpn\_connection\_tunnel1\_preshared\_key](#input\_vpn\_connection\_tunnel1\_preshared\_key) | The preshared key of the first VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero. Allowed characters are alphanumeric characters, periods(.) and underscores(\_) | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel1_startup_action"></a> [vpn\_connection\_tunnel1\_startup\_action](#input\_vpn\_connection\_tunnel1\_startup\_action) | The action to take when the establishing the tunnel for the first VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are add \| start. | `string` | `"add"` | no |
| <a name="input_vpn_connection_tunnel2_dpd_timeout_action"></a> [vpn\_connection\_tunnel2\_dpd\_timeout\_action](#input\_vpn\_connection\_tunnel2\_dpd\_timeout\_action) | The action to take after DPD timeout occurs for the second VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear \| none \| restart. | `string` | `"clear"` | no |
| <a name="input_vpn_connection_tunnel2_ike_versions"></a> [vpn\_connection\_tunnel2\_ike\_versions](#input\_vpn\_connection\_tunnel2\_ike\_versions) | The IKE versions that are permitted for the second VPN tunnel. Valid values are ikev1 \| ikev2. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_inside_cidr"></a> [vpn\_connection\_tunnel2\_inside\_cidr](#input\_vpn\_connection\_tunnel2\_inside\_cidr) | The CIDR block of the inside IP addresses for the second VPN tunnel | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel2_phase1_dh_group_numbers"></a> [vpn\_connection\_tunnel2\_phase1\_dh\_group\_numbers](#input\_vpn\_connection\_tunnel2\_phase1\_dh\_group\_numbers) | List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_phase1_encryption_algorithms"></a> [vpn\_connection\_tunnel2\_phase1\_encryption\_algorithms](#input\_vpn\_connection\_tunnel2\_phase1\_encryption\_algorithms) | List of one or more encryption algorithms that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_phase1_integrity_algorithms"></a> [vpn\_connection\_tunnel2\_phase1\_integrity\_algorithms](#input\_vpn\_connection\_tunnel2\_phase1\_integrity\_algorithms) | One or more integrity algorithms that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_phase2_dh_group_numbers"></a> [vpn\_connection\_tunnel2\_phase2\_dh\_group\_numbers](#input\_vpn\_connection\_tunnel2\_phase2\_dh\_group\_numbers) | List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_phase2_encryption_algorithms"></a> [vpn\_connection\_tunnel2\_phase2\_encryption\_algorithms](#input\_vpn\_connection\_tunnel2\_phase2\_encryption\_algorithms) | List of one or more encryption algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_phase2_integrity_algorithms"></a> [vpn\_connection\_tunnel2\_phase2\_integrity\_algorithms](#input\_vpn\_connection\_tunnel2\_phase2\_integrity\_algorithms) | One or more integrity algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_preshared_key"></a> [vpn\_connection\_tunnel2\_preshared\_key](#input\_vpn\_connection\_tunnel2\_preshared\_key) | The preshared key of the second VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero. Allowed characters are alphanumeric characters, periods(.) and underscores(\_) | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel2_startup_action"></a> [vpn\_connection\_tunnel2\_startup\_action](#input\_vpn\_connection\_tunnel2\_startup\_action) | The action to take when the establishing the tunnel for the second VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are add \| start. | `string` | `"add"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_customer_gateway_id"></a> [customer\_gateway\_id](#output\_customer\_gateway\_id) | Customer Gateway ID |
| <a name="output_vpn_connection_customer_gateway_configuration"></a> [vpn\_connection\_customer\_gateway\_configuration](#output\_vpn\_connection\_customer\_gateway\_configuration) | The configuration information for the VPN connection's Customer Gateway (in the native XML format) |
| <a name="output_vpn_connection_id"></a> [vpn\_connection\_id](#output\_vpn\_connection\_id) | VPN Connection ID |
| <a name="output_vpn_connection_tunnel1_address"></a> [vpn\_connection\_tunnel1\_address](#output\_vpn\_connection\_tunnel1\_address) | The public IP address of the first VPN tunnel |
| <a name="output_vpn_connection_tunnel1_cgw_inside_address"></a> [vpn\_connection\_tunnel1\_cgw\_inside\_address](#output\_vpn\_connection\_tunnel1\_cgw\_inside\_address) | The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway side) |
| <a name="output_vpn_connection_tunnel1_vgw_inside_address"></a> [vpn\_connection\_tunnel1\_vgw\_inside\_address](#output\_vpn\_connection\_tunnel1\_vgw\_inside\_address) | The RFC 6890 link-local address of the first VPN tunnel (Virtual Private Gateway side) |
| <a name="output_vpn_connection_tunnel2_address"></a> [vpn\_connection\_tunnel2\_address](#output\_vpn\_connection\_tunnel2\_address) | The public IP address of the second VPN tunnel |
| <a name="output_vpn_connection_tunnel2_cgw_inside_address"></a> [vpn\_connection\_tunnel2\_cgw\_inside\_address](#output\_vpn\_connection\_tunnel2\_cgw\_inside\_address) | The RFC 6890 link-local address of the second VPN tunnel (Customer Gateway side) |
| <a name="output_vpn_connection_tunnel2_vgw_inside_address"></a> [vpn\_connection\_tunnel2\_vgw\_inside\_address](#output\_vpn\_connection\_tunnel2\_vgw\_inside\_address) | The RFC 6890 link-local address of the second VPN tunnel (Virtual Private Gateway side) |
<!-- END_TF_DOCS -->