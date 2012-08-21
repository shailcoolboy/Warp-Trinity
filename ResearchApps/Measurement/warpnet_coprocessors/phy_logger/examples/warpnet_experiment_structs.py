# WARPnet Client<->Server Architecture
# WARPnet Parameter Definitions
#
# Author: Siddharth Gupta

import struct, time
from warpnet_framework.warpnet_common_params import *
from warpnet_framework.warpnet_client_definitions import *
from twisted.internet import reactor
import binascii

RETRANSMIT_COUNT = 10 # Max retries to send the data struct
WAIT_TIME = 10 # Time to wait before resending data structs
FILE_REFRESH_TIME = 60 # In seconds, time to wait between file reopens

# Struct IDs

STRUCTID_CONTROL = 0x13
STRUCTID_CONTROL_ACK = 0x14
STRUCTID_OBSERVE_REQUEST = 0x15
STRUCTID_OBSERVE = 0x16
STRUCTID_COMMAND = 0x17
STRUCTID_COMMAND_ACK = 0x18
STRUCTID_RTOBSERVE_REQUEST = 0x1A
STRUCTID_RTOBSERVE = 0x1B

STRUCTID_CFO = 0x20

STRUCTID_PHYCTRL = 0x22
STRUCTID_PHYCTRL_ACK = 0x23

STRUCTID_OBSERVE_BER = 0x24
STRUCTID_OBSERVE_BER_REQ = 0x25

STRUCTID_OBSERVE_COOPBER = 0x28
STRUCTID_OBSERVE_COOPBER_REQ = 0x29

STRUCTID_OBSERVE_PER = 0x26
STRUCTID_OBSERVE_PER_REQ = 0x27

STRUCTID_RAW_PKT = 0x30

STRUCTID_LOGPARAMS = 	0x32
STRUCTID_LOGPARAMS_ACK = 0x33

# Command IDs
COMMANDID_STARTTRIAL = 0x40
COMMANDID_STOPTRIAL = 0x41
COMMANDID_RELAYSTATE = 0x42
COMMANDID_PKTGEN = 0x46

COMMANDID_RESET_PER = 0x50

# Command Params
COMMANDPARAM_RELAYOFF = 0x43
COMMANDPARAM_RELAYAF = 0x44
COMMANDPARAM_RELAYDF = 0x45
COMMANDPARAM_PKTGEN_ENABLE = 0x47
COMMANDPARAM_PKTGEN_DISABLE = 0x48

PKTTYPE_NCDATA = 0x00
PKTTYPE_NCMHOPDATA = 0xA2
PKTTYPE_DFDATA = 0xEE
PKTTYPE_AFDATA = 0x55
PKTTYPE_AFGHDATA = 0xC3
PKTTYPE_DFGHDATA = 0x3C
PKTTYPE_INVALID = 0x88

PHYCTRL_BER_EN =		0x1
PHYCTRL_CFO_EN = 		0x2
PHYCTRL_PHYDUMP_EN = 	0x4
PHYTRCL_EXTPKTDET_EN = 	0x8
PHYCTRL_COOP_EN =		0x10
PHYCTRL_CFO_CORR_EN =	0x20
PHYCTRL_SWAP_ANT = 		0x40

PHYCTRL_TX_NC = 	0x01
PHYCTRL_TX_DF = 	0x02
PHYCTRL_TX_AF = 	0x04
PHYCTRL_TX_AFGH = 	0x08
PHYCTRL_TX_DFGH = 	0x10
PHYCTRL_TX_NCMHOP =	0x20

class MyDataLogger(DataCollector):
	
	def __init__(self, filename):
		self.filename = filename
		self.logFile = open(self.filename, 'w')
		
	def log(self, dataToLog):
		self.logFile.write(dataToLog)
		self.logFile.flush()
		
	def closeFile(self):
		self.logFile.close()

# Struct Definitions


# ControlStruct is a ClientStruct that stores some basic parameters to pass to the WARP board. The local variable can be accessed
# globally by calling ControlStruct.txPower etc. The struct must also understand the conversion from integer values to binary
# using the prepToSend function; it will be provided with the nodeID.
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


# CommandStruct is a Client struct to send commands or request data from the WARP board. The cmdIDs are defined in warpnet_params.py
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


