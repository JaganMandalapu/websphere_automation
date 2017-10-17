# Create an application server instance
import sys
# Usage: AdminServerManagement.checkIfServerExists ( nodeName, serverName)
# Usage: AdminServerManagement.createApplicationServer( nodeName, serverName, templateName)
# Usage: AdminServerManagement.setJVMProperties( nodeName, serverName, classpath, bootClasspath, initHeapsize, maxHeapsize, debugMode, debugArgs)

n1 = sys.argv[0]
n2 = sys.argv[1]
n3 = sys.argv[2]
n4 = sys.argv[3]
n5 = sys.argv[4]
n6 = ""

serverExists = AdminServerManagement.checkIfServerExists(n1, n2)
print serverExists
if (serverExists == 1):
 print "A server with the same name exists"
 sys.exit()

AdminServerManagement.createApplicationServer(n1, n2, n3)

AdminServerManagement.setJVMProperties(n1, n2, n6, n6, n4, n5, n6, n6)

# Save the configuration
AdminConfig.save()

