#!/bin/bash
source /data/shared_scripts/resources.sh
ID=`id -un`
IM_DIR=$2               #/opt/software/IBM/InstallationManager
IM_REPO=$3              #/data/binaries/ibm/websphere/IM18
IM_INSTALL_LOG=$4       #/data/scripts/logs/IM/im_install.log

if [ $ID != "$RUN_AS_ID" ] ; then
  echo "The script needs to be run as $RUN_AS_ID"
  echo "Exiting now.."
  exit 1
fi

install_im() {
  if [ -d $IM_DIR ] ;
  then
    echo "$IM_DIR already exists. Please check if Installation Manager is already installed.."
    echo "Exiting now.."
    exit 1
  fi

  $IM_REPO/userinstc -log $IM_INSTALL_LOG -acceptLicense -sVP -dL $AGENT_DATA
}

case $1 in
  install)
          echo
          echo "Installing Installation Manager"
          install_im
          ;;
  *)
          echo
          echo "Usage: $0 [install]"
          ;;
esac

