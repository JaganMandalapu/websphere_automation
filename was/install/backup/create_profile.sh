#!/bin/bash
source /data/shared_scripts/resources.sh
ID=`id -un`
profile_type=$1
was_install_dir=$2
profilename_dmgr=$3
profilename_appserver=$4
create_profile_log=$5
host_name=`hostname`
run_as_id=root

if [ $ID != "$run_as_id" ] ; then
  echo "The script needs to be run as $run_as_id"
  echo "Exiting now.."
  exit 1
fi

cat << dmgr > /data/scripts/logs/dmgr.txt
create
profileName=$profilename_dmgr
profilePath=$was_install_dir/profiles/$profilename_dmgr
templatePath=$was_install_dir/profileTemplates/dmgr
nodeName=${host_name}CellManager9
cellName=${host_name}Cell9
hostname=$host_name
startingPort=9000
validatePorts
isDefault
dmgr

cat << appserver > /data/scripts/logs/appserver.txt
create
profileName=$profilename_appserver
profilePath=$was_install_dir/profiles/$profilename_appserver
templatePath=$was_install_dir/profileTemplates/default
nodeName=${host_name}Node9
hostname=$host_name
startingPort=9100
validatePorts
omitAction=deployAdminConsole,defaultAppDeployAndConfig,deployIVTApplication
appserver

createDmgr() {
  if [ -d $was_install_dir/profiles/$profilename_dmgr ] ; then
    echo "$was_install_dir/profiles/$profilename_dmgr already exists. Please check if $profilename_dmgr profile exists."
    echo "Exiting now.."
    exit 1
  fi

  $was_install_dir/bin/manageprofiles.sh -response /data/scripts/logs/dmgr.txt >> $create_profile_log
}

createAppServer() {
  if [ -d $was_install_dir/profiles/$profilename_appserver ] ; then
    echo "was_install_dir/profiles/$profilename_appserver already exists. Please check if $profilename_appserver profile exists."
    echo "Exiting now.."
    exit 1
  fi

  $was_install_dir/bin/manageprofiles.sh -response /data/scripts/logs/appserver.txt >> $create_profile_log
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

