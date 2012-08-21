 /*! \file hopMacClient.c
 \brief Hop MAC Workshop Exercise.
 
 @version 12
 @author Chris Hunter
 
 This exercise is an extension of the previous
 HALFMAC exercise. In fact, you are welcome
 top copy and paste the parts of the code you
 completed in that exercise for the similar
 tasks here.
 
 The twist in this lab is that the server
 will periodically hop to a new part of the
 spectrum. Before doing so, it will transmit
 a special control packet (HOPPACKET) that
 contains the destination frequency band.
 
 If the packet is missed, your receiver will
 be stuck until the transmitter randomly hops
 back onto the channel you were sitting at.
 This can potentially be a very long time.
 An advanced extension to this lab is to
 scan for packets in various channels when
 no good packet is received for a certain
 amount of time. For our purposes, let this
 timeout be around 200ms.
 */

#include "warpmac.h"
#include "warpphy.h"
#include "hopMacClient.h"
#include "xparameters.h"
#include "string.h"
#include "errno.h"
#include "stdlib.h"
#include "stdio.h"
#include "xutil.h"
#include "ofdm_timer_regMacros.h"

///Routing table with agreed upon mapping between dipswitches and physical addresses
typedef struct {
	unsigned char addr[6];
} route;

///Instance of the routing table
route routeTable[16];

///Byte array containing physical MAC address of this node
unsigned char myAddr[6];
///Index to the routing table that identifies this node
unsigned char myID;

///Buffer for holding a packet-to-xmit across multiple retransmissions
Macframe txBuffer;
///Buffer to hold received packet
Macframe rxBuffer;

unsigned char chan;

///Data packet with payload meant for Ethernet transmission
#define DATAPACKET 1
///Acknowledgement packet meant for halting retransmissions
#define ACKPACKET 0
///Control packet containing destination frequency band
#define HOPPACKET 2

/**********************DELETE FOR WORKSHOP***************************/
/////////////////////SEEK MODE: OPTIONAL EXTENSION//////////////////////////
unsigned int waitTime = 200;	//If a packet hasn't been received in the last 200 ms, exhaustively search the spectrum
unsigned char scanMode=0; //By default, the optional scan mode is disabled
void middle(){
	/*Disables the optional scan mode*/
	scanMode=0;
}

void up(){
	/*Enables the optional scan mode*/
	scanMode=1;
	warpmac_stopTimer();
	warpmac_setTimerVal(waitTime*40000);
	warpmac_startTimer(DISABLECSMA);
}

void left(){
	/*Increases the timeout to begin exhaustive scan*/
	waitTime=waitTime-10;
}

void right(){
	/*Decreases the timeout to begin exhaustive scan*/
	waitTime=waitTime+10;
}

unsigned char dispIndex = 0;
int timerExpire(){
	if(scanMode){
		chan = ((chan+1)%15);
		if(chan==0) chan=1;
		warpphy_setChannel(GHZ_2,chan);
		warpmac_leftHex(chan);
		warpmac_stopTimer();
		warpmac_setTimerVal(waitTime*40000);
		warpmac_startTimer(DISABLECSMA);
	}
}
/////////////////////////////////////////////////////////////////////////////
/**********************DELETE FOR WORKSHOP***************************/

///@brief Callback for the reception of Ethernet packets
///
///This function is called by the ethernet MAC drivers
///when a packet is available to send. This function fills
///the Macframe transmit buffer with the packet and sends
///it over the OFDM link
///@param length Length, in bytes, of received Ethernet frame
///@param payload address of first byte in Ethernet payload.
void emacRx_callback(Xuint32 length, char* payload){
	
	//Set the length of the Macfram
	txBuffer.header.length = length;
	//Define the type to be data
	txBuffer.header.pktType = DATAPACKET;
	//Set the modulation scheme for the packet's full-rate symbols
	txBuffer.header.fullRate = HDR_FULLRATE_QPSK;
	//Set the payload coding rate
	txBuffer.header.codeRate = CODE_RATE_34;
	//Copy in the packet's destination MAC address
	//Hard-coded as the server (ID = 0)
	memcpy(txBuffer.header.destAddr,routeTable[0].addr,6);
	//Copy the header over to packet buffer 1
	warpmac_prepPhyForXmit(&txBuffer,1);
	//Send packet buffer 1
	warpmac_startPhyXmit(1);
	//Wait for it to finish and enable the receiver
	warpmac_finishPhyXmit();
	
	return;
}

