
/*! \file rtsctsMac.c
\brief RTS/CTS MAC.

@author Keith Wilhelm

The RTS/CTS MAC is a modified CSMA MAC that implements the RTS/CTS exchange
protocol on the WARP platform. When a node receives a packet over its ethernet
link addressed to another node in the network, it first sends an RTS 
(Request to Send) to that node. The node to which this RTS was addressed
then replies with a CTS (Clear To Send) if it is ready to receive data.
Upon receiving the CTS, the original node begins transmitting its data across
the PHY. Once the data packet is received by the other node, it replies with
an ACK packet. If there is a failure at any point in the exchange, it must be
restarted from the beginning. The rtsThreshold can be used to disable the
RTS/CTS exchange for packets shorter than the threshold, sending the data
packet directly instead.

The RTS/CTS MAC is able to look at IP addresses in the ethernet packets that
it receives and address those packets to a corresponding MAC address.
Ethernet packets that are sent to broadcast addresses or that are unrecognized
are sent directly over the PHY with no RTS, CTS, or ACK.

The RTS, CTS, and data packets carry information about how long the current
exchange will take to finish, so that other nodes hearing any of those packets
can defer until the end of the exchange, preventing them from interfering
with the exchange. This is accomplished by setting a network allocation
vector (NAV) timer.


Setup:
The each node must have an IP address whose first three bytes match the
net address (state.addr.net) and last byte matches the node ID (setting of the
dip switches). (Since the last number of the IP address cannot be 0, the node
ID cannot be 0 either). Each node's mac address must also match the routeTable
entry corresponding to its node ID (routeTable[myID].addr[]).

Comments by Joseph Camp:
The left-most LED will have a value of the modulation rate according to 
BPSK (1), QPSK (2), and 16QAM (3).  There are modes which are represented on
the right-most LED of these three modulation rates without RTS/CTS (0,1,2) and
then with RTS/CTS (3,4,5).  The mode can be incremented by pressing the right
button and it loops from 0x0 to 0x5.  Pressing the left button lowers the 
modulation rate.  The system is uncoded.  There is still a usleep(10) before 
the ACK is transmitted due to a timing issue that will be fixed with static
inline'ing of functions (approx. line 610).
*/
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>

#include "xparameters.h"
#include "xutil.h"
#include "ofdm_pktdetector_mimo_regMacros.h"
#include "warp_timer_regMacros.h"
#include "ofdm_txrx_mimo_regMacros.h"
#include "warpmac.h"
#include "warpphy.h"
#include "rtsctsMac.h"
#include "rtsctsTest.h"
#include "ascii_characters.h"


///packet headers
struct {
	///received packet
	Macframe rx;
	///Request To Send
	Macframe rts;
	///Clear To Send
	Macframe cts;
	///DATa
	Macframe dat;
	///ACKnowledgement
	Macframe ack;
	///BroadCast Data
	Macframe bcd;
} pkt;

///MAC/NAV states
enum {IDLE,BUSY};

///packet types and MAC states
enum {RTS=1,CTS=2,DAT=3,ACK=4,BCD=5,ETH=6};

///inter-frame delays, packet transmission times, and packet timeouts
struct {
	///backoff time increments
	unsigned short slot;
	///time between adjacent symbols within a packet exchange sequence, used only for timer calculations
	unsigned short SIFS;
	///time the channel must be idle to begin a packet exchange
	unsigned short DIFS;
	///time the channel must be idle to begin a packet exchange after receiving a bad packet
	unsigned short EIFS;
	
	///header transmission time
	unsigned short header;
	///transmission times for each of the packet types (not all are used)
	unsigned short transmit[5];
	///timeouts for receiving each of the packet types (not all are used)
	unsigned short timeout[5];
} delay;

///packet counters
unsigned int pktCtr[4][7];
///packet counter array indices
enum {TX=0, RXGOOD=1, RXUNEXP=2, RXBAD=3, DROP=3};

///struct for RTS/CTS MAC state variables
struct {
	///packets with payload shorter than rtsThreshold are sent without RTS/CTS handshake
	unsigned short rtsThreshold;
	///enable sending of CSI in the CTS packet
	unsigned char feedback_en;
	///MAC state; idle or indicates the type of packet that we expect to receive
	unsigned char mac;
	///wireless channel number (1-14)
	unsigned char chan;
	///current antenna; 0 - antenna A, 1 - antenna B
	unsigned char currentAnt;
	///index to the routing table that identifies this node
	unsigned char myID;
	///state of the general purpose IO pins (for debugging)
	unsigned char GPIOval;
	///modulation for base rate symbols
	unsigned char baseRate;
	///modulation for full rate symbols
	unsigned char fullRate;

