# WARPnet Client<->Server Architecture
# WARPnet Server system
#
# Author: Siddharth Gupta

from warpnet_common_params import *
from warpnet_server_params import *
from twisted.internet import stdio, reactor
from twisted.internet.protocol import Protocol, Factory, ClientFactory
from twisted.protocols.basic import NetstringReceiver, LineReceiver
import struct, json, cPickle, Queue, pprint, time
import pcapy
from impacket import ImpactPacket

debugLevel = 0	# Determines if the server prints data to the command line. To enable debug mode call

ethInterface = ''
serverPort = 10101
localMacAddress = range(0,6)

timePcapFactory = 0
timePcapSend = 0

# A class created for comparison purposes. A dontcare will always return True when compared to another integer. This allows for a
# very general search/subset function when using the registration and lock controllers
class dontcare(int):
	def __eq__(self, other):
		return True
	
	def __ne__(self, other):
		return False

# This class is responsible for tracking all the existing controllers connected to the server. It keeps track
# of two structures: (1) a list of the controller instance, the id and connected groups, (2) a dictionary where the
# key is the group and the value is a list of controllers that belong to that group id.
class controllerConnection():
	def __init__(self):
		self.contList = []
		self.grpDict = dict()
		self.availableCont = range(1,256)	# New controller ids are handed out based on available ones. Once a controller
											# disconnectes its id is put back into the list

	# Called once when a new controller joins. Is assigned an available id and added to the controller instance list
	def addNewConn(self, cInst):
		cID = self.availableCont.pop(0);
		self.contList.append((cInst, cID, []))
		return cID

	# Called when a controller disconnects. Get rid of the instance from the controller list and any references to it in the group dictionary.
	def deleteInst(self, cInst):
		for x in self.contList[:]:	#make a copy of the list before mutating it
			if x[0] == cInst:
				cID = x[1]
				self.contList.remove(x)
		for x in self.grpDict.keys():
			if cID in self.grpDict[x]:
				self.grpDict[x].remove(cID)
		self.availableCont.append(cID)	# Let the server re-assign the id to a controller
	
	# Return the instance of the controller given the controllerID
	def getInst(self, cID):
		for x in self.contList:
			if (x[1] == cID):
				return x[0]
		return None
	
	# Return all controllers that are part of a group
	def getIDs(self, cGrp):
		return self.grpDict(cGrp)
	
	# Check if a given controller is part of a group
	def inGrp(self, cID, cGrp):
		for x in self.contList:
			if (x[1] == cID):
				if cGrp in x[2]:
					return True
				break
		return False
		
	# Add a group association to a controller ID. The group is added to both the controller list and group dictionary.
	def addGrp(self, cID, cGrp):
		for x in self.contList:
			if x[1] == cID:
				if cGrp in x[2]:
					return SC_GRPID_GROUP_KNOWN
				else:
					x[2].append(cGrp)

		if cGrp not in self.grpDict.keys():
			self.grpDict[cGrp] = [cID]
		else:
			self.grpDict[cGrp].append(cID)

		return SC_GRPID_SUCCESS
	
	# Delete a group association for a particular controller id.
	def delGrp(self, cID, cGrp):
		for x in self.contList:
			if x[1] == cID:
				if cGrp in x[2]:
					x[2].remove(cGrp)
				
		if cID in self.grpDict[cGrp]:
			self.grpDict[cGrp].remove(cID)

		return SC_GRPID_SUCCESS
	
	# Returns the number of groups that a controller is associated with
	def numGrps(self, cID):
		for x in self.contList:
			if x[1] == cID:
				return len(x[2])
	
	# Display the state of the two lists
	def disp(self):
		print 'Controller List:'
		pprint.pprint(self.contList)
		print 'Group Dictionary:'
		pprint.pprint(self.grpDict)
		

