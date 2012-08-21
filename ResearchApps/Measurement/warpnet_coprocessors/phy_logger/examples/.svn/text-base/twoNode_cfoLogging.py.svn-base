from warpnet_framework.warpnet_client import *
from warpnet_framework.warpnet_common_params import *
from warpnet_experiment_structs import *
from twisted.internet import reactor
from datetime import *
from numpy import log10, linspace
import time
import sys

mods = [[2,2,2100,78-1]]

pktLens = [1412]; #range(1412, 91, -240) #[1440:-120:120]-28

time_on = 5*60
time_off = 0
numItrs = 1
fileName_offset = 50
#cfo = 2**20
cfo = 2**17

txGain = 55
minChanMag_D = 20


class ScriptMaster:
	def startup(self):
	
		stderr_log = open("exp_err.log", "a")
		stderr_log.write("\r\n####################################################################\r\n")
		stderr_log.write("%s started at %s\r\n" % (sys.argv[0], datetime.now()))
		stderr_log.write("####################################################################\r\n\r\n")
		stderr_log.flush()
		sys.stderr = stderr_log

		er_log = MyDataLogger('results/twoNode_realCFO_v%d_logging.txt' % (fileName_offset))

		er_log.log("%s" % (datetime.now()) )
		er_log.log("CFO: %d, Time on: %d, time off: %d, numIttrs: %d, fn_offset: %d\r\n" % (cfo, time_on, time_off, numItrs, fileName_offset))
		er_log.log("Continuous test of actual CFO on emulator kits\r\n")

		registerWithServer()
	
		nodes = dict()
		
		#WARP Nodes
		createNode(nodes, Node(0, NODE_PCAP))
		createNode(nodes, Node(2, NODE_PCAP))

		#BER processor "node"
		createNode(nodes, Node(98, NODE_PCAP)) #PHY logger

		connectToServer(nodes)

		controlStruct = ControlStruct()
		nodes[0].addStruct('controlStruct', controlStruct)
		nodes[2].addStruct('controlStruct', controlStruct)
		
		phyCtrl0 = PHYctrlStruct()
		phyCtrl1 = PHYctrlStruct()
		nodes[0].addStruct('phyCtrlStruct', phyCtrl0)
		nodes[2].addStruct('phyCtrlStruct', phyCtrl1)

		cmdStructStart = CommandStruct(COMMANDID_STARTTRIAL, 0)
		nodes[0].addStruct('cmdStructStart', cmdStructStart)
		
		cmdStructStop = CommandStruct(COMMANDID_STOPTRIAL, 0)
		nodes[0].addStruct('cmdStructStop', cmdStructStop)

		cmdStructResetPER = CommandStruct(COMMANDID_RESET_PER, 0)
		nodes[0].addStruct('cmdStructResetPER', cmdStructResetPER)
		nodes[2].addStruct('cmdStructResetPER', cmdStructResetPER)

		perStruct0 = ObservePERStruct()
		perStruct1 = ObservePERStruct()
		nodes[0].addStruct('perStruct', perStruct0)
		nodes[2].addStruct('perStruct', perStruct1)

		logParams = LogParams()
		nodes[98].addStruct('logParams', logParams)

		sendRegistrations(nodes)

		controlStruct.packetGeneratorPeriod = mods[0][2]
		controlStruct.packetGeneratorLength = pktLens[0]
		controlStruct.channel = 9
		controlStruct.txPower = txGain
		controlStruct.modOrderHeader = mods[0][0]
		controlStruct.modOrderPayload = mods[0][1]
		
		#PHYCtrol params:
		#param0: txStartOut delay
		#param1: artificial txCFO
		#param2: minPilotChanMag
		#param3: 
		# [0-0x01]: PHYCTRL_BER_EN: enable BER reporting
		# [1-0x02]: PHYCTRL_CFO_EN: enable CFO reporting
		# [2-0x04]: PHYCTRL_PHYDUMP_EN: enable Rx PHY dumping
		# [3-0x08]: PHYTRCL_EXTPKTDET_EN: use only ext pkt det
		# [4-0x10]: PHYCTRL_COOP_EN: 0=nonCoop, 1=coopMode
		# [5-0x20]: PHYCTRL_CFO_CORR_EN: 0=bypass CFO correction, 1=enable CFO correction
		# [6-0x40]: PHYCTRL_SWAP_ANT: 0=AntA, 1=AntA_Swapped
		#param4:
		# [ 7:0]: src re-Tx delay
		# [ 7:0]: relay AF Tx delay (only used when in COOP_TESTING)
		# [15:8]: relay DF Tx delay (only used when in COOP_TESTING)
		#param5: (0 ignores)
		# [17: 0]: AGC IIR coef FB
		#param6: (0 ignores)
		# [31:16]: H_BA minEstMag (UFix16_15)
		# [15: 0]: H_AA minEstMag (UFix16_15)
		#param7: (0 ignores)
		# [27:16]: AF blank stop
		# [11: 0]: AF blank start
		#param8: (0 ignores)
		# [17: 0]: AGC IIR coef Gain
		#param9: (Tx pkt types)
		# [31: 0]: OR'd combination of PHYCTRL_TX_*

		
		phyCtrl0.param0 = 32+12
		phyCtrl0.param1 = cfo #(2**19 ~ 1.2e-4)
		phyCtrl0.param2 = 0xFFF