	///resend limits
	struct {
		///RTS packet resend limit
		unsigned short rts;
		///data packet resend limit
		unsigned short dat;
	} maxResend;
	
	///addresses
	struct {
		///MAC address of this node
		unsigned char my[6];
		///broadcast MAC address
		const unsigned char bc[6];
		///network IP address
		const unsigned char net[4];
	} addr;
	
	///Routing table with agreed-upon mapping between dip-switches and physical addresses
	struct {
		unsigned char addr[6];
	} routeTable[16];
	
	unsigned char mrateMode;
	unsigned char rtsScheme;
} state = {
	.rtsThreshold = 65535,
	.feedback_en = 0,
	.mac = IDLE,
	.chan = 14,
	.currentAnt = 0,
	.GPIOval = 0,
	.baseRate = QPSK,
	.fullRate = QPSK,
	.maxResend.rts = 4,
	.maxResend.dat = 2,
	.addr.bc = {0xff,0xff,0xff,0xff,0xff,0xff},
	.addr.net = {10,0,0,0},
	.mrateMode = BPSK_MOD,
	.rtsScheme = DISABLED,
};


///@brief convert modulation rate mask to state
///takes masks of 1,2,4,6 and transforms them to states of 1,2,3,4
///@param rate_mask
unsigned char convertMasktoState(unsigned char rate_mask) {
	switch (rate_mask) {
		case BPSK :  return BPSK_MOD;
							  break;
		case QPSK :  return QPSK_MOD;
							  break;
		case QAM_16 : return QAM16_MOD;
							  break;
		case QAM_64 : return QAM64_MOD;
							  break;
		default: return QPSK_MOD;
	}
}


///@brief convert modulation rate state to mask
///takes states of 1,2,3,4 and transforms them to masks of 1,2,4,6
///@param rate_state 
unsigned char convertStatetoMask(unsigned char rate_state) {
	switch (rate_state) {
		case BPSK_MOD :  return BPSK;
							  break;
		case QPSK_MOD :  return QPSK;
							  break;
		case QAM16_MOD : return QAM_16;
							  break;
		case QAM64_MOD : return QAM_64;
							  break;
		default: return QPSK;
	}
}


///@brief increase modulation rate of the data packets
///if not at the highest rate increments state.fullRate
///@param none
void increaseRate() {
	if (convertMasktoState(state.fullRate)<HIGHEST_RATE) {
	 	state.fullRate = convertStatetoMask(convertMasktoState(state.fullRate)+1);
	}
	warpmac_leftHex(convertMasktoState(state.fullRate));
}


///@brief decrease modulation rate of the data packets
///if not at the lowest rate decrements state.fullRate
///@param none
void decreaseRate() {
	if (convertMasktoState(state.fullRate)>LOWEST_RATE) {
	 	state.fullRate = convertStatetoMask(convertMasktoState(state.fullRate)-1);
	}
	warpmac_leftHex(convertMasktoState(state.fullRate));
}


///@brief increase the mode for rate and rts mode
///Order of Modes: 
///static rates (without rts): 	bpsk (0), qpsk (1), 16qam (2)
///static rates (with rts): 		bpsk (3), qpsk (4), 16qam (5)
///@param none
void incrementMrateMode() {
	if (state.mrateMode < 0x5) {
		state.mrateMode++;
	}
	else {
		state.mrateMode=0x0;
	}
			
	state.rtsThreshold = 2000;
	state.rtsScheme = DISABLED;

	switch(state.mrateMode){
		case BPSK_MODE:
			state.fullRate = convertStatetoMask(BPSK_MOD);
			break;
		case QPSK_MODE:
			state.fullRate = convertStatetoMask(QPSK_MOD);
			break;
		case QAM16_MODE:
			state.fullRate = convertStatetoMask(QAM16_MOD);
			break;
		case BPSKRTS_MODE:
			state.fullRate = convertStatetoMask(BPSK_MOD);
			state.rtsThreshold =  1000;
			state.rtsScheme = ENABLED;
			break;
		case QPSKRTS_MODE:
			state.fullRate = convertStatetoMask(QPSK_MOD);
			state.rtsThreshold = 1000;
			state.rtsScheme = ENABLED;
			break;
		case QAM16RTS_MODE:
			state.fullRate = convertStatetoMask(QAM16_MOD);
			state.rtsThreshold = 1000;
			state.rtsScheme = ENABLED;
			break;
		default: 
			state.fullRate = convertStatetoMask(BPSK_MOD);
			state.mrateMode = BPSK_MODE;
			break;
	}	
	
	//Set the right LED to display mrateMode
	warpmac_rightHex(state.mrateMode);
	warpmac_leftHex(convertMasktoState(state.fullRate));
}

