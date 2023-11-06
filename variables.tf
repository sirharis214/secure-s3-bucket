variable "project_tags" {
  type        = map(string)
  description = "Incoming terraform tags to be merged with local project tags"
}

variable "bucket_name" {
  type        = string
  description = "name of S3 bucket"
}

variable "is_prefix" {
  type        = bool
  description = "if bucket_name is a prefix, use bucket_prefix when creating resource, no need to provide a trailing - ."
  default     = true
}

variable "is_public" {
  type        = bool
  description = "is the bucket shared publically"
  default     = false
}

variable "enable_ss3_se" {
  type        = bool
  description = "Enable SSE-S3 encryption instead of using SSE-KMS."
  default     = true
}

variable "kms_id" {
  type = string
  description = "If enable_ss3_se false, then provide KMS key id"
  default = null
}

variable "bucket_policy_document" {
  type        = string
  description = "JSON string of a policy document with statements to apply to the bucket resource policy."
  default     = null # "{\"Statement\":[]}"
}
