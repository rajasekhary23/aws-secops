# AWS Security Baseline Terraform Module

This Terraform module sets up the following AWS security services in each account:

- **AWS CloudTrail** (multi-region)
- **AWS Config**
- **GuardDuty**
- **Security Hub** (with CIS AWS Foundations Benchmark)

It supports centralized logging to a security/account-wide S3 bucket.

---

## 🔐 Prerequisites

### 1. Centralized Logging S3 Buckets

Create these two buckets in a designated **security/logging account**:

- CloudTrail bucket (e.g., `my-org-cloudtrail-logs`)
- AWS Config bucket (e.g., `my-org-config-logs`)

Make sure both have cross-account access policies like:

#### 📘 CloudTrail Bucket Policy
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Allow CloudTrail from other accounts",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::my-org-cloudtrail-logs/AWSLogs/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Sid": "Allow bucket listing",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::my-org-cloudtrail-logs"
    }
  ]
}
