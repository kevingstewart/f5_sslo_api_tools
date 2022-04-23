# SSL Orchestrator Topology Configuration using Ansible

This Ansible playbook will deploy an F5 SSL Orchestrator Inbound Layer 3 Topology.

The resulting Topology deployment will consist of the following:

- Inbound Layer 3 Topology
- 2 Layer 3 inspection devices
- 2 Service Chains
  - Service Chain 1 - inspection device 1
  - Service Chain 2 - inspection device 1, inspection device 2
- 2 Security Policy rules
  - default - Service Chain 1
  - XXXXX condition - Service Chain 2

The accompanying Terraform files generate an Ansible Variables file that can be used with this playbook. 

<br>

## Project Development ##
<hr>

This template was developed and tested with the following versions:

- SSL Ochestrator 7.5 / BIG-IP 15.1.1

<br>

## Usage ##
<hr>

- Deploy an Ansible config (after updating the YAML with correct IPs)

  ```
  ansible-playbook -i inventory/hosts playbooks/inbound-l3-complete.yaml
  ```

  