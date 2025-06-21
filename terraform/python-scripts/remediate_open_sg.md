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
```
Useful for remediation of overly permissive security group configurations.