# This class keeps track of all registrations in the system.
class registrationMaster():
	
	def __init__(self):
		self.regList = []
	
	def addRegistration(self, cID, cGrp, cInst, structID, nodeID, accessLevel):
		self.deleteRegistration(cID, cGrp, cInst, structID, nodeID)
		regToAdd = (cInst, cID, cGrp, structID, nodeID, accessLevel)
		self.regList.append(regToAdd)
		return SC_REG_SUCCESS

	def deleteRegistration(self, cID, cGrp, cInst, structID, nodeID):
		listOfRegs = self.subsetQuery(cID=cID, cGrp=cGrp, cInst=cInst, structID=structID, nodeID=nodeID)
		for x in listOfRegs:
			self.regList.remove(x)
		return SC_REG_SUCCESS
	
	def deleteRegistrationAll(self, cID):
		listOfRegs = self.subsetQuery(cID=cID)
		for x in listOfRegs:
			self.regList.remove(x)

	def deleteRegistrationGroup(self, cID, cGrp):
		listOfRegs = self.subsetQuery(cID=cID, cGrp=cGrp)
		for x in listOfRegs:
			self.regList.remove(x)

	def filterRegs(self, cID, cGrp, structID, nodeID, makeAvailable, excludeSelf=False):
		listOfNodes = []
		
		if makeAvailable == MAKE_AVAIL_ME:
			listOfNodes = self.subsetQuery(cID=cID, cGrp=cGrp, structID=structID, nodeID=nodeID)
		elif makeAvailable == MAKE_AVAIL_MY_GROUP:
			listOfNodes = self.subsetQuery(cID=cID, cGrp=cGrp, structID=structID, nodeID=nodeID, accessLevel=ADDRESSED_TO_ME)
			listOfNodes.extend(self.subsetQuery(cGrp=cGrp, structID=structID, nodeID=nodeID, accessLevel=ADDRESSED_TO_MY_GROUP))
			listOfNodes.extend(self.subsetQuery(cGrp=cGrp, structID=structID, nodeID=nodeID, accessLevel=ADDRESSED_TO_ANY_GROUP))
		elif makeAvailable == MAKE_AVAIL_ANY_GROUP:
			listOfNodes = self.subsetQuery(cID=cID, cGrp=cGrp, structID=structID, nodeID=nodeID, accessLevel=ADDRESSED_TO_ME)
			listOfNodes.extend(self.subsetQuery(cGrp=cGrp, structID=structID, nodeID=nodeID, accessLevel=ADDRESSED_TO_MY_GROUP))
			listOfNodes.extend(self.subsetQuery(structID=structID, nodeID=nodeID, accessLevel=ADDRESSED_TO_ANY_GROUP))
		
		#print 'filter regs list %s' % listOfNodes

		if excludeSelf:
			for x in listOfNodes[:]:
				if x[1] == cID and x[2] == cGrp:
					listOfNodes.remove(x)
		
		#print 'filter regs list after exclusion %s' % listOfNodes
		
		return self.makeInstanceList(listOfNodes)
	
	def filterRegsLockNotification(self, structID, nodeID, excludeID):
		masterList = self.subsetQuery(structID=structID, nodeID=nodeID)
		IDlist = []
		for x in masterList[:]:	#make a copy of the list and iterate over that because the iterated list is being mutated
			if (x[1] in IDlist) or (x[1] == excludeID):
				masterList.remove(x)
			else:
				IDlist.append(x[1])
		#print "lock notification list %s" % masterList
		return self.makeIDList(masterList)
	
	def isRegistered(self, cID, structID, nodeID):
		list = self.subsetQuery(cID=cID, structID=structID, nodeID=nodeID)
		if len(list) > 0:
			return True
		else:
			return False
		
	def subsetQuery(self, cID=dontcare(), cGrp=dontcare(), cInst=dontcare(), structID=dontcare(), nodeID=dontcare(), accessLevel=dontcare()):
		tempList = []
		#print "master set reg %s" % self.regList
		compTuple = (cInst, cID, cGrp, structID, nodeID, accessLevel)
		for x in self.regList:
			if x == compTuple:
				tempList.append(x)
		#print "subset reg %s" % tempList
		return tempList
	
	def makeInstanceList(self, registrations):
		tempInstList = []
		for x in registrations:
			tempInstList.append(x[0])
		return tempInstList

	def makeIDList(self, registrations):
		tempInstList = []
		for x in registrations:
			tempInstList.append(x[1])
		return tempInstList
		
	def disp(self):
		print 'Registration List'
		pprint.pprint(self.regList)
	
