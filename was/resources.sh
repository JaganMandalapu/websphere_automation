#Define global variables needed for WebSphere installation and configuration
RUN_AS_ID=webadm
RUN_AS_ID_PASSWORD=h1ghball
WAS_ADMIN_ID=wasadmin
WAS_ADMIN_PASSWORD=appserv4admin
IM_DIR=/opt/software/IBM/InstallationManager/eclipse
IM_REPO=/data/binaries/ibm/websphere/IM18
IM_INSTALL_LOG=/data/scripts/logs/IM/im_install.log
AGENT_DATA=/opt/software/IBM/AgentData
IM_SHARE=/opt/software/IBM/IMShare
WAS_INSTALL_DIR=/opt/software/IBM/WebSphere9/AppServer
WAS_REPO=/data/binaries/ibm/websphere/WAS9
SDK_REPO=/data/binaries/ibm/websphere/SDK8
IMCL_LOCATION=/opt/software/IBM/InstallationManager/eclipse/tools
WAS_INSTALL_LOG=/data/scripts/logs/WAS/was_install.log
PLG_INSTALL_DIR=/opt/software/IBM/WebSphere9/Plugins
PLG_REPO=/data/binaries/ibm/websphere/PLG9
PLG_INSTALL_LOG=/data/scripts/logs/PLG/plugin_install.log
WAS_FIX_REPO=/data/binaries/ibm/websphere/patch/WAS9
WAS_UPDATE_LOG=/data/scripts/logs/WAS/was_update.log
WSADMIN_DIR=/opt/software/IBM/WebSphere9/AppServer/profiles/Dmgr/bin
WAS_VERSION=was9

