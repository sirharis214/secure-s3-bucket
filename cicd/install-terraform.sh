#!/bin/bash

# fail on error
set -eu

# Define the Terraform version to install
TERRAFORM_VERSION="1.5.6"

# install yum-config-manager to manage repo
sudo yum install -y yum-utils

# add official HashiCorp Linux Repo
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Install the specific version of Terraform
sudo yum -y install "terraform-${TERRAFORM_VERSION}"

# verify
terraform --version
