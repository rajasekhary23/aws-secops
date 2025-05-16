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
```
Ensure the script runs with an IAM role or user that has `s3:GetBucketAcl` permission.