/*! \file csmaMac.c
 \brief Carrier-Sensing Random Access MAC.

 @version 16.1
 @author Chris Hunter and Patrick Murphy

 The csmaMac is a modified ALOHA MAC that
 serves as an example for novel MAC
 development. Nodes transmit whenever
 they have information to transmit, and only
 move on to the next packet once the original
 transmit is acknowledged (ACKed). If no ACK
 is received, a collision is inferred and the
 packet is re-transmitted.

 By default, the MAC also implements carrier-
 sensing multiple-access with collision-
 avoidance (CSMA-CA). This functionality is
 built into hardware peripherals in the project
 so very little software state is affected.

 In its current state, the project acts as
 a true ethernet MAC-level wireless bridge.
 Any ethernet activity that appears on one
 WARP will be sent to another via the custom
 wireless link.

 Also, the current versions supports hardware-triggered
 ACK transmissions. This reduces the turn-around time
 as well as reduces the jitter on the start time of the ACK
 relative to the start time of the preceeding DATA.

 */
#include "warpmac.h"
#include "warpphy.h"
#include "csmaMac.h"
#include "xparameters.h"
#include "ascii_characters.h"
#include "ofdm_txrx_mimo_regMacros.h"
#include "ofdm_agc_mimo_regMacros.h"

Macframe templatePkt;

unsigned int autoResp_matchCond;
unsigned int autoResp_action;
unsigned char pktBuf_tx_ACK;
unsigned char pktBuf_tx_DATA;
unsigned char pktBuf_rx;

unsigned short pktDet_AC_corr, pktDet_AC_energy, pktDet_RSSI_thresh;
char debug_goodHdrPrint;

//Arrays to track pkt sequence numbers for each partner node
unsigned char rxSequences[16];
unsigned char txSequences[16];

unsigned char maximumReSend;

///ID of this node
unsigned short int myID;

///Full rate modulation selection; QPSK by default
unsigned int pktFullRate;

//Payload code rate selection
unsigned int pktCodeRate;

///Buffer for holding a packet-to-xmit across multiple retransmissions
Macframe txMacframe;
///Buffer to hold received packet
Macframe rxMacframe;

///Current 802.11 channel
unsigned char chan;

//Define handy macros for CSMA MAC packet types
///Data packet with payload meant for Ethernet transmission
#define PKTTYPE_DATA 1
///Acknowledgement packet meant for halting retransmissions
#define PKTTYPE_ACK 0

///@brief Callback for the depression of the left push button
///
///This function is empty by default
void leftButton() {
}

///@brief Callback for the depression of the right push button
///
///This button switched between different fullrate modulation orders
void rightButton() {
	switch(pktFullRate){
		case HDR_FULLRATE_BPSK:
			pktFullRate = HDR_FULLRATE_QPSK;
			xil_printf("QPSK\r\n");
			break;
		case HDR_FULLRATE_QPSK:
			pktFullRate = HDR_FULLRATE_QAM_16;
			xil_printf("16-QAM\r\n");
			break;
		case HDR_FULLRATE_QAM_16:
			pktFullRate = HDR_FULLRATE_QAM_64;
			xil_printf("64-QAM\r\n");
			break;
		case HDR_FULLRATE_QAM_64:
			pktFullRate = HDR_FULLRATE_BPSK;
			xil_printf("BPSK\r\n");
			break;
	}
}

///@brief Callback for the depression of the up push button
///
///This button increments the 2.4GHz channel being used; only valid channels (in [1,14]) will be used
void upButton() {
	unsigned int newFreq;

	chan = (chan > 13) ? 14 : chan+1;
	newFreq = warpphy_setChannel(GHZ_2, chan);
	warpmac_leftHex(chan);

	xil_printf("New Frequency %d\r\n", newFreq);
}

