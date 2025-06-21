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
```
Requires IAM permissions to list users and delete login profiles.