# BER struct that is filled in by the node
class ObserveStruct(ClientStruct):
	sourceNode = -1
	numDataTx = -1
	numNACKTx = -1
	numDataRx = -1
	numNACKRx = -1
	numBadHeaderRx = -1
	sumGain = -1
	sumRSSI = -1
	packetCountRx = -1
	
	def __init__(self, sourceNode, logger=None):
		ClientStruct.__init__(self, logger)
		self.structID = STRUCTID_OBSERVE_REQUEST
		self.expectedReturnStructID = STRUCTID_OBSERVE
		self.sourceNode = sourceNode

		self.logData("structID=%d, nodeID, cmdID, numDataTx, numNACKTx, numDataRx, numNACKRx, numBadHeaderRx, sumGain, sumRSSI, packetCountRx, trialDuration, time\r\n" % STRUCTID_OBSERVE_REQUEST)
		
	def prepToSend(self, nodeID):
		self.updateDone = False
		return struct.pack('!BBH', self.structID, nodeID, self.sourceNode)
		
	def updateFromNode(self, rawData, pcapts):
		dataTuple = struct.unpack('!2BH9I', rawData[0:40])
		
		self.logData("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d\r\n" % (dataTuple[0], dataTuple[1], dataTuple[2], dataTuple[3], dataTuple[4], dataTuple[5], dataTuple[6], dataTuple[7], dataTuple[8], dataTuple[9], dataTuple[10], dataTuple[11], time.time()))


class RTObserveStruct(ClientStruct):
	sequenceNumber = -1
	pktType = -1
	srcNode = -1
	dstNode = -1
	relayNode = -1
	state = -1
	rssi = -1
	gain = -1
	timestamp = -1
	
	def __init__(self, logger=None):
		ClientStruct.__init__(self, logger)
		self.structID = STRUCTID_RTOBSERVE_REQUEST
		self.expectedReturnStructID = STRUCTID_RTOBSERVE
		
		self.logData("sequenceNumber, pktType, srcNode, dstNode, relayNode, state, RSSI, gain, timestamp\r\n")
	
	def prepToSend(self, nodeID):
		self.updateDone = False
		return struct.pack('!BBH', self.structID, nodeID, 0)
	
	def updateFromNode(self, rawData, pcapts):
		dataTuple = struct.unpack('!2BH6B2HI', rawData[0:18])
		self.logData("%d, %d, %d, %d, %d, %d, %d, %d, %d\r\n" % (dataTuple[2], dataTuple[3], dataTuple[4], dataTuple[5], dataTuple[6], dataTuple[7], dataTuple[9], dataTuple[10], dataTuple[11]))


class CFOStruct(ClientStruct):
	atten = 0
	pktLen = 0
	minMag = 0
	
	def __init__(self, logger=None):
		ClientStruct.__init__(self, logger)

		self.structID = STRUCTID_CFO #Dangerous to reuse structID only if there's another controller
		self.expectedReturnStructID = STRUCTID_CFO

		self.logData("nodeID, seqNum, cfo_c, cfo_p, cfo_b, txCFO, pktStatus, atten, pktLen, minMag, pcap timestamp\r\n")
		self.atten = 0
		self.pktLen = 0
		self.minMag = 0
	
	def prepToSend(self, nodeID):
		self.updateDone = False
		return struct.pack('!BBH', self.structID, nodeID, 0)
	
	def updateFromNode(self, rawData, pcapts):
		dataTuple = struct.unpack('!2B H 5i', rawData[0:24])
		self.logData("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %s\r\n" % (dataTuple[1], dataTuple[2], dataTuple[3], dataTuple[4], dataTuple[5], dataTuple[6], dataTuple[7], self.atten, self.pktLen, self.minMag, pcapts))

class PHYctrlStruct(ClientStruct):
	param0 = 0
	param1 = 0
	param2 = 0
	param3 = 0
	param4 = 0
	param5 = 0
	param6 = 0
	param7 = 0
	param8 = 0
	param9 = 0
	
	def __init__(self, logger=None):
		ClientStruct.__init__(self, logger)

		self.structID = STRUCTID_PHYCTRL
		self.expectedReturnStructID = STRUCTID_PHYCTRL_ACK
		self.param0 = 0 #short - Enable CFO correction
		self.param1 = 0 #int - 	 Tx CFO Freq
		self.param2 = 0 #int
		self.param3 = 0 #int
		self.param4 = 0 #int
		self.param5 = 0 #int
		self.param6 = 0 #int
		self.param7 = 0 #int
		self.param8 = 0 #int
		self.param9 = 0 #int
	
	def prepToSend(self, nodeID):
		self.updateDone = False
		#was type "i", but Python complained when MSB of argument was 1...
		return struct.pack('!BBH9I', self.structID, nodeID, self.param0, self.param1, self.param2, self.param3, self.param4, self.param5, self.param6, self.param7, self.param8, self.param9)

