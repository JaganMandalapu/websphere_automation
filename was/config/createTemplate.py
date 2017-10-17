# Create an application server template
import sys
#AdminTask.createApplicationServerTemplate('[-nodeName aleas022Node01 -serverName server1 -templateName custom_template -description custom_template ]')
#AdminTask.createApplicationServerTemplate('[-nodeName sys.argv[0] -serverName sys.argv[1] -templateName sys.argv[2] -description sys.argv[3] ]')

n1 = sys.argv[0]
n2 = sys.argv[1]
n3 = sys.argv[2]

plist = "[-nodeName " + n1 + " -serverName " + n2 + " -templateName " + n3 + "]"
print plist
AdminTask.createApplicationServerTemplate(plist)
# Save the configuration
AdminConfig.save()

