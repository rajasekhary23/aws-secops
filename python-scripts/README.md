# find_unencrypted_s3.py

## Purpose
This script identifies Amazon S3 buckets that do not have server-side encryption enabled.

## How it Works
- Uses the `boto3` SDK to list all S3 buckets.
- For each bucket, attempts to retrieve encryption settings.
- If encryption is not configured, it logs the bucket as unencrypted.

## Usage
```bash
python find_unencrypted_s3.py

---

### `disable_inactive_iam.md`

```markdown
# disable_inactive_iam.py

## Purpose
This script disables IAM users who haven't logged in via the AWS Console in the last 90 days.

## How it Works
- Lists all IAM users.
- Checks the `PasswordLastUsed` field for inactivity.
- Deletes the login profile of users who haven't logged in within 90 days, effectively disabling their console access.

## Usage
```bash
python disable_inactive_iam.py

---

### `cloudtrail_parser.md`

```markdown
# cloudtrail_parser.py

## Purpose
This script parses AWS CloudTrail logs (gzipped JSON files) to identify root account activity.

## How it Works
- Reads a gzip-compressed CloudTrail log file.
- Parses JSON content and filters for records involving the root user.
- Prints event name and timestamp for any root activity detected.

## Usage
```python
parse_cloudtrail_event("example_log_file.json.gz")

---

### `detect_public_s3.md`

```markdown
# detect_public_s3.py

## Purpose
Identifies publicly accessible S3 buckets by checking bucket ACLs.

## How it Works
- Lists all S3 buckets in the account.
- For each bucket, fetches its ACL and checks for the `AllUsers` group.
- Flags any bucket that grants public access.

## Usage
```bash
python detect_public_s3.py

---

### `remediate_open_sg.md`

```markdown
# remediate_open_sg.py

## Purpose
This script detects and remediates open security groups allowing SSH (port 22) from 0.0.0.0/0.

## How it Works
- Uses `boto3` to describe all security groups.
- Searches for inbound rules allowing 0.0.0.0/0 on TCP port 22.
- Removes those rules using `revoke_security_group_ingress`.

## Usage
```bash
python remediate_open_sg.py