#		phyCtrl0.param3 = (PHYCTRL_COOP_EN | PHYCTRL_BER_EN)
		phyCtrl0.param3 = (0) #PHYCTRL_COOP_EN)
#		phyCtrl0.param4 = (251-2) #v21 timing; #######reTxDly/FFToffset: 251/12, 249/10
		phyCtrl0.param4 = 255 #v22 timing
		phyCtrl0.param5 = 0
		phyCtrl0.param6 = 0
		phyCtrl0.param7 = 0
		phyCtrl0.param8 = 0
#		phyCtrl0.param9 = (PHYCTRL_TX_NC | PHYCTRL_TX_DF | PHYCTRL_TX_AF | PHYCTRL_TX_AFGH | PHYCTRL_TX_DFGH | PHYCTRL_TX_NCMHOP)
		phyCtrl0.param9 = (PHYCTRL_TX_NC)
		
		phyCtrl1.param0 = 0
		phyCtrl1.param1 = 0
		phyCtrl1.param2 = minChanMag_D
#		phyCtrl1.param3 = (PHYCTRL_CFO_CORR_EN | PHYCTRL_PHYDUMP_EN)
		phyCtrl1.param3 = (PHYCTRL_PHYDUMP_EN)
		phyCtrl1.param4 = 0
		phyCtrl1.param5 = 0x20000
		phyCtrl1.param6 = 1000 | (1000<<16)
		phyCtrl1.param7 = 0
		phyCtrl1.param8 = 0x20000
		phyCtrl1.param9 = 0

		nodes[0].sendToNode('phyCtrlStruct')
		nodes[2].sendToNode('phyCtrlStruct')

		nodes[0].sendToNode('controlStruct')
		nodes[2].sendToNode('controlStruct')

		nodes[0].sendToNode('cmdStructResetPER')
		nodes[2].sendToNode('cmdStructResetPER')

		trialInd = -1 #Increment before first trial, which should be trialNum=0
		
		pktLen = pktLens[0];
		
		#Experiment Loops
		for ittr in range(1,numItrs+1):
			print("Starting iteration %d of %d at %s" % (ittr, numItrs, datetime.now().strftime("%H:%M:%S")))
			
			trialInd += 1

			#Stop any traffic that might be running
			nodes[0].sendToNode('cmdStructStop')

			logParams.fileSuffix = fileName_offset+trialInd
			logParams.param0 = ittr
			logParams.param1 = 0
			logParams.param2 = 0
			logParams.param3 = 0
			nodes[98].sendToNode('logParams')

			#Reset the PER counters at all nodes
			nodes[0].sendToNode('cmdStructResetPER')
			nodes[2].sendToNode('cmdStructResetPER')

			#Start the trial
			nodes[0].sendToNode('cmdStructStart')

			#Run until minTime elapses
			time.sleep(time_on)

			nodes[0].sendToNode('cmdStructStop')

			time.sleep(time_off)

			if not reactor.running:
				return

		print("############################################")
		print("############# Experiment Done! #############")
		print("############################################")
		reactor.callFromThread(reactor.stop)
		
sm = ScriptMaster()
stdio.StandardIO(CmdReader()) #if interactive shell is needed
factory = WARPnetClient(sm.startup);
reactor.connectTCP('localhost', 10101, factory)
reactor.run()
