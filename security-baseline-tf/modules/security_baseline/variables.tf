variable "region" {
  description = "AWS region"
  type        = string
}

variable "cloudtrail_s3_bucket" {
  description = "S3 bucket name for CloudTrail"
  type        = string
}

variable "config_s3_bucket" {
  description = "S3 bucket name for AWS Config"
  type        = string
}

variable "config_role_arn" {
  description = "IAM Role ARN for AWS Config"
  type        = string
}