///@brief Callback for the reception of bad wireless headers
///
///@param packet Pointer to received Macframe
void phyRx_badHeader_callback() {
	warpmac_incrementLEDLow();
}

///@brief Callback for the reception of good wireless headers
///
///This function then polls the PHY to determine if the entire packet passes checksum
///thereby triggering the transmission of the ACK and the transmission of the received
///data over Ethernet.
///@param packet Pointer to received Macframe
void phyRx_goodHeader_callback(Macframe* packet){

	/**********************DELETE FOR WORKSHOP***************************/			
	/////////////////////SEEK MODE: OPTIONAL EXTENSION//////////////////////////
	warpmac_stopTimer();
	warpmac_setTimerVal(waitTime*40000);
	warpmac_startTimer(DISABLECSMA);
	/////////////////////////////////////////////////////////////////////////////
	/**********************DELETE FOR WORKSHOP***************************/
	
//Pseudocode for workshop users:
//1) Instantiate a "Macframe" that will be an acknowledgement packet
//2) Instantiate a variable to keep track of the receiver's state. Default this state variable to "INCOMPLETE"
//3) Check the "pktType" of the "phyHeader" of the received "Macframe"
//If "HOPPACKET"
//		4) Animate the top two LEDs using the "warpmac_incrementLEDHigh" function
//		5) Switch to the channel located in "packet->header.reserved1" using the "warpphy_setChannel" function (make sure to stay in "GHZ_2")
//If "DATAPACKET"
//		4) Check and make sure it was addressed to me with "warpmac_addressedToMe"
//		5) Set the acknowledgment "Macframe" to length 0 (Header only... no payload)
//		6) Set the "pktType" of the "phyHeader" of the acknowledgment "Macframe" to "ACKPACKET"
//		7) Set full rate modulation order to "QPSK"
//		8) Set the coding rate to "CODE_RATE_34"
//****Note: Header-only packets (like ACKs) will be QPSK with a rate 1/2 code. Thus, steps 7 and 8 aren't strictly necessary, they are just a safety measure to ensure the PHY
//doesn't receive an unexpected value in this field
//		9) memcpy the 6 bytes of "myAddr" into the "srcAddr" field of the acknowledgment
//		10) memcpy the 6 bytes of "packet->header.srcAddr" into the "destAddr" field of the acknowledgment (to send it back to the source of the data)
//		11) Copy the acknowledgement over to packet buffer 2 using the "warpmac_prepPhyForXmit" function
//		12) Poll the state of the state of the receiver using "warpphy_pollRxStatus." Block until the state turns to either "GOODPACKET" or "BADPACKET"
//		If "GOODPACKET"
//			13) Send the acknowledgment sitting in packet buffer 2 using the "warpmac_startPhyXmit"
//				Note: Since we have pre-loaded the acknowledgment into the PHY transmitter, the ACK will go over-the-air within 20 microseconds
//					  after the source transmitter finished
//			14) Animate the top two LEDs to visualize this behavior using the "warpmac_incrementLEDHigh" function
//			15) Copy the received "Macframe" to Ethernet using "warpmac_prepEmacForXmit"	
//			16) Start the Emac using "warpmac_startEmacXmit"
//		If "BADPACKET"
//			13) Animate the bottom two LEDs to visualize this behavior using the "warpmac_incrementLEDLow" function
	
	/**********************DELETE FOR WORKSHOP***************************/
	Macframe ackPacket;
	unsigned char state=INCOMPLETE;
	
	if(packet->header.pktType==HOPPACKET){
		//If HOPPACKET is received, jump to the channel in reserved1 of header
		warpmac_incrementLEDHigh();
		warpphy_setChannel(GHZ_2,packet->header.reserved1);
		chan = packet->header.reserved1;
		warpmac_leftHex(chan);
	}
	
	
	if(packet->header.pktType==DATAPACKET){
		
		if(warpmac_addressedToMe(packet)){
			
			
			ackPacket.header.length = 0;
			ackPacket.header.pktType = ACKPACKET;
			ackPacket.header.fullRate = HDR_FULLRATE_QPSK;
			ackPacket.header.codeRate = CODE_RATE_34;
			memcpy(ackPacket.header.srcAddr,(unsigned char *)myAddr,6);
			memcpy(ackPacket.header.destAddr,packet->header.srcAddr,6);
			
			//Copy the header over to packet buffer 2
			warpmac_prepPhyForXmit(&ackPacket,2);
			
			
			while(state==INCOMPLETE){
				//Blocks until the PHY reports the received packet as either good or bad
				state = warpphy_pollRxStatus();
			}
			
			if(state==GOODPACKET){
				//Send packet buffer 2
				warpmac_startPhyXmit(2);
				warpmac_incrementLEDHigh();
				//Starts the DMA transfer of the payload into the EMAC
				warpmac_prepEmacForXmit(packet);
				//Blocks until the PHY is finished sending and enables the receiver
				warpmac_finishPhyXmit();
				//Waits until the DMA transfer is complete, then starts the EMAC
				warpmac_startEmacXmit(packet);
				
			}
			
			if(state==BADPACKET){
				//xil_printf("BAD Packet, good header\r\n");
				warpmac_incrementLEDLow();
			}
			
		}
		
	}
	/**********************DELETE FOR WORKSHOP***************************/
}

