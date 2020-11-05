#!/bin/bash

echo "Reading config...." >&2
if [ "${1}" != "" ]; then
    source ${1}
else
    source ./azuredeploy.cfg
fi

echo "creating netweaver cluster"
az group deployment create \
--name NetWeaver-Deployment \
--resource-group "$rgname" \
--template-uri "https://raw.githubusercontent.com/bqtrinh/AzQ/master/sap-netweaver-server/azuredeploy-nw-infra.json" \
--parameters \
vmName="$NWVMNAME" \
vmUserName="$vmusername" \
vmPassword="$vmpassword" \
vnetName="$vnetname" \
ExistingNetworkResourceGroup="$rgname" \
vmSize="Standard_DS13_v2" \
osType="SLES for SAP 15 SP1 gen2" \
appAvailSetName="nwavailset" \
StaticIP="$FIRSTNWIPADDR"

echo "netweaver cluster created"
