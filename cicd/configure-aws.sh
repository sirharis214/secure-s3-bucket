#!/bin/bash

# fail on any error
set -eu

# configure aws
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $aws_secret_access_key
aws configure set region $AWS_REGION

# verify
aws configure list
