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

# Configure AWS credentials

