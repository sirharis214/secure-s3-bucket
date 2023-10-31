terraform {
  # Terraform core should be pinned to a minor version
  required_version = "= 1.5.6"
  required_providers {
    # Providers should be pinned to a major version
    # The provider source should always be specified
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.14.0"
    }
  }
  backend "s3" {
    region = "us-east-1"
    bucket = "aws-haris-sandbox20230828153749772900000001"
    key    = "terraform/secure-s3-bucket/terraform.tfstate"
  }
}

provider "aws" {
  # Update with your desired region
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::594924424566:role/aws-haris-sandbox-terraform-management"
    external_id  = "A3B7K9E-R3T8-G6H8-J4Y5-MN6PQ8r"
    session_name = "secure-s3-bucket-dev" # repo-branch ; module-workspace
  }
}
