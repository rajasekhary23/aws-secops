# Creating S3 bucket to log all the events for cloudtrail
module "cloudtrail_s3_bucket" {
  region        = var.region
  source        = "./modules/s3"
  bucket_name   = local.cloudtrail_bucket_name
  enable_policy = true
  bucket_policy = local.cloudtrail_policy
  kms_key_id = aws_kms_key.kms_key.key_id
}

# Creating S3 bucket to log all the events for cloudtrail
module "config_s3_bucket" {
  region        = var.region
  source        = "./modules/s3"
  bucket_name   = local.config_bucket_name
  enable_policy = true
  bucket_policy = local.config_policy
  kms_key_id = aws_kms_key.kms_key.key_id
}

# Enabling security_baseline
module "security_baseline" {
  source               = "./modules/security_baseline"
  region               = var.region
  kms_key_id           = aws_kms_key.kms_key.arn
  cloudtrail_s3_bucket = local.cloudtrail_bucket_name
  config_s3_bucket     = local.config_bucket_name
  config_role_arn      = aws_iam_role.aws_config_role.arn #"arn:aws:iam::085979823455:role/aws-config-role"
}