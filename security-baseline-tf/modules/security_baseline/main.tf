provider "aws" {
  region = var.region
}

# CloudTrail
resource "aws_cloudtrail" "main" {
  name                          = "${split("-",var.cloudtrail_s3_bucket)[0]}-trail" #"org-trail" 
  s3_bucket_name                = var.cloudtrail_s3_bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  enable_logging                = true
}

# AWS Config
resource "aws_config_configuration_recorder" "main" {
  name     = "${split("-",var.config_s3_bucket)[0]}-config"
  role_arn = var.config_role_arn
  recording_group {
    all_supported = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "main" {
  name           = aws_config_configuration_recorder.main.name
  s3_bucket_name = var.config_s3_bucket
  depends_on     = [aws_config_configuration_recorder.main]
}

resource "aws_config_configuration_recorder_status" "main" {
  name     = aws_config_configuration_recorder.main.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.main]
}

# GuardDuty
resource "aws_guardduty_detector" "main" {
  enable = true
}

# Security Hub
resource "aws_securityhub_account" "main" {}

resource "aws_securityhub_standards_subscription" "cis" {
  #Use below command to check available CIS standards
  # aws securityhub enable-security-hub --region us-east-1
  # aws securityhub describe-standards
  standards_arn = "arn:aws:securityhub:us-east-1::standards/cis-aws-foundations-benchmark/v/1.4.0"
  depends_on    = [aws_securityhub_account.main]
}
