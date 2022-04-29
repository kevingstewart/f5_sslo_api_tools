# SSL Orchestrator Topology Configuration using Ansible

This Ansible playbook will deploy an F5 SSL Orchestrator Inbound Layer 3 Topology.

The resulting Topology deployment will consist of the following:

- Inbound Layer 3 Topology
- 2 Layer 3 inspection devices (usually different types of L3 devices - this example uses the same type for demonstration purposes)
- 2 Service Chains
  - Service Chain 1 - Inspection device 1
  - Service Chain 2 - Inspection device 1, Inspection device 2
- 2 Security Policy rules
  - Internal traffic sourced from 10.0.0.0/8 subnets -> Service Chain 1
  - All other TLS traffic on TCP/443 -> Service Chain 2


The accompanying Terraform files generate an Ansible variables file (ansible_vars.yaml) that can be used with this playbook. 


## Project Development ##

This template was developed and tested with the following versions:

- SSL Ochestrator 7.5 / BIG-IP 15.1.1


## Usage ##

- Option 1: Deploy an Ansible config using the variables file that was created by the accompanying Terraform.

  From the 'ansible' folder:

  ```
  cp ../terraform-aws-sslo/ansible_vars.yaml .
  ansible-playbook -e @ansible_vars.yaml playbooks/inbound-l3-complete.yaml
  ```

- Option 2: Deploy an Ansible config with your own variables file.

  Use the 'ansible_vars.yaml.example' file as a template to create a custom 'ansible_vars.yaml' file and then update the variable values.

  From the 'ansible' folder:

   ```
  cp playbooks/ansible_vars.yaml.example ansible_vars.yaml
  vi ansible_vars.yaml
  ansible-playbook -e @ansible_vars.yaml playbooks/config-sslo-inbound-l3-complete.yaml
  ```
