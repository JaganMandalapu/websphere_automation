#
# My Custom Jython Script - file.py
#
#AdminServerManagement.createApplicationServer("aleas022Node01", "Server1", "default")
#AdminServerManagement.createApplicationServer("aleas022Node01", "Server2", "default")

# Use one of them as the first member of a cluster
#AdminClusterManagement.createClusterWithFirstMember("cluster1", "APPLICATION_SERVER","aleas022Node01", "Server2")

AdminClusterManagement.createFirstClusterMemberWithTemplateNodeServer("cluster1", "APPLICATION_SERVER", "server2", "aleas022Node01", "server1")

# Add a second member to the cluster
AdminClusterManagement.createClusterMember("cluster1", "aleas022Node01", "Server3")


# Start all servers and applications on the node
AdminServerManagement.startAllServers("aleas022Node01")
