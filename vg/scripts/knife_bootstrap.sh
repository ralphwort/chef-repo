#!/bin/bash
IPADDR=$1
IDFILE=$2
OS_USER=$3
NODE_NAME=$4
RECIPE=$5
echo knife bootstrap $IPADDR -i $IDFILE -x $OS_USER -N $NODE_NAME --sudo -r "recipe[$RECIPE]" 2>&1 >> /var/log/chef_bootstrap.log
knife bootstrap $IPADDR -i $IDFILE -x $OS_USER -N $NODE_NAME --sudo -r "recipe[$RECIPE]" 2>&1 >> /var/log/chef_bootstrap.log
