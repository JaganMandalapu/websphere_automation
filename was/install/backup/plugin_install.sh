#!/bin/bash
source /data/shared_scripts/resources.sh
ID=`id -un`
plg_install_dir=$2           #/opt/software/IBM/WebSphere9/Plugins
plg_repo=$3                  #/data/binaries/ibm/websphere/PLG9
sdk_repo=$4                  #/data/binaries/ibm/websphere/SDK8
imcl_location=$5             #/opt/software/IBM/InstallationManager/eclipse/tools
plg_install_log=$6           #/data/scripts/logs/PLG/plugin_install.log
run_as_id=root

if [ $ID != "$run_as_id" ] ; then
  echo "This script needs to be run as $run_as_id"
  echo "Exiting now.."
  exit 1
fi

listPackages() {
  packageJAVA=`$imcl_location/imcl listAvailablePackages -repositories $sdk_repo`
  packagePLUGIN=`$imcl_location/imcl listAvailablePackages -repositories $plg_repo`
  echo "JAVA package: $packageJAVA"
  echo "Plugin package: $packagePLUGIN"
}

installPlugin() {
  if [ -d $plg_install_dir ] ; then
    echo "$plg_install_dir already exists. Please check if Plugin is already installed."
    echo "Exiting now.."
    exit 1
  fi

  $imcl_location/imcl install $packageJAVA $packagePLUGIN -repositories $sdk_repo,$plg_repo -acceptLicense \
    -installationDirectory $plg_install_dir -log $plg_install_log -sharedResourcesDirectory $im_share -showProgress
}

case $1 in
  list)
      echo
      echo "Listing available packages in the repositories:"
      listPackages
      ;;
  install)
      echo
      echo "Installing the packages"
      listPackages
      installPlugin
      ;;
  *)
      echo
      echo "Usage: $0 [list|install]"
      ;;
  esac
