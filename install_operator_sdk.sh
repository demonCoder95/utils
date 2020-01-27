#!/bin/bash

# This script automates the installation process of operator-sdk for building k8s operators!
# Author: Noor
# Date: January 27, 2019

# Note:
# This script will download files in the current directory for binary verification!

# Set the release version variable
RELEASE_VERSION=v0.15.0

echo "[DEBUG] Downloading the operator-sdk release binary..."

# Get the release binary
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu

echo "[DEBUG] Finished downloading the binary."
echo "[DEBUG] Downloading the Armored ASCII Digital Signature..."
# Get the Armored ASCII for binary verification - has the digital signature of the operator-framework maintainers public key
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu.asc

echo "[DEBUG] Finished downloading the signature"

echo "[DEBUG] Verifying the binary with the signature..."
# Installing the RSA key in gpg
KEY_ID="082F7CAC"
gpg --keyserver keyserver.ubuntu.com --recv-key $KEY_ID
# Verify binary with gpg
gpg --verify operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu.asc

echo "[DEBUG] Finished verifying the binary"
echo "[DEBUG] Installing the binary..."

# Install the binary in the system
chmod +x operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu && sudo mkdir -p /usr/local/bin/ && sudo cp operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu /usr/local/bin/operator-sdk && rm operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu

echo "[DEBUG] Binary Installed. Everything set!"
