# WARPnet Client<->Server Architecture
# WARPnet Client controller
#
# Author: Siddharth Gupta

#import struct # import struct for converting string/integers to binary and defined bit widths
from warpnet_common_params import *
from warpnet_client_definitions import *
from twisted.internet import reactor, stdio
from twisted.internet.protocol import Protocol, ClientFactory
from twisted.protocols.basic import NetstringReceiver, LineReceiver
import json, cPickle
from twisted.python import threadable

###### Variables

clientFac = 0	# global variable that is the instance of the the WARPnetClient Factory so all functions can write to it
handleReflectedData = False

RETRANSMIT_COUNT = 10 # Max retries to send the data struct
WAIT_TIME = 1 # Time to wait before resending data structs


####### Class Definitions


class Register(InstructionClass):
	
	def __init__(self, group, structIDList, nodeID, accessLevel, addReg=True):
		if addReg:
			self.sendType = SC_REG_ADD
		else:
			self.sendType = SC_REG_DEL
		self.group = group
		self.structIDList = structIDList
		self.nodeID = nodeID
		self.accessLevel = accessLevel
		self.updateComplete = False
	
	def sendRegistration(self):
		dataDict = {'grp': self.group, 'structID': self.structIDList, 'nodeID': self.nodeID, 'accessLevel': self.accessLevel}
		clientFac.sendInstruction(self.sendType, dataDict, self.updateFromServer)
		if not threadable.isInIOThread():
			return self.waitForUpdate()
	
	def updateFromServer(self, data, status):
		if data['stat'] == SC_REG_SUCCESS:
#			print "Successfully registered for struct %s, node %d" % (self.structIDList, self.nodeID)
			self.returnStatus = True
		else:
			checkError(data['stat'])
			self.returnStatus = False
		self.updateComplete = True

class ConnectToNodes(InstructionClass):

	def __init__(self, connList, group):
		self.sendType = SC_CONNECT
		self.connList = connList
		self.group = group
		self.updateComplete = False
	
	def connect(self):
		dataDict = {'grp': self.group, 'connList': self.connList}
		clientFac.sendInstruction(self.sendType, dataDict, self.updateFromServer)
		if not threadable.isInIOThread():
			return self.waitForUpdate()
	
	def updateFromServer(self, data, status):
		if data['stat'] == SC_CONNECT_SUCCESS:
			print "Connected to nodes"
			self.returnStatus = True
		elif data['stat'] == SC_CONNECT_TYPE_MISMATCH:
			print "Node connection type mismatch"
			self.returnStatus = False
		elif data['stat'] == SC_CONNECT_UNKNOWN_TYPE:
			print "Unknown connection type"
			self.returnStatus = False
		else:
			checkError(data['stat'])
			self.returnStatus = False
		self.updateComplete = True

class GroupID(InstructionClass):

	def __init__(self, group, connect):
		if connect:
			self.sendType = SC_GRPID_ADD
		else:
			self.sendType = SC_GRPID_DEL
		self.group = group
		self.updateComplete = False
	
	def register(self):
		dataDict = {'grp': self.group}
		clientFac.sendInstruction(self.sendType, dataDict, self.updateFromServer)
		if not threadable.isInIOThread():
			return self.waitForUpdate()
	
	def updateFromServer(self, data, status):
		if data['stat'] == SC_GRPID_SUCCESS:
			print "Registered Group ID %d" % self.group
			self.returnStatus = True
		elif data['stat'] == SC_GRPID_GROUP_KNOWN:
			print "Group ID %d already known, nothing to do" % self.group
			self.returnStatus = True
		else:
			checkError(data['stat'])
			self.returnStatus = False
		self.updateComplete = True
		

