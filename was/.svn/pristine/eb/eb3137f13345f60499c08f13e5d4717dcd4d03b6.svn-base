#!/bin/bash
source /data/shared_scripts/resources.sh
ID=`id -un`
PLG_INSTALL_DIR=$2          #/opt/software/IBM/WebSphere9/Plugins
PLG_FIX_REPO=$3             #/data/binaries/ibm/websphere/patch/PLG9
IMCL_LOCATION=$4            #/opt/software/IBM/InstallationManager/eclipse/tools
PLG_UPDATE_LOG=$5           #/data/scripts/logs/PLG/plugin_update.log

DATE=`date +%m%d%Y`

if [ $ID != "$RUN_AS_ID" ] ; then
  echo "The script needs to be run as $RUN_AS_ID"
  echo "Exiting now.."
  exit 1
fi

list_fix() {
  fixPLG=`$IMCL_LOCATION/imcl listAvailablePackages -repositories $PLG_FIX_REPO`
  fixPlugin=`grep ".PLG.v" <<< "$fixPLG"`
  echo "Plugin fix: $fixPlugin"
}

install_fix() {
  list_fix
  echo "Installing $fixPlugin"
  $IMCL_LOCATION/imcl install $fixPlugin -repositories $PLG_FIX_REPO -installationDirectory \
  $PLG_INSTALL_DIR -acceptLicense -log $PLG_UPDATE_LOG -showProgress
}

case $1 in
  list)
      echo
      echo "Listing fixes from the available repositories"
      list_fix
      ;;
  install)
      echo
      echo "Backing up available profiles and installing the fixes"
      install_fix
      ;;
  *)
      echo
      echo "Usage: $0 [list|update]"
      ;;
esac