///@brief calculates ceil(a/b) of two unsigned integers, a and b
///uses integer arithmetic
///@param a dividend
///@param b divisor
///@return quotient
static inline unsigned int ceil_div_uint(unsigned int a, unsigned int b) {
	return (a+b-1)/b;
}


///@brief set difsPeriod in PHY
///Sets the time for which the channel must have been idle for warpmac_carrierSense()
///to return 1
///@param newTime Time
static inline void setCSMAIdleTime(unsigned int newTime) {
	ofdm_pktDetector_mimo_WriteReg_csma_difsPeriod(PKTDET_BASEADDR, newTime*80);
}


///@brief timer management function
///Handles setting and updating the timers
///@param type Indicates which timer to set
///@param newTime Length of timer in microseconds (not used for backoff)
void updateTimer(unsigned char type, unsigned int newTime) {
	extern Maccontrol controlStruct;	// used for tracking the backoff
	switch(type) {
	case TIMEOUT:
		if(!warp_timer_isActive(NAV)) {
			// convert microseconds to timer clock cycles
			newTime = (newTime + delay.slot) * 80;	// margin added for processing time
			if(warp_timer_isActive(BACKOFF))
				warp_timer_pause(BACKOFF);
			warp_timer_setVal(TIMEOUT, newTime);
			warp_timer_start(TIMEOUT);
		}
		break;
	case BACKOFF:
		state.mac = IDLE;
		newTime = randNum(controlStruct.currBackoff) * delay.slot * 80;
		if(!warp_timer_isActive(TIMEOUT) && !warp_timer_isActive(NAV)) {
			if(warp_timer_isPaused(BACKOFF)) {
				warp_timer_resume(BACKOFF);
			} else {
				warp_timer_setVal(BACKOFF, newTime);
				warp_timer_start(BACKOFF);
				if(controlStruct.currBackoff < controlStruct.maxBackoff)
					controlStruct.currBackoff++;
			}
		} else {
			warp_timer_stop(BACKOFF);
			warp_timer_setVal(BACKOFF, newTime);
			warp_timer_start(BACKOFF);
			warp_timer_pause(BACKOFF);
			if(controlStruct.currBackoff < controlStruct.maxBackoff)
				controlStruct.currBackoff++;
		}
		break;
	case NAV:
		// convert microseconds to timer clock cycles
		newTime = newTime * 80;
		if(warp_timer_isActive(TIMEOUT))
			warp_timer_stop(TIMEOUT);
		if(warp_timer_isActive(BACKOFF))
			warp_timer_pause(BACKOFF);
		if(warp_timer_isActive(NAV)) {
			warp_timer_pause(NAV);
			if(warp_timer_timeLeft(NAV) < newTime) {
				warp_timer_setVal(NAV, newTime);
				warp_timer_start(NAV);
			} else {
				warp_timer_resume(NAV);
			}
		} else {
			warp_timer_setVal(NAV, newTime);
			warp_timer_start(NAV);
		}
		
		break;
	}
}


///@brief Callback for the expiration of timers
///@param unused Not used
int rtsmac_timer_callback(unsigned char unused) {
	extern unsigned char timerIntStatus;
	if(timerIntStatus & 2) {
		// backoff expired
		if(pkt.bcd.isNew)
			sendBCD();
		else if(pkt.dat.isNew)
			initTX();
	} else if (timerIntStatus & 1) {
		// timeout expired
		if (pkt.dat.isNew) {
			updateTimer(BACKOFF, 0);
		}
	} else {
		//NAV expired
		//tvar[state.mac]++;
		if (pkt.dat.isNew) {
			updateTimer(BACKOFF, 0);
		}
	}
	return 0;
}


///@brief Drops the ethernet packet waiting to be sent
///Reenables ethernet reception
void dropPacket() {
	pkt.dat.isNew = 0;
	pkt.bcd.isNew = 0;
	state.mac = IDLE;
	pktCtr[DROP][ETH]++;
	warpmac_enableEthernet();
}


