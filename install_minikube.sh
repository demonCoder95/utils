#!/bin/bash

##############################################################################################
# Utility script to install minikube - takes care of all dependency requirement checks as well
##############################################################################################
# Script dependencies are:
# ========================
# check_virtualization.sh 	; to check virtualization support
# install_kubectl.sh 		; to install kubectl binary
# virtualbox installation
# The script handles dependency checking itself
##############################################################################################
# Author: Noor
# Date: January 28, 2019
##############################################################################################


# Check if virtualizaiton is supported on the current system
echo "[DEBUG] Checking for virtualization support..."

if [ -f "check_virtualization.sh" -a -f "install_kubectl.sh" ]; then
	echo "Dependencies satisfied!"
else
	echo "Dependency check failed!"
	exit 1
fi

./check_virtualization.sh
VIRT_SUPPORT="$?"

if [ $VIRT_SUPPORT != "0" ]; then
	echo "[DEBUG] Can't continue. Virtualization support is requied for minikube!"
	exit 1
fi

# Checking for kubectl installation
echo "[DEBUG] Checking for kubectl installation..."	
if [ "$(which kubectl | wc -c)" != "0" ]; then
	echo "[DEBUG] kubectl was found in $(which kubectl)"
else
	echo "[DEBUG] Kubectl was not found. It's required for minikube!"
	echo "Installing kubectl..."
	./install_kubectl.sh
	echo "[DEBUG] Done installing kubectl!"
fi

# Checking for hypervisor installation
echo "[DEBUG] Checking for virtualbox installation..."
if [ "$(which virtualbox | wc -c)" != "0" ]; then
	echo "[DEBUG] virtualbox was found in $(which virtualbox)"
else
	echo "[DEBUG] virtualbox was not found. Please install virtualbox and run the script again!"
	exit 1
fi

# Installing the minikube binary latest version
echo "[DEBUG] All dependencies satisfied. Installing the minikube binary..."
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/

echo "[DEBUG] Everything done!"
minikube version