class StructLock(InstructionClass):
	def __init__(self, group, structID, nodeID, lock=True):
		if lock:
			self.sendType = SC_LOCK
		else:
			self.sendType = SC_UNLOCK
		self.group = group
		self.structID = structID
		self.nodeID = nodeID
		self.updateComplete = False
	
	def sendCmd(self):
		dataDict = {'grp': self.group, 'structID': self.structID, 'nodeID': self.nodeID}
		clientFac.sendInstruction(self.sendType, dataDict, self.updateFromServer)
		if not threadable.isInIOThread():
			return self.waitForUpdate()
		
	def updateFromServer(self, data, status):
		if data['stat'] == SC_LOCK_SUCCESS:
			print "Successfully locked or unlocked"
			self.returnStatus = True
		elif data['stat'] == SC_LOCK_EXISTS:
			print "Struct already locked"
			self.returnStatus = False
		elif data['stat'] == SC_LOCK_NOLOCK:
			print "Struct node pair already unlocked"
			self.returnStatus = False
		elif data['stat'] == SC_LOCK_NOT_OWNER:
			print "Cannot unlock as not owner of lock"
			self.returnStatus = False
		else:
			checkError(data['stat'])
			self.returnStatus = False
		self.updateComplete = True

# This is the class Node that is the representation of a physical WARP node. This class must be instantiated with the nodeID and the type
# of connection the server has to that node (pcap, backdoor, socket). In addition, each Node has parameters that can be configured. These
# are stored in instantiations of ClientStructs. Each struct added to the node must have a tag that is used to refer to that struct.
# The addStruct function can be used to add new ClientStructs or reassign old tags with new structs. The function sendToNode requests the
# appropriate struct for the binary representation and then sends it to the WARP board. The node also keeps track of the structs that require
# registration with the server. 
class Node:
	nodeID = -1
	serverType = -1

	def __init__(self, nodeid, servConnection, group=0):
		self.nodeID = nodeid
		self.nodeStructs = dict()
		self.registration = dict()
		self.handleUnrequested = dict()
		self.serverType = servConnection
		self.group = group
	
	# There are a few optional items for addStruct. By default any struct added is registered with the server. If you would like to receive
	# unrequested structs of this type then set handleUnrequested=True. The access level tells the server what kind of updates from nodes
	# will make it to the client. For example, an ADDRESSED_TO_ME struct will not get an update when another client requests it.
	def addStruct(self, tag, struct, registerWithServer=True, accessLevel=ADDRESSED_TO_ME, handleUnrequested=False):
		self.nodeStructs[tag] = struct
		self.handleUnrequested[tag] = handleUnrequested
		if registerWithServer:
			if handleUnrequested:
				if accessLevel == ADDRESSED_TO_ME:
					self.registration[tag] = ADDRESSED_TO_MY_GROUP
				else:
					self.registration[tag] = accessLevel
			else:
				self.registration[tag] = accessLevel
	
	# The sendToNode function should be called when the client wants to send the appropriate struct to the respective nodeID. The tag
	# is the most important part as it will refer to the struct being sent. The input makeAvailable can be modified to change the
	# access of the data coming from the node.
	def sendToNode(self, tag, makeAvailable=MAKE_AVAIL_ME):
		#print "sending %s struct to server" % tag
		dataDict = {'grp': self.group, 'structID': self.nodeStructs[tag].structID, 'nodeID': self.nodeID, 'raw': self.nodeStructs[tag].prepToSend(self.nodeID), 'access': makeAvailable}
		clientFac.sendDataStruct(SC_DATA_TO_NODE, self.nodeStructs[tag].expectedReturnStructID, dataDict, self.nodeStructs[tag].structID, self.nodeID, self.nodeStructs[tag].callbackFromResponse)
		if not threadable.isInIOThread():
			return self.nodeStructs[tag].updateComplete()
	
	def lockStruct(self, tag):
		lock = StructLock(self.group, self.nodeStructs[tag].structID, self.nodeID, True)
		lock.sendCmd()

	def unlockStruct(self, tag):
		unlock = StructLock(self.group, self.nodeStructs[tag].structID, self.nodeID, False)
		unlock.sendCmd()
	
	def getNodeID(self):
		return self.nodeID
		
	def sendAllRegs(self):
		status = True
		for tag in self.registration.keys():
			tempstatus = self.sendRegTag(tag)
			status = status and tempstatus
		return status
	
	def sendRegTag(self, tag):
		registerInst = Register(self.group, [self.nodeStructs[tag].structID, self.nodeStructs[tag].expectedReturnStructID], self.nodeID, self.registration[tag], addReg=True)
		if self.handleUnrequested[tag]:
			clientFac.permanentQueue[(self.nodeStructs[tag].expectedReturnStructID, self.nodeID)] = UnrequestedData(self.nodeStructs[tag].expectedReturnStructID, self.nodeID, self.nodeStructs[tag].callbackFromResponse)
		clientFac.registeredPairs[(self.nodeStructs[tag].structID, self.nodeID)] = self.nodeStructs[tag]
		return registerInst.sendRegistration()


