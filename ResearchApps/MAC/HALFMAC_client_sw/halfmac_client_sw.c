/*! \file halfmac_client_sw.c
 \brief Reception Half of a CSMA MAC protocol

 @version 16.1
 @author Chris Hunter

 The goal of this MAC is to act as a receiver to a CSMA-enabled server.
 This server will continue to retransmit packets until this client
 acknowledges its reception.

 In this variant, ACK transmission is handled directly by software using
 the transmission mechanisms in the WARPMAC framework.

 Note to workshop users: any names in quotes
 are names that can be searched for in the
 WARP API.

*/


#include "xparameters.h"
#include "warpmac.h"
#include "warpphy.h"
#include "halfmac_client_sw.h"
#include "string.h"
#include "errno.h"
#include "stdlib.h"
#include "stdio.h"


//Define handy macros for CSMA MAC packet types
///Data packet with payload meant for Ethernet transmission
#define PKTTYPE_DATA 1
///Acknowledgement packet meant for halting retransmissions
#define PKTTYPE_ACK 0

///Buffer for holding a packet-to-xmit across multiple retransmissions
Macframe txMacframe;
///Buffer to hold received packet
Macframe rxMacframe;

unsigned short int myID;
unsigned char pktBuf_tx_ACK;
unsigned char pktBuf_tx_DATA;
unsigned char pktBuf_rx;

//Variable to keep track of the sequence number of the last error-free packet received
// This prevents duplicate packets from being sent via Ethernet, which confuses apps
unsigned int lastRxSeqNum;

///@brief Callback for the reception of Ethernet packets
///
///This function is called by the ethernet MAC drivers
///when a packet is available to send. This function fills
///the Macframe transmit buffer with the packet and sends
///it over the OFDM link
///@param length Length, in bytes, of received Ethernet frame
///@param payload address of first byte in Ethernet payload.
void dataFromNetworkLayer_callback(Xuint32 length, char* payload)
{

	//Note: This code is virtually identical to the code used previously in the noMac workshop exercise.
	//It does not fully implement the halfmac_server's transmission states (e.g. no retransmission, no carrier sensing,
	//no binary exponential backoff).

	//Set the length field in the header
	txMacframe.header.length = length;
	//Set the type to be a data packet
	txMacframe.header.pktType = PKTTYPE_DATA;
	//Copy in the packet's destination MAC address
	txMacframe.header.destAddr = (unsigned short int)(NODEID_TO_ADDR(0));
	//Set the modulation scheme for the packet's full-rate symbols
	txMacframe.header.fullRate = HDR_FULLRATE_QPSK;
	//Set the payload coding rate
	txMacframe.header.codeRate = HDR_CODE_RATE_34;
	//Copy the header over to the PHY's transmit packet buffer
	warpmac_prepPhyForXmit(&txMacframe, pktBuf_tx_DATA);
	//Send packet buffer pktBuf_tx_DATA
	warpmac_startPhyXmit(pktBuf_tx_DATA);
	//Wait for it to finish and enable the receiver
	warpmac_finishPhyXmit();
}

///@brief Callback for the reception of bad wireless headers
///
///@param packet Pointer to received Macframe
void phyRx_badHeader_callback()
{
	warpmac_incrementLEDLow();
}

