import sys
# Usage: createVirtualHostWithAliases('myhost', [['host1.com', 80], ['secure.host.com', 443]])
n1 = sys.argv[0]
n2 = sys.argv[1]
n3 = sys.argv[2]
n4 = sys.argv[3]

aliases = [['*', n2], ['*', n3], [n4, 80], [n4, 443]]

def createVirtualHostWithAliases (virtualHostName, aliases):
  virtualHost = AdminConfig.create("VirtualHost", AdminConfig.list("Cell"), [["name", virtualHostName]])
  for alias in aliases:
    AdminConfig.create("HostAlias", virtualHost, [["hostname", alias[0]], ["port", alias[1]]])

createVirtualHostWithAliases(n1, aliases)
AdminConfig.save()