# This function initiates the connection of this client script with the server. Additionally, the server connects to the respective nodes that
# are requested by the script. The input network is a dictionary of Nodes
def connectToServer(network):
	#clientFac.networkDef(network)
	connectionList = []
	for x in network.keys():
		connectionList.append((x, network[x].serverType))
	connector = ConnectToNodes(connectionList, network[x].group)
	return connector.connect()
	
# This function is used to create the network of nodes which the client controls. It requires a blank or existing dictionary of nodes and
# a new Node instance.
def createNode(networkDict, Node):
	networkDict[Node.getNodeID()] = Node

# The sendRegistrations function registers all the structs in the Nodes in 'network' with the server
def sendRegistrations(network):
	status = True
	for node in network:
		tempstatus = network[node].sendAllRegs()
		status = status and tempstatus
	return status

# This is a start of time call that the script must use to register its group ID. By default the group ID is 0. If the user wants different
# group IDs, the input takes in a list of group IDs.
def registerWithServer(ids=None):
	status = True
	if ids == None:
		idList = [0]
	else:
		idList = ids
	for x in idList:
		grouper = GroupID(x, True)
		tempstatus = grouper.register()
		status = status and tempstatus
	return status
	
# If there are multiple scripts running in the system then requests from one client can be seen by others as well. To allow this client
# to process that information call this function with hR=True.
def handleReflection(hR=False):
	global handleReflectedData
	handleReflectedData = hR

# If there is an emulator in the system, call this function to import in the emulator library. The return value is an instance
# to the emulator processor.
def initEmulator():
	import warpnet_client_azimuth_controller
	emulator = warpnet_client_azimuth_controller.Emulator(clientFac)
	return emulator

####### Twisted Networking

# WARPnet Protocol is a subclass of NetstringReciever. The superclass implements the type checking to only decode correctly formatted
# netstrings. When the connection is made, the protocol registers its instance with the factory for easy access. Once that is done, the
# user script is called
class WARPnetProtocol(NetstringReceiver):
	
	def stringReceived(self, data):
		#print "received data %s" % json.loads(data)
		self.factory.dataRecvd(cPickle.loads(data))
	
	def connectionMade(self):
		print "Successfully connected to WARPnet Server"
		self.factory.connProtocol = self
		reactor.callInThread(self.factory.scriptLoc)

