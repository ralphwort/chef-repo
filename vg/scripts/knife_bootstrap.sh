#!/bin/bash
IPADDR=$1
IDFILE=$2
OS_USER=$3
NODE_NAME=$4
RECIPE=$5
APPS=$6
TMP1=/tmp/chef_boot.$$
exec_str='knife bootstrap '$IPADDR' -i '$IDFILE' -x '$OS_USER' -N '$NODE_NAME' --sudo -r "recipe['$RECIPE']" --json-attributes "{\"names\": \"'$APPS'\"}" 2>&1 >> /var/log/chef_bootstrap.log'
echo $exec_str 2>&1 >> /var/log/chef_bootstrap.log
echo $exec_str > $TMP1
chmod +x $TMP1
$TMP1
rm $TMP1
