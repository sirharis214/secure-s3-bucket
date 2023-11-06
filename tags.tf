locals {
  module_tags = {
    module_name = join("/", compact([
      lookup(var.project_tags, "module_name", null),
      "secure-s3-bucket"
    ]))
    module_repo = "https://github.com/sirharis214/secure-s3-bucket"
  }
  tags = merge(var.project_tags, local.module_tags)
}
