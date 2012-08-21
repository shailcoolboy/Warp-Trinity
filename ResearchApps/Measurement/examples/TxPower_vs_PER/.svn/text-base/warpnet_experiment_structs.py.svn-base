# WARPnet Client<->Server Architecture
# WARPnet Parameter Definitions
#
# Author: Siddharth Gupta

import struct, time
from warpnet_common_params import *
from warpnet_client_definitions import *
from twisted.internet import reactor
import binascii

# Struct IDs

STRUCTID_CONTROL = 0x13
STRUCTID_CONTROL_ACK = 0x14
STRUCTID_COMMAND = 0x17
STRUCTID_COMMAND_ACK = 0x18
STRUCTID_OBSERVE_PER = 0x26
STRUCTID_OBSERVE_PER_REQ = 0x27

# Command IDs
COMMANDID_STARTTRIAL = 0x40
COMMANDID_STOPTRIAL = 0x41
COMMANDID_RESET_PER = 0x50

########################
## Struct Definitions ##
########################

# ControlStruct is a ClientStruct that stores some basic parameters to pass to the WARP board. The local variable can be accessed
# globally by calling ControlStruct.txPower etc. The struct must also understand the conversion from integer values to binary
# using the prepToSend function; it will be provided with the nodeID.
#  typedef struct {
#  	char structID;
#  	char nodeID;
#  	char txPower;
#  	char channel;
#  	char modOrderHeader;
#  	char modOrderPayload;
#  	short reserved;
#  	int pktGen_period;
#  	int pktGen_length;
#  } warpnetControl;
class ControlStruct(ClientStruct):
	txPower = -1
	channel = -1
	modOrderHeader = -1
	modOrderPayload = -1
	reserved = 0
	packetGeneratorPeriod = 0
	packetGeneratorLength = 0
	
	def __init__(self):
		self.structID = STRUCTID_CONTROL
		self.txPower = 63
		self.channel = 4
		self.modOrderHeader = 0
		self.modOrderPayload = 2
		self.packetGeneratorPeriod = 0
		self.packetGeneratorLength = 1300
		self.expectedReturnStructID = STRUCTID_CONTROL_ACK
	
	def prepToSend(self, nodeID):
		self.updateDone = False
		return struct.pack('!6BHII', self.structID, nodeID, self.txPower, self.channel, self.modOrderHeader, self.modOrderPayload, self.reserved, self.packetGeneratorPeriod, self.packetGeneratorLength)
		
	def updateFromNode(self, rawData, pcapts):
		dataTuple = struct.unpack('!BBH', rawData[0:4])
		#print "Control struct successfully applied at node %d" % dataTuple[1]


#CommandStruct is used to send commands or requests to the WARP nodes
# The cmdIDs are defined above
# Matching C code definition:
#  typedef struct {
#  	char structID;
#  	char nodeID;
#  	char cmdID;
#  	char cmdParam;
#  } warpnetCommand;
class CommandStruct(ClientStruct):
	cmdID = -1
	cmdParam = -1
	
	def __init__(self, cmdID, cmdParam):
		self.structID = STRUCTID_COMMAND
		self.expectedReturnStructID = STRUCTID_COMMAND_ACK
		self.cmdID = cmdID
		self.cmdParam = cmdParam
	
	def prepToSend(self, nodeID):
		self.updateDone = False
		return struct.pack('!4B', self.structID, nodeID, self.cmdID, self.cmdParam)
	
	def updateFromNode(self, rawData, pcapts):
		pass
		#print "Successfully executed command %d" % self.cmdID

#ObservePERStruct collects packet error rate (PER) data from WARP nodes
# Matching C code definition:
#  typedef struct {
#	 unsigned char structID;
#	 unsigned char nodeID;
#	 unsigned char reqNum;
#	 unsigned char reqType;
#	 unsigned int numPkts_tx;
#	 unsigned int numPkts_rx_good;
#	 unsigned int numPkts_rx_goodHdrBadPyld;
#	 unsigned int numPkts_rx_badHdr;
#  } warpnetObservePER;
class ObservePERStruct(ClientStruct):
	numPkts_tx = -1
	numPkts_rx_good = -1
	numPkts_rx_goodHdrBadPyld = -1
	numPkts_rx_badHdr = -1
	reqNum = -1
	reqType = -1
	
	def __init__(self, logger=None):
		ClientStruct.__init__(self, logger)

		self.structID = STRUCTID_OBSERVE_PER_REQ
		self.expectedReturnStructID = STRUCTID_OBSERVE_PER

		self.numPkts_tx = 0
		self.numPkts_rx_good = 0
		self.numPkts_rx_goodHdrBadPyld = 0
		self.numPkts_rx_badHdr = 0
		self.reqNum = 0
		self.reqType = 0
		
	def prepToSend(self, nodeID):
		self.updateDone = False
		return struct.pack('!4B', self.structID, nodeID, self.reqNum, self.reqType)
	
	def updateFromNode(self, rawData, pcapts):
		dataTuple = struct.unpack('!2B 2B 4I', rawData[0:20])
		self.reqNum = dataTuple[2]
		self.reqType = dataTuple[3]
		self.numPkts_tx = dataTuple[4]
		self.numPkts_rx_good = dataTuple[5]
		self.numPkts_rx_goodHdrBadPyld = dataTuple[6]
		self.numPkts_rx_badHdr = dataTuple[7]

