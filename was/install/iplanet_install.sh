#!/bin/bash
source /data/shared_scripts/resources.sh
ID=`id -un`
IPLANET_DIR=$2
IPLANET_REPO=$3
HOST_NAME=`hostname -s`
STATE_FILE=/data/scripts/install/statefile
STATE_TEMPLATE=/data/shared_scripts/install/statefile_template

if [ $ID != "$RUN_AS_ID" ] ; then
  echo "This script needs to be run as $RUN_AS_ID"
  echo "Exiting now.."
  exit 1
fi

installIplanet() {
  if [ -d $IPLANET_DIR ] ; then
    echo "$IPLANET_DIR already exists. Please check if iPlanet was already installed."
    echo "Exiting now.."
    exit 1
  fi

  mkdir -p /data/scripts/install
  touch $STATE_FILE

  while read line
  do
        eval echo "$line" >> "$STATE_FILE"
  done < "$STATE_TEMPLATE"


  $IPLANET_REPO/setup --silent $STATE_FILE
}

case $1 in
  install)
        echo
        echo "Installing iPlanet.."
        installIplanet
        ;;
  *)
        echo
        echo "usage: $0 [install]"
        ;;
esac

