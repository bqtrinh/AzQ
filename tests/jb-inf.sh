#!/bin/bash

echo "Reading config...." >&2
if [ "${1}" != "" ]; then
    source ${1}
else
    source ./azuredeploy.cfg
fi

echo "creating jumpbox"
az group deployment create \
--name JumpboxDeployment \
--resource-group $rgname \
--template-uri "https://raw.githubusercontent.com/bqtrinh/AzQ/master/tests/jb-inf.sh?token=ACARGSWU7ML2UFJNRUVJUFC7PTHIU" \
--parameters vmName=hanajumpbox \
vmUserName=$vmusername \
StaticIP=$JBPIP \
ExistingNetworkResourceGroup=$rgname \
vnetName=$vnetname \
subnetName=$mgtsubnetname \
vmPassword=$vmpassword \
customUri=$customuri

echo "jumpbox created"
