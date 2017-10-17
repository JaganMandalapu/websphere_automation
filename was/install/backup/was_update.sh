#!/bin/bash
source /data/scripts/resources.sh

ID=`id -un`
WAS_INSTALL_DIR=$2		#/opt/software/IBM/WebSphere9/AppServer
WAS_FIX_REPO=$3			#/data/binaries/ibm/websphere/patch/WAS9
IMCL_LOC=$4			#/opt/software/IBM/InstallationManager/eclipse/tools
WAS_UPDATE_LOG=$5		#/data/scripts/logs/WAS/was_update.log

DATE=`date +%m%d%Y`
WASPROF=$WAS_INSTALL_DIR/profiles
PROFILES=`ls $WASPROF`

if [ $ID != "root" ] ; then
  echo "The script needs to be run as root"
  echo "Exiting now.."
  exit 1
fi

backupProfile() {
  for i in `echo $PROFILES` ; do
    echo "Backing up $i profile"
    $WASPROF/$i/bin/backupConfig.sh $WASPROF/$i/bin/${i}_${DATE}.zip
  done
}

listFix() {
  fixWAS=`$IMCL_LOC/imcl listAvailablePackages -repositories $WAS_FIX_REPO`
  fixND=`grep ".ND.v" <<< "$fixWAS"`
  echo "WAS fix: $fixND"
}

installFix() {
  backupProfile
  listFix
  echo "Installing $fixND"
  $IMCL_LOC/imcl install $fixND -repositories $WAS_FIX_REPO -installationDirectory \
  $WAS_INSTALL_DIR -acceptLicense -log $WAS_UPDATE_LOG -showProgress
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

