import boto3
import gzip
import json

def parse_cloudtrail_event(file_path):
    with gzip.open(file_path, 'rt') as f:
        data = json.load(f)
        for record in data['Records']:
            if record['userIdentity']['type'] == 'Root':
                print(f"Root activity detected: {record['eventName']} on {record['eventTime']}")