#!/bin/bash

# Small utility script to install kubectl binary on a node
# Author: Noor
# Date: January 27, 2019

echo "[DEBUG] Getting the latest binary..."
# Get the latest binary
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

echo "[DEBUG] Installing kubectl..."
# Make the binary executable
chmod +x ./kubectl

# Move binary to the path
sudo mv ./kubectl /usr/local/bin/kubectl

echo "[DEBUG] Everything done!"

kubectl version --client
