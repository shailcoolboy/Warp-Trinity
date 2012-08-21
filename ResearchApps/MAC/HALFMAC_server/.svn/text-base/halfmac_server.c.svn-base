/*! \file halfmac_server.c
 \brief Server for halfmac workshop exercise
 
 @version 16.1
 @author Chris Hunter
 
 This code is a simple manipulation of csmaMac.c that allows for addressing
 multiple WARP nodes based upon the IP address of the packet being sent.
 
 */

#include "warpmac.h"
#include "warpphy.h"
#include "halfmac_server.h"
#include "xparameters.h"
#include "ascii_characters.h"
#include "ofdm_txrx_mimo_regMacros.h"
#include "wired_frame_formats.h"

Macframe templatePkt;

unsigned int autoResp_matchCond;
unsigned int autoResp_action;
unsigned char pktBuf_tx_DATA;
unsigned char pktBuf_rx;

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

unsigned int txSeqNum;

//Define handy macros for CSMA MAC packet types
///Data packet with payload meant for Ethernet transmission
#define PKTTYPE_DATA	1
#define PKTTYPE_ACK		0

///@brief Callback for the depression of the left push button
///
///This function is empty by default
void leftButton() {
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

			default:
				xil_printf("Undefined command\r\n");
				break;
		}
	}
	
	return;
}
///@brief Callback for the expiration of timers
///
///This function is responsible for handling #TIMEOUT and #BACKOFF.
///The job responsibilities of this function are to:
///-increase the contention window upon the expiration of a #TIMEOUT
///-initiate a #BACKOFF timer upon the expiration of a #TIMEOUT
///-retransmit a packet upon the expiration of a #BACKOFF
///@param timerType #TIMEOUT or #BACKOFF
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
///@param length Length, in bytes, of received Ethernet frame
void dataFromNetworkLayer_callback(Xuint32 length, char* payload){
	unsigned char destNode;
	int i;
	
	//Struct pointers to help decode the Ethernet payload
	ethernet_header* hdrPtr_ethernet;
	arp_header*		hdrPtr_arp;
	ipv4_header*	hdrPtr_ip;

	hdrPtr_ethernet = (ethernet_header*)payload;
	hdrPtr_arp = (arp_header*)(payload+sizeof(ethernet_header));
	hdrPtr_ip = (ipv4_header*)(payload+sizeof(ethernet_header));
	
	//Check the Ethertype of the received payload, and extract the 
	// last byte of the destination IP address
	switch(hdrPtr_ethernet->ethertype) {
		case ETHERTYPE_ARP:
			destNode = (unsigned char)((hdrPtr_arp->dest_addr_ip)&0xFF);
//			xil_printf("ARP pkt to %d\r\n", destNode);

//			for(i=0; i<28; i++)
//				xil_printf("[%02d] 0x%02x\r\n", i, payload[i]);
			break;

		case ETHERTYPE_IP:
			destNode = (unsigned char)((hdrPtr_ip->dest_addr_ip)&0xFF);
//			xil_printf("IP pkt to %d\r\n", destNode);
			break;

		default:
			//Invlaid Ethertype value; default to highest node ID
//			xil_printf("Unknown pkt format\r\n");
			destNode = 15;
	}

	if(destNode > 15)
		destNode = 15;

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
	
	//Copy in the packet's destination MAC address
	txMacframe.header.destAddr = (unsigned short int)(NODEID_TO_ADDR(destNode));
	
	txMacframe.header.seqNum = txSeqNum++;
	
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
///
///@param packet Pointer to received Macframe
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
					
					//Starts the DMA transfer of the payload into the EMAC
					warpmac_prepPktToNetwork((void *)warpphy_getBuffAddr(pktBuf_rx)+NUM_HEADER_BYTES, (packet->header.length));
					
					//Blocks until the PHY is finished sending and enables the receiver
					warpmac_finishPhyXmit();
					
					//Waits until the DMA transfer is complete, then starts the EMAC
					warpmac_startPktToNetwork((packet->header.length));
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
	
	//Set the full-rate modulation to QPSK by default
//	pktFullRate = HDR_FULLRATE_QPSK;
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
	warpphy_setEnergyDetThresh(7000);		//Min RSSI (in [0,16368])
	warpphy_setAutoCorrDetParams(90, 0);	//Min auto-correlation (in [0,2047])
	warpphy_setLongCorrThresh(8000);		//Min cross-correlation (in [0,45e3])
	
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
	warpmac_setCallback(EVENT_TIMER, (void *)timer_callback);
	warpmac_setCallback(EVENT_DATAFROMNETWORK, (void *)dataFromNetworkLayer_callback);
	warpmac_setCallback(EVENT_PHYGOODHEADER, (void *)phyRx_goodHeader_callback);
	warpmac_setCallback(EVENT_PHYBADHEADER, (void *)phyRx_badHeader_callback);
	warpmac_setCallback(EVENT_UARTRX, (void *)uartRecv_callback);
	
	//Set the default center frequency
	warpphy_setChannel(GHZ_2, chan);
	
	//Enable carrier sensing
	warpmac_setCSMA(1);
	
	txSeqNum = 0;
	
	//halfmac_server doesn't send ACKs, so skip autoResponder setup
	
	//Listen for new packets to send (either from Ethernet or local dummy packets)
	warpmac_enableDataFromNetwork();
	
	xil_printf("Reference Design v16.1 HALFMAC SERVER\r\n");
	
	xil_printf("Beginning main loop\r\n");
	
	while(1)
	{
		//Poll the timer, PHY and user I/O forever; actual processing will happen via callbacks above
		warpmac_pollPeripherals();
	}
	
	return 0;
}
