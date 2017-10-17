#!/bin/bash
source /data/shared_scripts/resources.sh
ID=`id -un`
PROFILE_TYPE=$1             #[dmgr|appserver]
WAS_INSTALL_DIR=$2          #/opt/software/IBM/WebSphere9/AppServer
BUSINESS_AREA=$3            #[EA|SQ|OS|CC]
CREATE_PROFILE_LOG=$4       #/data/scripts/logs/WAS/create_profile.log
HOST_NAME=`hostname -s`
NODE_NAME=${HOST_NAME}Node_${BUSINESS_AREA}
dmgr_profile=$WAS_INSTALL_DIR/profiles/Dmgr
appserver_profile=$WAS_INSTALL_DIR/profiles/AppServer_${BUSINESS_AREA}
createTemplate_script=/data/shared_scripts/config/createTemplate.py
WSADMIN_DIR=${dmgr_profile}/bin

if [ $ID != "$RUN_AS_ID" ] ; then
  echo "The script needs to be run as $RUN_AS_ID"
  echo "Exiting now.."
  exit 1
fi

cat << dmgr > /data/scripts/logs/dmgr.txt
create
profileName=Dmgr
profilePath=$WAS_INSTALL_DIR/profiles/Dmgr
templatePath=$WAS_INSTALL_DIR/profileTemplates/dmgr
nodeName=${HOST_NAME}CellManager
cellName=${HOST_NAME}Cell
hostname=$HOST_NAME
startingPort=9000
validatePorts
isDefault
dmgr

cat << appserver > /data/scripts/logs/appserver.txt
create
profileName=AppServer_${BUSINESS_AREA}
profilePath=$WAS_INSTALL_DIR/profiles/AppServer_${BUSINESS_AREA}
templatePath=$WAS_INSTALL_DIR/profileTemplates/default
nodeName=${HOST_NAME}Node_${BUSINESS_AREA}
hostname=$HOST_NAME
startingPort=9100
validatePorts
omitAction=deployAdminConsole,defaultAppDeployAndConfig,deployIVTApplication
appserver

createDmgr() {
  if [ -d $WAS_INSTALL_DIR/profiles/Dmgr ] ; then
    echo "$dmgr_profile already exists. Please check if Dmgr profile exists."
    echo "Exiting now.."
    exit 1
  fi

  $WAS_INSTALL_DIR/bin/manageprofiles.sh -response /data/scripts/logs/dmgr.txt >> $CREATE_PROFILE_LOG

  is_success=`grep -i INSTCONFSUCCESS $CREATE_PROFILE_LOG`

  if [[ $is_success != *"INSTCONFSUCCESS"* ]] ; then
    echo "Profile creation failed!"
    exit 1
  else
    echo "Profile creation succeeded!"
  fi

  echo
  echo "Starting the dmgr process"
  echo
  $WAS_INSTALL_DIR/bin/startManager.sh
}

createAppServer() {
  if [ -d $appserver_profile ] ; then
    echo "$appserver_profile already exists. Please check if AppServer_${BUSINESS_AREA} profile exists."
    echo "Exiting now.."
    exit 1
  fi

  $WAS_INSTALL_DIR/bin/manageprofiles.sh -response /data/scripts/logs/appserver.txt >> $CREATE_PROFILE_LOG

  is_success=`grep -i INSTCONFSUCCESS $CREATE_PROFILE_LOG`

  if [[ $is_success != *"INSTCONFSUCCESS"* ]] ; then
    echo "Profile creation failed!"
    exit 1
  else
    echo
    echo "Profile creation succeeded!"
    echo
  fi

  federateNode
  createTemplate
}

federateNode() {
  $appserver_profile/bin/addNode.sh $HOST_NAME 9003

}

createTemplate() {
  $WSADMIN_DIR/wsadmin.sh -lang jython -f $createTemplate_script $NODE_NAME server1 ${NODE_NAME}_template
}

case $1 in
  dmgr)
    echo
    echo "Creating the dmgr profile"
    createDmgr
    ;;
  appserver)
    echo
    echo "Creating the appserver profile"
    createAppServer
    ;;
  *)
    echo
    echo "Usage: $0 [dmgr|appserver]"
    ;;
esac

