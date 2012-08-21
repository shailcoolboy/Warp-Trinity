# WARPnet Client<->Server Architecture
# WARPnet Parameter Definitions
#
# Author: Siddharth Gupta

from warpnet_common_params import *
from twisted.internet import reactor
import struct, time

class WaitForResponse():
	# the receiver gives the received packet to this checker. if the response matches then it must cancel itself from the queue and cancel the
	# resender.
	def responseCheck(self, data):
		pass

	# recreate the timeouttimer, increment the resend counter, resend just the data
	def timeoutExpired(self):
		pass

class InstructionClass:

	sendType = -1 # packet type of sent command
	returnType = SC_STAT
	updateComplete = False
	returnStatus = False
	
	def waitForUpdate(self):
		while reactor.running and not self.updateComplete:
			pass
		return self.returnStatus
			
	def updateFromServer(self, data, status):
		updateComplete = True
		

def checkError(statusCode):
	if statusCode == SC_STAT_GROUP_UNMATCHED:
		print "Server does not know of group"
	elif statusCode == SC_STAT_NOT_CONN_NODE:
		print "Not connected to specified nodes"
	elif statusCode == SC_NOT_REGISTERED:
		print "Not registered for struct, group pair"
	elif statusCode == C_TIMEOUT:
		print "Request timed out"
	else:
		print "Error not known. Status Code = %d" % statusCode
		
# create blank ClientStruct that users can extend for structs that are understood at the WARP board
class ClientStruct:
	structID = -1
	expectedReturnStructID = -1
	updateDone = False
	returnStatus = False
	lockStatus = False
	
	def __init__(self, logger):
		if logger is None:
			self.loggers = []
		else:
			self.loggers = [logger]

	# The prepToSend function is called by a Node instance when it is about to send this struct to a particular node. The destination
	# nodeID will be provided by the instance and the struct must embed this in the right order. The returned data is the byte packed
	# sequence that is understood by the node.	
	def prepToSend(self, nodeID):
		self.updateDone = False
		return struct.pack('BB', self.structID, nodeID)	#pack converts the variables to binary
	
	def callbackFromResponse(self, data, status):
		if status:
			self.updateFromNode(data['raw'], data['pcapts'])
		else:
			if data['stat'] == SC_DATA_LOCKED:
				print "Data struct is locked, cannot update"
			else:
				checkError(data['stat'])
		self.returnStatus = status
		self.updateDone = True
	
	# The updateFromNode function is called when the node either receives a response to a sent struct or receives an unrequested struct.
	def updateFromNode(self, data, pcapts):
		pass

	def updateComplete(self):
		#print "waiting in update done"
		while reactor.running and not self.updateDone:
			pass
			#print "%s" % self.updateDone
		return self.returnStatus

	def addLogger(self, loggerInst):
		print "in add logger"
		self.loggers.append(loggerInst)
		print "new logger list %s" % self.loggers


	def logData(self, data):
		for logger in self.loggers:
			logger.log(data)

class DataCollector():
	
	def log(self, dataToLog):
		pass
