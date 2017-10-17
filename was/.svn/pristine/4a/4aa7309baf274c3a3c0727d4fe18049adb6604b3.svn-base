#!/bin/bash
# This scripts calls installApp.py script to install an application to a JVM
source /data/shared_scripts/resources.sh
ID=`id -un`
WAS_VERSION=$2                     #was9
APP_NAME=$3
BUSINESS_AREA=$4
JNDI=$5
DB_USER=$6
DB_PASSWORD=$7
APP_SERVER_NAME=${APP_NAME}_appserver
HOST_NAME=`hostname -s`
NODE_NAME=${HOST_NAME}Node_${BUSINESS_AREA}

ear_dir=/data/apps/${APP_NAME}/${WAS_VERSION}/deploy
ear_files=`ls -lrt $ear_dir`
ear_array=($ear_files)
ear_file=`echo ${ear_array[${#ear_array[@]}-1]}`
ear=$ear_dir/$ear_file

installApp_script=/data/shared_scripts/deploy/installAppWithVariousTasksAndNonTasksOptions.py
updateApp_script=/data/shared_scripts/deploy/updateApp.py
startSingleServer_script=/data/shared_scripts/deploy/startSingleServer.py
stopSingleServer_script=/data/shared_scripts/deploy/stopSingleServer.py

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
echo "Install the $APP_NAME application"
echo

installApp() {
  # Installing the application
  $WSADMIN_DIR/wsadmin.sh -lang jython -username $WAS_ADMIN_ID -password $WAS_ADMIN_PASSWORD -f \
    $installApp_script $APP_NAME $ear $NODE_NAME $APP_SERVER_NAME ${APP_NAME}_vhost
  stopAppServer
  startAppServer
}

updateApp() {
  # Update the appliaction
  $WSADMIN_DIR/wsadmin.sh -lang jython -username $WAS_ADMIN_ID -password $WAS_ADMIN_PASSWORD -f \
    $updateApp_script $APP_NAME $ear
  stopAppServer
  startAppServer
}

stopAppServer() {
  # Stop the JVM
  $WSADMIN_DIR/wsadmin.sh -lang jython -username $WAS_ADMIN_ID -password $WAS_ADMIN_PASSWORD -f \
    $stopSingleServer_script $NODE_NAME $APP_SERVER_NAME
}

startAppServer() {
  # Start the JVM
  $WSADMIN_DIR/wsadmin.sh -lang jython -username $WAS_ADMIN_ID -password $WAS_ADMIN_PASSWORD -f \
    $startSingleServer_script $NODE_NAME $APP_SERVER_NAME
}

case $1 in
  install)
    echo
    echo "Installing the $APP_NAME application"
    echo
    installApp
    ;;
  update)
    echo
    echo "Updating the $APP_NAME application"
    echo
    updateApp
    ;;
  *)
    echo
    echo "Usage: $0 [install|update]"
    ;;
esac