# WARPnetClient is an implementation of ClientFactory. It keeps track of the protocol, the script function and the network
class WARPnetClient(ClientFactory):
	protocol = WARPnetProtocol
	
	def __init__(self, file):
		global clientFac
		self.scriptLoc = file
		clientFac = self
		self.dataQueue = []
		self.permanentQueue = dict()
		self.registeredPairs = dict()
		self.counter = 0
	
	def networkDef(self, network):
		self.nodeNetwork = network
	
	def sendInstruction(self, instructionType, dataDict, callback=None):
		if callback != None:
			self.dataQueue.append(InstructionResponse(instructionType, dataDict, callback, self))
		self.sendDataToServer(instructionType, dataDict)
	
	# pre-processing for a data struct, add instance to queue, give to sendDataToServer
	def sendDataStruct(self, sendType, expectedReturnStructID, dataDict, structID, nodeID, callback=None):
		if callback != None:
			self.dataQueue.append(DataResponse(sendType, expectedReturnStructID, dataDict, structID, nodeID, callback, self))
		self.sendDataToServer(sendType, dataDict)
	
	# When data is to be sent to the server, the user script must provide the type of packet and the rest of the data in the form
	# of a dictionary. These are put together and sent to the server
	def sendDataToServer(self, sendType, dataDict):
		dictToSend = {'pktType': sendType}
		dictToSend.update(dataDict)
		pickledData = cPickle.dumps(dictToSend)
		if threadable.isInIOThread():
			self.connProtocol.sendString(pickledData)
		else:
			reactor.callFromThread(self.connProtocol.sendString, pickledData)
	
	def removeFromQueue(self, instToRemove):
		self.dataQueue.remove(instToRemove)
	
	# check received packet with the waiting queue otherwise discard
	def dataRecvd(self, data):
		if data['pktType'] == SC_DATA_FROM_NODE:
			self.counter += 1
		for x in self.dataQueue:
			if x.responseCheck(data):
				return
		try:
			if self.permanentQueue[(data['structID'],data['nodeID'])].responseCheck(data):
				return
		except KeyError:
			pass
		if handleReflectedData:
			try:
				if data['pktType'] == SC_DATA_TO_NODE_REFLECT:
					structinst = self.registeredPairs[(data['structID'], data['nodeID'])]
					self.dataQueue.append(DataReflect(structinst.expectedReturnStructID, data['structID'], data['nodeID'], structinst.callbackFromResponse, self))
					print "reflected data"
					return
				elif data['pktType'] == SC_LOCK_NOTIFICATION:
					structinst = self.registeredPairs[(data['structID'], data['nodeID'])]
					structinst.lockStatus = True
					print "lock notification"
					return
				elif data['pktType'] == SC_UNLOCK_NOTIFICATION:
					structinst = self.registeredPairs[(data['structID'], data['nodeID'])]
					structinst.lockStatus = False
					print "unlock notification"
					return
			except KeyError:
				pass
		print "unknown received struct %s" % data
		


class DataResponse(WaitForResponse):
	
	# initialize with the struct type that was sent and the expected return type. also include the function to call when correct
	def __init__(self, sentStructType, expectedReturnStructID, dataDict, structID, nodeID, instanceToCall, factoryInstance):
		self.sentStructType = sentStructType
		self.expectedReturnStructID = expectedReturnStructID
		self.dataDict = dataDict
		self.structID = structID
		self.nodeID = nodeID
		self.instanceToCall = instanceToCall
		self.factoryInstance = factoryInstance
		
		self.resendCounter = 0
		self.timeoutTimer = reactor.callLater(WAIT_TIME, self.timeoutExpired)
	
	# the receiver gives the received packet to this checker. if the response matches then it must cancel itself from the queue and cancel the
	# resender.
	def responseCheck(self, data):
		if data['pktType'] == SC_DATA_FROM_NODE:
			if data['structID'] == self.expectedReturnStructID and data['nodeID'] == self.nodeID:
				if self.timeoutTimer.active():
					self.timeoutTimer.cancel()
				self.factoryInstance.removeFromQueue(self)
				self.instanceToCall(data, True)
				# process the data, go the required callback
				return True
		elif data['pktType'] == SC_STAT and data['reqType'] == SC_DATA_TO_NODE:
			if self.timeoutTimer.active():
				self.timeoutTimer.cancel()
			self.factoryInstance.removeFromQueue(self)
			self.instanceToCall(data, False)
			return True
		return False

	# recreate the timeouttimer, increment the resend counter, resend just the data
	def timeoutExpired(self):
		self.resendCounter += 1
		if self.resendCounter > RETRANSMIT_COUNT:
			self.factoryInstance.removeFromQueue(self)
			#print "too many timeouts, cancelling send"
			self.instanceToCall({'stat': C_TIMEOUT}, False)
		else:
			print "resending after timeout data %x" % self.structID
			self.factoryInstance.sendDataToServer(self.sentStructType, self.dataDict)
			self.timeoutTimer = reactor.callLater(WAIT_TIME, self.timeoutExpired)

