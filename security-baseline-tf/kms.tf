
resource "aws_kms_key" "kms_key" {
  description         = "KMS key encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  policy = local.kms_policy
  
  tags = {
    Name = "Encryption-key"
    Owner = "YRS"
  }
}

resource "aws_kms_alias" "main" {
  name          = "alias/speedcloud-kms"  #${join("-", slice(split("-", var.bucket_name), 0, 3))}
  target_key_id = aws_kms_key.kms_key.key_id
}