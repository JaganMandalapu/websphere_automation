#!/bin/bash
source /data/shared_scripts/resources.sh
ID=`id -un`
WAS_INSTALL_DIR=$2        #/opt/software/IBM/WebSphere9/AppServer
WAS_REPO=$3               #/data/binaries/ibm/websphere/WAS9
SDK_REPO=$4               #/data/binaries/ibm/websphere/SDK8
IMCL_LOCATION=$5          #/opt/software/IBM/InstallationManager/eclipse/tools
WAS_INSTALL_LOG=$6        #/data/scripts/logs/WAS/was_install.log

if [ $ID != "$RUN_AS_ID" ] ; then
  echo "The script needs to be run as $RUN_AS_ID"
  echo "Exiting now.."
  exit 1
fi

listPackages() {
  packageJAVA=`$IMCL_LOCATION/imcl listAvailablePackages -repositories $SDK_REPO`
  packageWAS=`$IMCL_LOCATION/imcl listAvailablePackages -repositories $WAS_REPO`
  echo "JAVA package: $packageJAVA"
  echo "WAS package: $packageWAS"
}
installWAS() {
  if [ -d $WAS_INSTALL_DIR ] ; then
    echo "$WAS_INSTALL_DIR already exists. Please check if WAS is already installed."
    echo "Exiting now.."
    exit 1
  fi

  $IMCL_LOCATION/imcl install $packageJAVA $packageWAS -repositories $SDK_REPO,$WAS_REPO -acceptLicense \
    -installationDirectory $WAS_INSTALL_DIR -log $WAS_INSTALL_LOG -sharedResourcesDirectory $IM_SHARE -showProgress
}

case $1 in
  list)
      echo
      echo "Listing available pacakges from the repositories:"
      listPackages
      ;;
  install)
      echo
      echo "Installing the packages:"
      listPackages
      installWAS
      ;;
  *)
      echo
      echo "Usage: $0 [list|install]"
      ;;
esac

