# AWS SSL Orchestrator Infrastructure Deployment using Terraform

These Terraform configuration files will deploy an F5 SSL Orchestrator environment into Amazon Web Services (AWS).

The resulting deployment will consist of the following:

- Security VPC and various subnets for SSL Orchestrator and inspection devices
- Application VPC and subnet for demo application
- Demo application server (Wordpress)
- F5 SSL Orchestrator (BIG-IP Virtual Edition)
- Two layer 3 inspection devices

The Terraform does not automatically deploy an SSL Orchestrator Topology configuration. However, it does generate an Ansible Variables file that can be used with the accompanying Ansible playbook to deploy an Inbound Layer 3 Topology. You can also manually configure and deploy the Topology instead.


## Project Development ##

This template was developed and tested in the **AWS US-East-1** region with the following versions:

- Terraform v1.1.8 / AWS Provider v3.75.1
- Terraform v0.14.5 / AWS Provider v3.57.0


## Usage ##

- From a web browser client - subscribe to the following EC2 instances:

  - https://aws.amazon.com/marketplace/pp?sku=5n807t93duw392y7t8v7nb1zv
  - https://aws.amazon.com/marketplace/pp?sku=758gbcgh7wafwchsq40cmj18j
  - https://aws.amazon.com/marketplace/pp?sku=9jk8duinsir94459457myhn4q
  - https://aws.amazon.com/marketplace/pp?sku=9jk8duinsir94459457myhn4q

- Obtain your programmatic access credentials for your AWS account: Access Key ID, Access Key, and Session Token.

- From inside your development environment - add a profile to you AWS credentials files or export the AWS credentials
  ```
  export AWS_ACCESS_KEY_ID="foo"
  export AWS_SECRET_ACCESS_KEY="foo"
  export AWS_SESSION_TOKEN="foo"
  ```

- From the terraform-aws-sslo folder - Copy the included **terraform.tfvars.example** file to **terraform.tfvars** and update the values (they will override the defaults from the *variables.tf* file):

  - Set a unique prefix value for object creation
  - Set a BIG-IP license key. You will need a BYOL SSL Orchestrator base registration key.
  - Set a unique name for the EC2 keypair. Terraform will create the keypair in AWS and also save it to the current folder.
  - Set the AWS region and availability (if different)
  - Set the AMI ID for SSL Orchestrator (**sslo_ami**) if you wish to use a different software version
  - Set the SSL Orchestrator instance type (if different). Ensure that you use an instance type that supports the 7 ENIs required for this deployment. This will usually be some variant of a **4xlarge** instance type.
  - Set your SSL Orchestrator **admin** user password (use a strong password!). Note: This is configured for demo/dev enviroments only. The recommended practice is to use a secrets manager like Secrets or Vault to store the password.

- From inside your development environment - deploy the Terraform configuration
  ```
  terraform init
  terraform validate
  terraform plan
  terraform apply -auto-approve
  ```

- If there are no errors, Terraform  will output several values, including the public IP address to access the SSL Orchestrator TMUI/API.


## Deleting the Deployment ##

When you are ready to delete your deployment
  ```
  terraform destroy
  ```


## Steps for Manual SSL Orchestrator Topology Configuration ##

**TODO: review and correct configuration object field name references**

- [optional] Upload a trusted SSL certificate and key before entering the SSL Orchestrator guide configuration UI

- Create an L3 Inbound topology

- Define SSL settings (using either the default or the previously uploaded certificate and key)

- Create the first inspection service
  - Enter a name for the service
  - Select a Layer 3 type from the service catalog
  - De-select automatic network configuration
  - Use **dmz1** as the To-Service VLAN
  - Enter the IP address of the inspection service (from Terraform outputs)
  - Use **dmz2** as the From-Service VLAN
  - Enable Port remapping (e.g., 8000)

- Create the second inspection service
  - Enter a name for the service
  - Select a different Layer 3 type from the service catalog
  - De-select automatic network configuration
  - Use **dmz3** as the To-Service VLAN
  - Enter the IP address of the inspection service (from Terraform outputs)
  - Use **dmz4** as the From-Service VLAN
  - Enable Port remapping (e.g., 9000)

- Create a Service Chain and add the first inspection service to it.

- Create a second Service Chain and add both inspection services to it.

- In the Egress settings, use automap and network default route

- In the Security Policy rules, add the first Service Chain to the Default rule.

- Create a new rule with **FILL IN THE BLANK** condition and apply the second Service Chain to it.

- Deploy the Topology configuration.


**Inbound Traffic Diagram**
*needs to be updated*

 ![f5](https://user-images.githubusercontent.com/18743780/134435723-a9216d8a-0cd7-463a-bda7-665eaaff9008.png)


<hr>

**Misc notes - to be cleaned up later**

- SSLO has ATC packages installed and DO provisions SSLO and sets networking up via runtime-init in the f5_onboard.tmpl

- This demo uses "Inspection" devices sitting in separate service chains to simulate real world deployments. These are a Linux hosts with Snort installed. Snort is not configured but it will bootstrap with appropriate routing and IP forwarding so that packets traverse the inspection zone and re-enter the dmz2/dmz4 interfaces.

- If the config fails, you should check where traffic is stopping.  A good place to start is at the F5. Do a tcpdump on the dmz1 and dmz3 interface...do you see traffic? yes then tcpdump the dmz2/dmz4 interface....traffic? no....then its probably the Inspection devices and it didnt bootstrap properly.

- SSH into the devices and check the route table, does it have a route to 10.0.2.0/24 via 10.0.4.23/10.0.7.23?

- Run these commands to fix the routing issue, change the IP on the dmz3/4 device to 10.0.7.23:
  ```
  sudo ip route add 10.0.2.0/24 via 10.0.4.23 dev eth2
  sudo sysctl -w net.ipv4.ip_forward=1
  ```
