import sys
from tolist import tolist

virtualHost = sys.argv[0]

def printVirtualHostAliases(virtualHost):
  vh = AdminConfig.getid("/VirtualHost:" + virtualHost)
  if len(vh) > 0:
    for al in tolist(AdminConfig.showAttribute(vh, 'aliases')):
      print "%s:%s" % (AdminConfig.showAttribute(al, 'hostname'), AdminConfig.showAttribute(al, 'port'))
  else:
    print "VirtualHost '%s' not found" % (virtualHost)

printVirtualHostAliases(virtualHost)

