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
```
Make sure your AWS credentials are set via environment variables, AWS config file, or IAM role.