#!/bin/bash

# fail on error
set -eu

# install yum-config-manager to manage repo
sudo yum install -y yum-utils

# add official HashiCorp Linux Repo
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# install tf
sudo yum -y install terraform

# verify
terraform --version
