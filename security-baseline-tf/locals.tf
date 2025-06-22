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

  #IAM policy
  iam_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject"
        ],
        Resource = "arn:aws:s3:::${local.config_bucket_name}/AWSLogs/*"
      },
      {
        Effect   = "Allow",
        Action   = "s3:GetBucketAcl",
        Resource = "arn:aws:s3:::${local.config_bucket_name}"
      },
      {
        Effect = "Allow",
        Action = [
          "config:Put*",
          "config:Get*",
          "config:Describe*"
        ],
        Resource = "*"
      }
    ]
  })

  kms_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # Allow root account full access
      {
        Sid: "RootAccess",
        Effect: "Allow",
        Principal: {
          AWS: "arn:aws:iam::${local.account_id}:root"
        },
        Action: "kms:*",
        Resource: "*"
      },

      # Allow CloudTrail to use the key to encrypt logs
      {
        Sid: "AllowCloudTrailEncrypt",
        Effect: "Allow",
        Principal: {
          Service: "cloudtrail.amazonaws.com"
        },
        Action: [
          "kms:GenerateDataKey*",
          "kms:Decrypt"
        ],
        Resource: "*",
        Condition: {
          StringLike: {
            "kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:us-east-1:${local.account_id}:trail/*"
          }
        }
      },

      # Allow S3 to use the key only for specific buckets
      {
        Sid: "AllowS3UseForCloudTrailAndConfig",
        Effect: "Allow",
        Principal: {
          Service: "s3.amazonaws.com"
        },
        Action: [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource: "*",
        Condition: {
          StringEquals: {
            "aws:SourceAccount": "${local.account_id}"
          },
          "StringLike": {
            "aws:SourceArn": [
              "arn:aws:s3:::sc-cloudtrail-log",
              "arn:aws:s3:::sc-config-log"
            ]
          }
        }
      },

      # Optional: allow your Terraform role or pipeline IAM role to use the key
      {
        Sid: "AllowTerraformRoleAccess",
        Effect: "Allow",
        Principal: {
          AWS: "arn:aws:iam::${local.account_id}:user/rajasekhar"
        },
        Action: [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource: "*"
      }
    ]
  })
}
