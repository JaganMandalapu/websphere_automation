#!/bin/bash

vhost=$1

/opt/software/IBM/WebSphere9/AppServer/profiles/Dmgr/bin/wsadmin.sh -lang jython -username wasadmin -password appserv4admin \
 -f /data/shared_scripts/config/printVirtualHostAliases.py $vhost
