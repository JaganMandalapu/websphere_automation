#
# My Custom Jython Script - file.py
#
# Create an application server template
AdminTask.createApplicationServerTemplate('[-nodeName aleas022Node01 -serverName server1 -templateName custom_template -description custom_template ]')

# Save the configuration
AdminConfig.save()

# Create a cluster without a member
AdminClusterManagement.createClusterWithoutMember("cluster1")

# Create a cluster with first member using a custom template
AdminClusterManagement.createFirstClusterMemberWithTemplate("cluster1", "aleas022Node01", "server2", "custom_template")

# Add a second member to the cluster
AdminClusterManagement.createClusterMember("cluster1", "aleas022Node01", "server3")

# Start all servers and applications on the node
AdminServerManagement.startAllServers("aleas022Node01")

# Save everything
AdminConfig.save()
