# Creating S3 bucket to log all the events for cloudtrail
module "cloudtrail_s3_bucket" {
  source        = "./modules/s3"
  bucket_name   = local.cloudtrail_bucket_name
  enable_policy = true
  bucket_policy = local.cloudtrail_policy
}

output "cloudtrailbucket_name" {
  value = module.cloudtrail_s3_bucket.bucket_name
}

# Creating S3 bucket to log all the events for cloudtrail
module "config_s3_bucket" {
  source        = "./modules/s3"
  bucket_name   = local.config_bucket_name
  enable_policy = true
  bucket_policy = local.config_policy
}

output "configbucket_name" {
  value = module.config_s3_bucket.bucket_name
}

# Enabling security_baseline
module "security_baseline" {
  source               = "./modules/security_baseline"
  region               = "us-east-1"
  cloudtrail_s3_bucket = local.cloudtrail_bucket_name
  config_s3_bucket     = local.config_bucket_name
  config_role_arn      = "arn:aws:iam::085979823455:role/aws-config-role"
}