///@brief Callback for the reception of Ethernet packets
///This function is called by the ethernet MAC drivers when a packet is
///available to send. If the packet is addressed to a specific IP address,
///this function translates that IP address into a MAC address using the
///routeTable, completes the headers of the RTS and data packets, and calls
///initTX. If the packet is to be broadcast, sendBCD is called.
///@param length Length, in bytes, of received Ethernet frame
///@param payload Pointer to Ethernet payload.
int rtsmac_emacRx_callback(Xuint32 length, char* payload) {
	UTime time;
	warpmac_disableEthernet();
	pktCtr[RXGOOD][ETH]++;
	
	if(*(unsigned char *)(payload+33)<16
		&& *(unsigned char *)(payload+32)==state.addr.net[2]
		&& *(unsigned char *)(payload+31)==state.addr.net[1]
		&& *(unsigned char *)(payload+30)==state.addr.net[0]) {
		// complete the data packet header
		// enable RTS/CTS if length of packet > RTS threshold
		pkt.dat.header.length = length;
		memcpy(pkt.dat.header.destAddr,
			state.routeTable[*(unsigned char *)(payload+33)].addr,
			6);
		pkt.dat.header.currReSend = 0;
		pkt.dat.isNew = 1;
		
		pkt.dat.header.fullRate = state.fullRate;

		// calculate transmission time for data packet
		delay.transmit[DAT] = delay.header + 8*ceil_div_uint((length+4), (state.fullRate & 0xF)*6);
		delay.timeout[DAT] = delay.transmit[DAT] + 44;		//44us turnaround between CTS and DAT
		// complete the RTS packet header
		memcpy(pkt.rts.header.destAddr, pkt.dat.header.destAddr, 6);
		pkt.rts.header.currReSend = 0;
		time.uint16 = delay.timeout[CTS] + delay.timeout[DAT] + delay.timeout[ACK];
		pkt.rts.header.reserved1 = time.uint8[0];
		pkt.rts.header.reserved2 = time.uint8[1];
		
		initTX();
	} else {
		// set up and load BCD packet once so that subsequent calls to sendBCD can skip this step
		pkt.bcd.header.length = length;
		pkt.bcd.header.fullRate = state.fullRate;
		pkt.bcd.isNew = 1;
		warpmac_prepPhyForXmit(&pkt.bcd,1);
		sendBCD();
	}
	
	return 0;
}


///@brief Initiate a packet exchange sequence
///The sequence begins with an RTS if the data packet length exceeds the
///RTS/CTS threshold or with the data packet if not. The packet is dropped
///if the maximum resend count has been reached. If a carrier is sensed,
///a backoff timer is set. Once the timer ends, the communication will
///be retried. After sending a packet, this function sets a timeout for
///receiving the response.
void initTX() {
	if(pkt.dat.isNew) {
		if((pkt.rts.header.currReSend <= state.maxResend.rts) && (pkt.dat.header.currReSend <= state.maxResend.dat)) {
			if(!warp_timer_isActive(NAV) && !warp_timer_isActive(TIMEOUT)) {
				if(warpmac_carrierSense()) {
					if(pkt.dat.header.length < state.rtsThreshold) {
						// begin with data packet (send without RTS/CTS exchange)
						warpmac_prepPhyForXmit(&pkt.dat, 1);
						sendDAT();
					} else {
						// begin with RTS
						warpmac_prepPhyForXmit(&pkt.rts, 2);
						warpmac_startPhyXmit(2);
						state.mac = CTS;
						pktCtr[TX][RTS]++;
						pkt.rts.header.currReSend++;
						warpmac_finishPhyXmit();
						updateTimer(TIMEOUT, delay.timeout[CTS]);
						// set fullRate for MISO if feedback is enabled, SISO otherwise
						pkt.dat.header.fullRate = (state.feedback_en) ? (state.fullRate | (state.fullRate<<4)) : state.fullRate;
						// copy data packet header into PHY while waiting for CTS
						warpmac_prepPhyForXmit(&pkt.dat, 1);
					}
					setCSMAIdleTime(delay.DIFS);	// reset to DIFS (in case EIFS was previously set)
				} else {
					updateTimer(BACKOFF, 0);
				}
			}
		} else {
			// resend limit has been reached
			dropPacket();
		}
	}
}


///@brief Send Clear To Send packet over the PHY
///checks NAV state to determine whether channel is reserved
///Channel state information should be in TxBuffer 3
///@param packet Pointer to received RTS packet
void sendCTS(Macframe* packet) {
	UTime time;

	memcpy(pkt.cts.header.destAddr,packet->header.srcAddr,6);
	// set the NAV of other nodes to reserve the channel
	time.uint8[0] = packet->header.reserved1;
	time.uint8[1] = packet->header.reserved2;
	// calculate new NAV time using RTS's NAV time
	time.uint16 = time.uint16 - delay.timeout[CTS];
	pkt.cts.header.reserved1 = time.uint8[0];
	pkt.cts.header.reserved2 = time.uint8[1];
	
	delay.timeout[DAT] = time.uint16 - delay.timeout[ACK];
	
	warpmac_prepPhyForXmit(&pkt.cts, 3);
	
	// send CTS packet if NAV indicates channel is idle, else do not respond
	if(!warp_timer_isActive(NAV)) {
		warpmac_startPhyXmit(3);			// CSI must be in buffer 3
		pktCtr[TX][CTS]++;
		state.mac = DAT;
		warpmac_finishPhyXmit();
		updateTimer(TIMEOUT, delay.timeout[DAT]);
	}
}


