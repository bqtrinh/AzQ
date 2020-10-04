#!/bin/bash

echo "Reading config...." >&2
if [ "${1}" != "" ]; then
    source ${1}
else
    source ./azuredeploy.cfg
fi

az account set --subscription "$subscriptionid"

echo "creating additional application server"
az group deployment create \
--name NetWeaver-aas-Deployment \
--resource-group "$rgname" \
--template-uri "https://raw.githubusercontent.com/bqtrinh/AzQ/mastersap-netweaver-server/azuredeploy-nw-infra.json" \
--parameters \
vmName="$AASVMNAME" \
vmUserName="$vmusername" \
vmPassword="$vmpassword" \
vnetName="$vnetname" \
ExistingNetworkResourceGroup="$vnetrgname" \
vmSize="Standard_DS2_v2" \
osType="SLES 12 SP4" \
appAvailSetName="nwavailset" \
StaticIP="$AASIPADDR" \
subnetName="$appsubnetname" \
enableAcceleratedNetworking="no"

echo "additional application server created"
