# WARPnet Client<->Server Architecture
# WARPnet Parameter Definitions
#
# Author: Siddharth Gupta

from warpnet_client_definitions import *
from warpnet_common_params import *
from twisted.python import threadable
import re
from datetime import *
import time

EMU_RETRANSMIT_COUNT = 10 # Max retries to send the data struct
EMU_WAIT_TIME = 30 # Time to wait before resending data structs

class Emulator():

	def __init__(self, factory):
		self.factory = factory
		self.updateComplete = False
		self.returnStatus = False
	
	def connect(self, ipaddress):
		self.sendMessage(SC_EMULATOR_PRESENT, {'ip': ipaddress})
	
	def command(self, *args):
		#Concatenates all the user's arguments, delimited by spaces
		# Arguments are converted to strings if needed
		command = ' '.join(map(str,args))
		return self.sendMessage(SC_EMULATOR_MSG_TO_BOX, {'msg': command + '\n'}, self.updateFromServer)

	
	def waitForUpdate(self):
		while reactor.running and not self.updateComplete:
			pass
		return self.returnStatus
			
	def updateFromServer(self, data, status):
		if status:
			if re.search('ace_success', data['msg']):
				self.returnStatus = True
			else:
				print data['msg']
				self.returnStatus = False
				#raise Exception('ACE_ERROR (%s): %s ' % (datetime.now().strftime("%H:%M:%S"), data))
		else:
			self.returnStatus = False
		self.updateComplete = True

	def sendMessage(self, sendType, dataDict, callback=None):
		self.updateComplete = False
		if callback != None:
			self.factory.dataQueue.append(EmulatorResponse(dataDict, callback, self.factory))
		self.factory.sendDataToServer(sendType, dataDict)
		if not threadable.isInIOThread() and callback != None:
			return self.waitForUpdate()

class EmulatorResponse(WaitForResponse):
	
	def __init__(self, dataDict, instanceToCall, factoryInstance):
		self.dataDict = dataDict
		self.instanceToCall = instanceToCall
		self.factoryInstance = factoryInstance
		
		self.resendCounter = 0
		self.timeoutTimer = reactor.callLater(EMU_WAIT_TIME, self.timeoutExpired)
	
	def responseCheck(self, data):
		#print data
		if data['pktType'] == SC_EMULATOR_MSG_FROM_BOX:
			if self.timeoutTimer.active():
				self.timeoutTimer.cancel()
			self.factoryInstance.removeFromQueue(self)
			self.instanceToCall(data, True)
			return True
		return False

	def timeoutExpired(self):
		self.resendCounter += 1
		if self.resendCounter > EMU_RETRANSMIT_COUNT:
			self.factoryInstance.removeFromQueue(self)
			#print "too many timeouts, cancelling send"
			self.instanceToCall({'stat': C_TIMEOUT}, False)
		else:
			print "emulator resent after timeout: %s" % self.dataDict
			self.factoryInstance.sendDataToServer(SC_EMULATOR_MSG_TO_BOX, self.dataDict)
			self.timeoutTimer = reactor.callLater(EMU_WAIT_TIME, self.timeoutExpired)
