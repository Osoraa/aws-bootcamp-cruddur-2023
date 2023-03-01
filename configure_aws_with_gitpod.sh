#!/bin/bash
set -e

# Move into temporary directory
OLD_DIR="$PWD"
TMP_DIR="$(mktemp -d)"
echo "Installing AWS"
cd $TMP_DIR || exit 1

# Install and update AWS CLI
curl -fsSl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qq awscliv2.zip
sudo ./aws/install --update

# Remove temporary folder
cd $OLD_DIR
rm -rf $TMP_DIR

# AWS config
cat <<- AWSFILE > /home/gitpod/.aws/config
[default]
# sso_start_url = ${AWS_SSO_URL}
# sso_region = ${AWS_SSO_REGION}
account_id = ${AWS_ACCOUNT_ID}
role_name = ${AWS_ROLE_NAME}
region = ${AWS_REGION}
output = ${yaml}
AWSFILE

# AWS credentials
cat <<- AWSFILE > /home/gitpod/.aws/credentials
[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
# aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
# region = ${AWS_SSO_REGION}
# sso_role_name = ${AWS_ROLE_NAME}
# region = ${AWS_REGION}
AWSFILE
