#!/bin/bash

# fail on any error
set -eu

# go to root; out of cicd dir
# cd ..

# init
terraform init

# plan and apply
if terraform apply -auto-approve -no-color -input=false plan.out; then
    echo "Terraform apply successful."
else
    # If terraform apply fails, capture and echo the error message
    echo "Terraform apply failed. Error details:"
    terraform show -json plan.out | jq '.planned_values.root_module.resources[] | select(.change.actions[] | contains("create") or contains("update") or contains("delete")).change.after' | jq -r
    exit 1
fi