class InstructionResponse(WaitForResponse):
	
	# initialize with the struct type that was sent and the expected return type. also include the function to call when correct
	def __init__(self, instructionType, dataDict, instanceToCall, factoryInstance):
		self.instructionType = instructionType
		self.dataDict = dataDict
		self.instanceToCall = instanceToCall
		self.factoryInstance = factoryInstance
		
		self.resendCounter = 0
		self.timeoutTimer = reactor.callLater(WAIT_TIME, self.timeoutExpired)
	
	# the receiver gives the received packet to this checker. if the response matches then it must cancel itself from the queue and cancel the
	# resender.
	def responseCheck(self, data):
		if data['pktType'] == SC_STAT and data['reqType'] == self.instructionType:
			if self.timeoutTimer.active():
				self.timeoutTimer.cancel()
			self.factoryInstance.removeFromQueue(self)
			self.instanceToCall(data, True)
			return True
		return False

	# recreate the timeouttimer, increment the resend counter, resend just the data
	def timeoutExpired(self):
		self.resendCounter += 1
		if self.resendCounter > RETRANSMIT_COUNT:
			self.factoryInstance.removeFromQueue(self)
			self.instanceToCall(data, False)
			print "too many timeouts, cancelling send"
		else:
			print "resending after timeout instruction"
			self.factoryInstance.sendDataToServer(self.instructionType, self.dataDict)
			self.timeoutTimer = reactor.callLater(WAIT_TIME, self.timeoutExpired)

class UnrequestedData(WaitForResponse):

	def __init__(self, expectedReturnStructID, nodeID, instanceToCall):
		self.expectedReturnStructID = expectedReturnStructID
		self.nodeID = nodeID
		self.instanceToCall = instanceToCall
	
	def responseCheck(self, data):
		if data['pktType'] == SC_DATA_FROM_NODE:
			self.instanceToCall(data, True)
			return True
		return False

class DataReflect(WaitForResponse):
	
	# initialize with the struct type that was sent and the expected return type. also include the function to call when correct
	def __init__(self, expectedReturnStructID, structID, nodeID, instanceToCall, factoryInstance):
		self.expectedReturnStructID = expectedReturnStructID
		self.structID = structID
		self.nodeID = nodeID
		self.instanceToCall = instanceToCall
		self.factoryInstance = factoryInstance
		
		self.timeoutTimer = reactor.callLater(WAIT_TIME, self.timeoutExpired)
	
	# the receiver gives the received packet to this checker. if the response matches then it must cancel itself from the queue and cancel the
	# timeout timer.
	def responseCheck(self, data):
		if data['pktType'] == SC_DATA_FROM_NODE:
			if data['structID'] == self.expectedReturnStructID and data['nodeID'] == self.nodeID:
				if self.timeoutTimer.active():
					self.timeoutTimer.cancel()
				self.factoryInstance.removeFromQueue(self)
				self.instanceToCall(data, True)
				# process the data, go the required callback
				return True
		return False

	# recreate the timeouttimer, increment the resend counter, resend just the data
	def timeoutExpired(self):
		self.factoryInstance.removeFromQueue(self)
	

class DataLogger(DataCollector):
	
	def __init__(self, filename, flushTime):
		self.filename = filename
		self.flushTime = flushTime
		self.logFile = open(self.filename, 'w')
		
		if flushTime != 0:
			self.timer = reactor.callLater(self.flushTime, self.flushFile)
	
	def flushFile(self):
		self.logFile.close()
		self.logFile = open(self.filename, 'a')
		self.timer = reactor.callLater(self.flushTime, self.flushFile)
		
	def log(self, dataToLog):
		if threadable.isInIOThread():
			self.logFile.write(dataToLog)
		else:
			reactor.callFromThread(self.logFile.write, dataToLog)
		
	def closeFile(self):
		self.logFile.close()




			
class CmdReader(LineReceiver):
	from os import linesep as delimiter
	
	def __init__(self, functionCall=None):
		if functionCall is None:
			self.func = self.noContinue
		else:
			self.func = functionCall
	
	def noContinue(self, line):
		#print "In noContinue"
		pass
	
	def lineReceived(self, line):
		if line == 'a':
			print clientFac.dataQueue
			print clientFac.permanentQueue
			print clientFac.registeredPairs
		elif line == 'c':
			print clientFac.counter
		elif line == 'q':
			reactor.stop()
		else:
			self.func(line)











