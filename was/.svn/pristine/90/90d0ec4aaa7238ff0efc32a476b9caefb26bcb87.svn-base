#!/bin/bash
# This script calls createServer.py to create an application server instance
source /data/shared_scripts/resources.sh
ID=`id -un`
APP_NAME=$1
BUSINESS_AREA=$2
WAS_VERSION=$3                          #was9
APP_SERVER_NAME=${APP_NAME}_appserver
INIT_HEAP=$4
MAX_HEAP=$5
HOST_NAME=`hostname -s`
NODE_NAME=${HOST_NAME}Node_${BUSINESS_AREA}
TEMPLATE_NAME=${NODE_NAME}_template

createServer_script=/data/shared_scripts/config/createServer.py
configureJVMLogs_script=/data/shared_scripts/config/configureJVMLogs.py
logLocation=/data/logs/${APP_NAME}/app/${WAS_VERSION}/

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

echo
echo "Creating the ${APP_SERVER_NAME} JVM"
echo

# Creating an appserver (JVM)
$WSADMIN_DIR/wsadmin.sh -lang jython -username $WAS_ADMIN_ID -password $WAS_ADMIN_PASSWORD -f \
  $createServer_script $NODE_NAME $APP_SERVER_NAME $TEMPLATE_NAME $INIT_HEAP $MAX_HEAP

if [[ $? != 0 ]] ; then
  echo
  echo "Error encountered while creating the ${APP_SERVER_NAME} JVM"
  echo
  exit 1
fi

echo
echo "Configuring log location for the ${APP_SERVER_NAME} JVM"
echo

# Configuring JVM logs
$WSADMIN_DIR/wsadmin.sh -lang jython -username $WAS_ADMIN_ID -password $WAS_ADMIN_PASSWORD -f $configureJVMLogs_script $APP_SERVER_NAME $logLocation

# Creating app directory
mkdir -p /data/apps/${APP_NAME}/${WAS_VERSION}/deploy

