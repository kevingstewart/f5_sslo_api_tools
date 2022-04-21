# terraform-aws-sslo
Terraform and Configuration Management files for an AWS SSLO deployment 

Built and Tested with the following versions in AWS East Region.
Terraform version v.0.14.5
AWS Provider v3.57.0

Region and AZ are set to East and 1a, these are set in the variables.tf

Instance types are set in the variables.tf

Static private IP's are set for the BIG-IP, these are set in the f5_onboard.tmpl and in interfaces.tf

You will need a BYOL SSLO key/license to properly spin this up.  This is hardcoded in the f5_onboard.tmpl

Prefix is set in the variables.tf, set this to make your SSLO objects unique: the default is set to: "demo" 

User=admin Password=f5Twister! , this is configured for demo/dev enviroments only, it is recommend that you use a secrets manager like Secrets or Vault

SSLO has ATC packages installed and DO provisions SSLO and sets networking up via runtime-init in the f5_onboard.tmpl

SSLO day 2 automation coming later(as3 or ansible)

This demo uses "Inspection" devices sitting in separate service chains to simulate real world deployments. These are a Linux hosts with Snort installed. Snort is not configured but it will bootstrap with appropriate routing and IP forwarding so that packets
traverse the inspection zone and re-enter the DMZ2/DMZ4 interfaces.

There are static IP addresses hard coded for ease of demo at the moment. The outputs at the completion of the Terraform will help with IP understanding.

The VIP address is 10.0.2.200

If the config fails, you should check where traffic is stopping.  A good place to start is at the F5. Do a tcpdump on the DMZ1 and DMZ3 interface...do you see traffic? yes then 
tcpdump the DMZ2/DMZ4 interface....traffic? no....then its probably the Inspection devices and it didnt bootstrap properly.

ssh into the devices and check the route table, does it have a route to 10.0.2.0/24 via 10.0.4.23/10.0.7.23?

Run these commands to fix the routing issue, change the IP on the DMZ3/4 device to 10.0.7.23:

sudo ip route add 10.0.2.0/24 via 10.0.4.23 dev eth2

sudo sysctl -w net.ipv4.ip_forward=1



Prereqs:

1. Terraform >= v.0.14.5

2. Git installed on your local machine to clone this repo

3. An AWS account with programmatic access and Key Pair created

Steps to deploy:

1. Make sure you meet the prereqs

2. Replace the hard coded license key in the f5_onboard.tmpl file

3. run these commands:

terraform init

terraform plan

terraform apply

terraform destroy <-- when you are ready to tear it down

4. The BIG-IP SSLO is not configured, this is coming soon but all of the plumbing is in place

Be sure to create the pool and pool member before configuring, this example uses a Wordpress App, IP address is outputted.

5. Configure a L3 Inbound topology

6. Use auto map and on the port remap use the default

7. On the Egress, use automap and network default

8. Use DMZ1 and DMZ3 Vlan for to

9. Use DMZ2 and DMZ4 Vlan for from

10. Put inspection_service_ip_1 in the first chain

11. Put inspection_service_ip_2 in the second chain

12. You will need to create an additional Rule to apply the second chain.  You can use "SSL Check is true" to ensure traffic intercepts and traverses both chains.

<b>Inbound Traffic Diagram</b>

 ![f5](https://user-images.githubusercontent.com/18743780/134435723-a9216d8a-0cd7-463a-bda7-665eaaff9008.png)



