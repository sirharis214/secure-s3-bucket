locals {
  provider_role_arn    = "${jsondecode(data.aws_secretsmanager_secret_version.codebuild_provider_assume_role.secret_string)["role_arn"]}"
  provider_external_id = "${jsondecode(data.aws_secretsmanager_secret_version.codebuild_provider_assume_role.secret_string)["external_id"]}"
}

data "aws_secretsmanager_secret" "codebuild_provider_assume_role" {
  name = "CodeBuild.AwsHarisSandbox.TerraformManagement.ExternalId"
}

data "aws_secretsmanager_secret_version" "codebuild_provider_assume_role" {
  secret_id = data.aws_secretsmanager_secret.codebuild_provider_assume_role.id
}
