#!/bin/bash

# This script installs podman for Ubuntu 18.04/Ubuntu 19.04 and Ubuntu 19.10 systems
# Author: Noor
# Date: January 27, 2019

echo "[DEBUG] Doing pre-install work..."

echo "[DEBUG] Sourcing distro info..."
# source the distro information
. /etc/os-release 

echo "[DEBUG] Checking compatibility..."
echo "[DEBUG] Distro is $VERSION"
if [ $VERSION_ID == "18.04" -o $VERSION_ID == "19.04" -o $VERSION_ID == "19.10" ]
then
    echo "[DEBUG] Distro is compatible"
else
    echo "[DEBUG] Distro is NOT compatible!"
    echo "[DEBUG] Compatible distros are Ubuntu 18.04, Ubuntu 19.04 and Ubuntu 19.10"
fi

echo "[DEBUG] Update APT sources list..."
# Update the APT sources list
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/x${NAME}_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"

echo "[DEBUG] Getting release key for podman..."
# Get the release key for podman
wget -nv https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/x${NAME}_${VERSION_ID}/Release.key -O Release.key

echo "[DEBUG] Installing podman..."
# Add the key to APT, update repo list and install podman
sudo apt-key add - < Release.key
sudo apt-get update -qq
sudo apt-get -qq -y install podman

echo "[DEBUG] Configuring registries for podman.."
# Config podman with registry addresses
sudo mkdir -p /etc/containers
echo -e "[registries.search]\nregistries = ['docker.io', 'quay.io']" | sudo tee /etc/containers/registries.conf

echo "[DEBUG] Everything done!"
podman version
