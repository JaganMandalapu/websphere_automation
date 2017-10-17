#!/bin/bash

ID=`id -un`
PROFILE_TYPE=$1			#dmgr|appserver
WAS_INSTALL_DIR=$2		#/opt/software/IBM/WebSphere9/AppServer
PROFILENAME_DMGR=$3		#Dmgr9
PROFILENAME_APPSERVER=$4	#AppServer9
CREATE_PROFILE_LOG=$5		#/data/scripts/logs/WAS/create_profile.log
HOST=`hostname`

if [ $ID != "root" ] ; then
  echo "The script needs to be run as root"
  echo "Exiting now.."
  exit 1
fi

cat << dmgr > /data/scripts/logs/dmgr.txt
create
profileName=$PROFILENAME_DMGR
profilePath=$WAS_INSTALL_DIR/profiles/$PROFILENAME_DMGR
templatePath=$WAS_INSTALL_DIR/profileTemplates/dmgr
nodeName=$HOSTCellManager9
cellName=$HOSTCell9
hostname=$HOST
startingPort=9000
validatePorts
isDefault
dmgr

cat << appserver > /data/scripts/logs/appserver.txt
create
profileName=$PROFILENAME_APPSERVER
profilePath=$WAS_INSTALL_DIR/profiles/$PROFILENAME_APPSERVER
templatePath=$WAS_INSTALL_DIR/profileTemplates/default
nodeName=$HOSTNode9
hostname=$HOST
startingPort=9100
validatePorts
omitAction=deployAdminConsole,defaultAppDeployAndConfig,deployIVTApplication
appserver

createDmgr() {
  if [ -d $WAS_INSTALL_DIR/profiles/$PROFILENAME_DMGR ] ; then
    echo "$WAS_INSTALL_DIR/profiles/$PROFILENAME_DMGR already exists. Please check if $PROFILENAME_DMGR profile exists."
    echo "Exiting now.."
    exit 1
  fi

  $WAS_INSTALL_DIR/bin/manageprofiles.sh -response /data/scripts/logs/dmgr.txt >> $CREATE_PROFILE_LOG
}

createAppServer() {
  if [ -d $WAS_INSTALL_DIR/profiles/$PROFILENAME_APPSERVER ] ; then
    echo "WAS_INSTALL_DIR/profiles/$PROFILENAME_APPSERVER already exists. Please check if $PROFILENAME_APPSERVER profile exists."
    echo "Exiting now.."
    exit 1
  fi

  $WAS_INSTALL_DIR/bin/manageprofiles.sh -response /data/scripts/logs/appserver.txt >> $CREATE_PROFILE_LOG
}

case $1 in
  dmgr)
    echo
    echo "Creating dmgr profile"
    createDmgr
    ;;
  appserver)
    echo
    echo "Creating an appserver profile"
    createAppServer
    ;;
  *)
    echo
    echo "Usage: $0 [dmgr|appserver]"
    ;;
esac

