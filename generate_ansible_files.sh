#!/bin/bash

# Run Terraform to provision infrastructure
terraform init -input=false -backend=false
terraform apply -auto-approve

# Retrieve output values from Terraform for Ansible inventory
master_ips=$(terraform output -raw master_ips)
worker_ips=$(terraform output -raw worker_ips)

# Generate Ansible inventory file
cat << EOF > ansible_inventory
[master]
${master_ips}

[worker]
${worker_ips}
EOF

# Generate Ansible configuration file
cat << EOF > ansible.cfg
[defaults]
inventory = ansible_inventory
remote_user = ubuntu
private_key_file = private_key.pem
EOF

# Generate private key file content
terraform output -raw private_key > private_key.pem
chmod 600 private_key.pem  # Set appropriate permissions for private key