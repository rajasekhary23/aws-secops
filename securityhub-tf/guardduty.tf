resource "aws_guardduty_detector" "main" {
  enable = true
}

resource "aws_guardduty_organization_admin_account" "admin" {
  admin_account_id = var.admin_account_id
}

resource "aws_guardduty_organization_configuration" "org_config" {
  detector_id = aws_guardduty_detector.main.id
  auto_enable = "ALL_MEMBERS"
}