# This script creates a bridge interface file in RHEL/CENTOS7

#Author: Noor Muhammad
#Date: Dec 13, 2019

if [ $# -lt 1 ];then
       echo "Usage: $0 <BRIDGE_NAME> <IP> <NETMASK> <GATEWAY>"
       exit 1
fi

# Inputs are stored separately in case there might be input validation needed in the future
# Use REGEX perhaps?
BRIDGE_NAME=$1
IP=$2
NETMASK=$3
GATEWAY=$4


# the filename
FILENAME=ifcfg-$BRIDGE_NAME

cat > $FILENAME << EOF
NAME=$BRIDGE_NAME
DEVICE=$BRIDGE_NAME
BOOTPROTO=static
IPADDR=$IP
NETMASK=$NETMASK
GATEWAY=$GATEWAY
ONBOOT=yes
TYPE=Bridge
NM_CONTROLLED=no
MTU=1500
EOF


echo "File $FILENAME created with contents: "
echo "**************************************"
cat $FILENAME
echo "**************************************"
