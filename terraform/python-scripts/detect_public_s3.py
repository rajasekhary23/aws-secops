import boto3

s3 = boto3.client('s3')

for bucket in s3.list_buckets()['Buckets']:
    name = bucket['Name']
    acl = s3.get_bucket_acl(Bucket=name)
    for grant in acl['Grants']:
        grantee = grant['Grantee']
        if grantee.get('URI') and 'AllUsers' in grantee['URI']:
            print(f"[!] Public bucket found: {name}")