class lockMaster():
	
	def __init__(self):
		self.lockList = []
		
	def addLock(self, cID, cGrp, structID, nodeID):
		locks = self.subsetQuery(structID=structID, nodeID=nodeID)
		if len(locks) > 0:
			return SC_LOCK_EXISTS
		lockToAdd = (cID, cGrp, structID, nodeID)
		self.lockList.append(lockToAdd)
		return SC_LOCK_SUCCESS
			
	def deleteLock(self, cID, cGrp, structID, nodeID):
		locks = self.subsetQuery(structID=structID, nodeID=nodeID)
		if len(locks) == 1:
			if locks[0][0] == cID and locks[0][1] == cGrp:
				self.lockList.remove(locks[0])
				return SC_LOCK_SUCCESS
			else:
				return SC_LOCK_NOT_OWNER
		elif len(locks) == 0:
			return SC_LOCK_NOLOCK
		elif len(locks) > 1:
			raise Duplicate_Locks
	
	def isLocked(self, requester_cID, requester_cGrp, structID, nodeID):
		locks = self.subsetQuery(structID=structID, nodeID=nodeID)
		if len(locks) == 0:
			return False
		elif len(locks) == 1:
			if locks[0][0] == requester_cID and locks[0][1] == requester_cGrp:
				return False
			else:
				return True
		else:
			raise Duplicate_Locks
	
	def deleteLocksID(self, cID=dontcare(), cGrp=dontcare()):
		locks = self.subsetQuery(cID=cID, cGrp=cGrp)
		tempList = []
		for x in locks:
			tempList.append(x)
			self.lockList.remove(x)
		return tempList
		

	def subsetQuery(self, cID=dontcare(), cGrp=dontcare(), structID=dontcare(), nodeID=dontcare()):
		tempList = []
		#print "master set lock %s" % self.lockList
		compTuple = (cID, cGrp, structID, nodeID)
		for x in self.lockList:
			if x == compTuple:
				tempList.append(x)
		#print "subset lock %s" % tempList
		return tempList

	def disp(self):
		print 'Lock List:'
		pprint.pprint(self.lockList)


