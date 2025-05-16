import boto3

ec2 = boto3.client('ec2')

sgs = ec2.describe_security_groups()['SecurityGroups']
for sg in sgs:
    for perm in sg['IpPermissions']:
        if perm.get('FromPort') == 22 and perm['IpRanges']:
            for ip_range in perm['IpRanges']:
                if ip_range['CidrIp'] == '0.0.0.0/0':
                    print(f"Revoking SSH from {sg['GroupId']}")
                    ec2.revoke_security_group_ingress(
                        GroupId=sg['GroupId'],
                        IpProtocol='tcp',
                        FromPort=22,
                        ToPort=22,
                        CidrIp='0.0.0.0/0'
                    )