///@brief Callback for the depression of the middle push button
///
///This button decrements the 2.4GHz channel being used; only valid channels (in [1,14]) will be used
void middleButton(){
	unsigned int newFreq;

	chan = (chan < 2) ? 1 : chan-1;
	newFreq = warpphy_setChannel(GHZ_2, chan);
	warpmac_leftHex(chan);

	xil_printf("New Frequency %d\r\n", newFreq);
}


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
			case ASCII_1:
				pktFullRate = HDR_FULLRATE_BPSK;
				xil_printf("Tx Full Rate = BPSK\r\n");
				break;

			case ASCII_2:
				pktFullRate = HDR_FULLRATE_QPSK;
				xil_printf("Tx Full Rate = QPSK\r\n");
				break;

			case ASCII_4:
				pktFullRate = HDR_FULLRATE_QAM_16;
				xil_printf("Tx Full Rate = 16-QAM\r\n");
				break;

			case ASCII_6:
				pktFullRate = HDR_FULLRATE_QAM_64;
				xil_printf("Tx Full Rate = 64-QAM\r\n");
				break;

			case ASCII_7:
				pktCodeRate = HDR_CODE_RATE_12;
				xil_printf("Coding Rate = 1/2\r\n");
				break;
			case ASCII_8:
				pktCodeRate = HDR_CODE_RATE_23;
				xil_printf("Coding Rate = 2/3\r\n");
				break;
			case ASCII_9:
				pktCodeRate = HDR_CODE_RATE_34;
				xil_printf("Coding Rate = 3/4\r\n");
				break;
			case ASCII_0:
				pktCodeRate = HDR_CODE_RATE_NONE;
				xil_printf("Coding Rate = 1 (no coding)\r\n");
				break;
			case ASCII_F:
				if(chan<14) chan++;
				warpphy_setChannel(GHZ_2, chan);
				xil_printf("Current channel: %d\r\n",chan);
				break;
			case ASCII_f:
				if(chan>1) chan--;
				warpphy_setChannel(GHZ_2, chan);
				xil_printf("Current channel: %d\r\n",chan);
				break;

			case ASCII_C:
				pktDet_AC_corr = (pktDet_AC_corr < 250) ? (pktDet_AC_corr+5) : 255;
				xil_printf("AutoCorr_corr: %d\tAutoCorr_energy: %d\r\n", pktDet_AC_corr, pktDet_AC_energy);
				warpphy_setAutoCorrDetParams(pktDet_AC_corr, pktDet_AC_energy);
				break;
			case ASCII_c:
				pktDet_AC_corr = (pktDet_AC_corr > 4) ? (pktDet_AC_corr-5) : 0;
				xil_printf("AutoCorr_corr: %d\tAutoCorr_energy: %d\r\n", pktDet_AC_corr, pktDet_AC_energy);
				warpphy_setAutoCorrDetParams(pktDet_AC_corr, pktDet_AC_energy);
				break;

			case ASCII_E:
				pktDet_AC_energy = (pktDet_AC_energy<2047) ? (pktDet_AC_energy+1) : 2047;
				xil_printf("AutoCorr_corr: %d\tAutoCorr_energy: %d\r\n", pktDet_AC_corr, pktDet_AC_energy);
				warpphy_setAutoCorrDetParams(pktDet_AC_corr, pktDet_AC_energy);
				break;
			case ASCII_e:
				pktDet_AC_energy = (pktDet_AC_energy>0) ? (pktDet_AC_energy-1) : 0;
				xil_printf("AutoCorr_corr: %d\tAutoCorr_energy: %d\r\n", pktDet_AC_corr, pktDet_AC_energy);
				warpphy_setAutoCorrDetParams(pktDet_AC_corr, pktDet_AC_energy);
				break;
				
			case ASCII_R:
				pktDet_RSSI_thresh += 100;
				xil_printf("RSSI_thresh: %d\r\n", pktDet_RSSI_thresh);
				warpphy_setEnergyDetThresh(pktDet_RSSI_thresh);
				break;

			case ASCII_r:
				pktDet_RSSI_thresh -= 100;
				xil_printf("RSSI_thresh: %d\r\n", pktDet_RSSI_thresh);
				warpphy_setEnergyDetThresh(pktDet_RSSI_thresh);
				break;
			case ASCII_A:
				debug_goodHdrPrint = 1;
				break;
			case ASCII_a:
				debug_goodHdrPrint = 0;
				break;
				
			default:
				xil_printf("Undefined command\r\n");
				break;
		}
	}

	return;
}
///@brief Callback for the expiration of timers
///
///This function is responsible for handling TIMEOUT_TIMER and BACKOFF_TIMER.
///The job responsibilities of this function are to:
///-increase the contention window upon the expiration of a TIMEOUT_TIMER
///-initiate a BACKOFF_TIMER timer upon the expiration of a TIMEOUT_TIMER
///-retransmit a packet upon the expiration of a BACKOFF_TIMER
///@param timerType TIMEOUT_TIMER or BACKOFF_TIMER
void timer_callback(unsigned char timerType) {

	switch(timerType) {
		case TIMEOUT_TIMER:
			warpmac_setTimer(BACKOFF_TIMER);
			break;

		case BACKOFF_TIMER:
			if(txMacframe.header.remainingTx) {
				//Copy the header over to the Tx packet buffer
				warpmac_prepPhyForXmit(&txMacframe, pktBuf_tx_DATA);

				//Send from the Tx packet buffer
				warpmac_startPhyXmit(pktBuf_tx_DATA);
				
				//Wait for it to finish
				warpmac_finishPhyXmit();

				//Start a timeout timer
				warpmac_setTimer(TIMEOUT_TIMER);
				warpmac_decrementRemainingReSend(&txMacframe);
			}
			else {
				//Either the packet has been sent the max number of times, or
				// we just got an ACK and need to backoff before starting with a new packet
				warpmac_enableDataFromNetwork();
			}
			break; //END BACKOFF_TIMER
	}
}


