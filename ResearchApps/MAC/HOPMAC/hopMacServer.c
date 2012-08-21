 /*! \file hopMacServer.c
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
#include "hopMacServer.h"
#include "xparameters.h"
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include "ofdm_txrx_mimo_regMacros.h"
#include "xtime_l.h"




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

//Misc. Globals
unsigned char currentAnt = 0;
static volatile unsigned char uartByte = 0;
unsigned char chan;

unsigned char controlMode = 1;


///Data packet with payload meant for Ethernet transmission
#define DATAPACKET 1
///Acknowledgement packet meant for halting retransmissions
#define ACKPACKET 0
///Hop packet to notify nodes ofchannel hopping event
#define HOPPACKET 2

#define ARPREQUEST 0x806


///@brief Callback for the depression of the up push button
///
///This button increments the 2.4GHz channel being used
void up(){
	controlMode=1;
}

///@brief Callback for the depression of the middle push button
///
///This button decrements the 2.4GHz channel being used
void middle(){
	controlMode=0;
}

void switchChannels(){
	Macframe followMe;
	
							//	 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14
	unsigned char chanVec[14] = {1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 14};
	//unsigned char chanVec[14] = {1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0};
	//unsigned char chanVec[14] = {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0};
	chan = rand()%14;
	while(chanVec[chan] != 1){//11
		chan = rand()%14;
	}
	chan = chan+1;
	
	
	unsigned char broadcast[6] = {255,255,255,255,255,255};
	followMe.header.length = 0;
	followMe.header.pktType = HOPPACKET;
	memcpy(followMe.header.destAddr,broadcast,6);
	followMe.header.reserved1 = chan;
	char i=0;
#define NUMCONTROL 32
	if(controlMode){
		while(i<NUMCONTROL){
			if(warpmac_carrierSense()){
				//Copy the header over to packet buffer 1
				warpmac_prepPhyForXmit(&followMe,2);
				//Send packet buffer 1
				warpmac_startPhyXmit(2);
				//Wait for it to finish and enable the receiver
				warpmac_finishPhyXmit();
				
			}
			i++;
		}
	}
	
	//	warpmac_sendOfdm(&txBuffer);
	//	warpmac_sendOfdm(&txBuffer);
	//	warpmac_sendOfdm(&txBuffer);
	//	warpmac_freePayload(&txBuffer);
	
	warpphy_setChannel(GHZ_2,chan);
	warpmac_leftHex(chan);
	//xil_printf("Chan = %d\r\n",chan);
	
	//	usleep(500);
	
	
}


///@brief Callback for the expiration of timers
///
///This function is responsible for handling #TIMEOUT and #BACKOFF.
///The job responsibilities of this function are to:
///-increase the contention window upon the expiration of a #TIMEOUT
///-initiate a #BACKOFF timer upon the expiration of a #TIMEOUT
///-retransmit a packet upon the expiration of a #BACKOFF
///@param timerType #TIMEOUT or #BACKOFF
void timer_callback(unsigned char timerType){
	int status;
	switch(timerType){
		case TIMEOUT:
			
			status = warpmac_incrementResend(&txBuffer);
			if(status == 0){
				txBuffer.isNew = 0;
				//The packet has been resent too many times, so we are going to re-enable Ethernet and overwrite
				warpmac_enableEthernet();
				return;
			}
			
			warpmac_setTimer(BACKOFF);
			return;
			
			break;
			case BACKOFF:
			
			//Copy the header over to packet buffer 1
			warpmac_prepPhyForXmit(&txBuffer,1);
			//Send packet buffer 1
			warpmac_startPhyXmit(1);
			//Wait for it to finish and enable the receiver
			warpmac_finishPhyXmit();
			//Start a timeout timer
			warpmac_setTimer(TIMEOUT);
			break;
			return;
	}
}


///@brief Callback for the reception of Ethernet packets
///
///This function is called by the ethernet MAC drivers
///when a packet is available to send. This function fills
///the Macframe transmit buffer with the packet and sends
///it over the OFDM link
///@param length Length, in bytes, of received Ethernet frame
void emacRx_callback(Xuint32 length){
	txBuffer.isNew = 1;
	u8* payload = (u8*)(warpphy_getBuffAddr(1)+NUM_HEADER_BYTES);
	
	unsigned short int* pkttype = (unsigned short int*)(&payload[12]);
	unsigned char* destNode;
	
	
	if(*pkttype==ARPREQUEST){
		destNode=&payload[41];
	}
	else{
		destNode=&payload[33];
	}
	
	
	//if(*destIP>0xc0a80100 && *destIP<0xc0a8010F){
	
	//if(destNode>0 && destNode<0xc0a8010F){
	
	
	
	warpmac_disableEthernet();
	txBuffer.header.currReSend = 0;
	txBuffer.header.length = length;
	txBuffer.header.pktType = DATAPACKET;
	
	//Set the modulation scheme for the packet's full-rate symbols
	txBuffer.header.fullRate = HDR_FULLRATE_QPSK;
	//Set the payload coding rate
	txBuffer.header.codeRate = CODE_RATE_34;
	
	//Copy in the packet's destination MAC address
	//Hard-coded as this node's partner node
	memcpy(txBuffer.header.destAddr,routeTable[*destNode].addr,6);
	
	
	if(warpmac_carrierSense()){
		//Copy the header over to packet buffer 1
		warpmac_prepPhyForXmit(&txBuffer,1);
		//Send packet buffer 1
		warpmac_startPhyXmit(1);
		//Wait for it to finish and enable the receiver
		warpmac_finishPhyXmit();
		//Start a timeout timer
		warpmac_setTimer(TIMEOUT);
	}
	else{
		//Start a backoff timer
		warpmac_setTimer(BACKOFF);
	}
	
	//}
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
	warpmac_incrementLEDHigh();
	Macframe ackPacket;
	unsigned char state=INCOMPLETE;
	
	if(warpmac_addressedToMe(packet)){
		
		switch(packet->header.pktType){
			case DATAPACKET:
				
				
				
				while(state==INCOMPLETE){
					//Blocks until the PHY reports the received packet as either good or bad
					state = warpphy_pollRxStatus();
				}
				
				if(state==GOODPACKET){
					warpmac_prepEmacForXmit(packet);
					//Blocks until the PHY is finished sending and enables the receiver
					warpmac_startEmacXmit(packet);
				}
				
				if(state==BADPACKET){
					//xil_printf("BAD Packet, good header\r\n");
					warpmac_incrementLEDLow();
				}
				
				break;
				
				case ACKPACKET:
				
				if(warpmac_inTimeout()){
					txBuffer.isNew = 0;
					warpmac_incrementLEDHigh();
					warpmac_clearTimer(TIMEOUT);
					warpmac_enableEthernet();
				}
				
				break;
				
				
		}
		
		
	}
}

///@brief Main function
///
///This function configures MAC parameters, enables the underlying frameworks, and then loops forever.
int main(){		
	xil_printf("Hopmac Server\r\n");
	//Initialize the framework
	warpmac_init();
	
	chan = 1;
	
	warpmac_setMaxResend(2);
	warpmac_setMaxCW(2);
	warpmac_setTimeout(160);
	warpmac_setSlotTime(9);
	
	
	
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
	warpmac_setTimerCallback((void *)timer_callback);
	warpmac_setEmacCallback((void *)emacRx_callback);
	
	
	warpmac_setUpButtonCallback((void *)up);
	warpmac_setMiddleButtonCallback((void *)middle);
	
	
	//Set the default center frequency
	warpphy_setChannel(GHZ_2, chan);
	
	warpmac_enableCSMA();
	warpmac_enableEthernet();
	
	//Set the modulation scheme use for base rate (header) symbols
	warpmac_setBaseRate(QPSK);
	
	XTime tEnd, tCur;
	unsigned int seconds = 5;
	unsigned char startCount = 1;
	
	xil_printf("Mask version 1\r\n");
	while(1){
		warpmac_pollEthernet();
		
		XTime_GetTime(&tCur);
		//usleep(1000);
		if (startCount){
			tEnd  = tCur + ((XTime) seconds) * 160000000;
			startCount=0;
		}
		
		//	if(tCur>tEnd){
		//		switchChannels();
		//		startCount=1;
		//		seconds = 1;
		//
		//	}
		if(tCur>tEnd){
			if(txBuffer.isNew==0){
				warpmac_disableEthernet();
				usleep(1000);
				switchChannels();
				startCount=1;
				seconds = 5;
				warpmac_enableEthernet();
			}
		}
		
	}
	return;
}
