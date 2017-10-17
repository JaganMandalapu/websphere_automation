#----------------------------------------------------------------
# Display End Point info
#----------------------------------------------------------------
def displayEndPointsFunc (  ):

        print ""
        print "================================================================"
        print "WebSphere Application Server End Points"
        print "================================================================"
        print ""
        print "Node                      Server                  EndPoint Name                           Port"
        print "====                      ======                  =============                           ===="

        cells = AdminConfig.list("Cell" )
cells = wsadminToList(cells)

        for cell in cells:
                nodes = AdminConfig.list("Node", cell )
nodes = wsadminToList(nodes)
                for node in nodes:
                        hostName = AdminConfig.showAttribute(node, "name" )
                        serverIndices = AdminConfig.list("ServerIndex", node )
serverIndices = wsadminToList(serverIndices)

                        for serverIndex in serverIndices:
                                entries = AdminConfig.list("ServerEntry", serverIndex )
                                entries = wsadminToList(entries)
                                for entry in entries:
                                        serverName = AdminConfig.showAttribute(entry, "serverName" )
                                        endPoints = AdminConfig.showAttribute(entry, "specialEndpoints" )
endPoints = wsadminToList(endPoints)
                                        for endPoint in endPoints:
                                                endPointName = AdminConfig.showAttribute(endPoint, "endPointName" )
                                                endPointPortHost = AdminConfig.showAttribute(endPoint, "endPoint" )
                                                endPointPort = AdminConfig.showAttribute(endPointPortHost, "port" )
                                                endPointHost = AdminConfig.showAttribute(endPointPortHost, "host" )

                                                print hostName+"         "+serverName+"             "+endPointName+"                   "+str(endPointPort)+" "
                                        #endFor
                                #endFor
                        #endFor
                #endFor
        #endFor
        print ""
        print "================================================================"
        print ""
#endDef

