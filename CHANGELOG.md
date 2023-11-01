# v0.0.1

* state of CHANGELOG.md
* update logs for codebuild project
* updated buildspec-plan.yml for storing artifacts
* removed S3 ACL
* try CodeBuild-apply job
* added cache bucket to plan and apply
* new kms ket encryption
* re-structure both build specs
* provider assume role tf_management
* test wrong external_id
* Secret Manager Role aws-haris-sandbox-terraform-management, allows role cicd to assume
* Going to keep the SM same, going to update the permission on who can assume to someone other than cicd