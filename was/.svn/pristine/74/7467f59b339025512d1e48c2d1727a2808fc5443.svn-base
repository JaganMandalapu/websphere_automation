#!/bin/bash

WAS_INSTALL_DIR=/opt/software/IBM/WebSphere9/AppServer
WSADMIN_DIR=$WAS_INSTALL_DIR/profiles/Dmgr9/bin

NODES=`$WSADMIN_DIR/wsadmin.sh -lang jython -f /data/scripts/wsadmin/listNodes.py 2>&1`
echo "Nodes: $NODES"
#export $NODES
