# v0.0.3
* fix caller provided JSON string of a policy document with statements, defaults to null
* fix resource aws_s3_bucket_policy's loop to use count instead of for_each

# v0.0.2
* beginning of CHANGELOG.md
* var.kms_id default to null, only required is enable_ss3_se = false
