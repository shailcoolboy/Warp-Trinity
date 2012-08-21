from warpnet_client import *
from warpnet_common_params import *
from warpnet_experiment_structs import *
from twisted.internet import reactor
from datetime import *
import time

minTime = 10
pktLen = 1412
pktPeriod = 2000
mod_hdr = 2
mod_payload = 2
txGains = [30, 45, 60];

class ScriptMaster:
	def startup(self):
	
		er_log = DataLogger('twoNode_PER_Test_v0.m', flushTime=0)
		er_log.log("%%WARPnet PER Test Example - %s\r\n" % datetime.now())

		registerWithServer()
	
		nodes = dict()
		
		#WARP Nodes
		createNode(nodes, Node(0, NODE_PCAP))
		createNode(nodes, Node(1, NODE_PCAP))

		connectToServer(nodes)

		controlStruct = ControlStruct()
		nodes[0].addStruct('controlStruct', controlStruct)
		nodes[1].addStruct('controlStruct', controlStruct)
		
		cmdStructStart = CommandStruct(COMMANDID_STARTTRIAL, 0)
		nodes[0].addStruct('cmdStructStart', cmdStructStart)
		
		cmdStructStop = CommandStruct(COMMANDID_STOPTRIAL, 0)
		nodes[0].addStruct('cmdStructStop', cmdStructStop)

		cmdStructResetPER = CommandStruct(COMMANDID_RESET_PER, 0)
		nodes[0].addStruct('cmdStructResetPER', cmdStructResetPER)
		nodes[1].addStruct('cmdStructResetPER', cmdStructResetPER)

		perStruct0 = ObservePERStruct()
		perStruct1 = ObservePERStruct()
		nodes[0].addStruct('perStruct', perStruct0)
		nodes[1].addStruct('perStruct', perStruct1)

		sendRegistrations(nodes)

		controlStruct.packetGeneratorPeriod = pktPeriod
		controlStruct.packetGeneratorLength = pktLen
		controlStruct.channel = 9
		controlStruct.txPower = 63
		controlStruct.modOrderHeader = mod_hdr
		controlStruct.modOrderPayload = mod_payload
		
		nodes[0].sendToNode('controlStruct')
		nodes[1].sendToNode('controlStruct')

		nodes[0].sendToNode('cmdStructResetPER')
		nodes[1].sendToNode('cmdStructResetPER')

		#Experiment loop
		for ii, txGain in enumerate(txGains):
			print("Starting trial %d with TxGain %d at %s" % (ii, txGain, datetime.now()))
	
			#Stop any traffic that might be running
			nodes[0].sendToNode('cmdStructStop')
	
			#Reset the PER counters at all nodes
			nodes[0].sendToNode('cmdStructResetPER')
			nodes[1].sendToNode('cmdStructResetPER')
	
			controlStruct.txPower = txGain
			nodes[0].sendToNode('controlStruct')

			#Let things settle
			time.sleep(0.25)
			
			#Start the trial
			nodes[0].sendToNode('cmdStructStart')
	
			#Run until minTime elapses
			time.sleep(minTime)
	
			nodes[0].sendToNode('cmdStructStop')
	
			#Give the nodes and server time to process any final structs
			time.sleep(1)
	
			#Request 3 PER struts from each node, verifying the response matches this request
			perStruct0.reqNum = 0
			perStruct1.reqNum = 0
			perStruct0.reqType = 0
			perStruct1.reqType = 0
			
			nodes[0].sendToNode('perStruct')
			nodes[1].sendToNode('perStruct')
			
			if (perStruct0.reqNum != 0) or (perStruct1.reqNum != 0) or \
				(perStruct0.reqType != 0) or (perStruct1.reqType != 0):
				print("BAD STATE! Out-of-order PER Struct Received")
		
			#Record the results
			er_log.log("n0_txGain(%d) = %d;\t" % (ii+1, txGain))
			er_log.log("n0_txPkts(%d) = %d;\t" % (ii+1, perStruct0.numPkts_tx))
	
			er_log.log("n1_rxPkts_good(%d) = %d;\t" % 	(ii+1, perStruct1.numPkts_rx_good))
			er_log.log("n1_rxPkts_GhBp(%d) = %d;\t" % 	(ii+1, perStruct1.numPkts_rx_goodHdrBadPyld))
			er_log.log("n1_rxPkts_BadHdr(%d) = %d;\r\n" % 	(ii+1, perStruct1.numPkts_rx_badHdr))
	
		
		print("############################################")
		print("############# Experiment Done! #############")
		print("############################################")
		reactor.callFromThread(reactor.stop)
		
sm = ScriptMaster()
stdio.StandardIO(CmdReader())
factory = WARPnetClient(sm.startup);
reactor.connectTCP('localhost', 10101, factory)
reactor.run()
