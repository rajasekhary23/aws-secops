# AWS SecOps Preparation

This repository provides practical Infrastructure as Code (IaC), automation scripts, and policy controls to help prepare for cloud security engineering interviews and real-world cloud security operations.

---

## 📁 Directory Structure

```
aws-secops-prep/
├── terraform/              # Terraform modules for AWS security services
├── python-scripts/         # Python scripts for automating security checks/remediation
├── scp/                    # AWS Service Control Policies
├── cheat-sheet.md          # 1-page summary of AWS security best practices
├── interview-questions.md  # Interview question list
└── README.md               # This file
```

---

## 🔐 AWS Security Services & Topics

### 🔎 AWS Config
Tracks and audits resource configurations. Enables compliance automation through **managed rules**.
- Example: Ensuring S3 buckets have encryption enabled.

### 🛡️ GuardDuty
Threat detection service for identifying unexpected behaviors like port scanning, compromised instances, or credential misuse.

### 🔍 Security Hub
Centralized security view across AWS accounts. Aggregates findings from tools like GuardDuty, Inspector, IAM Access Analyzer, and more.

### 📜 CloudTrail
Records all API activity within an AWS environment. Essential for forensic analysis and compliance.

### 📊 VPC Flow Logs
Captures traffic information at the network interface level. Useful for anomaly detection and troubleshooting.

### 📜 SCP (Service Control Policies)
Org-level guardrails in AWS Organizations. Prevent misconfigurations or risky deployments across all accounts.

### 🔐 IAM Best Practices
- Use **least privilege** principle.
- Enforce **MFA**.
- Disable **inactive users** and rotate access keys regularly.
- Apply **permissions boundaries** and **conditions**.

---

## ☁️ Terraform Modules

- `s3_secure.tf`: Enforces encryption, logging, versioning, and lifecycle rules.
- `config_rules.tf`: Enables security configuration rules (e.g., S3 encryption check).
- `guardduty.tf`: Automates GuardDuty setup across AWS Organizations.
- `securityhub.tf`: Bootstraps Security Hub and configures org-level onboarding.
- `wafv2.tf`: Sets up WAFv2 with managed rule sets (AWSManagedRulesCommonRuleSet).

---

## 🐍 Python Automation Scripts

- `find_unencrypted_s3.py`: Detects S3 buckets without server-side encryption.
- `disable_inactive_iam.py`: Disables IAM users not used in the last 90 days.
- `cloudtrail_parser.py`: Detects suspicious root account activity.
- `detect_public_s3.py`: Identifies publicly accessible S3 buckets.
- `remediate_open_sg.py`: Revokes port 22 access from 0.0.0.0/0 in security groups.

---

## 🛡️ SCP Examples

- `deny_not_in_region.json`: Deny actions not in approved regions.
- `require_mfa.json`: Deny IAM actions without MFA.

---

## 🧠 Interview Focus Topics

- Cloud-native security architecture.
- Vulnerability management and remediation in AWS.
- Secure multi-account design.
- Infrastructure as Code (Terraform).
- Python for security automation.
- Compliance: SOC2, PCI DSS, NIST 800-53.
- Threat modeling and incident response in cloud environments.

---

## 📘 References

- [AWS Security Best Practices](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards.html)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Python Boto3 AWS SDK](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)