///@brief Send a data packet over the PHY
void sendDAT() {
	extern Maccontrol controlStruct;
	warpmac_startPhyXmit(1);
	warpmac_finishPhyXmit();		
	pktCtr[TX][DAT]++;
	pkt.dat.header.currReSend++;
	state.mac = ACK;
	updateTimer(TIMEOUT, delay.timeout[ACK]);
	
}


///@brief Broadcast a data packet
///Verifies that the channel is not reserved or busy before transmitting.
void sendBCD() {
	if(!warp_timer_isActive(NAV) && !warp_timer_isActive(TIMEOUT)) {
		if(warpmac_carrierSense()) {
			warpmac_startPhyXmit(1);
			pkt.bcd.isNew = 0;
			pktCtr[TX][BCD]++;
			setCSMAIdleTime(delay.DIFS);
			warpmac_finishPhyXmit();
			warpmac_enableEthernet();
		}
	}
}


///@brief Callback for the reception of bad wireless packets
int rtsmac_phyRx_badHeader_callback() {
	if (pkt.dat.isNew) {
		updateTimer(BACKOFF, 0);
	}
	setCSMAIdleTime(delay.EIFS);
	warpmac_incrementLEDLow();
	return 0;
}


///@brief Callback for the reception of good wireless packet headers
///This interrupt service routine is called when a packet header is detected,
///allowing a reduction in the turn-around time of the response packet.
///This is accomplished by completing the response packet header and loading it
///into the PHY before the rest of the incoming packet is received, letting us
///send the response as soon as possible.
///@param packet Pointer to received header
int rtsmac_phyRx_goodHeader_callback(Macframe* packet) {
	extern Maccontrol controlStruct;
	unsigned char rxStatus = INCOMPLETE;
	if(warpmac_addressedToMe(packet) && !warp_timer_isActive(NAV)) {
		warp_timer_stop(TIMEOUT);
		//warpmac_setDebugGPIO(state.GPIOval |= 1);
		if(packet->header.pktType == RTS) { 
			while(rxStatus == INCOMPLETE) {
				rxStatus = warpphy_pollRxStatus();
			}
			if(rxStatus == GOODPACKET) {
				sendCTS(packet);
			}
		} else if(packet->header.pktType == CTS) { 
			while(rxStatus == INCOMPLETE) {
				rxStatus = warpphy_pollRxStatus();
			}
			if(rxStatus == GOODPACKET) {
				sendDAT();
			}
		} else if(packet->header.pktType == DAT) { 
			memcpy(pkt.ack.header.destAddr,packet->header.srcAddr,6);
			warpmac_prepPhyForXmit(&pkt.ack,2);
			while(rxStatus == INCOMPLETE) {
				rxStatus = warpphy_pollRxStatus();
			}
			if(rxStatus == GOODPACKET) {
				//Send packet buffer 2 containing the ACK
				if (packet->header.reserved3 == (state.mrateMode+1)) {
					incrementMrateMode();
				}
				//JC extra context switches with rts causing problems (needs "static inline" for ultimate solution)
				usleep(10);
				warpmac_startPhyXmit(2);
				//Starts the DMA transfer of the payload into the EMAC
				warpmac_prepEmacForXmit(packet);
				pktCtr[TX][ACK]++;
				pktCtr[TX][ETH]++;
				//Blocks until the PHY is finished sending and enables the receiver
				warpmac_finishPhyXmit();
				//Waits until the DMA transfer is complete, then starts the EMAC
				warpmac_startEmacXmit(packet);
				if (pkt.dat.isNew) {
					updateTimer(BACKOFF, 0);
				}
			}
		} else if(packet->header.pktType == ACK) {
				pkt.dat.isNew = 0;
				controlStruct.currBackoff = 0;
				warpmac_enableEthernet();
		} else {
			// packet was not expected, invoke backoff procedure
			while(rxStatus == INCOMPLETE) {
				rxStatus = warpphy_pollRxStatus();
			}
			if(rxStatus == GOODPACKET) {
				pktCtr[RXGOOD][packet->header.pktType]--;
				pktCtr[RXUNEXP][packet->header.pktType]++;
				if (pkt.dat.isNew) {
					updateTimer(BACKOFF, 0);
				}
			}
		}
	 } else if(packet->header.pktType == BCD) {
		// packet was broadcast, simply forward over ethernet and backoff
		while(rxStatus == 0) {
			rxStatus = warpphy_pollRxStatus();
		}
		if(rxStatus == GOODPACKET) {
			//Starts the DMA transfer of the payload into the EMAC
			warpmac_prepEmacForXmit(packet);
			//Waits until the DMA transfer is complete, then starts the EMAC
			warpmac_startEmacXmit(packet);
			if (pkt.dat.isNew) {
				updateTimer(BACKOFF, 0);
			}
		}
	} else {
		// packet addressed to someone else, set/update NAV timer to reserve channel
		UTime time;
		time.uint8[0] = packet->header.reserved1;
		time.uint8[1] = packet->header.reserved2;
		if(time.uint16 > 0) {
			updateTimer(NAV,time.uint16);
		}
	}
	
	if(rxStatus == GOODPACKET) {
		pktCtr[RXGOOD][packet->header.pktType]++;
		warpmac_incrementLEDHigh();
	} else if(rxStatus == BADPACKET) {
		pktCtr[RXBAD][packet->header.pktType]++;
		rtsmac_phyRx_badHeader_callback();
	}
	//warpmac_setDebugGPIO(state.GPIOval &= ~1);
	return 0;
}


