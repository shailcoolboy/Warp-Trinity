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

		#Node entry for the BER processor app
		createNode(nodes, Node(99, NODE_PCAP))

		connectToServer(nodes)

		controlStruct = ControlStruct()
		nodes[0].addStruct('controlStruct', controlStruct)
		nodes[1].addStruct('controlStruct', controlStruct)
		
		cmdStructBERen = CommandStruct(COMMANDID_ENABLE_BER_TESTING, 0)
		nodes[0].addStruct('cmdStructBERen', cmdStructBERen)
		nodes[1].addStruct('cmdStructBERen', cmdStructBERen)

		cmdStructStart = CommandStruct(COMMANDID_STARTTRIAL, 0)
		nodes[0].addStruct('cmdStructStart', cmdStructStart)
		
		cmdStructStop = CommandStruct(COMMANDID_STOPTRIAL, 0)
		nodes[0].addStruct('cmdStructStop', cmdStructStop)

		berStruct = ObserveBERStruct()
		nodes[99].addStruct('berStruct', berStruct, handleUnrequested=True)

		sendRegistrations(nodes)

		controlStruct.packetGeneratorPeriod = pktPeriod
		controlStruct.packetGeneratorLength = pktLen
		controlStruct.channel = 9
		controlStruct.txPower = 63
		controlStruct.modOrderHeader = mod_hdr
		controlStruct.modOrderPayload = mod_payload
		
		nodes[0].sendToNode('controlStruct')
		nodes[1].sendToNode('controlStruct')

		nodes[0].sendToNode('cmdStructBERen')
		nodes[1].sendToNode('cmdStructBERen')

		#Experiment loop
		for ii, txGain in enumerate(txGains):
			print("Starting trial %d with TxGain %d at %s" % (ii, txGain, datetime.now()))
	
			#Stop any traffic that might be running
			nodes[0].sendToNode('cmdStructStop')
	
			#Update the Tx gain at the Tx node
			controlStruct.txPower = txGain
			nodes[0].sendToNode('controlStruct')

			#Clear the internal BER counters
			berStruct.clearBitCounts()

			#Let things settle
			time.sleep(0.25)
			
			#Start the trial
			nodes[0].sendToNode('cmdStructStart')
	
			#Run until minTime elapses
			time.sleep(minTime)
	
			nodes[0].sendToNode('cmdStructStop')
	
			#Give the nodes and server time to process any final structs
			time.sleep(1)
	
			#Record the results
			er_log.log("n0_txGain(%d) = %d;\t" % (ii+1, txGain))
			er_log.log("n1_bitsRx(%d) = %d;\t" % (ii+1, berStruct.totalBitsReceived))
			er_log.log("n1_bitErrs(%d) = %d;\r\n" % (ii+1, berStruct.totalBitErrors))
		
		print("############################################")
		print("############# Experiment Done! #############")
		print("############################################")
		reactor.callFromThread(reactor.stop)
		
sm = ScriptMaster()
stdio.StandardIO(CmdReader())
factory = WARPnetClient(sm.startup);
reactor.connectTCP('localhost', 10101, factory)
reactor.run()
