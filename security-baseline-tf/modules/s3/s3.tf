#data "aws_caller_identity" "current" {}
#${data.aws_caller_identity.current.account_id}
resource "aws_s3_bucket" "main" {
  region        = var.region
  bucket        = var.bucket_name
  force_destroy = true
  
  tags = {
    Name  = "AWS ${split("-",var.bucket_name)[1]} Logs Bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "public_acls" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "logging" {
  bucket = aws_s3_bucket.main.id

  target_bucket = aws_s3_bucket.main.id
  target_prefix = "access-logs/"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse_kms" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "logs_lifecycle" {
  bucket = aws_s3_bucket.main.id
  
  rule {
    id      = "log-expiration-rule"
    status  = "Enabled"
    filter {
      prefix = "AWSLogs/"
    }
    transition {
      days          = 30
      storage_class = "GLACIER" #"STANDARD_IA"
    }
    expiration {
      days = 90
    }
    abort_incomplete_multipart_upload {
      days_after_initiation = 3
    }
  }
}
# Conditionally create policy only if enabled
resource "aws_s3_bucket_policy" "policy" {
  count  = var.enable_policy ? 1 : 0
  bucket = aws_s3_bucket.main.id
  policy = var.bucket_policy
}

