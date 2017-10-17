#!/bin/bash 

ports=`/opt/software/IBM/WebSphere9/AppServer/profiles/Dmgr/bin/wsadmin.sh -lang jython \
  -username wasadmin -password appserv4admin -f /data/shared_scripts/config/listServerPorts.py tread_appserver alsqad002Node_SQ | sed '1,2d'`

ports=($ports)

echo ${ports[0]}
echo ${ports[1]}
