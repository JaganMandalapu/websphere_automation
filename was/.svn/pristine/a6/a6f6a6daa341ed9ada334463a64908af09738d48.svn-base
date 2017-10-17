#!/bin/bash
# This scripts calls createTemplate.py to create a custom application server template

WAS_INSTALL_DIR=/opt/software/IBM/WebSphere9/AppServer
WSADMIN_DIR=$WAS_INSTALL_DIR/profiles/Dmgr9/bin

echo "Line 1"
createTemplate_script=/data/scripts/wsadmin/createTemplate.py

echo "Line 2"
#AdminNodeManagement.listNodes()
source /data/scripts/wsadmin/listNodes.sh > /dev/null 2>&1

echo "Line 3"
echo "Nodes: $NODES"

#for i in `echo $NODES` ; do
  #AdminTask.createApplicationServerTemplate('[-nodeName aleas022Node01 -serverName server1 -templateName custom_template ]')
#  $WSADMIN_DIR/wsadmin.sh -lang jython -f $createTemplate_script $i server1 ${i}_template
#done

