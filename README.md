# F5 SSL Orchestrator API Project Tools

This project contains:

- Ansible folders, F5 Ansible collection, and sample playbooks
- Terraform templates for AWS

To use:

- From local browser - subscribe to following EC2 instances:
  - https://aws.amazon.com/marketplace/pp?sku=5n807t93duw392y7t8v7nb1zv
  - https://aws.amazon.com/marketplace/pp?sku=758gbcgh7wafwchsq40cmj18j
  - https://aws.amazon.com/marketplace/pp?sku=9jk8duinsir94459457myhn4q
  - https://aws.amazon.com/marketplace/pp?sku=9jk8duinsir94459457myhn4q


- From inside your development environment - export AWS tokens
  ```
  export AWS_ACCESS_KEY_ID="foo"
  export AWS_SECRET_ACCESS_KEY="foo"
  export AWS_SESSION_TOKEN="foo"
  ```

- From local code/terraform-aws-sslo folder - update values:
  - Add BIG-IP (eval) license to f5_onboard.tmpl
  - Modify prefix variable in variables.tf
  - Add keypair name to ec2_key_name in variables.tf
  - Create keypair in AWS console and download to current folder

- From inside your development environment - launch Terraform template
  ```
  cd terraform-aws-sslo
  terraform init
  terraform plan
  terraform apply -auto-approve
  ```

- Force installation of the on-box SSLO RPM
  ```
  export BIGIP="34.234.171.124"
  curl -sku 'admin:f5Twister!' -H 'Content-Type: application/json' -X POST "https://${BIGIP}/mgmt/shared/iapp/stage-package-install" -d '{"packagePath":"/usr/share/packages/f5-iappslx-ssl-orchestrator/f5-iappslx-ssl-orchestrator-15.1.0-7.5.2.noarch.rpm"}'
  curl -sku 'admin:f5Twister!' -H 'Content-Type: application/json' -X POST "https://$BIGIP/mgmt/shared/iapp/package-management-tasks" -d '{"operation":"INSTALL","packageFilePath":"/var/config/rest/downloads/f5-iappslx-ssl-orchestrator-15.1.0-7.5.2.noarch.rpm"}'
  ```

- Deploy an Ansible config (after updating the YAML with correct IPs)
  ```
  cd ../ansible
  ansible-playbook -i inventory/hosts playbooks/inbound-l3-complete.yaml
  ```

  