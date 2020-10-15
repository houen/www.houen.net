---
layout: post
title: AWS CLI setup of AWS Transfer S3 SFTP server with user and password authentication
description: Easy AWS CLI commands to set up an AWS Transfer S3 server with user and password authentication
summary: I wanted to go with a cleaner look and feel. I think the theme achieves that very nicely.
tags: [meta]
---

I recently needed to set up S3-backed FTP server (SFTP actually) for work.

After googling and reading the related AWS documentation I figured out how to do it, 
but it seemed to me that it was harder than it really needed to be. Here I try to explain how to do it in a simple way using AWS CLI.

## Prerequisites
- AWS CLI `brew install aws`
- An AWS root user with set up AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY. 
See [here](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html) for how under "Programmatic access"


Check that AWS CLI is installed with `aws`. You should get output similar to this:
```
➜  www.houen.net git:(master) ✗ aws                                            19:12:16
usage: aws [options] <command> <subcommand> [<subcommand> ...] [parameters]
```

## Setup
### Authenticate with AWS CLI and set default region
First, you need to authenticate with AWS, and set the region you will be working in. 
Do this by exporting AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and AWS_DEFAULT_REGION. Replace "..." with your values.
```
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
export AWS_DEFAULT_REGION="..."
```

Test it out with: `aws s3 ls`. If you did it wrong you get this:
```
➜  www.houen.net git:(master) ✗ aws s3 ls                                      19:19:45
Unable to locate credentials. You can configure credentials by running "aws configure".
```

If you did it right, you get a (maybe empty) list of your S3 buckets.

### Set your config vars
```
S3_BUCKET_NAME="my-aws-transfer-sftp-server-bucket"

CF_STACK_NAME="My-AWS-Transfer-SFTP-Server-Stack"
CF_TEMPLATE_URL="https://s3.amazonaws.com/aws-transfer-resources/custom-idp-templates/aws-transfer-custom-idp-secrets-manager-apig.template.yml"

# IAM policy name
iam_policy_name="aws-transfer-s3-sftp-bucket-access-$username"
# IAM policy document path
iam_policy_doc_path="$DIR/config/s3_ftp_access_iam_policy.json"
iam_user_policy_doc_path="$DIR/config/s3_ftp_access_iam_policy_$username.json"
# IAM role name
iam_role_name="aws-transfer-s3-sftp-bucket-access-$username"
# Secret name
secret_name="SFTP/$username"
# Users home directory in the bucket. They are locked to this directory and subdirectories
bucketdir="/partner-uploads/$username"
homedir="/aws-transfer-s3-ftp/partner-uploads/$username"
```

### Set it all up
```
aws s3api create-bucket --bucket "$S3_BUCKET_NAME"

# Create Cloudformation stack for API Gateway
# CAPABILITY_IAM is a flag for CloudFormation to confirm that it can create an IAM role
cf_stack_arn=$(aws cloudformation create-stack \
    --capabilities CAPABILITY_IAM \
    --template-url $CF_TEMPLATE_URL \
    --stack-name $CF_STACK_NAME \
    --output text) 

server_id=$(aws cloudformation describe-stacks \
    --query "Stacks[?StackName=='$CF_STACK_NAME'].Outputs[0][?OutputKey=='ServerId'].OutputValue" \
    --output text)
```


---
## Sources
- https://aws.amazon.com/blogs/storage/enable-password-authentication-for-aws-transfer-for-sftp-using-aws-secrets-manager/
- https://aws.amazon.com/premiumsupport/knowledge-center/sftp-iam-user-cli/