# Class definition to handle processing of all controller messages. In addition it keeps track of registrations and locks
class ProcessControllerData():

	# The WARPnetFactory instantiates this class and gives it its own instance. This lets the class send messages to specific controllers
	def __init__(self, factory):
		self.factory = factory
		self.procFunc = {
						SC_REG_ADD: self.pc_reg,
						SC_REG_DEL: self.pc_dereg,
						SC_GRPID_ADD: self.pc_group_add,
						SC_GRPID_DEL: self.pc_group_del,
						SC_LOCK: self.pc_lock,
						SC_UNLOCK: self.pc_unlock,
						SC_CONNECT: self.pc_connect,
						SC_DATA_TO_NODE: self.pc_data,
						SC_EMULATOR_PRESENT: self.emulator,
						}; #register each of the handlers

	# Input function that hands off the received message to the appropriate handler.
	def controllerMsg(self, controllerID, data):
		if controllerID != -1:
			try:
				self.procFunc[data['pktType']](controllerID, data)
			except KeyError:
				print "not defined yet %s" % data
	
	# Handler for the registration message
	def pc_reg(self, controllerID, data):
		if debugLevel > 0:
			print "regAdd %s" % data
		group = data['grp']
		node = data['nodeID']
		if self.factory.controllers.inGrp(controllerID, group):
			if self.factory.nodeManager.isConnected(node, controllerID, group):
				for x in data['structID']:
					status = self.factory.regManager.addRegistration(controllerID, group, self.factory.controllers.getInst(controllerID), x, node, data['accessLevel'])
				self.sendStatus(controllerID, status, SC_REG_ADD)
				for x in data['structID']:
					if self.factory.lockManager.isLocked(controllerID, group, x, node):
						self.sendLockNotification(controllerID, x, node)
			else:
				self.sendStatus(controllerID, SC_STAT_NOT_CONN_NODE, SC_REG_ADD)
		else:
			self.sendStatus(controllerID, SC_STAT_GROUP_UNMATCHED, SC_REG_ADD)

	
	def pc_dereg(self, controllerID, data):
		if debugLevel > 0:
			print "regDel %s" % data
		group = data['grp']
		if self.factory.controllers.inGrp(controllerID, group):
			for x in data['structID']:
				status = self.factory.regManager.deleteRegistration(controllerID, group, self.factory.controllers.getInst(controllerID), x, data['nodeID'])
			self.sendStatus(controllerID, status, SC_REG_DEL)
		else:
			self.sendStatus(controllerID, SC_STAT_GROUP_UNMATCHED, SC_REG_DEL)
	
	def pc_unlock(self, controllerID, data):
		if debugLevel > 0:
			print "unlock %s" % data
		group = data['grp']
		structID = data['structID']
		node = data['nodeID']
		if self.factory.controllers.inGrp(controllerID, group):
			status = self.factory.lockManager.deleteLock(controllerID, group, structID, node)
			self.sendStatus(controllerID, status, SC_UNLOCK)
			if status == SC_LOCK_SUCCESS:
				notificationList = self.factory.regManager.filterRegsLockNotification(structID, node, controllerID)
				for x in notificationList:
					self.sendUnlockNotification(x, structID, node)
		else:
			self.sendStatus(controllerID, SC_STAT_GROUP_UNMATCHED, SC_UNLOCK)


	def pc_lock(self, controllerID, data):
		if debugLevel > 0:
			print "lock %s" % data
		group = data['grp']
		structID = data['structID']
		node = data['nodeID']
		if self.factory.controllers.inGrp(controllerID, group):
			if self.factory.regManager.isRegistered(controllerID, structID, node):
				status = self.factory.lockManager.addLock(controllerID, group, structID, node)
				self.sendStatus(controllerID, status, SC_LOCK)
				if status == SC_LOCK_SUCCESS:
					notificationList = self.factory.regManager.filterRegsLockNotification(structID, node, controllerID)
					for x in notificationList:
						self.sendLockNotification(x, structID, node)
			else:
				self.sendStatus(controllerID, SC_NOT_REGISTERED, SC_LOCK)
		else:
			self.sendStatus(controllerID, SC_STAT_GROUP_UNMATCHED, SC_LOCK)

	
	def pc_group_add(self, controllerID, data):
		if debugLevel > 0:
			print "grp_add %s" % data
		group = data['grp']
		statCode = self.factory.controllers.addGrp(controllerID, group)
		self.sendStatus(controllerID, statCode, SC_GRPID_ADD)
		
	def pc_group_del(self, controllerID, data):
		if debugLevel > 0:
			print "grp_del %s" % data
		group = data['grp']
		if self.factory.controllers.inGrp(controllerID, group):
			statCode = self.factory.controllers.delGrp(controllerID, group)
			self.sendStatus(controllerID, statCode, SC_GRPID_DEL)
			self.factory.regManager.deleteRegistrationGroup(controllerID, group)
			self.factory.nodeManager.deleteGroup(controllerID, group)
			#if self.factory.controllers.numGrps(controllerID) == 0:
			#	self.deleteAllLocks(controllerID)	
			listOfDeletedLocks = self.factory.lockManager.deleteLocksID(controllerID, group)
			self.sendNotificationsForList(listOfDeletedLocks)
		else:
			self.sendStatus(controllerID, SC_STAT_GROUP_UNMATCHED, SC_GRPID_DEL)
	

	def pc_connect(self, controllerID, data):
		if debugLevel > 0:
			print "connect %s" % data
		group = data['grp']
		connectList = data['connList']
		if self.factory.controllers.inGrp(controllerID, group):
			for x in connectList:
				node = x[0]
				type = x[1]
				if type == NODE_PCAP:
					statCode = self.factory.nodeManager.addConnection(node, type, controllerID, group)
				elif type == NODE_SOCKET:
					statCode = self.factory.nodeManager.addConnection(node, type, controllerID, group, x[2])
				else:
					statCode = SC_CONNECT_UNKNOWN_TYPE
				if statCode != SC_CONNECT_SUCCESS:
					self.sendStatus(controllerID, statCode, SC_CONNECT)
					return
			self.sendStatus(controllerID, statCode, SC_CONNECT)
		else:
			self.sendStatus(controllerID, SC_STAT_GROUP_UNMATCHED, SC_CONNECT)
	
	
	def pc_data(self, controllerID, data):
		if debugLevel > 0:
			print "data to node %s" % data
		group = data['grp']
		structID = data['structID']
		node = data['nodeID']
		availability = data['access']
		dataToSend = str(data['raw'])
		if self.factory.controllers.inGrp(controllerID, group):
			if self.factory.regManager.isRegistered(controllerID, structID, node):
				if not self.factory.lockManager.isLocked(controllerID, group, structID, node):
					self.factory.nodeManager.sendToNode(controllerID, group, structID, node, dataToSend, availability, ETH_HEADER)
					notificationList = self.factory.regManager.filterRegs(controllerID, group, structID, node, availability, True)
					self.factory.sendData_cInsts(notificationList, SC_DATA_TO_NODE_REFLECT, {'structID': structID, 'nodeID': node, 'raw': dataToSend})
				else:
					self.sendStatus(controllerID, SC_DATA_LOCKED, SC_DATA_TO_NODE)
			else:
				self.sendStatus(controllerID, SC_NOT_REGISTERED, SC_DATA_TO_NODE)
		else:
			self.sendStatus(controllerID, SC_STAT_GROUP_UNMATCHED, SC_DATA_TO_NODE)
		
		
	def pc_data_from_node(self, controllerID, groupID, structID, nodeID, access, rawData, pcapts):
		notificationList = self.factory.regManager.filterRegs(controllerID, groupID, structID, nodeID, access, False)
		self.factory.sendData_cInsts(notificationList, SC_DATA_FROM_NODE, {'structID': structID, 'nodeID': nodeID, 'raw': rawData, 'pcapts': pcapts})
	
	def sendStatus(self, controllerID, statCode, reqType):
		self.factory.sendData_cID(controllerID, SC_STAT, {'stat': statCode, 'reqType': reqType})
		
	def sendLockNotification(self, cID, structID, node):
		self.factory.sendData_cID(cID, SC_LOCK_NOTIFICATION, {'structID': structID, 'nodeID': node})
		
	def sendUnlockNotification(self, cID, structID, node):
		self.factory.sendData_cID(cID, SC_UNLOCK_NOTIFICATION, {'structID': structID, 'nodeID': node})
	
	def sendNotificationsForList(self, listOfDeletedLocks):
		#listOfDeletedLocks = self.factory.lockManager.deleteLockAll(controllerID)
		for lock in listOfDeletedLocks:
			notificationList = self.factory.regManager.filterRegsLockNotification(lock[2], lock[3], lock[0])
			for x in notificationList:
				self.sendUnlockNotification(x, lock[2], lock[3])
				
	def emulator(self, controllerID, data):
		import warpnet_server_azimuth
		emulatorProcessor = warpnet_server_azimuth.processEmulatorMsg(self.factory, controllerID, data['ip'])
		self.procFunc[SC_EMULATOR_MSG_TO_BOX] = emulatorProcessor.message
	
