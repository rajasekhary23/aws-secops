module "security_baseline" {
  source               = "./modules/security_baseline"
  region               = "us-east-1"
  cloudtrail_s3_bucket = "speedcloud-cloudtrail-logs"
  config_s3_bucket     = "speedcloud-config-logs"
  config_role_arn      = "arn:aws:iam::085979823455:role/aws-config-role"
}