///@brief Callback for the reception of Ethernet packets
///
///This function is called by the ethernet MAC drivers
///when a packet is available to send. This function fills
///the Macframe transmit buffer with the packet and sends
///it over the OFDM link
///@param length Length, in bytes, of received payload (Ethernet or dummy payload length)
///@param payload Pointer to first byte of received payload (first byte of Ethernet or dummy payload)
void dataFromNetworkLayer_callback(Xuint32 length, char* payload){
	unsigned char rxSeqNum;
	unsigned char destNode;

	//Reset the contention window to its minimum
	warpmac_resetCurrentCW();

	//Disable further Ethernet packets (will be re-enabled after this packet is ACK'd or dropped)
	warpmac_disableDataFromNetwork();

	//Update the Tx packet header with this packet's values
	txMacframe.header.length = length;
	txMacframe.header.pktType = PKTTYPE_DATA;

	//Set the modulation scheme for the packet's full-rate symbols
	txMacframe.header.fullRate = pktFullRate;

	//Set the code rate for the packet's payload
	txMacframe.header.codeRate = pktCodeRate;

	//For now, assume our destination is our opposite ID (all traffic is 0 <-> 1)
	destNode = (myID+1)%2;

	//Copy in the packet's destination MAC address
	txMacframe.header.destAddr = (unsigned short int)(NODEID_TO_ADDR(destNode));

	//Use the next sequence number for this node (top four bits) and resend count of 0 (bottom four bits)
	txSequences[destNode] = (txSequences[destNode] + 1) % 256;
	txMacframe.header.seqNum = txSequences[destNode];

	//Set the remaining Tx counter to the maximum numeber of transmissions
	txMacframe.header.remainingTx = (maximumReSend+1);

	if(warpmac_carrierSense()) {
		//If the modium is idle:

		//Copy the header to the Tx packet buffer
		warpmac_prepPhyForXmit(&txMacframe, pktBuf_tx_DATA);

		//Transmit the packet
		warpmac_startPhyXmit(pktBuf_tx_DATA);
		
		//Wait for it to finish
		warpmac_finishPhyXmit();

		//Start a timeout timer
		warpmac_setTimer(TIMEOUT_TIMER);
		warpmac_decrementRemainingReSend(&txMacframe);
	}
	else {
		//Medium was busy; start a backoff timer
		warpmac_setTimer(BACKOFF_TIMER);
	}

	return;
}

///@brief Callback for the reception of bad wireless headers
void phyRx_badHeader_callback() {

	//Don't do anything with the packet (it had errors, and can't be trusted)
	
	//Increment the bottom LEDs
	warpmac_incrementLEDLow();

	return;
}