///@brief Define transmit, inter-frame, and timeout times
void initDelays() {
	// times for sending various packets
	delay.header = 64;		// header only packet requires 64us
	delay.transmit[CTS] = delay.header + 6*(state.fullRate & 0xF)*8;
	delay.transmit[ACK] = delay.header;
	
	// delay times (in microseconds)
	delay.slot = 9;
	delay.SIFS = 46;
	delay.DIFS = delay.SIFS + 2*delay.slot;
	delay.EIFS = delay.SIFS + delay.DIFS + delay.transmit[ACK];
	
	// timeouts for receiving response packets
	delay.timeout[CTS] = delay.slot  + delay.transmit[CTS] + 46;		// 46us turnaround between RTS and CTS
	delay.timeout[ACK] = delay.slot + delay.transmit[ACK] + 24;	// 24us turnaround between data and ACK
	
	// set DIFS time in PHY
	setCSMAIdleTime(delay.DIFS);
	
	warpmac_setMaxCW(5);
}


///@brief Set up addresses and routing table
void initAddresses() {
	unsigned char i;
	
	//Read Dip Switch value from FPGA board.
	//This value will be used as an index into the routing table for other nodes
	state.myID = warpmac_getMyId();
	
	//Create an arbitrary address for this node (16-24-63-53-e2-(c2+state.myID))
	state.addr.my[0] = 0x16; state.addr.my[1] = 0x24; state.addr.my[2] = 0x63;
	state.addr.my[3] = 0x53; state.addr.my[4] = 0xe2; state.addr.my[5] = 0xc2+state.myID;
	
	//Fill an arbitrary routing table so that nodes know each others' addresses
	for(i=0;i<16;i++) {
		state.routeTable[i].addr[0] = state.addr.my[0];
		state.routeTable[i].addr[1] = state.addr.my[1];
		state.routeTable[i].addr[2] = state.addr.my[2];
		state.routeTable[i].addr[3] = state.addr.my[3];
		state.routeTable[i].addr[4] = state.addr.my[4];
		state.routeTable[i].addr[5] = state.addr.my[5]+i-state.myID;
	}
	
	warpmac_setMacAddr((unsigned char *)(&state.addr.my));
}


