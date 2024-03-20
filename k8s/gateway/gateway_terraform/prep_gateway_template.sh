#!/bin/bash
ssh -i ~/.ssh/pve root@pve 'bash -s' < gateway_template.sh
terraform validate
terraform plan
# terraform apply -auto-approve