///@brief Callback for the reception of good wireless headers
///
///This function then polls the PHY to determine if the entire packet passes checksum
///thereby triggering the transmission of the ACK and the transmission of the received
///data over Ethernet.
///@param packet Pointer to received Macframe
int phyRx_goodHeader_callback(Macframe* packet){

	unsigned char state = PHYRXSTATUS_INCOMPLETE;
	unsigned char srcNode;
	unsigned char shouldSend = 0;

	if(debug_goodHdrPrint) {
		xil_printf("GH: RSSI=%4d\tAGC=%d/%2d\r\n",
			ofdm_txrx_mimo_ReadReg_Rx_PktDet_midPktRSSI_antA(),
			OFDM_AGC_MIMO_ReadReg_GRF_A(0),
			OFDM_AGC_MIMO_ReadReg_GBB_A(0));
	}
		
	//Calculate the node ID from the packet's source MAC address
	srcNode = ADDR_TO_NODEID( (packet->header.srcAddr) );

	//If the packet is addressed to this node
	if( packet->header.destAddr == (NODEID_TO_ADDR(myID)) ) {

		switch(packet->header.pktType) {
			//If received packet is data
			case PKTTYPE_DATA:
				//At this point, we have pre-loaded the PHY transmitter with the ACK in hoping that
				//the packet passes checksum. Now we wait for the state of the received to packet
				//to move from PHYRXSTATUS_INCOMPLETE to either PHYRXSTATUS_GOOD or PHYRXSTATUS_BAD

				//Poll the PHY until the payload is declared good or bad
				state = warpmac_finishPhyRecv();

				if(state & PHYRXSTATUS_GOOD){
					//The auto-reponder will send the pre-programmed ACK automatically
					//User code only needs to update its stats, then check to see the PHY is finished transmitting

					//Toggle the top LEDs
					warpmac_incrementLEDHigh();

					//Update the right-hex display with the current sequence number
					warpmac_leftHex(0xF & (packet->header.seqNum));

					//Check if the last received seq number for this partner node matches this received pkt
					// If not, record the new number and allow the pkt to be forwarded over the wire
					if(rxSequences[srcNode] != (packet->header.seqNum))
					{
						//Not a duplicate packet; update this partner's last-known sequence number
						rxSequences[srcNode] = (packet->header.seqNum);
						shouldSend = 1;
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

			case PKTTYPE_ACK:
				//Clear the TIMEOUT and enable Ethernet
				if(warpmac_inTimeout()) {
					warpmac_incrementLEDHigh();

					//Clear the timeout timer, set when we transmitted the data packet
					warpmac_clearTimer(TIMEOUT_TIMER);

					//Clear the remaining transmit count to assure this packet won't be re-transmitted
					txMacframe.header.remainingTx = 0;

					//Start a backoff, to gaurantee a random time before attempting to transmit again
					warpmac_setTimer(BACKOFF_TIMER);

					//Re-enable EMAC polling immediately (for testing; using the post-ACK backoff is better for real use)
					//warpmac_enableDataFromNetwork();
				}
				else {
					//Got an unexpected ACK; ignore it
				}

				break; //END PKTTYPE_ACK
		}
	}
	else {
		state = warpmac_finishPhyRecv();
	}
	//Return 0, indicating we didn't clear the PHY status bits (WARPMAC will handle it)
	return 0;
}

///@brief Main function
///
///This function configures MAC parameters, enables the underlying frameworks, and then loops forever.
int main(){

	//Initialize global variables
	chan = 4;

	//Assign the packet buffers in the PHY
	// The auto responder can't transmit from buffer 0, so we use it for Rx packets
	// The other assignments (DATA/ACK) are arbitrary; any buffer in [1,30] will work
	pktBuf_rx = 1;
	pktBuf_tx_DATA = 2;
	pktBuf_tx_ACK = 3;

	//Set the full-rate modulation to QPSK by default
	pktFullRate = HDR_FULLRATE_QAM_16;

	//Set the payload coding rate to 3/4 rate by default
	pktCodeRate = HDR_CODE_RATE_34;

	//Initialize the MAC/PHY frameworks
	warpmac_init();
	maximumReSend = 8;
	warpmac_setMaxResend(maximumReSend);
	warpmac_setMaxCW(5);
	warpmac_setTimeout(120);
	warpmac_setSlotTime(22);

	//Read Dip Switch value from FPGA board.
	//This value will be used as an index into the routing table for other nodes
	myID = (unsigned short int)warpmac_getMyId();
	warpmac_rightHex(myID);

	//Configure the PHY and radios for single antenna (SISO) mode
	warpphy_setAntennaMode(TX_ANTMODE_SISO_ANTA, RX_ANTMODE_SISO_ANTA);
	//warpphy_setAntennaMode(TX_ANTMODE_MULTPLX, RX_ANTMODE_MULTPLX);
	//warpphy_setAntennaMode(TX_ANTMODE_ALAMOUTI_ANTA, RX_ANTMODE_ALAMOUTI_ANTA);

	//Set the packet detection thresholds
	pktDet_RSSI_thresh = 7000;
	pktDet_AC_corr = 90;
	pktDet_AC_energy = 20;
	
	warpphy_setEnergyDetThresh(pktDet_RSSI_thresh);		//Min RSSI (in [0,16368])
	warpphy_setAutoCorrDetParams(pktDet_AC_corr, pktDet_AC_energy);	//Min auto-correlation (in [0,2047])
	warpphy_setLongCorrThresh(8000);		//Min cross-correlation (in [0,45e3])
	warpphy_setCarrierSenseThresh(12000); //Carrier sense thresh (in [0,16368])
	
	
	//Rx buffer is where the EMAC will DMA Wireless payloads from
	warpmac_setRxBuffers(&rxMacframe, pktBuf_rx);

	//Tx buffer is where the EMAC will DMA Ethernet payloads to
	warpmac_setPHYTxBuffer(pktBuf_tx_DATA);
	warpmac_setEMACRxBuffer(pktBuf_tx_DATA);

	//Set the modulation scheme use for base rate (header) symbols
	warpmac_setBaseRate(QPSK);

	//Copy this node's MAC address into the Tx buffer's source address field
	txMacframe.header.srcAddr = (unsigned short int)(NODEID_TO_ADDR(myID));

	//Register callbacks
	warpmac_setCallback(EVENT_UPBUTTON, (void *)upButton);
	warpmac_setCallback(EVENT_LEFTBUTTON, (void *)leftButton);
	warpmac_setCallback(EVENT_RIGHTBUTTON, (void *)rightButton);
	warpmac_setCallback(EVENT_MIDDLEBUTTON, (void *)middleButton);
	warpmac_setCallback(EVENT_TIMER, (void *)timer_callback);
	warpmac_setCallback(EVENT_DATAFROMNETWORK, (void *)dataFromNetworkLayer_callback);
	warpmac_setCallback(EVENT_PHYGOODHEADER, (void *)phyRx_goodHeader_callback);
	warpmac_setCallback(EVENT_PHYBADHEADER, (void *)phyRx_badHeader_callback);
	warpmac_setCallback(EVENT_UARTRX, (void *)uartRecv_callback);

	//Set the default center frequency
	warpphy_setChannel(GHZ_2, chan);

	//Enable carrier sensing
	warpmac_setCSMA(1);

	/******** START autoResponse setup *******/
	//Setup the PHY's autoResponse system
	// For CSMA, it is configured to send pktBuf pktBuf_tx_ACK when a good DATA packet is received addressed to this node

	//Match condition 0: received header's destination address is this node's address
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_DSTADDR, 2, htons(NODEID_TO_ADDR(myID)));
	mimo_ofdmTxRx_setMatch0(autoResp_matchCond);

	//Match condition 1: received header's type is DATA
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_TYPE, 1, PKTTYPE_DATA);
	mimo_ofdmTxRx_setMatch1(autoResp_matchCond);

	//Configure the header translator to use the Rx pkt's src address as the outgoing pkt's dst address
	// Addresses are two bytes, so two entries in the header translator need to be overridden
	// Except for these bytes, the ACK pktBuf's contents will be sent unaltered
	// PHY_HEADERTRANSLATE_SET(templatePktBuf, byteAddrToOverwrite, srcPktBuf, srcByteAddr)
	PHY_HEADERTRANSLATE_SET(pktBuf_tx_ACK, (PKTHEADER_INDX_DSTADDR+0), pktBuf_rx, (PKTHEADER_INDX_SRCADDR+0));
	PHY_HEADERTRANSLATE_SET(pktBuf_tx_ACK, (PKTHEADER_INDX_DSTADDR+1), pktBuf_rx, (PKTHEADER_INDX_SRCADDR+1));

	//Create a template ACK packet
	templatePkt.header.fullRate = pktFullRate;
	templatePkt.header.codeRate = pktCodeRate;
	templatePkt.header.length = 0;
	templatePkt.header.srcAddr = (unsigned short)(NODEID_TO_ADDR(myID));
	templatePkt.header.pktType = PKTTYPE_ACK;

	//Copy the header down to the PHY's packet buffer
	// This doesn't actually send anything; the autoResponse system will use this template when sending ACKs
	warpmac_prepPhyForXmit(&templatePkt, pktBuf_tx_ACK);

	//Action defitions come last; bad things might happen if an action is enabled (set non-zero) before the template pkt is ready.
	//All actors are disabled during warpphy_init; only load non-zero configurations for actors you intend to use

	//Action 0: send pkt from buf pktBuf_tx_ACK when match0 & match1 & goodPkt, using header translation
	autoResp_action = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_ACK, PHY_AUTORESPONSE_ACT_TRANS_HDR, 0, (PHY_AUTORESPONSE_REQ_MATCH0 | PHY_AUTORESPONSE_REQ_MATCH1 | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
	mimo_ofdmTxRx_setAction0(autoResp_action);
	/******* END autoResponse setup ******/

	//Listen for new packets to send (either from Ethernet or local dummy packets)
	warpmac_enableDataFromNetwork();

	xil_printf("Reference Design v16.1 CSMAMAC\r\n");
	xil_printf("Beginning main loop\r\n");

	
	/******* DEBUG STUFF *******/
	debug_goodHdrPrint = 0;
	
	while(1)
	{
		//Poll the timer, PHY and user I/O forever; actual processing will happen via callbacks above
		warpmac_pollPeripherals();
	}

	return;
}
