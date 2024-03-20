#!/bin/bash
terraform validate
terraform plan
terraform apply -auto-approve