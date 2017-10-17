#!/bin/bash
source /data/scripts/resources.sh
ID=`id -un`
PLUGIN_INSTALL_DIR=$2
PLUGIN_FIX_REPO=$3
IMCL_LOC=$4
PLUGIN_UPDATE_LOG=$5

DATE=`date +%m%d%Y`

if [ $ID != "root" ] ; then
  echo "The script needs to be run as root"
  echo "Exiting now.."
  exit 1
fi

listFix() {
  fixPLG=`$IMCL_LOC/imcl listAvailablePackages -repositories $PLUGIN_FIX_REPO`
  fixPlugin=`grep ".PLG.v" <<< "$fixPLG"`
  echo "Plugin fix: $fixPlugin"
}

installFix() {
  listFix
  echo "Installing $fixPlugin"
  $IMCL_LOC/imcl install $fixPlugin -repositories $PLUGIN_FIX_REPO -installationDirectory \
  $PLUGIN_INSTALL_DIR -acceptLicense -log $PLUGIN_UPDATE_LOG -showProgress
}

case $1 in
  list)
      echo
      echo "Listing fixes from the available repositories"
      listFix
      ;;
  update)
      echo
      echo "Backing up available profiles and installing the fixes"
      installFix
      ;;
  *)
      echo
      echo "Usage: $0 [list|update]"
      ;;
esac

