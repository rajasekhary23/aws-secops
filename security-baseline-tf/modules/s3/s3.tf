#data "aws_caller_identity" "current" {}
#${data.aws_caller_identity.current.account_id}
resource "aws_s3_bucket" "main" {
  bucket        = var.bucket_name
  force_destroy = true
}

# Conditionally create policy only if enabled
resource "aws_s3_bucket_policy" "policy" {
  count  = var.enable_policy ? 1 : 0
  bucket = aws_s3_bucket.main.id
  policy = var.bucket_policy
}
