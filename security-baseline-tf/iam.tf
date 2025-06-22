resource "aws_iam_role" "aws_config_role" {
  name = "AWSConfigRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "config.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "aws_config_policy" {
  name        = "AWSConfigPolicy"
  description = "IAM policy for AWS Config to write to the config logs bucket"

  policy = local.iam_policy
}

resource "aws_iam_role_policy_attachment" "aws_config_policy_attach" {
  role       = aws_iam_role.aws_config_role.name
  policy_arn = aws_iam_policy.aws_config_policy.arn
}
