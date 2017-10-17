#!/bin/bash
source /data/shared_scripts/resources.sh

ID=`id -un`
WAS_INSTALL_DIR=$2        #/opt/software/IBM/WebSphere9/AppServer
WAS_FIX_REPO=$3           #/data/binaries/ibm/websphere/patch/WAS9
IMCL_LOC=$4               #/opt/software/IBM/InstallationManager/eclipse/tools
WAS_UPDATE_LOG=$5         #/data/scripts/logs/WAS/was_update.log

DATE=`date +%m%d%Y`
wasprof=$WAS_INSTALL_DIR/profiles
profiles=`ls $wasprof`

if [ $ID != "$RUN_AS_ID" ] ; then
  echo "The script needs to be run as $RUN_AS_ID"
  echo "Exiting now.."
  exit 1
fi

backup_profile() {
  for i in `echo $profiles` ; do
    echo "Backing up $i profile"
    $wasprof/$i/bin/backupConfig.sh $wasprof/$i/bin/${i}_${DATE}.zip
  done
}

list_fix() {
  fixWAS=`$IMCL_LOC/imcl listAvailablePackages -repositories $WAS_FIX_REPO`
  fixND=`grep ".ND.v" <<< "$fixWAS"`
  echo "WAS fix: $fixND"
}

install_fix() {
  backup_profile
  list_fix
  echo "Installing $fixND"
  $IMCL_LOC/imcl install $fixND -repositories $WAS_FIX_REPO -installationDirectory \
  $WAS_INSTALL_DIR -acceptLicense -log $WAS_UPDATE_LOG -showProgress
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

