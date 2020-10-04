#!/bin/bash

echo "Reading config...." >&2
if [ "${1}" != "" ]; then
    source ${1}
else
    source ./azuredeploy.cfg
fi

az account set --subscription "$subscriptionid"

echo "installing iscsi server software"
az group deployment create \
--name ISCSIDeployment \
--resource-group $rgname \
--template-uri "https://raw.githubusercontent.com/bqtrinh/AzQ/mastersap-iscsi-server/iscsiserver-sw.json" \
--parameters vmName="${ISCSIVMNAME}" \
customUri=$customuri \
IQN1="$NFSIQN" \
IQN1client1="$NFSIQNCLIENT1" \
IQN1client2="$NFSIQNCLIENT2" \
IQN2="$HANAIQN" \
IQN2client1="$HANAIQNCLIENT1" \
IQN2client2="$HANAIQNCLIENT2" \
IQN3="$ASCSIQN" \
IQN3client1="$ASCSIQNCLIENT1" \
IQN3client2="$ASCSIQNCLIENT2"

echo "iscsi server software installed"
