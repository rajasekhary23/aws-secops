# Data block to get account ID
data "aws_caller_identity" "current" {}

# local variables
locals {
  account_id             = data.aws_caller_identity.current.account_id
  cloudtrail_bucket_name = "${var.cloudtrail_s3_bucket_name}-${local.account_id}"
  config_bucket_name     = "${var.config_s3_bucket_name}-${local.account_id}"
  cloudtrail_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowCloudTrailWrite",
        Effect = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action   = "s3:PutObject",
        Resource = "arn:aws:s3:::${local.cloudtrail_bucket_name}/AWSLogs/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },
      {
        Sid    = "AllowCloudTrailACL",
        Effect = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action   = "s3:GetBucketAcl",
        Resource = "arn:aws:s3:::${local.cloudtrail_bucket_name}"
      }
    ]
  })
  config_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Allow Config from all accounts",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "config.amazonaws.com"
        },
        "Action" : "s3:PutObject",
        "Resource" : "arn:aws:s3:::${local.config_bucket_name}/AWSLogs/*",
        "Condition" : {
          "StringEquals" : {
            "s3:x-amz-acl" : "bucket-owner-full-control"
          }
        }
      },
      {
        "Sid" : "Allow bucket ACL check",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "config.amazonaws.com"
        },
        "Action" : "s3:GetBucketAcl",
        "Resource" : "arn:aws:s3:::${local.config_bucket_name}"
      }
    ]
  })
}
