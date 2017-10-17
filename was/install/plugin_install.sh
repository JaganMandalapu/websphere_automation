#!/bin/bash
source /data/shared_scripts/resources.sh
ID=`id -un`
PLG_INSTALL_DIR=$2           #/opt/software/IBM/WebSphere9/Plugins
PLG_REPO=$3                  #/data/binaries/ibm/websphere/PLG9
SDK_REPO=$4                  #/data/binaries/ibm/websphere/SDK8
IMCL_LOCATION=$5             #/opt/software/IBM/InstallationManager/eclipse/tools
PLG_INSTALL_LOG=$6           #/data/scripts/logs/PLG/plugin_install.log

if [ $ID != "$RUN_AS_ID" ] ; then
  echo "This script needs to be run as $RUN_AS_ID"
  echo "Exiting now.."
  exit 1
fi

listPackages() {
  packageJAVA=`$IMCL_LOCATION/imcl listAvailablePackages -repositories $SDK_REPO`
  packagePLUGIN=`$IMCL_LOCATION/imcl listAvailablePackages -repositories $PLG_REPO`
  echo "JAVA package: $packageJAVA"
  echo "Plugin package: $packagePLUGIN"
}

installPlugin() {
  if [ -d $PLG_INSTALL_DIR ] ; then
    echo "$PLG_INSTALL_DIR already exists. Please check if Plugin is already installed."
    echo "Exiting now.."
    exit 1
  fi

  $IMCL_LOCATION/imcl install $packageJAVA $packagePLUGIN -repositories $SDK_REPO,$PLG_REPO -acceptLicense \
    -installationDirectory $PLG_INSTALL_DIR -log $PLG_INSTALL_LOG -sharedResourcesDirectory $IM_SHARE -showProgress
}

case $1 in
  list)
      echo
      echo "Listing available packages in the repositories:"
      listPackages
      ;;
  install)
      echo
      echo "Installing the packages:"
      listPackages
      installPlugin
      ;;
  *)
      echo
      echo "Usage: $0 [list|install]"
      ;;
  esac

