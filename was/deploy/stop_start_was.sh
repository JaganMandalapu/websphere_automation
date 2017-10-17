#!/bin/bash
source /data/shared_scripts/resources.sh
ID=`id -un`
profile=$2
WAS_ADMIN_PASSWORD=$3

if [ $ID != "$RUN_AS_ID" ] ; then
  echo "The script needs to be run as $RUN_AS_ID"
  echo "Exiting now.."
  exit 1
fi

wasprof=$WAS_INSTALL_DIR/profiles
profiles=`ls $wasprof`

stop_profile() {
  for i in $profiles ; do
    if [[ $profile == $i ]] ; then
      if [[ $i == *"Dmgr"* ]] ; then
        $WAS_INSTALL_DIR/bin/stopManager.sh -username $WAS_ADMIN_ID -password $WAS_ADMIN_PASSWORD >> /data/scripts/logs/WAS/stop_$profile.log
      elif [[ $i == *"AppServer"* ]] ; then
        $WAS_INSTALL_DIR/bin/stopServer.sh nodeagent -profileName $i -username $WAS_ADMIN_ID -password $WAS_ADMIN_PASSWORD >> /data/scripts/logs/WAS/stop_$profile.log
      else
        echo "$profile not found!"
      fi
    fi
  done
}

start_profile() {
  for i in $profiles ; do
    if [[ $profile == $i ]] ; then
      if [[ $i == *"Dmgr"* ]] ; then
        $WAS_INSTALL_DIR/bin/startManager.sh >> /data/scripts/logs/WAS/start_$profile.log
      elif [[ $i == *"AppServer"* ]]; then
        $WAS_INSTALL_DIR/bin/startServer.sh nodeagent -profileName $i >> /data/scripts/logs/WAS/start_$profile.log
      else
        echo "$profile not found!"
      fi
    fi
  done
}

restart_profile() {
  stop_profile
  start_profile
}

case $1 in
  stop)
    echo
    echo "Stopping the $profile process"
    echo
    stop_profile
    ;;
  start)
    echo
    echo "Starting the $profile process"
    echo
    start_profile
    ;;
  restart)
    echo
    echo "Restarting the $profile process"
    echo
    restart_profile
    ;;
  *)
    echo
    echo "Usage $0 [stop|start|restart profileName <password>]"
esac

