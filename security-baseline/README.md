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

#### 📘 Config Bucket Policy
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Allow Config from all accounts",
      "Effect": "Allow",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::my-org-config-logs/AWSLogs/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Sid": "Allow bucket ACL check",
      "Effect": "Allow",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::my-org-config-logs"
    }
  ]
}

### 2. IAM Role for AWS Config
In each account, create an IAM role (e.g., aws-config-role) with:

Trusted entity: AWS Config

Permissions:

AWSConfigRole

AmazonS3FullAccess (or specific S3 permissions for the config bucket)

### 3. Enable GuardDuty and Security Hub in all AWS regions
This module enables these services in the specified region. To ensure all-region coverage, either:

Use this module per region

Use AWS Organizations features for auto-enablement

## 🚀 Usage
Update the root module with your account details:
```hcl
module "security_baseline" {
  source               = "./modules/security_baseline"
  region               = "us-east-1"
  cloudtrail_s3_bucket = "my-org-cloudtrail-logs"
  config_s3_bucket     = "my-org-config-logs"
  config_role_arn      = "arn:aws:iam::123456789012:role/aws-config-role"
}

Then deploy with:
```bash
terraform init
terraform plan
terraform apply

## 📝 Notes
You can extend this module to include centralized GuardDuty and Security Hub administrators.

Consider automating this across accounts using StackSets or a CI/CD pipeline with role switching.

Store state securely in a remote backend (e.g., S3 + DynamoDB locking).

## 📌 Module Structure
```css
security-baseline/
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
└── modules/
    └── security_baseline/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
