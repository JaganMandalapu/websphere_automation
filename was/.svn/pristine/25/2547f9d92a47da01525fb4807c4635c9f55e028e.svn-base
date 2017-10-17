import re, sys

server = sys.argv[0]
n = sys.argv[1]
node = '[-nodeName ' + n + ']'

listPorts = AdminTask.listServerPorts(server, node)

for row in listPorts.split("\n"):
  if re.search("WC_defaulthost", row):
    port = re.compile('port (\d+)')
    print(port.findall(row)[0])

