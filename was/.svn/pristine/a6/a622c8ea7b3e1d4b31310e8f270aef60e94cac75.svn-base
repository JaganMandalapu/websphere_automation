#!/bin/bash
source /data/shared_scripts/resources.sh
ID=`id -un`
BUSINESS_AREA=$1
WAS_VERSION=$2       #was9
APP_NAME=$3
webserver_url=$4
secure_port=$5
APP_SERVER_NAME=${APP_NAME}_appserver
HOST_NAME=`hostname -s`
NODE_NAME=${HOST_NAME}Node_${BUSINESS_AREA}
vhost=${APP_NAME}_vhost

listServerPorts_script=/data/shared_scripts/config/listServerPorts.py
setVhost_script=/data/shared_scripts/config/setVhost.py
printVirtualHostAliases_script=/data/shared_scripts/config/printVirtualHostAliases.py


if [ $ID != "$RUN_AS_ID" ] ; then
  echo "The script needs to be run as $RUN_AS_ID"
  echo "Exiting now.."
  exit 1
fi

if [[ $APP_NAME == "" ]] ; then
  echo
  echo "Application name cannot be empty!"
  exit 1
fi

ports=`$WSADMIN_DIR/wsadmin.sh -lang jython -username $WAS_ADMIN_ID -password $WAS_ADMIN_PASSWORD \
  -f $listServerPorts_script $APP_SERVER_NAME $NODE_NAME | sed '1,2d'`

if [[ $? != 0 ]] ; then
    echo
    echo "Error encountered while getting the port information"
    echo
    exit 1
fi

ports=($ports)

$WSADMIN_DIR/wsadmin.sh -lang jython -username $WAS_ADMIN_ID -password $WAS_ADMIN_PASSWORD \
  -f $setVhost_script $vhost ${ports[0]} ${ports[1]} $webserver_url

if [[ $? != 0 ]] ; then
      echo
      echo "Error encountered while getting the port information"
      echo
      exit 1
fi

#$WSADMIN_DIR/wsadmin.sh -lang jython -username $WAS_ADMIN_ID -password $WAS_ADMIN_PASSWORD \
# -f $printVirtualHostAliases_script $vhost

