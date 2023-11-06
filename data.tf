locals {
  bucket_name = var.is_prefix ? lower(replace(substr(var.bucket_name, 0, 36), ".", "-")) : lower(replace(var.bucket_name, ".", "-"))
  bucket_policy = var.bucket_policy_document == null ? null : jsonencode({
    Version   = "2012-10-17"
    Statement = jsondecode(var.bucket_policy_document).Statement
  })
}

/*
S3 bucket names have some restrictions, and one of them is a limit on the total length of the bucket name.
The bucket name, when combined with the AWS region and other elements, forms a unique global resource name.
To ensure this length constraint is met, you might need to limit the number of characters in the bucket name.

By taking the first 36 characters of var.bucket_name, 
we are ensuring that the resulting S3 bucket name doesn't exceed any character limits. 
*/