# Class definition of the protocol for WARPnetServer. It is an implementation of NetstringReceiver that does the type checking to ensure
# that all received messages are valid netstrings
class WARPnetServer(NetstringReceiver):

	id = -1

	# Once the data received, pass the data onto the processor to take action
	def stringReceived(self, data):
		dataDict = cPickle.loads(data)
		self.factory.processor.controllerMsg(self.id, dataDict)
	
	# Once the connection is made, assign a new id, send it to the controller.
	def connectionMade(self):
		# Connection added to master list with no group affiliations
		self.id = self.factory.controllers.addNewConn(self)
		print "Connected to %d" % self.id

		
	# If the client disconnects, remove its id from the controllerList and all its registrations and locks
	def connectionLost(self, reason):
		# Delete the connection from the list structure. Delete any registrations and locks that may exist
		listOfDeletedLocks = self.factory.lockManager.deleteLocksID(self.id)
		self.factory.processor.sendNotificationsForList(listOfDeletedLocks)
		self.factory.regManager.deleteRegistrationAll(self.id)
		self.factory.controllers.deleteInst(self)
		self.factory.nodeManager.deleteController(self.id)
		print "Lost connection to %d" % self.id
		
		
		
# This is the factory class that is responsible for keeping track of all open connections to the controllers
class WARPnetFactory(Factory):

	protocol = WARPnetServer
	
	def __init__(self):
		self.processor = ProcessControllerData(self)
		self.controllers = controllerConnection()
		self.lockManager = lockMaster()
		self.regManager = registrationMaster()
		self.nodeManager = NodeManager(self)
	
	
	def sendDataToController(self, cInst, type, dataDict):
		dictToSend = {'pktType': type}
		dictToSend.update(dataDict)
		cInst.sendString(cPickle.dumps(dictToSend))

	def sendData_cID(self, controllerID, type, dataDict):
		idInst = self.controllers.getInst(controllerID)
		if idInst != None:
			self.sendDataToController(idInst, type, dataDict)
	
	def sendData_cInsts(self, cInsts, type, dataDict):
		for cInst in cInsts:
			self.sendDataToController(cInst, type, dataDict)