class ObserveBERStruct(ClientStruct):
#0	unsigned char structID;
#1	unsigned char nodeID;
#2	unsigned short sequenceNumber;
#3	unsigned char nodeID_tx;
#4	unsigned char nodeID_rx;
#5	unsigned short mac_seqNum;
#6	unsigned int bits_rx;
#7	unsigned int bits_errors;

	totalBitsReceived = 0
	totalBitErrors = 0
	nodeID_tx = -1
	nodeID_rx = -1
	
	def __init__(self, logger=None):
		ClientStruct.__init__(self, logger)

		self.structID = STRUCTID_OBSERVE_BER_REQ
		self.expectedReturnStructID = STRUCTID_OBSERVE_BER

		self.totalBitsReceived = 0
		self.totalBitErrors = 0
		
	def prepToSend(self, nodeID):
		self.updateDone = False
		return struct.pack('!BBH', self.structID, nodeID, 0)
	
	def updateFromNode(self, rawData, pcapts):
		dataTuple = struct.unpack('!2B H 2B H 2I', rawData[0:16])
		self.nodeID_tx = dataTuple[3]
		self.nodeID_rx = dataTuple[4]
		self.totalBitsReceived += dataTuple[6]
		self.totalBitErrors += dataTuple[7]
	
	def clearBitCounts(self):
		self.totalBitsReceived = 0
		self.totalBitErrors = 0

class ObserveCoopBERStruct(ClientStruct):
#0	unsigned char structID;
#1	unsigned char nodeID;
#2	unsigned short sequenceNumber;
#3	unsigned char nodeID_tx;
#4	unsigned char nodeID_rx;
#5	unsigned short mac_seqNum;
#6	unsigned char mac_pktType;
#7	unsigned char reserved0;
#8	unsigned char reserved1;
#9	unsigned char reserved2;
#10	unsigned int bits_rx;
#11	unsigned int bits_errors;
	nodeID_tx = -1
	nodeID_rx = -1

	totalBitsReceived_NC = 0
	totalBitsReceived_AF = 0
	totalBitsReceived_AFGH = 0
	totalBitsReceived_DF = 0
	totalBitsReceived_DFGH = 0
	totalBitsReceived_NCMHOP = 0

	totalBitErrors_NC = 0
	totalBitErrors_AF = 0
	totalBitErrors_AFGH = 0
	totalBitErrors_DF = 0
	totalBitErrors_DFGH = 0
	totalBitErrors_NCMHOP = 0

	totalBitsReceived_AF_noNC = 0
	totalBitsReceived_AFGH_noNC = 0
	totalBitsReceived_DF_noNC = 0
	totalBitsReceived_DFGH_noNC = 0

	totalBitErrors_AF_noNC = 0
	totalBitErrors_AFGH_noNC = 0
	totalBitErrors_DF_noNC = 0
	totalBitErrors_DFGH_noNC = 0

	lastSeqNum_NC = -1;
	
	def __init__(self, logger=None):
		ClientStruct.__init__(self, logger)

		self.structID = STRUCTID_OBSERVE_COOPBER_REQ
		self.expectedReturnStructID = STRUCTID_OBSERVE_COOPBER

		self.totalBitsReceived_NC = 0
		self.totalBitsReceived_AF = 0
		self.totalBitsReceived_AFGH = 0
		self.totalBitsReceived_DF = 0
		self.totalBitsReceived_DFGH = 0
		self.totalBitsReceived_NCMHOP = 0

		self.totalBitErrors_NC = 0
		self.totalBitErrors_AF = 0
		self.totalBitErrors_AFGH = 0
		self.totalBitErrors_DF = 0
		self.totalBitErrors_DFGH = 0
		self.totalBitErrors_NCMHOP = 0

		self.totalBitsReceived_AF_noNC = 0
		self.totalBitsReceived_AFGH_noNC = 0
		self.totalBitsReceived_DF_noNC = 0
		self.totalBitsReceived_DFGH_noNC = 0

		self.totalBitErrors_AF_noNC = 0
		self.totalBitErrors_AFGH_noNC = 0
		self.totalBitErrors_DF_noNC = 0
		self.totalBitErrors_DFGH_noNC = 0
		
		self.lastSeqNum_NC = -1;

	def prepToSend(self, nodeID):
		self.updateDone = False
		return struct.pack('!BBH', self.structID, nodeID, 0)
	
	def updateFromNode(self, rawData, pcapts):
		dataTuple = struct.unpack('!2B H 2B H 4B 2I', rawData[0:20])
		self.nodeID_tx = dataTuple[3]
		self.nodeID_rx = dataTuple[4]
		self.coopPktType = dataTuple[6]

		if(dataTuple[6] == PKTTYPE_NCDATA):
			self.totalBitsReceived_NC += dataTuple[10]
			self.totalBitErrors_NC += dataTuple[11]
			self.lastSeqNum_NC = dataTuple[5]

		elif(dataTuple[6] == PKTTYPE_AFDATA):
			self.totalBitsReceived_AF += dataTuple[10]
			self.totalBitErrors_AF += dataTuple[11]

			if(self.lastSeqNum_NC != dataTuple[5]):
				self.totalBitsReceived_AF_noNC += dataTuple[10]
				self.totalBitErrors_AF_noNC += dataTuple[11]

		elif(dataTuple[6] == PKTTYPE_AFGHDATA):
			self.totalBitsReceived_AFGH += dataTuple[10]
			self.totalBitErrors_AFGH += dataTuple[11]

			if(self.lastSeqNum_NC != dataTuple[5]):
				self.totalBitsReceived_AFGH_noNC += dataTuple[10]
				self.totalBitErrors_AFGH_noNC += dataTuple[11]

		elif(dataTuple[6] == PKTTYPE_DFDATA):
			self.totalBitsReceived_DF += dataTuple[10]
			self.totalBitErrors_DF += dataTuple[11]

			if(self.lastSeqNum_NC != dataTuple[5]):
				self.totalBitsReceived_DF_noNC += dataTuple[10]
				self.totalBitErrors_DF_noNC += dataTuple[11]

		elif(dataTuple[6] == PKTTYPE_DFGHDATA):
			self.totalBitsReceived_DFGH += dataTuple[10]
			self.totalBitErrors_DFGH += dataTuple[11]

			if(self.lastSeqNum_NC != dataTuple[5]):
				self.totalBitsReceived_DFGH_noNC += dataTuple[10]
				self.totalBitErrors_DFGH_noNC += dataTuple[11]

		elif(dataTuple[6] == PKTTYPE_NCMHOPDATA):
			self.totalBitsReceived_NCMHOP += dataTuple[10]
			self.totalBitErrors_NCMHOP += dataTuple[11]

		else:
			print("ObserveCoopBERStruct::updateFromNode: Unknown pktType=%d" % dataTuple[6])

	def clearBitCounts(self):
		self.totalBitsReceived_NC = 0
		self.totalBitsReceived_AF = 0
		self.totalBitsReceived_AFGH = 0
		self.totalBitsReceived_DF = 0
		self.totalBitsReceived_DFGH = 0
		self.totalBitsReceived_NCMHOP = 0

		self.totalBitErrors_NC = 0
		self.totalBitErrors_AF = 0
		self.totalBitErrors_AFGH = 0
		self.totalBitErrors_DF = 0
		self.totalBitErrors_DFGH = 0
		self.totalBitErrors_NCMHOP = 0

		self.totalBitsReceived_AF_noNC = 0
		self.totalBitsReceived_AFGH_noNC = 0
		self.totalBitsReceived_DF_noNC = 0
		self.totalBitsReceived_DFGH_noNC = 0

		self.totalBitErrors_AF_noNC = 0
		self.totalBitErrors_AFGH_noNC = 0
		self.totalBitErrors_DF_noNC = 0
		self.totalBitErrors_DFGH_noNC = 0
		
		self.lastSeqNum_NC = -1;
		
