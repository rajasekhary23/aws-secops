module "security_baseline" {
  source              = "./modules/security_baseline"
  region              = "us-east-1"
  cloudtrail_s3_bucket = "my-org-cloudtrail-logs"
  config_s3_bucket     = "my-org-config-logs"
  config_role_arn      = "arn:aws:iam::123456789012:role/aws-config-role"
}