# creates instances for new nodes. Pcap connections make pcapHandler instances and add the node number to the pcapLoop. Socket connections
# create a new factory/protocol instance that connects to it
class NodeManager():

	def __init__(self, factory):
		# need to initialize the two pcap loops
		self.factory = factory
		self.pcapRead = pcapReadLoop()
		pcapObj = self.pcapRead.getPcap()
		self.pcapWrite = pcapWriteLoop(pcapObj)
		self.existingConnections = dict()
		reactor.callInThread(self.pcapRead.passToFactory)
		reactor.callInThread(self.pcapRead.read)
		reactor.callInThread(self.pcapWrite.write)
		
	def addConnection(self, node, nodeType, cID, cGrp, ip=None):
		if node in self.existingConnections.keys():
			if self.existingConnections[node][0] != nodeType:
				return SC_CONNECT_TYPE_MISMATCH
			if (cID, cGrp) not in self.existingConnections[node][1]:
				self.existingConnections[node][1].append((cID, cGrp))
		else:
			self.existingConnections[node] = [nodeType, [(cID, cGrp)]]
			if nodeType == NODE_PCAP:
				instance = NodeConnectionClient(node, self, self.pcapWrite, self.pcapRead)
			elif nodeType == NODE_SOCKET:
				instance = NodeConnectionClient(node, self)
				reactor.connectTCP(ip, 10101, instance)
			self.existingConnections[node].append(instance)

		return SC_CONNECT_SUCCESS

	def isConnected(self, node, cID, cGrp):
		if (node in self.existingConnections.keys()) and ((cID, cGrp) in self.existingConnections[node][1]):
			return True
		else:
			return False

	def sendToNode(self, cID, cGrp, structID, nodeID, data, access, ethernetType):
		self.existingConnections[nodeID][2].sendStruct(cID, cGrp, structID, nodeID, data, access, ethernetType)
		
	def dataFromNode(self, cID, cGrp, structID, nodeID, access, rawData, pcapts):
		self.factory.processor.pc_data_from_node(cID, cGrp, structID, nodeID, access, rawData, pcapts)

	def deleteController(self, cID):
		self.deleteSubset(cID=cID)
	
	def deleteGroup(self, cID, cGrp):
		self.deleteSubset(cID=cID, cGrp=cGrp)

	def deleteSubset(self, cID=dontcare(), cGrp=dontcare()):
		for node in self.existingConnections.keys():
			data = self.existingConnections[node]
			for tuple in data[1][:]:
				if tuple == (cID, cGrp):
					data[1].remove(tuple)
			if len(data[1]) == 0:
				data[2].deleteConnection()
				del self.existingConnections[node]
	
	def disp(self):
		print 'NodeManager connections:'
		pprint.pprint(self.existingConnections)
		print 'PcapRead mux:'
		pprint.pprint(self.pcapRead.instMux)
		
class NodeSocketProtocol(Protocol):
	
	def connectionMade(self):
		self.factory.connection = self
	
	def dataReceived(self, data):
		structPkt = WARPnetStruct(data, False)
		node = structPkt.getNode()
		structID = structPkt.getStruct()
		controller = structPkt.getController()
		group = structPkt.getGroup()
		access = structPkt.getAccess()
		if debugLevel > 0:
			print 'received data from node %d' % node
		floatTimestamp = time.time()
		stringTimestamp = '%.6f' % floatTimestamp
		self.factory.rcvdValidStruct(controller, group, structID, node, access, structPkt.get_raw(), stringTimestamp, time.time())
		
	def sendData(self, data, ethernetType):
		self.transport.write(data)

	def disconnect(self):
		self.transport.loseConnection()


	
class NodeConnectionClient(ClientFactory):
	protocol = NodeSocketProtocol
	
	def __init__(self, id, manager, pcapWriteConn=None, pcapReadConn=None):
		self.manager = manager
		self.connection = pcapWriteConn
		self.readLink = pcapReadConn
		self.id = id
		if self.readLink != None:
			self.readLink.addToHandler(self.id, self)
		
	def sendStruct(self, cID, cGrp, structID, nodeID, data, access, ethernetType):
		structPacket = WARPnetStruct(data, True)
		structPacket.setController(cID)
		structPacket.setGroup(cGrp)
		structPacket.setAccess(access)
		structPacket.setStruct(structID)
		structPacket.setNode(nodeID)
		self.connection.sendData(structPacket, ethernetType)
		
	def deleteConnection(self):
		if self.readLink == None:
			self.connection.disconnect()
		else:
			self.readLink.delFromHandler(self.id)
			
	def rcvdValidStruct(self, cID, cGrp, structID, nodeID, access, raw, pcapts, processTime):
		#print 'valid struct'
		self.manager.dataFromNode(cID, cGrp, structID, nodeID, access, raw, pcapts)
		timePcapSend = time.time() - processTime


