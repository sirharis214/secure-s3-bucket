resource "aws_s3_bucket" "this" {
  bucket        = var.is_prefix ? null : local.bucket_name
  bucket_prefix = var.is_prefix ? "${local.bucket_name}-" : null
  tags          = local.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.enable_ss3_se ? null : var.kms_id
      sse_algorithm     = var.enable_ss3_se ? "AES256" : "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = !var.is_public
  block_public_policy     = !var.is_public
  ignore_public_acls      = !var.is_public
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "this" {
  for_each = var.bucket_policy_document == null ? [] : [1]

  bucket = aws_s3_bucket.this.id
  policy = local.bucket_policy
}
