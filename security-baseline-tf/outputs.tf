output "aws_config_role_arn" {
  description = "ARN of the IAM role used by AWS Config"
  value       = aws_iam_role.aws_config_role.arn
}

output "cloudtrailbucket_name" {
  value = module.cloudtrail_s3_bucket.bucket_name
}

output "configbucket_name" {
  value = module.config_s3_bucket.bucket_name
}