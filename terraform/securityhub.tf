resource "aws_securityhub_account" "this" {}

resource "aws_securityhub_organization_admin_account" "admin" {
  admin_account_id = var.admin_account_id
}

resource "aws_securityhub_organization_configuration" "org_config" {
  auto_enable = true
}