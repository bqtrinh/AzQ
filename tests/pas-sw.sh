#!/bin/bash

echo "Reading config...." >&2
if [ "${1}" != "" ]; then
    source ${1}
else
    source ./azuredeploy.cfg
fi

az account set --subscription "$subscriptionid"

echo "creating netweaver cluster"
az group deployment create \
--name NetWeaver-Deployment \
--resource-group "$rgname" \
--template-uri "https://raw.githubusercontent.com/bqtrinh/AzQ/mastersap-netweaver-server/azuredeploy-nw-sw.json" \
--parameters \
VMNAME="$PASVMNAME" \
VMIPADDR="$PASIPADDR" \
ISPRIMARY="YES" \
URI="$customuri" \
NFSILBIP="$NFSILBIP" \
ASCS1VM="$ASCSVMNAME1" \
ASCS1IP="$ASCSIP1" \
ASCS2VM="$ASCSVMNAME2" \
ASCS2IP="$ASCSIP2" \
MASTERPASSWORD="$vmpassword" \
DBHOST="hanailb" \
DBSID="$HANASID" \
DBINSTANCE="00" \
ASCSSID="$ASCSSID" \
ASCSHOST="ascsilb" \
NWINSTANCE="05" \
ASCSINSTANCE="00" \
ERSINSTANCE="01" \
SAPBITSMOUNT="$SAPBITSMOUNT" \
SAPMNTMOUNT="$SAPMNTMOUNT" \
USRSAPSIDMOUNT="$USRSAPSIDMOUNT" \
USRSAPASCSMOUNT="$USRSAPASCSMOUNT" \
USRSAPERSMOUNT="$USRSAPERSMOUNT" \
ASCSILBIP="$ASCSLBIP" \
DBIP="$HANAILBIP" \
CONFIGURESAP="YES" \
SAPSOFTWARETODEPLOY="$SAPSOFTWARETODEPLOY" \
use_anf=$USE_ANF

echo "netweaver cluster created"
