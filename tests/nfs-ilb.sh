#!/bin/bash

echo "Reading config...." >&2
if [ "${1}" != "" ]; then
    source ${1}
else
    source ./azuredeploy.cfg
fi

echo "creating nfs cluster"
az group deployment create \
--name NFSDeployment \
--resource-group $rgname \
--template-uri "https://raw.githubusercontent.com/bqtrinh/AzQ/mastersap-nfs-service/azuredeploy-nfs-ilb.json" \
--parameters prefix=nfs \
VMName1=$NFSVMNAME1 \
VMName2=$NFSVMNAME2 \
VMSize="Standard_D2s_v3" \
vnetName=$vnetname \
SubnetName=$appsubnetname \
VMUserName=$vmusername \
VMPassword=$vmpassword \
OperatingSystem="SLES for SAP 12 SP4" \
ExistingNetworkResourceGroup=$vnetrgname \
StaticIP1=$NFSIP1 \
StaticIP2=$NFSIP2 \
iSCSIIP=$ISCSIIP \
ILBIP=$NFSILBIP

echo "nfs cluster created"
