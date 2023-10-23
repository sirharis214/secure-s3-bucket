#!/bin/bash

# fail on any error
set -eu

# go to root; out of cicd dir
cd ..

# init
terraform init

# plan
terraform plan -no-color -input=false -refresh=false -out=plan.out
