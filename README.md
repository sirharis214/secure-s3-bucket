# secure-s3-bucket

Module that creates AWS S3 bucket

# Usage

## Bucket name is not a prefix

```hcl
locals = {
  tags = {
    module_name  = "file-backups"
    module_owner = "Test User" 
  }
}

module "example_bucket" {
  source                      = "git::https://github.com/sirharis214/secure-s3-bucket?ref=v0.0.1"
  
  bucket_name                 = "haris-example-bucket"
  is_prefix                   = false
  bucket_policy_document      = data.aws_iam_policy_document.this.json
  project_tags                = local.tags
}

output "bucket_name" {
  value = module.example_bucket.bucket
}
```

Incoming `var.project_tags` must include a tag named `module_name`, set to the name of the module you're provisioning this bucket in. In the above example, your resources would get tagged with:
```json
{
    "module_name":    "file-backups/secure-s3-bucket",
    "module_owner":   "Test User",
}
```

If you do not set `module_name` in `var.project_tags`, you will receive an error:
```bash
$: terraform plan
Error: Invalid index

  on modules/secure-s3-bucket/tags.tf line 3, in locals:
   3:     module_name = "${var.project_tags["module_name"]}/secure-s3-bucket"
    |----------------
    | var.project_tags is map of string with 2 elements

The given key does not identify an element in this collection value.
```

### Bucket Policy

Use `var.bucket_policy_document` to pass a JSON string to the module of the policy statements to be added to the bucket. **Do not** declare a Terraform `aws_s3_bucket_policy` resource outside of this module as this will create a perpetual drift between the module's resource policy and the caller's policy.

```hcl
module "example_bucket" {
  source                      = "git::https://github.com/sirharis214/secure-s3-bucket?ref=v0.0.1"
  bucket_name                 = local.bucket_name
  bucket_policy_document      = data.aws_iam_policy_document.this.json
  project_tags                = local.tags
}

data "aws_iam_policy_document" "this" {
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::987654321987:root",
      ]
    }
    actions   = [
      "s3:*",
    ]
    resources = [
      module.sample_bucket.bucket,
      "${module.sample_bucket.bucket}/*",
    ]
  }
}
```

## Usage with a Bucket Name Prefix

> :warning: If using a previous version of this module without the `var.is_prefix`, the bucket naming has changed within this module and your buckets may be destroyed on `terraform apply`.

The following will create a bucket that uses the bucket name as a prefix.

```hcl
locals = {
  tags = {
    module_name  = "file-backups"
    module_owner = "Test User" 
  }
}

module "example_bucket" {
  source                      = "git::https://github.com/sirharis214/secure-s3-bucket?ref=v0.0.1"
  
  bucket_name                 = "haris-example-bucket"
  bucket_policy_document      = data.aws_iam_policy_document.this.json
  project_tags                = local.tags
}

output "bucket_name" {
  value = module.example_bucket.bucket
}
```

The resulting bucket name will be `haris-example-bucket-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` where the x's are a random character.

## Argument Reference

* `project_tags` - (Required) Incoming project tags to be merged with local module tags. This must include a tag called `module_name`.

* `bucket_name` - (Required) Name of the bucket. Note that if `var.is_prefix=true` then the resulting bucket name will be the first 36 characters of this var.bucket_name, a dash, and 22 or more random characters.

* `is_prefix` - (Optional) Use the bucket name as a prefix, adding a random string to the end of the bucket name to avoid collisions. For example, if `var.bucket_name = mybucket` and this is set to true, then the bucket name will be `mybucket-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`.

* `is_public` - (Optional) True if the bucket is shared publically, false otherwise.

* `enable_ss3_se` - (Optional) Enable SSE-S3 instead of using SSE-KMS (KMS is recommended but some AWS services are not able to deliver to KMS buckets, such as Load Balancer access logs).

* `kms_id` - (Optional) AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when enable_ss3_se = false. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms 

* `bucket_policy_document` - (Optional) A JSON string of a resource policy with statements to add to the bucket resource policy. To create a policy to pass into this variable see [data source `aws_iam_policy_document`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document).


## Outputs Offered

* `bucket` - The name of the bucket. This is useful if you set the prefix variable in which case the bucket name will have a random string for a suffix.

* `bucket_arn` - The ARN of the bucket
