/*! \file halfmac_client_hw.c
 \brief Reception Half of a CSMA MAC protocol

 @version 16.1
 @author Chris Hunter

 The goal of this MAC is to act as a receiver to a CSMA-enabled server.
 This server will continue to retransmit packets until this client
 acknowledges its reception.

 In this variant, ACK transmission is handled automatically by the
 autoresponder core.

 Note to workshop users: any names in quotes
 are names that can be searched for in the
 WARP API.

*/


#include "xparameters.h"
#include "warpmac.h"
#include "warpphy.h"
#include "halfmac_client_hw.h"
#include "ascii_characters.h"
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

unsigned int autoResp_delay;
unsigned int autoResp_action;
unsigned int lastRxSeqNum;

///@brief Callback for the reception of UART bytes
///@param uartByte ASCII byte received from UART
///
///Provides the user with the bytes that was received over the serial port. This is useful for configuring
///PHY and MAC parameters in real time on a board.
void uartRecv_callback(unsigned char uartByte)
{
	if(uartByte != 0x0)
	{
		xil_printf("(%c)\t", uartByte);

		switch(uartByte)
		{
			case ASCII_a:
			/**********************DELETE FOR WORKSHOP***************************/
				autoResp_delay += 10;
				autoResp_action = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_ACK, PHY_AUTORESPONSE_ACT_TRANS_HDR, autoResp_delay, (PHY_AUTORESPONSE_REQ_MATCH0 | PHY_AUTORESPONSE_REQ_MATCH1 | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
				mimo_ofdmTxRx_setAction0(autoResp_action);
				xil_printf("Autoresponse ACK Delay: %d\r\n", autoResp_delay);
				break;

			case ASCII_z:
				autoResp_delay -= 10;
				autoResp_action = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_ACK, PHY_AUTORESPONSE_ACT_TRANS_HDR, autoResp_delay, (PHY_AUTORESPONSE_REQ_MATCH0 | PHY_AUTORESPONSE_REQ_MATCH1 | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
				mimo_ofdmTxRx_setAction0(autoResp_action);
				xil_printf("Autoresponse ACK Delay: %d\r\n", autoResp_delay);
			break;
			/**********************DELETE FOR WORKSHOP***************************/
			default:
				//Unused command value; ignore
			break;
		}//END switch(uartByte)
	}

	return;
}


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
	//Copy the header over to packet buffer pktBuf_tx_DATA
	warpmac_prepPhyForXmit(&txMacframe, pktBuf_tx_DATA);
	//Send packet buffer pktBuf_tx_DATA
	warpmac_startPhyXmit(pktBuf_tx_DATA);
	//Wait for it to finish and enable the receiver
	warpmac_finishPhyXmit();

	return;
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
int phyRx_goodHeader_callback(Macframe* packet)
{

//WORKSHOP PSEUDOCODE:
//1) Instantiate an unsigned char variable to monitor the OFDM receiver's state. Default this state variable to "PHYRXSTATUS_INCOMPLETE"
//2) Check the 'destAddr' element in the 'header' struct of the 'packet' Macframe. Only proceed if this value matches 'myID'
//			Note: myID is a global that is assigned in main(), based on your node's DIP switch setting at boot
//3) Check the 'pktType' field of the header.
//  If 'PKTTYPE_DATA'
//		4) Poll the state of the state of the receiver using "warpmac_finishPhyRecv." Block until the state turns to either "PHYRXSTATUS_GOOD" or "PHYRXSTATUS_BAD"
//		If "PHYRXSTATUS_GOOD"
//			5a) Animate the top two LEDs to visualize this behavior using the "warpmac_incrementLEDHigh" function
//			6a) Copy the received "Macframe" to the Ethernet MAC (Emac) using "warpmac_prepPktToNetwork"
//					Note: The first argument of this function is the beginning of the packet that you want sent over the wire.
//					  	  This does NOT include all of the extra wireless MAC header information of the packet. The first byte
//					  	   of the payload is located at (void *)warpphy_getBuffAddr(pktBuf_rx)+NUM_HEADER_BYTES,
//					  	  where pktBuf_rx is an already defined global in this file (noMac.c) that specifies the location of
//					  	  the Macframe in the PHY.
//			7a) Wait for the ACK to finish sending with "warpmac_finishPhyXmit"
//					Note: Even though we did not explicitly transmit an ACK via software, we know that one is currently being sent
//						  since we configured the autoresponder to do so.
//			8a) Start the Emac using "warpmac_startPktToNetwork"
//				Note: The only argument to this function is the length (in bytes) of the packet to be sent. This length is stored in the
//				the 'length' field of the 'header' struct belonging to the 'packet' Macframe (i.e. packet->header.length).
//		If "PHYRXSTATUS_BAD"
//			5b) Animate the bottom two LEDs to visualize this behavior using the "warpmac_incrementLEDLow" function


/**********************USER CODE STARTS HERE***************************/
	unsigned char state = PHYRXSTATUS_INCOMPLETE;
	char shouldSend = 0;
	
	//If the packet is addressed to this node
	if( packet->header.destAddr == (NODEID_TO_ADDR(myID)) )
	{
		switch(packet->header.pktType){
			//If received packet is data
			case PKTTYPE_DATA:
				//At this point, we have pre-loaded the PHY transmitter with the ACK in hoping that
				// the packet passes checksum. Now we wait for the state of the received to packet
				// to move from PHYRXSTATUS_INCOMPLETE to either PHYRXSTATUS_GOOD or PHYRXSTATUS_BAD

				//Blocks until the PHY declares the payload good or bad
				state = warpmac_finishPhyRecv();

				if(state & PHYRXSTATUS_GOOD){
					//The auto-reponder will send the pre-programmed ACK automatically
					//User code only needs to update its own state, then check to see the PHY
					// is finished transmitting

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

				if(state & PHYRXSTATUS_BAD){
					warpmac_incrementLEDLow();
				}

				break; //END PKTTYPE_DATA
			default:
				//Invalid packet type; ignore
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
	xil_printf("HALFMAC Client v16.1: AutoResponder-driven Acknowledgments\r\n");

	//Assign the packet buffers in the PHY
	// The auto responder can't transmit from buffer 0, so we use it for Rx packets
	// The other assignments (DATA/ACK) are arbitrary; any buffer in [1,30] will work
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
	warpmac_setCallback(EVENT_UARTRX, (void *)uartRecv_callback);

	//Set the default center frequency
	warpphy_setChannel(GHZ_2, 4);

	lastRxSeqNum = 0;
	
	Macframe templatePkt;
	

/************************************/
/***** AUTO RESPONDER CONFIG *******/
/************************************/
	//WORKSHOP PSEUDOCODE: Note, autoresponder functions are not currently part of the API. They are
	//documented separately at http://warp.rice.edu/trac/wiki/OFDM/MIMO/Docs/AutoResponse
	//1) Use the PHY_AUTORESPONSE_MATCH_CONFIG macro to make sure that it is only engaged when a 
	//	 received packet's destination address matches 'myID'
	//		NOTE: Addresses are 2-bytes wide and are located at addr PKTHEADER_INDX_DSTADDR
	//2) Use the PHY_AUTORESPONSE_MATCH_CONFIG macro to make sure that it is only engaged when a 
	//	 received packet's type is a DATAPACKET

/**********************USER CODE STARTS HERE***************************/
	//Setup the PHY's autoResponse system
	
	unsigned int autoResp_matchCond;
	
	// For CSMA, it is configured to send pktBuf pktBuf_tx_ACK when a good DATA packet is received addressed to this node
	//Match condition 0: received header's destination address is this node's address
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_DSTADDR, 2, htons(NODEID_TO_ADDR(myID)));
	mimo_ofdmTxRx_setMatch0(autoResp_matchCond);

	//Match condition 1: received header's type is PKTTYPE_DATA
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_TYPE, 1, PKTTYPE_DATA);
	mimo_ofdmTxRx_setMatch1(autoResp_matchCond);
/**********************USER CODE ENDS HERE***************************/

	//Configure the header translator to use the Rx pkt's src address as the outgoing pkt's dst address
	// Addresses are two bytes, so two entries in the header translator need to be overridden
	// Except for these bytes, the ACK pktBuf's contents will be sent unaltered
	// PHY_HEADERTRANSLATE_SET(templatePktBuf, byteAddrToOverwrite, srcPktBuf, srcByteAddr)
	PHY_HEADERTRANSLATE_SET(pktBuf_tx_ACK, (PKTHEADER_INDX_DSTADDR+0), pktBuf_rx, (PKTHEADER_INDX_SRCADDR+0));
	PHY_HEADERTRANSLATE_SET(pktBuf_tx_ACK, (PKTHEADER_INDX_DSTADDR+1), pktBuf_rx, (PKTHEADER_INDX_SRCADDR+1));

	//Create a template ACK packet
	templatePkt.header.fullRate = HDR_FULLRATE_QPSK;
	templatePkt.header.codeRate = HDR_CODE_RATE_34;
	templatePkt.header.length = 0;
	templatePkt.header.srcAddr = (unsigned short)(NODEID_TO_ADDR(myID));
	templatePkt.header.pktType = PKTTYPE_ACK;

	//Copy the header down to the PHY's packet buffer
	// This doesn't actually send anything; the autoResponse system will use this template when sending ACKs
	warpmac_prepPhyForXmit(&templatePkt, pktBuf_tx_ACK);

	//Action defitions come last; bad things might happen if an action is enabled (set non-zero) before the template pkt is ready.
	//All actors are disabled during warpphy_init; only load non-zero configurations for actors you intend to use
	autoResp_delay = 0;

	//Action 0: send pkt from buf pktBuf_tx_ACK when match0 & match1 & goodPkt, using header translation
	autoResp_action = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_ACK, PHY_AUTORESPONSE_ACT_TRANS_HDR, autoResp_delay, (PHY_AUTORESPONSE_REQ_MATCH0 | PHY_AUTORESPONSE_REQ_MATCH1 | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));

	//Write the configuration word to the PHY's autoResponder
	mimo_ofdmTxRx_setAction0(autoResp_action);

	//Enable Ethernet
	warpmac_enableDataFromNetwork();

	while(1)
	{
		//Poll the timer, PHY and user I/O forever; actual processing will happen via callbacks above
		warpmac_pollPeripherals();
	}

	return;
}
