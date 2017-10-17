#!/bin/bash
source /data/shared_scripts/resources.sh
ID=`id -un`
was_install_dir=$2        #/opt/software/IBM/WebSphere9/AppServer
was_repo=$3               #/data/binaries/ibm/websphere/WAS9
sdk_repo=$4               #/data/binaries/ibm/websphere/SDK8
imcl_location=$5          #/opt/software/IBM/InstallationManager/eclipse/tools
was_install_log=$6        #/data/scripts/logs/WAS/was_install.log
run_as_id=root

if [ $ID != "$run_as_id" ] ; then
  echo "The script needs to be run as $run_as_id"
  echo "Exiting now.."
  exit 1
fi

listPackages() {
  packageJAVA=`$imcl_location/imcl listAvailablePackages -repositories $sdk_repo`
  packageWAS=`$imcl_location/imcl listAvailablePackages -repositories $was_repo`
  echo "JAVA package: $packageJAVA"
  echo "WAS package: $packageWAS"
}
installWAS() {
  if [ -d $was_install_dir ] ; then
    echo "$was_install_dir already exists. Please check if WAS is already installed."
    echo "Exiting now.."
    exit 1
  fi

  $imcl_location/imcl install $packageJAVA $packageWAS -repositories $sdk_repo,$was_repo -acceptLicense \
    -installationDirectory $was_install_dir -log $was_install_log -sharedResourcesDirectory $im_share -showProgress
}

case $1 in
  list)
      echo
      echo "Listing available pacakges from the repositories:"
      listPackages
      ;;
  install)
      echo
      echo "Installing the packages"
      listPackages
      installWAS
      ;;
  *)
      echo
      echo "Usage: $0 [list|install]"
      ;;
esac