///@brief Set up headers for each packet type
void initHeaders() {
	UTime time;
	
	// set up RTS packet
	pkt.rts.header.fullRate = state.fullRate;
	pkt.rts.header.length = 0;
	pkt.rts.header.pktType = RTS;
	memcpy(pkt.rts.header.srcAddr,(unsigned char *)state.addr.my,6);
	pkt.rts.header.currReSend = 0;
	
	// set up CTS packet
	pkt.cts.header.fullRate = state.fullRate;
	pkt.cts.header.length = 0;
	pkt.cts.header.pktType = CTS;
	memcpy(pkt.cts.header.srcAddr,(unsigned char *)state.addr.my,6);
	pkt.cts.header.currReSend = 0;
	
	// set up data packet
	pkt.dat.header.fullRate = state.fullRate;
	pkt.dat.header.pktType = DAT;
	memcpy(pkt.dat.header.srcAddr,(unsigned char *)state.addr.my,6);
	time.uint16 = delay.timeout[ACK];	// set NAV of other nodes
	pkt.dat.header.currReSend = 0;
	pkt.dat.header.reserved1 = time.uint8[0];
	pkt.dat.header.reserved2 = time.uint8[1];
	
	// set up ACK packet
	pkt.ack.header.fullRate = state.fullRate;
	pkt.ack.header.length = 0;
	pkt.ack.header.pktType = ACK;
	pkt.ack.header.currReSend = 0;
	pkt.ack.header.reserved1 = 0;	// set NAV to 0 for ACK (do not reserve channel)
	pkt.ack.header.reserved2 = 0;
	
	// set up broadcast data packet
	pkt.bcd.header.fullRate = state.fullRate;
	pkt.bcd.header.pktType = BCD;
	memcpy(pkt.bcd.header.destAddr,(unsigned char *)state.addr.bc,6);
	memcpy(pkt.bcd.header.srcAddr,(unsigned char *)state.addr.my,6);
	pkt.bcd.header.currReSend = 0;
	pkt.bcd.header.reserved1 = 0;	// set NAV to 0 (don't expect any reply)
	pkt.bcd.header.reserved2 = 0;
}


/***************** Button Handlers *********************************/
///@brief Left push-button handler
///decrease transmitter gain
void rtsmac_left() {
//	extern unsigned char txGain;
//	warpphy_setGainMinus(ceil_div_uint(txGain,8));
	decreaseRate();
	xil_printf("Rate (decrease): %d\r\n",convertMasktoState(state.fullRate));

	// static unsigned char i = 0;
	// i++;
	// i %= 6;
	// switch(i) {
	// case 0:
		// state.feedback_en = 0;
		// csi.current = csi.antA;
		// xil_printf("\nfeedback disabled");
		// break;
	// case 1:
		// state.feedback_en = 1;
		// csi.current = csi.antA;
		// xil_printf("\nantA");
		// break;
	// case 2:
		// state.feedback_en = 1;
		// csi.current = csi.antB;
		// xil_printf("\nantB");
		// break;
	// case 3:
		// state.feedback_en = 1;
		// csi.current = csi.half;
		// xil_printf("\nhalf");
		// break;
	// case 4:
		// state.feedback_en = 1;
		// csi.current = csi.otherhalf;
		// xil_printf("\notherhalf");
		// break;
	// case 5:
		// state.feedback_en = 1;
		// csi.current = csi.alternating;
		// xil_printf("\nalternating");
		// break;
	// }
}


///@brief Middle push-button handler
///print state variables
void rtsmac_middle() {
	printState();
	printTvars();
	printStatistics();
}


///@brief Right push-button handler
///increase transmitter gain
void rtsmac_right() {
//	extern unsigned char txGain;
//	warpphy_setGainPlus(ceil_div_uint(txGain,8));
	incrementMrateMode();
	xil_printf("mrateMode (increase): %d\r\n", state.mrateMode);
//		increaseRate();
//		xil_printf("Rate (increase): %d\r\n",convertMasktoState(state.fullRate));
}


///@brief Up push-button handler
///toggle between RTS/CTS and ordinary CSMA/CA by moving the rtsThreshold
void rtsmac_up() {
	state.rtsThreshold = (state.rtsThreshold == 0) ? 65535 : 0;
	// warpmac_leftHex((state.rtsThreshold) == 0 ? 1 : 0);
}


/***************** Status Display Functions ************************/
///@brief display status of the node
void printState() {
	extern Maccontrol controlStruct;
	xil_printf("\nMAC=%d,NAV=%d,dat.isNew=%d,bcd.isNew=%d,currentAnt=%d,"
		"timeLeft_0=%d,timeLeft_1=%d,timeLeft_2=%d,timeLeft_3=%d,tstatus=%x\r\n",
		state.mac,
		warp_timer_isActive(NAV),
		pkt.dat.isNew,
		pkt.bcd.isNew,
		state.currentAnt,
		warp_timer_timeLeft(0),
		warp_timer_timeLeft(1),
		warp_timer_timeLeft(2),
		warp_timer_timeLeft(3),
		warp_timer_getStatuses());
}


///@brief clear packet counter arrays
void clearPktCtr() {
	unsigned char i, j;
	for(i = 0; i < 4; i++){
		for(j = 0; j < 7; j++){
			pktCtr[i][j] = 0;
		}
	}
}