///@brief Main function
///
///This function configures MAC parameters, enables the underlying frameworks, and then loops forever.
int main(){		
	xil_printf("Hopmac Client\r\n");
	//Initialize the framework
	warpmac_init();
	
	chan = 1;
	
	//Read Dip Switch value from FPGA board.
	//This value will be used as an index into the routing table for other nodes
	myID = warpmac_getMyId();
	
	//Create an arbitrary address for this node
	unsigned char tmpAddr[6] = {0x16,0x24,0x63,0x53,0xe2,0xc2+myID};
	
	
	memcpy((unsigned char *)myAddr,(unsigned char *)tmpAddr,6);
	
	//Fill an arbitrary routing table so that nodes know each others' addresses
	unsigned char i;
	for(i=0;i<16;i++){
		routeTable[i].addr[0] = myAddr[0];
		routeTable[i].addr[1] = myAddr[1];
		routeTable[i].addr[2] = myAddr[2];
		routeTable[i].addr[3] = myAddr[3];
		routeTable[i].addr[4] = myAddr[4];
		routeTable[i].addr[5] = myAddr[5]+i-myID;
	}
	
	warpmac_setMacAddr((unsigned char *)(&myAddr));
	
	
	warpmac_setRxBuffer(&rxBuffer,0);
	//Tx buffer is where the EMAC will DMA payloads to
	warpmac_setTxBuffer(1);
	
	//Copy this node's MAC address into the Tx buffer's source address field
	memcpy(txBuffer.header.srcAddr,(unsigned char *)myAddr,6);
	
	warpmac_setBadHeaderCallback((void *)phyRx_badHeader_callback);
	warpmac_setGoodHeaderCallback((void *)phyRx_goodHeader_callback);
	warpmac_setEmacCallback((void *)emacRx_callback);
	
	
	/////////////////////SEEK MODE: OPTIONAL EXTENSION//////////////////////////
	warpmac_setMiddleButtonCallback(middle);
	warpmac_setUpButtonCallback(up);
	warpmac_setLeftButtonCallback(left);
	warpmac_setRightButtonCallback(right);
	warpmac_setTimerCallback((void *)timerExpire);
	warpmac_setTimerVal(waitTime*40000);
	warpmac_startTimer(DISABLECSMA);
	/////////////////////////////////////////////////////////////////////////////
	
	
	//Set the default center frequency
	warpphy_setChannel(GHZ_2, chan);
	
	warpmac_enableCSMA();
	warpmac_enableEthernet();
	
	//Set the modulation scheme use for base rate (header) symbols
	warpmac_setBaseRate(QPSK);
	
	while(1){
		warpmac_pollEthernet();
	}
	
	return;
}
