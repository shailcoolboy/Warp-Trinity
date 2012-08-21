/*! \file cogmac_client.c
 \brief Reception Half of a CSMA MAC protocol

 @version 16.1
 @author Chris Hunter

 Like the halfmac_client_hw.c exercise, the goal of this MAC is to
 act as a receiver to a CSMA-enabled server. This server will continue
 to retransmit packets until this client acknowledges its reception.

 In addition, the server will periodically announce that it will be
 hopping to a new channel. It will include the scheduled time of the
 channel hop in this message.
 
 Note to workshop users: any names in quotes
 are names that can be searched for in the
 WARP API.

*/


#include "xparameters.h"
#include "warpmac.h"
#include "warpphy.h"
#include "cogmac_client_hw.h"
#include "ascii_characters.h"
#include "string.h"
#include "errno.h"
#include "stdlib.h"
#include "stdio.h"



///Type of packet the server will respond to your requests with
#define PKTTYPE_COGRESP		4
///Type of packet you must send to the server for requesting channel
#define PKTTYPE_COGREQ			3
///Type of packet server broadcasts periodically to inform of hop
#define PKTTYPE_COGHOPPENDING	2
///Data packet with payload meant for Ethernet transmission
#define PKTTYPE_DATA 1
///Acknowledgement packet meant for halting retransmissions
#define PKTTYPE_ACK 0

#define COGRESP_SUCCESS			0
#define COGRESP_ILLEGALCHAN		1
#define COGRESP_TOOLATE			2


///Buffer for holding a packet-to-xmit across multiple retransmissions
Macframe txMacframe;
///Buffer to hold received packet
Macframe rxMacframe;

unsigned short int myID;
unsigned char pktBuf_tx_ACK;
unsigned char pktBuf_tx_DATA;
unsigned char pktBuf_rx;
unsigned char pktBuf_tx_COG;

unsigned int autoResp_delay;
unsigned int autoResp_action;
unsigned int lastRxSeqNum;

unsigned char newChan;
unsigned char requestChan;

///@brief Callback for the reception of UART bytes
///@param uartByte ASCII byte received from UART
///
///Provides the user with the bytes that was received over the serial port. This is useful for configuring
///PHY and MAC parameters in real time on a board.
void uartRecv_callback(unsigned char uartByte)
{
	if(uartByte != 0x0)
	{
		if (uartByte<=ASCII_9 && uartByte>=ASCII_0) {
			requestChan  = uartByte - 0x30;
			if(requestChan==0) requestChan=10;
			
			//WORKSHOP PSEUDOCODE:
			//1) Print that you are going to request channel "requestChan"
			//2) Create a new Macframe for your channel request
			//3) Set the length of the frame to be 0 (no payload bytes)
			//4) Set the fullRate field fo be HDR_FULLRATE_QPSK
			//5) Set the codeRate field to be HDR_CODERATE_34
			//6) Set the destAddr field to be the server (ID=0)
			//7) Set the srcAddr field to be yourself (myID)
			//8) Let the cogParam field be the requestChan
			//9) Prep and transmit the Macframe like you have before
			
			/**********************USER CODE STARTS HERE***************************/
			xil_printf("Requesting Channel %d...\r\n",requestChan);
			
			Macframe cogRequest;
			
			cogRequest.header.length = 0;
			cogRequest.header.pktType = PKTTYPE_COGREQ;
			cogRequest.header.fullRate = HDR_FULLRATE_QPSK;
			cogRequest.header.codeRate = HDR_CODE_RATE_34;
			cogRequest.header.destAddr = (unsigned short int)(NODEID_TO_ADDR(0));
			cogRequest.header.srcAddr = (unsigned short int)(NODEID_TO_ADDR(myID));
			cogRequest.header.cogParam = requestChan;
			
			//Copy the header to the Tx packet buffer
			warpmac_prepPhyForXmit(&cogRequest, pktBuf_tx_COG);
			
			//Transmit the packet
			warpmac_startPhyXmit(pktBuf_tx_COG);
			
			//Wait for it to finish
			warpmac_finishPhyXmit();
			/**********************USER CODE ENDS HERE*****************************/
			
			
		}
		
		else{
			switch(uartByte)
			{
				default:
					//Unused command value; ignore
				break;
			}//END switch(uartByte)
		}
	}

	return;
}