///@brief display packet counts
///TX - transmitted packets
///RX_good - received good packet
///RX_unexp - good packet received when a different type of packet was expected
///RX_bad - received bad packet
void printStatistics() {
	unsigned char i = 0;
	char pktType[7][8] = {"TOTAL","RTS","CTS","DAT","ACK","BCD","ETH"};
	xil_printf("\r\n        |   TX    | RX_good |RX_unexp | RX_bad  |\r\n");
	pktCtr[TX][0] = 0;
	pktCtr[RXGOOD][0] = 0;
	pktCtr[RXUNEXP][0] = 0;
	pktCtr[RXBAD][0] = 0;
	for(i = 1; i < 5; i++) {
		pktCtr[TX][0] += pktCtr[TX][i];
		pktCtr[RXGOOD][0] += pktCtr[RXGOOD][i];
		pktCtr[RXUNEXP][0] += pktCtr[RXUNEXP][i];
		pktCtr[RXBAD][0] += pktCtr[RXBAD][i];
		xil_printf("%8s|%9d|%9d|%9d|%9d|\r\n",
			(unsigned char *)pktType[i],
			pktCtr[TX][i],
			pktCtr[RXGOOD][i],
			pktCtr[RXUNEXP][i],
			pktCtr[RXBAD][i]);
	}
	xil_printf("%8s|%9d|%9d|%9d|%9d|\r\n",
		(unsigned char *)pktType[0],
		pktCtr[TX][0],
		pktCtr[RXGOOD][0],
		pktCtr[RXUNEXP][0],
		pktCtr[RXBAD][0]);
	xil_printf("-------------------------------------------------\r\n");
	xil_printf("        |   TX    |   RX    |\r\n");
	xil_printf("%8s|%9d|%9d|\r\n",
		(unsigned char *)pktType[BCD],
		pktCtr[TX][BCD],
		pktCtr[RXGOOD][BCD]);
	xil_printf("-------------------------------------------------\r\n");
	xil_printf("        |   TX    |   RX    |  DROP   |\r\n");
	xil_printf("%8s|%9d|%9d|%9d|\r\n",
		(unsigned char *)pktType[ETH],
		pktCtr[TX][ETH],
		pktCtr[RXGOOD][ETH],
		pktCtr[DROP][ETH]);
}


///@brief Main function
///This function configures MAC parameters, enables the underlying
///frameworks, and then polls the ethernet MAC continuously.
int main() {
	xil_printf("\r\nInitializing RTS/CTS MAC...\r\n");
	
	//Initialize the framework
	warpmac_init();
	
	initDelays();
	initAddresses();
	initHeaders();
	
	state.fullRate = convertStatetoMask(BPSK_MOD);
	state.mrateMode = BPSK_MODE;
	state.rtsThreshold = 2000;
	state.rtsScheme = DISABLED;
	warpmac_rightHex(state.mrateMode);

	clearPktCtr();
	
	// setup timer modes
	warp_timer_setMode(TIMEOUT, DISABLECSMA);
	warp_timer_setMode(BACKOFF, ENABLECSMA);
	warp_timer_setMode(NAV, DISABLECSMA);
	
	//Rx buffer is where the EMAC will DMA Wireless payloads from
	warpmac_setRxBuffer(&pkt.rx,0);
	//Tx buffer is where the EMAC will DMA Ethernet payloads to
	warpmac_setTxBuffer(1);
	
	warpmac_setBadHeaderCallback((void *)rtsmac_phyRx_badHeader_callback);
	warpmac_setGoodHeaderCallback((void *)rtsmac_phyRx_goodHeader_callback);
	warpmac_setTimerCallback((void *)rtsmac_timer_callback);
	warpmac_setEmacCallback((void *)rtsmac_emacRx_callback);
	warpmac_setUpButtonCallback((void *)rtsmac_up);
	warpmac_setMiddleButtonCallback((void *)rtsmac_middle);
	warpmac_setLeftButtonCallback((void *)rtsmac_left);
	warpmac_setRightButtonCallback((void *)rtsmac_right);
	
	//Set the default center frequency
	warpphy_setChannel(GHZ_2, state.chan);
	
	warpmac_enableCSMA();
	warpmac_enableEthernet();
	
	//Set the modulation scheme use for base rate (header) symbols
	warpmac_setBaseRate(state.baseRate);
	
	//display 1 if RTS/CTS is forced on, 0 if not
	// warpmac_leftHex((state.rtsThreshold) == 0 ? 1 : 0);
	warpmac_rightHex(state.mrateMode);
	warpmac_leftHex(convertMasktoState(state.fullRate));

	xil_printf(" finished.\r\n");
	while(1)
	{
		volatile unsigned char uartByte = 0;
		
		warpmac_pollEthernet();

	}

	return 0;
}
