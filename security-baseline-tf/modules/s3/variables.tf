variable "region" {
  description = "AWS region"
  type = string
}

variable "kms_key_id" {
  description = "kms key id"
  type = string
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "enable_policy" {
  description = "Whether to apply the bucket policy"
  type        = bool
  default     = false
}

variable "bucket_policy" {
  description = "Optional bucket policy in JSON format"
  type        = string
  default     = ""
}
