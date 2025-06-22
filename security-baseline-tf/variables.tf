variable "region" {
  type    = string
  default = "us-east-1"
}
variable "cloudtrail_s3_bucket_name" {
  type    = string
  default = "speedcloud-cloudtrail-logs"
}

variable "config_s3_bucket_name" {
  type    = string
  default = "speedcloud-config-logs"
}