///@brief Callback for the expiration of timers
///
///This function is responsible for handling expirations
///of warp_timer 
void timer_callback(unsigned char timerType) {
	
	//WORKSHOP PSEUDOCODE:
	//1) Check that timerType argument is the timer you specified
	//2) Use "warpphy_setChannel" to change channels to "newChan" global
	//3) Display the new channel on the left hex with "warpmac_leftHex"
	
	/**********************USER CODE STARTS HERE***************************/
	switch(timerType) {
		case USER_TIMER_A:
			warpmac_leftHex(newChan);
			warpphy_setChannel(GHZ_2, newChan);					
			break;
	}
	/**********************USER CODE ENDS HERE*****************************/
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
				
				case PKTTYPE_COGRESP:
					
					//WORKSHOP PSEUDOCODE:
					//1) Check the cogParam field of the received phyHeader (packet->header.cogParam)
					//2) cogParam will be COGRESP_SUCCESS if your request was granted,
					//	 COGRESP_ILLEGALCHAN if you requested an illegal channel
					//	 COGRESP_TOOLATE if the next hop has already been decided. Print
					//	 this information so you can see whether or not your request was 
					//   successful. 
				
					/**********************USER CODE STARTS HERE***************************/
					switch (packet->header.cogParam) {
						case COGRESP_SUCCESS:
							xil_printf("Request accepted\r\n");
							break;
						case COGRESP_ILLEGALCHAN:
							xil_printf("Request denied... illegal channel requested\r\n");
							break;
						case COGRESP_TOOLATE:
							xil_printf("Request denied... next channel already decided\r\n");
							break;
						default:
							break;
					}
					/**********************USER CODE ENDS HERE*****************************/
					break;

				
			default:
				//Invalid packet type; ignore
				break;
		}
	}//END rx.destAddr == myID
	else if( (packet->header.destAddr) == 0xFF) {
		//Broadcast packet
		
		switch(packet->header.pktType){
			case PKTTYPE_COGHOPPENDING:
				/**********************USER CODE STARTS HERE***************************/
				//WORKSHOP PSEUDOCODE:
				//1) Clear the timer, even if it's already running (using warp_timer_resetDone(USER_TIMER_A))
				//2) Set the timer for the next hop, using the received packet header's header.timeLeft paramter, with
				//    warp_timer_setTimer(USER_TIMER_A, 0, clockCycles);
				//    The macro TIMERCLK_CYCLES_PER_MSEC is defined to help convert miliseconds to clock cycles
				//3) Start the timer with warp_timer_start(USER_TIMER_A)
				//4) Update the global variable newChan with header.cogParam

				warp_timer_resetDone(USER_TIMER_A);
				warp_timer_setTimer(USER_TIMER_A, 0, packet->header.timeLeft*TIMERCLK_CYCLES_PER_MSEC); //milliseconds
				warp_timer_setMode(USER_TIMER_A, TIMER_MODE_NOCARRIERSENSE); 
				warp_timer_start(USER_TIMER_A);
		
				newChan = packet->header.cogParam;
		
				/**********************USER CODE ENDS HERE***************************/
				break;
		}
		state = warpmac_finishPhyRecv();
	}
	else { //Packet was addressed to someone else; ignore it
		state = warpmac_finishPhyRecv();
	}

	//Return 0, indicating we didn't clear the PHY status bits (WARPMAC will handle it)
	return 0;
}

///@brief Main function
///
///This function configures MAC parameters, enables the underlying frameworks, and then loops forever.
int main()
{
	xil_printf("COGMAC Client v16.1: AutoResponder-driven Acknowledgments\r\n");

	//Assign the packet buffers in the PHY
	// The auto responder can't transmit from buffer 0, so we use it for Rx packets
	// The other assignments (DATA/ACK) are arbitrary; any buffer in [1,30] will work
	pktBuf_rx = 1;
	pktBuf_tx_DATA = 2;
	pktBuf_tx_ACK = 3;
	pktBuf_tx_COG = 4;

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
	warpmac_setCallback(EVENT_TIMER, (void *)timer_callback);
	
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