class ObservePERStruct(ClientStruct):
	#typedef struct {
	#	unsigned char structID;
	#	unsigned char nodeID;
	#	unsigned char reqNum;
	#	unsigned char reqType;
	#	unsigned int numPkts_tx;
	#	unsigned int numPkts_rx_good;
	#	unsigned int numPkts_rx_goodHdrBadPyld;
	#	unsigned int numPkts_rx_badHdr;
	#} warpnetObservePER;
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

class LogParams(ClientStruct):
#typedef struct {
#	unsigned char structID;
#	unsigned char nodeID;
#
#	unsigned short fileSuffix;
#	
#	unsigned int param0;
#	unsigned int param1;
#	unsigned int param2;
#	unsigned int param3;
#} warpnetLogParams;	
	fileSuffix = 0
	param0 = 0
	param1 = 0
	param2 = 0
	param3 = 0
	
	def __init__(self, logger=None):
		ClientStruct.__init__(self, logger)

		self.structID = STRUCTID_LOGPARAMS
		self.expectedReturnStructID = STRUCTID_LOGPARAMS_ACK
		self.fileSuffix = 0
		self.param0 = 0 #int
		self.param1 = 0 #int
		self.param2 = 0 #int
		self.param3 = 0 #int
	
	def prepToSend(self, nodeID):
		self.updateDone = False
		#was type "i", but Python complained when MSB of argument was 1...
		return struct.pack('!BBH4I', self.structID, nodeID, self.fileSuffix, self.param0, self.param1, self.param2, self.param3)

	def updateFromNode(self, rawData, pcapts):
		pass