# One instance running in a thread that calls the appropriate pcap handler when data is received
class pcapReadLoop():

	def __init__(self):
		self.instMux = dict()
		self.pcapObj = pcapy.open_live(ethInterface, 1500, True, 2)
		self.pcapObj.setfilter('ether proto 0x%x' % ETH_RECEIVE)
		self.counter = 0
		self.recvdQueue = Queue.Queue()
	
	def getPcap(self):
		return self.pcapObj
		
	def read(self):
		while(reactor.running):
			self.pcapObj.loop(1, self.dataRcvd)

	def passToFactory(self):
		while(reactor.running):
			nextItem = self.recvdQueue.get()
			header = nextItem[0]
			data = nextItem[1]
			pkt = WARPnetEthernetHeader(aBuffer=data)
			off = pkt.get_header_size()
			if pkt.getNumStructs() == 1:
				self.counter += 1
				structPkt = WARPnetStruct(data[off:], False)
				node = structPkt.getNode()
				structID = structPkt.getStruct()
				controller = structPkt.getController()
				group = structPkt.getGroup()
				access = structPkt.getAccess()
				if debugLevel > 0:
					print 'received data from node %d' % node
				if node in self.instMux.keys():
					pcapTimestamp = header.getts()
					floatTimestamp = pcapTimestamp[0] + pcapTimestamp[1]/1000000.0
					stringTimestamp = '%.6f' % floatTimestamp
					reactor.callFromThread(self.instMux[node].rcvdValidStruct, controller, group, structID, node, access, structPkt.get_raw(), stringTimestamp, nextItem[2])
					timePcapFactory = time.time() - nextItem[2]

	def dataRcvd(self, header, data): #has to be made complex. parse impacket, find the node and mux on that to send it along
		self.recvdQueue.put((header, data, time.time()))
		#print 'received data'
#		pkt = WARPnetEthernetHeader(aBuffer=data)
#		off = pkt.get_header_size()
#		#print struct.unpack_from('6B', data[off:])
#		if pkt.getNumStructs() == 1:
#			self.counter += 1
#			structPkt = WARPnetStruct(data[off:], False)
#			node = structPkt.getNode()
#			structID = structPkt.getStruct()
#			controller = structPkt.getController()
#			group = structPkt.getGroup()
#			access = structPkt.getAccess()
#			if debugLevel > 0:
#				print 'received data from node %d' % node
#			if node in self.instMux.keys():
#				pcapTimestamp = header.getts()
#				floatTimestamp = pcapTimestamp[0] + pcapTimestamp[1]/1000000.0
#				stringTimestamp = '%.6f' % floatTimestamp
#				reactor.callFromThread(self.instMux[node].rcvdValidStruct, controller, group, structID, node, access, structPkt.get_raw(), stringTimestamp)

		#printData = "Source Address: %s" % pkt.get_ether_shost()
		#print printData
		#reactor.callFromThread(cmdreader.print_stdio, printData)

	def addToHandler(self, nodeID, instance):
		self.instMux[nodeID] = instance
	
	def delFromHandler(self, nodeID):
		del self.instMux[nodeID]
		
class pcapWriteLoop():

	def __init__(self, pcapObj):
		self.pcapObj = pcapObj
		self.writeQueue = Queue.Queue()
	
	def sendData(self, structPacket, ethernetType): # has to be much more complex. must create the impacket and send full structure
		ethPkt = WARPnetEthernetHeader()
		ethPkt.set_ether_shost(localMacAddress)
		ethPkt.set_ether_dhost([0xff,0xff,0xff,0xff,0xff,0xff])
		ethPkt.set_ether_type(ethernetType)
		ethPkt.setPktLength(18+structPacket.get_header_size())
		ethPkt.setNumStructs(1)
		ethPkt.setSeqNo(0)
		ethPkt.contains(structPacket)
		self.writeQueue.put(ethPkt)
	
	def write(self):
		while(reactor.running):
			#if (not self.writeQueue.empty()):
			nextItem = self.writeQueue.get()
			self.pcapObj.inject(nextItem.get_packet())
			if debugLevel > 0:
				print "injecting"

