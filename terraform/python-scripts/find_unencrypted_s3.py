import boto3

s3 = boto3.client('s3')
buckets = s3.list_buckets()

for bucket in buckets['Buckets']:
    name = bucket['Name']
    try:
        enc = s3.get_bucket_encryption(Bucket=name)
        rules = enc['ServerSideEncryptionConfiguration']['Rules']
        print(f"{name} is encrypted with: {rules[0]['ApplyServerSideEncryptionByDefault']['SSEAlgorithm']}")
    except Exception as e:
        print(f"{name} has no encryption: {e}")