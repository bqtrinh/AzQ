#!/bin/bash

echo "Reading config...." >&2
if [ "${1}" != "" ]; then
    source ${1}
else
    source ./azuredeploy.cfg
fi

az account set --subscription "$subscriptionid"

echo "installing nfs cluster"
az group deployment create \
--name NFSDeployment \
--resource-group $rgname \
--template-uri "https://raw.githubusercontent.com/bqtrinh/AzQ/master/sap-nfs-service/azuredeploy-nfs-sw.json" \
--parameters \
VMName1=$NFSVMNAME1 \
VMName2=$NFSVMNAME2 \
VMUserName=$vmusername \
VMPassword=$vmpassword \
customURI="$customuri" \
StaticIP1=$NFSIP1 \
StaticIP2=$NFSIP2 \
IQN="$NFSIQN" \
IQNClient1="$NFSIQNCLIENT1" \
IQNClient2="$NFSIQNCLIENT2" \
iSCSIIP=$ISCSIIP \
ILBIP=$NFSILBIP

echo "nfs cluster installed"