///@brief Callback for the reception of good wireless headers
///
///This function then polls the PHY to determine if the entire packet passes checksum
///thereby triggering the transmission of the received data over Ethernet.
///@param packet Pointer to received Macframe
int phyRx_goodHeader_callback(Macframe* packet){

//WORKSHOP PSEUDOCODE:
//1) Instantiate an unsigned char variable to monitor the OFDM receiver's state. Default this state variable to "PHYRXSTATUS_INCOMPLETE"
//2) Instantiate a new Macframe to represent the acknowledgment packet you send if the payload of received packet is error-free
//3) Check the 'destAddr' element in the 'header' struct of the 'packet' Macframe. Only proceed if this value matches 'myID'
//			Note: myID is a global that is assigned in main(), based on your node's DIP switch setting at boot
//4) Check the 'pktType' field of the header.
//	If 'PKTTYPE_DATA'
//		5) Fill in the Macframe you created at the top of this function. You must fill in the following fields:
//			- 'length' should be 0 (i.e. there is no payload present in an ACK packet)
//			- 'pktType' should be 'ACKPACKET' in order to differentiate this packet from data frames
//			- 'fullRate' should be 'HDR_FULLRATE_QPSK' (the ACK has no full-rate payload, but this field msut still have a valid value)
//			- 'codeRate' should be 'HDR_CODE_RATE_34' (the ACK has no coded payload, but this field msut still have a valid value)
//			- 'srcAddr' should be set to your node's ID (myID)
//			- 'destAddr' should be set to the 'srcAddr' of the received packet
//		6) Copy the ACK into the 'pktBuf_tx_ACK' PHY buffer using "warpmac_prepPhyForXmit"
//		7) Poll the state of the state of the receiver using "warpmac_finishPhyRecv." Block until the state turns to either "PHYRXSTATUS_GOOD" or "PHYRXSTATUS_BAD"
//		If "GOODPACKET"
//			9a) Send the ACK using 'warpmac_startPhyXmit'
//			10a) Animate the top two LEDs to visualize this behavior using the "warpmac_incrementLEDHigh" function
//		    11a) Using the received packet header's sequence number, check if this is a duplicate packet that you have already transmitted via Ethernet. If not:
//				  Copy the received "Macframe" to the Ethernet MAC (Emac) using "warpmac_prepPktToNetwork"
//					Note: The first argument of this function is the beginning of the packet that you want sent over the wire.
//					  	  This does NOT include all of the extra wireless MAC header information of the packet. The first byte
//					  	   of the payload is located at (void *)warpphy_getBuffAddr(pktBuf_rx)+NUM_HEADER_BYTES,
//					  	  where pktBuf_rx is an already defined global in this file (noMac.c) that specifies the location of
//					  	  the Macframe in the PHY.
//			12a) Wait for the ACK to finish sending with "warpmac_finishPhyXmit"
//			13a) Start the Emac using "warpmac_startPktToNetwork"
//				Note: The only argument to this function is the length (in bytes) of the packet to be sent. This length is stored in the
//				the 'length' field of the 'header' struct belonging to the 'packet' Macframe (i.e. packet->header.length).
//		If "BADPACKET"
//			9b) Animate the bottom two LEDs to visualize this behavior using the "warpmac_incrementLEDLow" function


/**********************USER CODE STARTS HERE***************************/
	unsigned char state = PHYRXSTATUS_INCOMPLETE;
	Macframe ackPacket;
	char shouldSend = 0;

	//If the packet is addressed to this node
	if( packet->header.destAddr == (NODEID_TO_ADDR(myID)) )
	{
		switch(packet->header.pktType) {
			//If received packet is data
			case PKTTYPE_DATA:

				//Fill in the ACK header
				ackPacket.header.length = 0;
				ackPacket.header.pktType = PKTTYPE_ACK;
				ackPacket.header.fullRate = HDR_FULLRATE_QPSK;
				ackPacket.header.codeRate = HDR_CODE_RATE_34;
				ackPacket.header.srcAddr = NODEID_TO_ADDR(myID);
				ackPacket.header.destAddr = packet->header.srcAddr;

				//Copy the header over to packet pktBuf_tx_ACK
				warpmac_prepPhyForXmit(&ackPacket, pktBuf_tx_ACK);

				//Blocks until the PHY declares the payload good or bad
				state = warpmac_finishPhyRecv();

				if(state & PHYRXSTATUS_GOOD) {
					warpmac_startPhyXmit(pktBuf_tx_ACK);

					//Toggle the top LEDs
					warpmac_incrementLEDHigh();

					//Check if this is a new packet; only send it over Ethernet if it's new
					if(packet->header.seqNum != lastRxSeqNum) {
						shouldSend = 1;
						lastRxSeqNum = packet->header.seqNum;
					}
					
					//Starts the DMA transfer of the payload into the EMAC
					if(shouldSend) warpmac_prepPktToNetwork((void *)warpphy_getBuffAddr(pktBuf_rx)+NUM_HEADER_BYTES, (packet->header.length));

					//Blocks until the PHY is finished sending and enables the receiver
					warpmac_finishPhyXmit();

					//Waits until the DMA transfer is complete, then starts the EMAC
					if(shouldSend) warpmac_startPktToNetwork((packet->header.length));
				}

				if(state & PHYRXSTATUS_BAD) {
					warpmac_incrementLEDLow();
				}

				break; //END PKTTYPE_DATA
			default:
				//Invalid packet type; ignore this reception
				break;
		}
	}//END rx.destAddr == myID
	else {
		state = warpmac_finishPhyRecv();
	}
	/**********************USER CODE ENDS HERE***************************/

	//Return 0, indicating we didn't clear the PHY status bits (WARPMAC will handle it)
	return 0;
}

///@brief Main function
///
///This function configures MAC parameters, enables the underlying frameworks, and then loops forever.
int main()
{
	xil_printf("HALFMAC Client v16.1: Software-driven Acknowledgments\r\n");


	//Assign the packet buffers in the PHY
	pktBuf_rx = 1;
	pktBuf_tx_DATA = 2;
	pktBuf_tx_ACK = 3;

	//Initialize the framework
	// This function sets safe defaults for many parameters in the MAC/PHY frameworks
	// Many of these can be changed with other warpmac_ and warpphy_ calls
	//  or by customizing the warpmac.c/warpphy.c source
	warpmac_init();

	//Read Dip Switch value from FPGA board.
	//This value will be used as an index into the routing table for other nodes
	myID = (unsigned short int)warpmac_getMyId();
	warpmac_rightHex(myID);

	//Set the PHY for SISO using just the radio in slot 2
	warpphy_setAntennaMode(TX_ANTMODE_SISO_ANTA, RX_ANTMODE_SISO_ANTA);

	//Set the packet detection thresholds
	warpphy_setEnergyDetThresh(7000);		//Min RSSI (in [0,16368])
	warpphy_setAutoCorrDetParams(90, 0);	//Min auto-correlation (in [0,2047])
	warpphy_setLongCorrThresh(8000);		//Min cross-correlation (in [0,45e3])
	
	//Rx buffer is where the EMAC will DMA Wireless payloads from
	warpmac_setRxBuffers(&rxMacframe, pktBuf_rx);

	//Tx buffer is where the EMAC will DMA Ethernet payloads to
	warpmac_setPHYTxBuffer(pktBuf_tx_DATA);
	warpmac_setEMACRxBuffer(pktBuf_tx_DATA);

	//Connect the various user-level callbacks
	warpmac_setCallback(EVENT_DATAFROMNETWORK, (void *)dataFromNetworkLayer_callback);
	warpmac_setCallback(EVENT_PHYGOODHEADER, (void *)phyRx_goodHeader_callback);
	warpmac_setCallback(EVENT_PHYBADHEADER, (void *)phyRx_badHeader_callback);

	//Set the default center frequency
	warpphy_setChannel(GHZ_2, 4);

	lastRxSeqNum = 0;

	//Enable Ethernet
	warpmac_enableDataFromNetwork();

	while(1)
	{
		//Poll the timer, PHY and user I/O forever; actual processing will happen via callbacks above
		warpmac_pollPeripherals();
	}

	return;
}
