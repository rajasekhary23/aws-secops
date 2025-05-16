resource "aws_s3_bucket" "secure_bucket" {
  bucket = "my-secure-bucket"
  versioning { enabled = true }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = "my-logging-bucket"
    target_prefix = "log/"
  }

  acl = "private"

  lifecycle_rule {
    enabled = true
    noncurrent_version_expiration { days = 30 }
  }
}