#This script is to configure a VLANIF for a bond in  RHEL/Centos
#It also adds the same interface to specified bridge

#Author: Noor Muhammad
#Date: Dec 13, 2019

if [ $# -lt 1 ]; then
	echo "Usage: $0 <BOND_NAME> <VLAN_ID> <BRIDGE_NAME>"
	exit 1
fi

#The bond to use
BOND_NAME=$1
#VLANID of the VLAN to create
VLANID=$2
#The bridge in which to add the interface
BRIDGE_NAME=$3

# The filename
FILENAME=ifcfg-$BOND_NAME.$VLANID

cat > $FILENAME << EOF
NAME=$BOND_NAME.$VLANID
DEVICE=$BOND_NAME.$VLANID
TYPE=Bond
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=none
MTU=1500
VLAN=yes
BRIDGE=$BRIDGE_NAME
EOF

echo "File $FILENAME created with contents: "
echo "**************************************"
cat $FILENAME
echo "**************************************"

