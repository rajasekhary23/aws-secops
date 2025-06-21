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
```
Ensure the input file is a CloudTrail log in the correct compressed JSON format.