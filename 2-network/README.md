## 2-network

## Prerequisites
1. 0-bootstrap executed successfully.
2. 1-org executed successfully

## Overview Details
There are 2 important components that get deployed by terraform code in 2-network directories viz dns-hub, network-hub.

Network-hub essentially creates VPCs, Transit Gateway, configures route tables, and firewall all other network-related resources.

Dns-hub creates route 53 Setup. 

Refer to the child documents below for more details on each service that gets deployed in 2-network.