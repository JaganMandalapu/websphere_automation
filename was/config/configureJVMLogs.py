import sys

def configureJVMLogs(serverName, logDir):
  logDir = logDir.strip()
  if (logDir[len(logDir) - 1] != '/'):
    logDir = logDir + "/"
  server = AdminConfig.getid('/Server:' + serverName)
  errLog = serverName + '_SystemErr.log'
  outLog = serverName + '_SystemOut.log'
  setFile(AdminConfig.showAttribute(server, 'errorStreamRedirect'), logDir, errLog)
  setFile(AdminConfig.showAttribute(server, 'outputStreamRedirect'), logDir, outLog)

def setFile(streamId, logDir, fileName):
  AdminConfig.modify(streamId, [['fileName', logDir + fileName]])

n1 = sys.argv[0]
n2 = sys.argv[1]

configureJVMLogs(n1, n2)

AdminConfig.save()

