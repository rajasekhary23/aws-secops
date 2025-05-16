import boto3
from datetime import datetime, timezone, timedelta

iam = boto3.client('iam')
now = datetime.now(timezone.utc)
cutoff = now - timedelta(days=90)

for user in iam.list_users()['Users']:
    login_profile = iam.get_login_profile(UserName=user['UserName'])
    last_used = iam.get_user(UserName=user['UserName'])['User']['PasswordLastUsed']
    if last_used < cutoff:
        print(f"Disabling user {user['UserName']}")
        iam.delete_login_profile(UserName=user['UserName'])