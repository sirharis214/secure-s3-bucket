#!/bin/bash

# fail on any error
set -eu

# go to root; out of cicd dir
cd ..

# init
terraform init

# plan
terraform apply -auto-approve -no-color -input=false plan.out
