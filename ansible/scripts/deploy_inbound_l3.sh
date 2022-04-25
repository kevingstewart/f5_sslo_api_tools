#!/bin/bash
echo ""
echo "This will deploy an SSL Orchestrator Inbound Layer 3 Topology"
echo "using the ansible_vars.yaml file created by the accompanying Terraform."
echo ""
read -r -p "Are you sure? [y/N] " response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    cp ../terraform-aws-sslo/ansible_vars.yaml .
    ansible-playbook -e @ansible_vars.yaml playbooks/inbound-l3-complete.yaml
else
    echo "Cancelled"
fi
