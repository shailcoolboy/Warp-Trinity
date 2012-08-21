# WARPnet Client<->Server Architecture
# WARPnet Parameter Definitions
#
# Author: Siddharth Gupta

from twisted.internet import reactor
from twisted.internet.protocol import Protocol, ClientFactory
from warpnet_common_params import *

class EmulatorProtocol(Protocol):

	def sendMessage(self, msg):
		self.transport.write(msg)

	def dataReceived(self, data):
		self.factory.dataReceived(data)
		
	def connectionMade(self):
		self.factory.protocolInst = self
		print "Connected to Emulator"

	def connectionLost(self, reason):
		print "Disconnected from Emulator"

class EmulatorFactory(ClientFactory):
	protocol = EmulatorProtocol
	
	def __init__(self, master):
		self.master = master
	
	def sendMessage(self, message):
		self.protocolInst.sendMessage(message)
		
	def dataReceived(self, data):
		self.master.dataReceived(data)
	
class processEmulatorMsg():
	
	def __init__(self, factory, controllerID, ipAddr):
		self.emulator = EmulatorFactory(self)
		self.factory = factory
		self.cID = controllerID
		reactor.connectTCP(ipAddr, 10102, self.emulator)
	
	def sendMessage(self, message):
		self.emulator.sendMessage(message)
	
	def message(self, controllerID, data):
		#print "Sending Message to Emulator"
		self.sendMessage(data['msg'])

	def dataReceived(self, data):
		self.factory.sendData_cID(self.cID, SC_EMULATOR_MSG_FROM_BOX, {'msg': data})