class WARPnetEthernetHeader(ImpactPacket.Ethernet):
	def __init__(self, aBuffer=None):
		ImpactPacket.Header.__init__(self, 18)
		if(aBuffer):
			self.load_header(aBuffer)

	def get_header_size(self):
		"Return size of Ethernet header"
		return 18
		
	def setPktLength(self, len):
		self.set_word(14, len)
	
	def setNumStructs(self, num):
		self.set_byte(16, num)
		
	def getNumStructs(self):
		return self.get_byte(16)
	
	def setSeqNo(self, num):
		self.set_byte(17, num)
	
	def get_packet(self):
		return ImpactPacket.Header.get_packet(self)

class WARPnetStruct(ImpactPacket.Header):
	def __init__(self, aBuffer, fromController):
		self.fromController = fromController
		if self.fromController:
			self.lengthOfPacket = len(aBuffer) + 4
		else:
			self.lengthOfPacket = len(aBuffer)
		ImpactPacket.Header.__init__(self, self.lengthOfPacket)
		if self.fromController:
			self.load_header('\x00\x00\x00\x00' + aBuffer)
		else:
			self.load_header(aBuffer)

	def setController(self, id):
		self.set_byte(0, id)

	def getController(self):
		return self.get_byte(0)
	
	def setGroup(self, grp):
		self.set_byte(1, grp)

	def getGroup(self):
		return self.get_byte(1)
		
	def setAccess(self, level):
		self.set_byte(2, level)

	def getAccess(self):
		return self.get_byte(2)
		
	def setStruct(self, structid):
		self.set_byte(4, structid)

	def getStruct(self):
		return self.get_byte(4)
	
	def setNode(self, node):
		self.set_byte(5, node)

	def getNode(self):
		return self.get_byte(5)

	def get_header_size(self):
		return self.lengthOfPacket
		
	def get_raw(self):
		return self.get_packet()[4:self.lengthOfPacket]
	
	def printraw(self):
		for x in range(0,6):
			print self.get_byte(x)


class CmdReader(LineReceiver):
	from os import linesep as delimiter
	
	def lineReceived(self, line):
		if line == 'r':
			factory.regManager.disp()
		elif line == 'l':
			factory.lockManager.disp()
		elif line == 'd':
			factory.controllers.disp()
		elif line == 'a':
			factory.regManager.disp()
			factory.lockManager.disp()
			factory.controllers.disp()
			factory.nodeManager.disp()
		elif line == 'c':
			print factory.nodeManager.pcapRead.counter
			print factory.nodeManager.pcapRead.recvdQueue.qsize()
		elif line == 't':
			print 'Pcap to Factory: %.6f' % timePcapFactory
			print 'Pcap to Client: %.6f' % timePcapSend
		elif line == 'q':
			reactor.stop()
			ethPkt = WARPnetEthernetHeader()
			ethPkt.set_ether_shost(localMacAddress)
			ethPkt.set_ether_dhost([0xff,0xff,0xff,0xff,0xff,0xff])
			ethPkt.set_ether_type(ETH_RECEIVE)
			ethPkt.setPktLength(18)
			ethPkt.setNumStructs(0)
			ethPkt.setSeqNo(255)
			structPkt = WARPnetStruct('123456789ABCDEF', False)
			structPkt.setController(2)
			structPkt.setGroup(3)
			structPkt.setAccess(0)
			factory.nodeManager.pcapWrite.sendData(structPkt, ETH_RECEIVE)


# This function is called when warpnet_server.py is executed as main. This will set up the 
if __name__ == "__main__":
	import sys
	if len(sys.argv) == 4:
		ethInterface = sys.argv[1]
		serverPort = int(sys.argv[2])
		mac = sys.argv[3].split(':')
		for x in range(0, len(mac)):
			localMacAddress[x] = int('0x'+mac[x], 16)
	elif len(sys.argv) == 5:
		ethInterface = sys.argv[1]
		serverPort = int(sys.argv[2])
		mac = sys.argv[3].split(':')
		for x in range(0, len(mac)):
			localMacAddress[x] = int('0x'+mac[x], 16)
		debugLevel = sys.argv[4]
	else:
		sys.exit()


# Create a stdio listener object
stdio.StandardIO(CmdReader())

# Create a WARPnetFactory class that listens on the input server port and any interface.
factory = WARPnetFactory()
reactor.listenTCP(serverPort, factory)

print "Started WARPnet Server. Listening on port %d." % serverPort

# Start the event loop
reactor.run()
