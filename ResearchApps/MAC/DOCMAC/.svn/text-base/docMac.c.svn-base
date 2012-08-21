/*! \file doc.c
 \brief Distributed On-Demand Cooperation
 
 @version 15
 @author Chris Hunter and Patrick Murphy
 
 
 */
#include "warpmac.h"
#include "warpnet.h"
#include "warpphy.h"
#include "docMac.h"
#include "xparameters.h"
#include "ofdm_txrx_mimo_regMacros.h"
#include "string.h"
#include "errno.h"
#include "stdlib.h"
#include "stdio.h"
#include "ascii_characters.h"
#include "warp_userioboard_util.h"
#include "radio_controller_ext.h"
#include "xtime_l.h"



#define PERLOW	80000
#define PERHIGH	60000
#define DUTYLOW 13107
#define DUTYHIGH 13107

#define htons(A) ((((Xuint16)(A) & 0xff00) >> 8) | (((Xuint16)(A) & 0x00ff) << 8))
#define MAX_NUMNODES 3

#define REQ_DST_ME PHY_AUTORESPONSE_REQ_MATCH0
#define REQ_RLY_ME PHY_AUTORESPONSE_REQ_MATCH1
#define REQ_DATA PHY_AUTORESPONSE_REQ_MATCH2
#define REQ_NACK PHY_AUTORESPONSE_REQ_MATCH3

#define NUM_RX_PKTBUFS 2



unsigned char randomData_Mode;

Macframe templatePkt;
unsigned int autoResp_matchCond;
unsigned int autoResp_action;
unsigned int autoResp_action_reTx;
unsigned int autoResp_action_coopTx;
unsigned short autoRespDelay_NACKTx, autoRespDelay_AFTx, autoRespDelay_ReTx, autoRespDelay_ACKTx;
unsigned int docPreambleScaling,docPayloadScaling;
unsigned int txPower;

unsigned char relayDestID;
unsigned int relayLen;
unsigned char alternating;
unsigned char currentAlt;

XTime startTime;
XTime stopTime;

unsigned char pktBuf_tx_ACK;
unsigned char pktBuf_tx_NACK;
unsigned char pktBuf_tx_DATA;
unsigned char pktBuf_rx_emac;
unsigned char pktBuf_tx_AF;
unsigned char pktBuf_rx;
unsigned char rxPktBufs[NUM_RX_PKTBUFS];
unsigned char pktBuf_rx_ind;
unsigned char respondToNacks;

unsigned char relayMode;
unsigned short relayMode_lastSrcAddr;

unsigned char enableStats;
int pktGen_length;
int pktGen_period;
unsigned char enablePktGen;
unsigned char allowRelay;

unsigned short rx_correThresh;
unsigned char cfoDly;
unsigned char ignoreSeqNums;
unsigned char cfoVar;
unsigned char agcPrintMode;
unsigned int pktDet_rssi;
unsigned int agcGains;
unsigned char antB_preambleShift;
unsigned char debug_sisoMode;
unsigned char userIOBoard_LEDs;
unsigned char charsToPrint[16];
unsigned int pktCount_good, pktCount_bad;

unsigned short int rxSequences[MAX_NUMNODES];
unsigned short int txSequences[MAX_NUMNODES];

unsigned char max_numTransmissions;

///Index to the routing table that identifies this node
unsigned short int myID;

///Full rate modulation selection; QPSK by default
unsigned int pktFullRate;

//Payload code rate selection; must be CODE_RATE_NONE for uncoded PHY
unsigned int pktCodeRate;

#define NUMMODES 2

unsigned int stats_numDataTx[MAX_NUMNODES][MAX_NUMNODES][NUMMODES];
unsigned int stats_numNACKTx[MAX_NUMNODES][MAX_NUMNODES][NUMMODES];
unsigned int stats_numDataRx[MAX_NUMNODES][MAX_NUMNODES][NUMMODES];
unsigned int stats_numNACKRx[MAX_NUMNODES][MAX_NUMNODES][NUMMODES];
unsigned int stats_sumGains[MAX_NUMNODES][MAX_NUMNODES][NUMMODES];
unsigned int stats_sumPacketsRx[MAX_NUMNODES][MAX_NUMNODES][NUMMODES];
unsigned int stats_sumRSSI[MAX_NUMNODES][MAX_NUMNODES][NUMMODES];
unsigned int stats_numBadHeaderRx;

///Buffer for holding a packet-to-xmit across multiple retransmissions
Macframe txBuffer;
///Buffer to hold received packet
Macframe rxBuffer;

///Current antenna selection
unsigned char currentAnt;
///Current 802.11 channel
unsigned char chan;

unsigned char buzzerEnable;

//Define handy macros for MAC packet types
///ACK/NACK packet types
#define ACKPACKET 0
#define NACKPACKET 1
///Data packet types
#define DATAPACKET 2

// Aid for Debugging Purposes, if 1 print from Teraterm
#define PrintDebug 0

warpnetEthernetPktHeader txEthPktHeader;


void resetStats(){
int i,j,k;

for(i=0;i<MAX_NUMNODES;i++){
	for(j=0;j<MAX_NUMNODES;j++){
		for(k=0;k<NUMMODES;k++){
			stats_numDataTx[i][j][k]=0;
			stats_numNACKTx[i][j][k]=0;
			stats_numDataRx[i][j][k]=0;
			stats_numNACKRx[i][j][k]=0;	
			stats_sumGains[i][j][k]=0;
			stats_sumPacketsRx[i][j][k]=0;
			stats_sumRSSI[i][j][k]=0;
		}
	}
}

stats_numBadHeaderRx=0;
}


///@brief Callback for the depression of the left push button
///
///This function is empty by default
void left(){
//	xil_printf("stats_numDataTx      = %d\r\n",stats_numDataTx);
//	xil_printf("stats_numDataRx      = %d\r\n",stats_numDataRx);
//	xil_printf("numRelayTx     = %d\r\n",numRelayTx);
//	xil_printf("stats_numBadHeaderRx = %d\r\n",stats_numBadHeaderRx);
//	xil_printf("stats_numNACKTx      = %d\r\n",stats_numNACKTx);
//	xil_printf("stats_numNACKRx      = %d\r\n",stats_numNACKRx);
}

///@brief Callback for the depression of the right push button
///
///This button switched between different fullrate modulation orders
void right(){
//	stats_numDataTx=0;
//	stats_numDataRx=0;
//	stats_numBadHeaderRx=0;
//	stats_numNACKTx=0;
//	stats_numNACKRx=0;
//	numRelayTx = 0;
}

///@brief Callback for the depression of the up push button
///
///This button increments the 2.4GHz channel being used; only valid channels (in [1,14]) will be used
void up(){
	buzzerEnable = 1;
}

///@brief Callback for the depression of the middle push button
///
///This button decrements the 2.4GHz channel being used; only valid channels (in [1,14]) will be used
void middle(){
	buzzerEnable  = 0;
}

///@brief Updates the LCD
///
///Updates the LCD. This is only for the User I/O daughtercard. If you do not have this card,
///this function will do nothing. This operation takes some time, so it can only be called in a few places so as to
///not adversely affect the performance of the MAC.
void updateLCD()
{

//	warp_userioboard_set_leds(userIOBoard_LEDs);	
//	snprintf(charsToPrint, 16, "Good: %09d ", pktCount_good);
//	warp_userio_lcd_printline(charsToPrint, 16, 4, 1);
//	snprintf(charsToPrint, 16, "Bad:  %09d ", (pktCount_bad)>>1);//bad pkts get counted twice
//	warp_userio_lcd_printline(charsToPrint, 16, 5, 1);
	
	return;
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
			case ASCII_W:
				docPreambleScaling+=10;
				mimo_ofdmTx_setTxScaling(docPreambleScaling,docPayloadScaling);
				xil_printf("+Preamble Scaling: %d\r\n",docPreambleScaling);
				break;
				
			case ASCII_w:
				docPreambleScaling-=10;
				mimo_ofdmTx_setTxScaling(docPreambleScaling,docPayloadScaling);
				xil_printf("-Preamble Scaling: %d\r\n",docPreambleScaling);
				break;
				
			case ASCII_E:
				docPayloadScaling+=10;
				mimo_ofdmTx_setTxScaling(docPreambleScaling,docPayloadScaling);
				xil_printf("+Payload Scaling: %d\r\n",docPayloadScaling);
				break;
				
			case ASCII_e:
				docPayloadScaling-=10;
				mimo_ofdmTx_setTxScaling(docPreambleScaling,docPayloadScaling);
				xil_printf("-Payload Scaling: %d\r\n",docPayloadScaling);				
				break;
				
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
				
			case ASCII_5:
			    randomData_Mode=(randomData_Mode+1)%2;
				xil_printf("randomData_Mode: %d\r\n",randomData_Mode);
				break;

				
			case ASCII_6:
				pktFullRate = HDR_FULLRATE_QAM_64;
				xil_printf("Tx Full Rate = 64-QAM\r\n");
				break;
			
			case ASCII_8:
				debug_sisoMode = (debug_sisoMode ^ 1) & 0x1;
				if(debug_sisoMode){
					warpphy_setAntennaMode(TX_ANTMODE_SISO_ANTA, RX_ANTMODE_SISO_ANTA);
				}
				else{
					warpphy_setAntennaMode(TX_ANTMODE_ALAMOUTI_ANTA, RX_ANTMODE_ALAMOUTI_ANTA);
				}
				xil_printf("SISO mode = %d\r\n", debug_sisoMode);

				break;
			case ASCII_9:
				agcPrintMode = (agcPrintMode ^ 1) & 0x1;
				break;

			case ASCII_O:
				warpphy_set_FFTOffset_Plus();
				break;
			case ASCII_o:
				warpphy_set_FFTOffset_Minus();
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
			case ASCII_G:
				txPower++;
				warpphy_setTxPower(txPower);
				xil_printf("New Tx Power = 0x%x\r\n",txPower);
				break;
			case ASCII_g:
				txPower--;
				warpphy_setTxPower(txPower);
				xil_printf("New Tx Power = 0x%x\r\n",txPower);
				break;
			case ASCII_C:
				ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) | COARSE_CFO_EN);
				xil_printf("Coarse CFO Enabled\r\n");
				break;
			case ASCII_c:
				ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) & ~(COARSE_CFO_EN));
				xil_printf("Coarse CFO Disabled\r\n");
				break;
			case ASCII_A:
				xil_printf("AF/ReTx enabled\r\n");
				respondToNacks = 1;
				break;
			case ASCII_a:
				xil_printf("AF/ReTx disabled\r\n");
				respondToNacks = 0;
				break;
			case ASCII_t:
				rx_correThresh = rx_correThresh - 50;
				warpphy_setLongCorrThresh(rx_correThresh);
				break;
			case ASCII_T:
				rx_correThresh = rx_correThresh + 50;
				warpphy_setLongCorrThresh(rx_correThresh);
				break;

		    case ASCII_V:
				cfoVar++;
				mimo_ofdmRx_setCFOMaxDiff(cfoVar);
				xil_printf("cfoVar = %d\r\n",cfoVar);
				break;
		    case ASCII_v:
				cfoVar--;
				mimo_ofdmRx_setCFOMaxDiff(cfoVar);
				xil_printf("cfoVar = %d\r\n",cfoVar);
				break;

				
			case ASCII_J:
				cfoDly++;
				mimo_ofdmRx_setCFOCalcDly(cfoDly);
				xil_printf("CFO delay: %d\r\n", cfoDly);
				break;
			case ASCII_j:
				cfoDly--;
				mimo_ofdmRx_setCFOCalcDly(cfoDly);
				xil_printf("CFO delay: %d\r\n", cfoDly);
				break;
				
			case ASCII_x:
				//warpmac_uhoh();
				break;
				
				
			case ASCII_S:
				//warpphy_setAFScalingPlus();
				break;
				
			case ASCII_s:
				//warpphy_setAFScalingMinus();
				break;
			
			case ASCII_P:
				warpphy_setPktDetPlus(200);
                break;

            case ASCII_p:
				warpphy_setPktDetMinus(200);
                break;
                
			case ASCII_B:
				//antB_preambleShift++;
				//warpphy_setAntBPreambleShift(antB_preambleShift);
				//xil_printf("AntB Preamble Shift: %d\r\n", antB_preambleShift);
				break;
				
			case ASCII_b:
				//antB_preambleShift--;
				//warpphy_setAntBPreambleShift(antB_preambleShift);
				//xil_printf("AntB Preamble Shift: %d\r\n", antB_preambleShift);
				break;
				
			case ASCII_R:
				autoRespDelay_AFTx++;
				autoRespDelay_ReTx++;
				xil_printf("autoRespDelay_AFTx: %d - autoRespDelay_ReTx: %d\r\n", autoRespDelay_AFTx, autoRespDelay_ReTx);
				break;
				
			case ASCII_r:
				autoRespDelay_AFTx--;
				autoRespDelay_ReTx--;
				xil_printf("autoRespDelay_AFTx: %d - autoRespDelay_ReTx: %d\r\n", autoRespDelay_AFTx, autoRespDelay_ReTx);
				break;
			
                
            case ASCII_q:
                ignoreSeqNums = (ignoreSeqNums ^ 1)%2;
                xil_printf("Ignore seq nums: %d\r\n", ignoreSeqNums);
                break;

			case ASCII_N:
//				autoRespDelay_NACKTx++;
//	autoResp_action = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_NACK, PHY_AUTORESPONSE_ACT_TRANS_HDR, autoRespDelay_NACKTx, (REQ_DST_ME | REQ_DATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT)); //Use for NACKs in place of ACKs
//				mimo_ofdmTxRx_setAction1(autoResp_action);
//				xil_printf("NACK delay: %d\r\n", autoRespDelay_NACKTx);
				break;
				
			case ASCII_n:
//				autoRespDelay_NACKTx--;
//	autoResp_action = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_NACK, PHY_AUTORESPONSE_ACT_TRANS_HDR, autoRespDelay_NACKTx, (REQ_DST_ME | REQ_DATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT)); //Use for NACKs in place of ACKs
//				mimo_ofdmTxRx_setAction1(autoResp_action);
//				xil_printf("NACK delay: %d\r\n", autoRespDelay_NACKTx);
				break;

			case ASCII_Z:
				autoRespDelay_ACKTx++;
				autoResp_action = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_ACK, 1, autoRespDelay_ACKTx, (REQ_DST_ME | REQ_DATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
				mimo_ofdmTxRx_setAction0(autoResp_action);
				xil_printf("ACK delay: %d\r\n", autoRespDelay_ACKTx);
				break;

			case ASCII_z:
				autoRespDelay_ACKTx--;
				autoResp_action = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_ACK, 1, autoRespDelay_ACKTx, (REQ_DST_ME | REQ_DATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
				mimo_ofdmTxRx_setAction0(autoResp_action);
				xil_printf("ACK delay: %d\r\n", autoRespDelay_ACKTx);
				break;
				
			case ASCII_m:
				
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
void timer_callback(unsigned char timerType){
	switch(timerType){
	
		case BUZZER_TIMER:
		
			warp_userioboard_set_buzzer_en(0);
		//	xil_printf("!\r\n");
		break;
		case TIMEOUT_TIMER:
		
			if(!relayMode)
			{
				//Source sent a DATA but never got ACK or NACK; time to re-transmit or give up
				
				//Check if this will be our last transmission attempt
				if(txBuffer.remainingTx == 1)
				{
					//Disable the auto-retransmitter, in case a NACK is received after a relay transmission during our backoff
					autoResp_action_reTx = 0;
					mimo_ofdmTxRx_setAction2(autoResp_action_reTx);

					//Overwrite the relay address to our own, disabling cooperation from now on
					txBuffer.header.relAddr = NODEID_TO_ADDR(myID);
					
					//Copy the updated header down to the PHY pkt buffer
					warpmac_prepPhyForXmit(&txBuffer, pktBuf_tx_DATA);
				}
				
				//Start a random backoff before attempting to re-transmit
				warpmac_setTimer(BACKOFF_TIMER);
			}
			else //relayMode == 1
			{
				//Relay never got a ACK or NACK, so disable the autoResponse actor for cooperative transmissions
				
				
				
				autoResp_action_coopTx = 0;
				mimo_ofdmTxRx_setAction4(autoResp_action_coopTx);
				


				
				
				//De-assert relay mode
				relayMode = 0;
				
				//Clear autoResponse FLAGA (was set by previous reception of DATA)
				warpphy_clearAutoResponseFlag(AUTORESP_FLAGID_A);
				
				//Re-enable capture of AF waveforms
				//warpmac_setDebugGPIO(0xF);
				warpphy_AFrecordEnable(1);
			}
		break;//END TIMEOUT_TIMER

		case BACKOFF_TIMER:
			if(txBuffer.remainingTx == 0)
			{
				//No more re-transmissions for this packet; discard it and return
				//Re-enable new packet handling (effectively discards current packet)
				warpmac_enableDataFromNetwork();
			}
			else
			{
				if(txBuffer.remainingTx == 1)
				{
					//Disable the autoResponder for data re-transmissions (it already started its last transmission)
					autoResp_action_reTx = 0;
					mimo_ofdmTxRx_setAction2(autoResp_action_reTx);
				}
				
				//Re-transmit the packet
				warpmac_startPhyXmit(pktBuf_tx_DATA);

				//Wait for it to finish
				warpmac_finishPhyXmit();
							warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA_SWAPPED);
				//Start the timeout interval immediately after the Tx finishes
				warpmac_setTimer(TIMEOUT_TIMER);

				//Decrement the packet's remaining transmisisons
				txBuffer.remainingTx = txBuffer.remainingTx - 1;
				
				
			}
		break;//END BACKOFF_TIMER
	}
}


void processCommand(warpnetCommand* commandStruct){
	//xil_printf("Process Command Packet\r\n");
	switch(commandStruct->cmdID){
		case COMMANDID_STARTTRIAL:
//			xil_printf("Starting trial\r\n");
			resetStats();
			if(enablePktGen) warpmac_startPacketGeneration(pktGen_length, pktGen_period);
			XTime_GetTime(&startTime);
			enableStats = 1;
		break;
		case COMMANDID_STOPTRIAL:
//			xil_printf("Stopping trial\r\n");
			enableStats=0;
			XTime_GetTime(&stopTime);
			warpmac_stopPacketGeneration();
			
		break;
		case COMMANDID_PKTGEN:
			if(commandStruct->cmdParam==COMMANDPARAM_ENABLE){
				enablePktGen=1;
//				xil_printf("Enabled Packet Generation\r\n");
			}
			
			if(commandStruct->cmdParam==COMMANDPARAM_DISABLE){
				enablePktGen=0;
//				xil_printf("Disabled Packet Generation\r\n");
			}
		break;
		case COMMANDID_RELAYSTATE:
			if(commandStruct->cmdParam==COMMANDPARAM_OFF){
				allowRelay=0;
				alternating=0;
			}
			else if(commandStruct->cmdParam==COMMANDPARAM_AF){
				allowRelay=1;
			}
			else if(commandStruct->cmdParam==COMMANDPARAM_ALTERNATING){
				alternating=1;
			}
		break;
			
	}
}

void processRequest(warpnetRequest* requestStruct, warpnetObserve* observeStruct, char mode){
	//xil_printf("Processing Request: NodeID = %d, cmdID = %d\r\n",myID,requestStruct->cmdID);
	observeStruct->structID=STRUCTID_OBSERVE;
	observeStruct->nodeID=myID;
	observeStruct->sourceNode=requestStruct->cmdID;
	observeStruct->numDataTx=stats_numDataTx[requestStruct->cmdID][myID][mode];
	observeStruct->numNACKTx=stats_numNACKTx[requestStruct->cmdID][myID][mode];
	observeStruct->numDataRx=stats_numDataRx[myID][requestStruct->cmdID][mode];
	observeStruct->numNACKRx=stats_numNACKRx[myID][requestStruct->cmdID][mode];
	observeStruct->numBadHeaderRx=stats_numBadHeaderRx;
	observeStruct->sumGains=stats_sumGains[myID][requestStruct->cmdID][mode];
	observeStruct->sumRSSI=stats_sumRSSI[myID][requestStruct->cmdID][mode];
	observeStruct->sumPacketCountRx=stats_sumPacketsRx[myID][requestStruct->cmdID][mode];
	
	//xil_printf("sumPacketCountRx = %d \r\n",stats_sumPacketsRx[myID][requestStruct->cmdID][mode]);
	
	observeStruct->trialDuration = stopTime-startTime;
//	XTime_GetTime(&(observeStruct->timeStamp));


//xil_printf("Requested gains = %d\r\n",stats_sumGains[myID][requestStruct->cmdID]);
//xil_printf("Saved gains = %d\r\n",stats_sumGains[myID][0]);

}

void processControl(warpnetControl* controlStruct){
	pktGen_length = controlStruct->pktGen_length;
	pktGen_period = controlStruct->pktGen_period;
	chan = controlStruct->channel;
	warpphy_setChannel(GHZ_2, chan);
	
	xil_printf("Channel = %d\r\n",chan);
	//xil_printf("LEN: %d, Period: %d\r\n",pktGen_length,pktGen_period);
}

///@brief Callback for the reception of Ethernet Management packets
///
///This function is called by the ethernet MAC drivers
///and process the packet to perform specific operations
///depending on the packet struct
///@param length Length, in bytes, of received Ethernet frame
///@brief Callback for the reception of Ethernet Management packets
///
///This function is called by the ethernet MAC drivers
///and process the packet to perform specific operations
///depending on the packet struct
///@param length Length, in bytes, of received Ethernet frame
void mgmtFromNetworkLayer_callback(Xuint32 length, char* payload){

//xil_printf("MGMT RX!\r\n");

	int pktBuf_payloadAddr;
	warpnetEthernetPktHeader* receivedPkt;
	warpnetControllerGroup* copyStruct;
	warpnetCommand* commandStruct;
	warpnetControl* controlStruct;
	warpnetRequest* requestStruct;
	warpnetAck ackStruct;
	warpnetObserve observeStruct;
	int sizeofcopy,rxPktOffset,numRxStructs,rxSeqNum,i,thisStructType;
	sizeofcopy = sizeof(warpnetControllerGroup);
	receivedPkt = (warpnetEthernetPktHeader*) payload;
		
	//If this is a WARPnet Ethernet packet, process it immediately
	if((receivedPkt->ethType) == WARPNET_ETHTYPE_SVR2NODE){
		rxPktOffset = sizeof(warpnetEthernetPktHeader);
		numRxStructs = receivedPkt->numStructs;
		rxSeqNum = receivedPkt->seqNum;
		
		//Itereate over each struct in the Ethernet packet
		for(i=0; i<numRxStructs; i++)
		{
			//Punt if numStructs would have us march past the end of the received packet
			if(rxPktOffset >= length)
			{
				xil_printf("Error! Mgmt pktLength too short for numStructs\r\n");
				return;
			}
			
			copyStruct = (warpnetControllerGroup*)(payload+rxPktOffset);
			
			//Extract the struct type (always the first byte of a struct)
			thisStructType = *(unsigned char*)(payload+rxPktOffset+sizeofcopy);
			switch(thisStructType)
			{
				case STRUCTID_COMMAND:
					commandStruct = (warpnetCommand*)(payload+rxPktOffset+sizeofcopy);
					if((commandStruct->nodeID) == myID){

						ackStruct.structID = STRUCTID_COMMAND_ACK;
						ackStruct.nodeID = myID;
						ackStruct.cmdID = commandStruct->cmdID;
						
						txEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetAck) + sizeofcopy;
						txEthPktHeader.numStructs = 1;
						
						pktBuf_payloadAddr = warpphy_getBuffAddr(WARPNET_NODE2SVR_PKTBUFFINDEX);
						memcpy((void *)pktBuf_payloadAddr, &(txEthPktHeader), sizeof(warpnetEthernetPktHeader));
						memcpy((void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader), copyStruct, sizeofcopy);
						memcpy((void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader)+sizeofcopy, &(ackStruct), sizeof(warpnetAck));
						
						warpmac_prepPktToNetwork((void *)pktBuf_payloadAddr, txEthPktHeader.pktLength);
						warpmac_startPktToNetwork(txEthPktHeader.pktLength);
						processCommand(commandStruct);
					}
					rxPktOffset += sizeof(warpnetCommand);
					break;
				case STRUCTID_CONTROL:
					controlStruct = (warpnetControl*)(payload+rxPktOffset+sizeofcopy);
					if((controlStruct->nodeID) == myID){

						ackStruct.structID = STRUCTID_CONTROL_ACK;
						ackStruct.nodeID = myID;
						
						txEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetAck) + sizeofcopy;
						txEthPktHeader.numStructs = 1;
						
						pktBuf_payloadAddr = warpphy_getBuffAddr(WARPNET_NODE2SVR_PKTBUFFINDEX);
						memcpy((void *)pktBuf_payloadAddr, &(txEthPktHeader), sizeof(warpnetEthernetPktHeader));
						memcpy((void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader), copyStruct, sizeofcopy);
						memcpy((void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader)+sizeofcopy, &(ackStruct), sizeof(warpnetAck));
						
						warpmac_prepPktToNetwork((void *)pktBuf_payloadAddr, txEthPktHeader.pktLength);
						warpmac_startPktToNetwork(txEthPktHeader.pktLength);
						processControl(controlStruct);
					}
					
					rxPktOffset += sizeof(warpnetControl);
					break;
				case STRUCTID_OBSERVE_REQUEST_NORELAY:
					requestStruct = (warpnetRequest*)(payload+rxPktOffset+sizeofcopy);
					if((requestStruct->nodeID) == myID){
						processRequest(requestStruct,&observeStruct,0);
						txEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetObserve) + sizeofcopy;
						txEthPktHeader.numStructs = 1;
						
						pktBuf_payloadAddr = warpphy_getBuffAddr(WARPNET_NODE2SVR_PKTBUFFINDEX);
						memcpy((void *)pktBuf_payloadAddr, &(txEthPktHeader), sizeof(warpnetEthernetPktHeader));
						memcpy((void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader), copyStruct, sizeofcopy);
						memcpy((void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader)+sizeofcopy, &(observeStruct), sizeof(warpnetObserve));
						
						warpmac_prepPktToNetwork((void *)pktBuf_payloadAddr, txEthPktHeader.pktLength);
						warpmac_startPktToNetwork(txEthPktHeader.pktLength);
					}
					
					rxPktOffset += sizeof(warpnetControl);
					break;
				case STRUCTID_OBSERVE_REQUEST_RELAY:
					requestStruct = (warpnetRequest*)(payload+rxPktOffset+sizeofcopy);
					if((requestStruct->nodeID) == myID){
						processRequest(requestStruct,&observeStruct,1);
						txEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetObserve) + sizeofcopy;
						txEthPktHeader.numStructs = 1;
						
						pktBuf_payloadAddr = warpphy_getBuffAddr(WARPNET_NODE2SVR_PKTBUFFINDEX);
						memcpy((void *)pktBuf_payloadAddr, &(txEthPktHeader), sizeof(warpnetEthernetPktHeader));
						memcpy((void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader), copyStruct, sizeofcopy);
						memcpy((void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader)+sizeofcopy, &(observeStruct), sizeof(warpnetObserve));
						
						warpmac_prepPktToNetwork((void *)pktBuf_payloadAddr, txEthPktHeader.pktLength);
						warpmac_startPktToNetwork(txEthPktHeader.pktLength);
					}
					
					rxPktOffset += sizeof(warpnetControl);
					break;
			}/* END switch(thisStructType) */
			
		}/* END for(numRxStructs) */
	}/* END if(warpNet packet) */
	
	return;


}

///@brief Callback for the reception of Ethernet packets
///
///This function is called by the ethernet MAC drivers
///when a packet is available to send. This function fills
///the Macframe transmit buffer with the packet and sends
///it over the OFDM link
///@param length Length, in bytes, of received Ethernet frame
void dataFromNetworkLayer_callback(Xuint32 length, char* payload){

	unsigned char rxSeqNum;
	unsigned char destNode;
	unsigned char relayNode;
	
	warpnetRTObserve rtObserve;
	warpnetControllerGroup controllerGroup;
	XTime timeStamp;
	
	XTime_GetTime(&timeStamp);

	

//	xil_printf("data from network Layer\r\n");

	//Disable any new packets until we're finished with this one
	warpmac_disableDataFromNetwork();

	warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA);
	
	//Reset the contention window to its smallest size for this exchange
	warpmac_resetCurrentCW();

	//Update the Tx pkt buffer index if we're cycling through them (for non-Ethernet traffic testing only)
	if(randomData_Mode){
		pktBuf_tx_DATA = (((pktBuf_tx_DATA+1)%25) + 4);
		warpmac_setPHYTxBuffer(pktBuf_tx_DATA);
	}


	//Define and enable the autoResponse actor for sending our retransmissions when NACKs are received
	autoResp_action_reTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_DATA, 0, autoRespDelay_ReTx, (REQ_DST_ME | REQ_NACK | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
	mimo_ofdmTxRx_setAction2(autoResp_action_reTx);

	//For now, assume our destination is our opposite ID (all traffic is 0 <-> 1)
	// and the node 2 is always our relay
	destNode = (myID+1)%2;
	
	if(alternating&&currentAlt){
		relayNode = 2;
	}
	else{
		relayNode = myID;
	}

//relayNode = 2;
	
//xil_printf("RELAY NODE%d\r\n",relayNode);

	//Increment the sequence number for this destination
	txSequences[destNode] = ( (txSequences[destNode]+1) & 0xFFFF);

	//Set this packet's remainingTx count to the maximum
	txBuffer.remainingTx = max_numTransmissions;

	//Construct the new wireless packet's header
	txBuffer.header.length = length;		//Packet length (payload only)
	txBuffer.header.pktType = DATAPACKET;	//Packet type DATA
	txBuffer.header.fullRate = pktFullRate;	//Full-rate modulation scheme
	txBuffer.header.codeRate = pktCodeRate;	//Coding rate (ignored for uncoded PHY)
	txBuffer.header.seqNum = txSequences[destNode];	//Dest node's next seqeunce number
	txBuffer.header.srcAddr = NODEID_TO_ADDR(myID);			//Source MAC address
	txBuffer.header.destAddr = NODEID_TO_ADDR(destNode);	//Destination MAC address
	txBuffer.header.relAddr = NODEID_TO_ADDR(relayNode);	//Relay MAC address

	
	//Copy the header over to the DATA Tx packet buffer
	warpmac_prepPhyForXmit(&txBuffer, pktBuf_tx_DATA);


	if(enableStats) stats_numDataTx[destNode][myID][currentAlt]++;
	currentAlt = (currentAlt+1)%2;	

	//Packet is ready for transmission
	if(warpmac_carrierSense()){
		//Medium is idle; transmit right away
		warpmac_startPhyXmit(pktBuf_tx_DATA);
		
		////CRH
		//				xil_printf("****TRANSMIT****\r\n");
		//				unsigned int test = 64;
		//				unsigned int testIndex;
						
		//				for(testIndex=0;testIndex<test;testIndex++){
		//					xil_printf("%x ",0xFF&(*((char *)warpphy_getBuffAddr(pktBuf_tx_DATA)+NUM_HEADER_BYTES+testIndex)));
		//				}
		//				xil_printf("****TRANSMIT****\r\n");
	////CRH

		//Wait for it to finish and enable the receiver
		warpmac_finishPhyXmit();
		warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA_SWAPPED);

		//Start a timeout timer
		warpmac_setTimer(TIMEOUT_TIMER);

		//Decrement the remaining resent counter
		if(txBuffer.remainingTx > 0){
			txBuffer.remainingTx = txBuffer.remainingTx - 1;
		}
	}
	
	else{
		//Medium was busy in the last DIFS period; wait a random backoff before transmitting
		warpmac_setTimer(BACKOFF_TIMER);
	}
	
	if(enableStats){
	controllerGroup.controllerID = 0;
	controllerGroup.controllerGrp = 0;
	controllerGroup.access = 1;

	rtObserve.structID = STRUCTID_RTOBSERVE;
	rtObserve.nodeID = myID;
	rtObserve.sequenceNumber = txBuffer.header.seqNum;
	rtObserve.pktType = txBuffer.header.pktType;
	rtObserve.srcNode = txBuffer.header.srcAddr;
	rtObserve.destNode = txBuffer.header.destAddr;
	rtObserve.relNode = txBuffer.header.relAddr;
	rtObserve.rssi = 0xFFFF;
	rtObserve.gain = 0xFFFF;
	rtObserve.state=0xFF;
	rtObserve.timeStampHigh = (unsigned short)((timeStamp>>32)&0xFFFF);	
	rtObserve.timeStampLow = (unsigned int)(timeStamp&0xFFFFFFFF);
	txEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetRTObserve) + sizeof(warpnetControllerGroup);
	
	int pktBuf_payloadAddr = warpphy_getBuffAddr(WARPNET_NODE2SVR_PKTBUFFINDEX);
	memcpy((void *)pktBuf_payloadAddr, &(txEthPktHeader), sizeof(warpnetEthernetPktHeader));
	memcpy((void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader), &controllerGroup, sizeof(warpnetControllerGroup));
	memcpy((void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader)+sizeof(warpnetControllerGroup), &(rtObserve), sizeof(warpnetRTObserve));
	


	//xil_printf("%d, %d, %d, %d\r\n" ,rtObserve.sequenceNumber,rtObserve.srcNode ,rtObserve.destNode ,rtObserve.relNode );
				
	warpmac_prepPktToNetwork((void *)pktBuf_payloadAddr, txEthPktHeader.pktLength);
	warpmac_startPktToNetwork(txEthPktHeader.pktLength);
	
	
	
	
	}
	
	
	return;
}

///@brief Callback for the reception of bad wireless headers
///
///@param packet Pointer to received Macframe
void phyRx_badHeader_callback() {

	
	userIOBoard_LEDs = userIOBoard_LEDs==0x80 ? 0x01 : (userIOBoard_LEDs << 1);

	if(enableStats) stats_numBadHeaderRx++;

	
    if(agcPrintMode)
	{
		agcGains = ofdm_AGC_GetGains();
		pktDet_rssi = ofdm_txrx_mimo_ReadReg_Rx_PktDet_midPktRSSI_antA();
		xil_printf("(bad)\tAGC Gains: %d %d\t%d %d\t", agcGains&0x3, (agcGains>>2)&0x1F, (agcGains>>8)&0x3, (agcGains>>10)&0x1F);
		//		xil_printf("AGC Thresholds: %d / %d / %d\t", (0xFFFFFF00 | agc_coarseThresh_1), (0xFFFFFF00 | agc_coarseThresh_2), (0xFFFFFF00 | agc_coarseThresh_3) );
        xil_printf("RSSI (ant A): %d\r\n", pktDet_rssi);
	}

	
	return;
}

///@brief Callback for the reception of good wireless headers
///
///This function then polls the PHY to determine if the entire packet passes checksum
///thereby triggering the transmission of the ACK and the transmission of the received
///data over Ethernet.
///@param packet Pointer to received Macframe
int phyRx_goodHeader_callback(Macframe* packet){

int manualClear = 0;



warpmac_setDebugGPIO(0x1,0x1);
		unsigned int currPhaseInc;
	unsigned char state=PHYRXSTATUS_INCOMPLETE;
	unsigned char srcNode,dstNode,relNode,relMode;
	unsigned char shouldSend = 0;
	warpnetRTObserve rtObserve;
	warpnetControllerGroup controllerGroup;
	XTime timeStamp;
	int i;
	shouldSend = 0;
	
	XTime_GetTime(&timeStamp);
	
	controllerGroup.controllerID = 0;
	controllerGroup.controllerGrp = 0;
	controllerGroup.access = 1;
	
	//Extract the source node ID from the packet's source address
	srcNode = ADDR_TO_NODEID(packet->header.srcAddr);
	relNode = ADDR_TO_NODEID(packet->header.relAddr);
	dstNode = ADDR_TO_NODEID(packet->header.destAddr);

	rtObserve.structID = STRUCTID_RTOBSERVE;
	rtObserve.nodeID = myID;
	rtObserve.sequenceNumber = packet->header.seqNum;
	rtObserve.pktType = packet->header.pktType;
	rtObserve.srcNode = srcNode;
	rtObserve.destNode = dstNode;
	rtObserve.relNode = relNode;
	rtObserve.rssi = ofdm_txrx_mimo_ReadReg_Rx_PktDet_midPktRSSI_antA();
	rtObserve.gain = warpphy_returnGainsDB();
	rtObserve.timeStampHigh = (unsigned short)((timeStamp>>32)&0xFFFF);	
	rtObserve.timeStampLow = (unsigned int)(timeStamp&0xFFFFFFFF);
	txEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetRTObserve) + sizeof(warpnetControllerGroup);
	

	
	int pktBuf_payloadAddr = warpphy_getBuffAddr(WARPNET_NODE2SVR_PKTBUFFINDEX);
	memcpy((void *)pktBuf_payloadAddr, &(txEthPktHeader), sizeof(warpnetEthernetPktHeader));
	memcpy((void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader), &controllerGroup, sizeof(warpnetControllerGroup));
	memcpy((void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader)+sizeof(warpnetControllerGroup), &(rtObserve), sizeof(warpnetRTObserve));
						

	
	if(relNode==2){
		relMode = 1;
	}
	else{
		relMode = 0;
	}
	
	if(enableStats) stats_sumGains[myID][srcNode][relMode] += warpphy_returnGainsDB();
	//xil_printf("GAINS = %d\r\n",warpphy_returnGainsDB());
	if(enableStats) stats_sumPacketsRx[myID][srcNode][relMode]++;
	if(enableStats)	stats_sumRSSI[myID][srcNode][relMode]+=ofdm_txrx_mimo_ReadReg_Rx_PktDet_midPktRSSI_antA();
	
	//Debug-only: print AGC values for this packet
	if(agcPrintMode)
	{
		agcGains = ofdm_AGC_GetGains();
		pktDet_rssi = ofdm_txrx_mimo_ReadReg_Rx_PktDet_midPktRSSI_antA();
		xil_printf("(good)\tAGC Gains: %d %d\t%d %d\t", agcGains&0x3, (agcGains>>2)&0x1F, (agcGains>>8)&0x3, (agcGains>>10)&0x1F);
        xil_printf("RSSI (ant A): %d\r\n", pktDet_rssi);
	}
	
	//Rotate the ring of LEDs clockwise
	userIOBoard_LEDs = userIOBoard_LEDs==0x1 ? 0x80 : (userIOBoard_LEDs >> 1);
	
	//Print the header (debug only- completely ruins actual performance)
#if 0
	xil_printf("Rx Header: ");
	for(i=0; i<24; i++)
	{
		xil_printf("%d.",*((unsigned char*)&(packet->header) + i));
	}
	xil_printf("\r\n");
#endif

	//If packet is from self, it was (hopefully) transmitted by the relay
	// Count this as a retransmission
	if(packet->header.srcAddr == ( NODEID_TO_ADDR(myID)) ) {
		switch(packet->header.pktType){
			case DATAPACKET:
				warpmac_clearTimer(TIMEOUT_TIMER);
				warpmac_clearTimer(BACKOFF_TIMER);
				warpmac_finishPhyRecv();
				warpmac_setTimer(TIMEOUT_TIMER);
				if(txBuffer.remainingTx > 0){
					txBuffer.remainingTx = txBuffer.remainingTx - 1;					
				}
			break;

			default:
				//This should never, ever happen...
			break;
		}

		//return;
	}
	
	//If the packet is addressed to this node
	if(packet->header.destAddr == ( NODEID_TO_ADDR(myID)) ) {

		switch(packet->header.pktType){
			case DATAPACKET:
				
				if((packet->header.length)>1400){
					updateLCD();
				}

				state = warpmac_finishPhyRecv();
				
				if(state&PHYRXSTATUS_GOOD){
					//Go, go autoResponder ACK!
					warpmac_incrementLEDHigh();
					
					
					//Check if the last received seq number for this partner node matches this received pkt
					// If not, record the new number and allow the pkt to be forwarded over the wire
					if(ignoreSeqNums || ( (srcNode<MAX_NUMNODES) && (rxSequences[srcNode] != (packet->header.seqNum))) ){
						rxSequences[srcNode] = (packet->header.seqNum);
						//CRH - NACK CHARACTERIZATION
							if(enableStats) stats_numDataRx[packet->header.destAddr][packet->header.srcAddr][relMode]++;
						//CHR
						//shouldSend = 1;
					}
					

					
					////
					//warp_userioboard_buzzer_set(PERHIGH, DUTYHIGH);
					//warp_userioboard_set_buzzer_en(1&buzzerEnable);
					//warpmac_setTimer(BUZZER_TIMER);
					////
					
					//Update the right-hex display with the current resend count for the received pkt
					warpmac_leftHex(0xF & (packet->header.seqNum));
					
					//Starts the DMA transfer of the payload into the EMAC
					if(shouldSend)
					{

						warpmac_prepPktToNetwork((void *)warpphy_getBuffAddr(pktBuf_rx)+NUM_HEADER_BYTES, (packet->header.length));
						
						
					//	xil_printf("****RECEIVE**\r\n");
					//	unsigned int test = 64;
					//	unsigned int testIndex;
						
					//	for(testIndex=0;testIndex<test;testIndex++){
					//		xil_printf("%x ",0xFF&(*((char *)warpphy_getBuffAddr(pktBuf_rx)+NUM_HEADER_BYTES+testIndex)));
					//	}
					//	xil_printf("****RECEIVE****\r\n");
						
						warpmac_finishPhyXmit();//? needed?
						warpmac_startPktToNetwork(packet->header.length);
						


						
					}
					
				}
				
				if(state&PHYRXSTATUS_BAD){
				warpmac_incrementLEDLow();
					//Go, go autoReponder NACK!
					//CRH - NACK CHARACTERIZATION
					if(enableStats) stats_numNACKTx[packet->header.srcAddr][myID][relMode]++;
					//CHR
					
					////

					//warp_userioboard_buzzer_set(PERLOW, DUTYLOW);
					//warp_userioboard_set_buzzer_en(1&buzzerEnable);
					//warpmac_setTimer(BUZZER_TIMER);
					////


					
					
					//Rotate the ring of LEDs counter-clockwise
					userIOBoard_LEDs = userIOBoard_LEDs==0x80 ? 0x01 : (userIOBoard_LEDs << 1);
					
				}
			
			break;//END DATAPACKET
				
			case ACKPACKET:
				pktCount_good++;


				//Clear the timeout timer, set when we transmitted the data packet
				warpmac_clearTimer(TIMEOUT_TIMER);

				//Clear the backoff timer; this handles the case of receiving an ACK for a forwarded DATA packet
				warpmac_clearTimer(BACKOFF_TIMER);

				//Clear the remaining transmit count to assure this packet won't be re-transmitted
				txBuffer.remainingTx = 0;

				//Start a backoff, to gaurantee a random time before attempting to transmit again
				warpmac_setTimer(BACKOFF_TIMER);

			break;//END ACKPACKET
				
			case NACKPACKET:
				
				if(warpmac_inTimeout())
				{

				//CRH - NACK CHARACTERIZATION
				if(enableStats) stats_numNACKRx[packet->header.destAddr][packet->header.srcAddr][relMode]++;
				//CHR
				
					//Go, go autoResponder DATA reTx (if it's still enabled)!



					//Clear the timeout timer, set when we transmitted the data packet
					warpmac_clearTimer(TIMEOUT_TIMER);

					if(txBuffer.remainingTx == 0)
					{
						//No more re-transmits; start a backoff, to gaurantee a random time before attempting to transmit a new data packet
						warpmac_setTimer(BACKOFF_TIMER);
					}
					else if(txBuffer.remainingTx == 1)
					{
						//Decrement the remaining transmit count
						txBuffer.remainingTx = txBuffer.remainingTx - 1;
						
						//Disable the autoResponder for data re-transmissions (it already started its last transmission)
						autoResp_action_reTx = 0;
						mimo_ofdmTxRx_setAction2(autoResp_action_reTx);

						//Wait for the transmission to finish the autoRepsonse trigger re-trasnmit
						warpmac_finishPhyXmit();

						//Start a timeout, waiting for a ACK/NACK
						warpmac_setTimer(TIMEOUT_TIMER);

						
					}
					else//remainingTx > 1
					{
						//Decrement the remaining transmit count
						txBuffer.remainingTx = txBuffer.remainingTx - 1;
						
						//Wait for the transmission to finish the autoRepsonse trigger re-trasnmit
						warpmac_finishPhyXmit();
						
						//Start a timeout, waiting for a ACK/NACK
						warpmac_setTimer(TIMEOUT_TIMER);

						
					}
				}
				else if(warpmac_inBackoff())
				{
					//Covers case where we missed a NACK and missed the relay's re-transmission but heard the terminal NACK
					warpmac_clearTimer(TIMEOUT_TIMER);
					warpmac_clearTimer(BACKOFF_TIMER);
					if(txBuffer.remainingTx > 0)
					{
						txBuffer.remainingTx = txBuffer.remainingTx - 1;
					}
					warpmac_setTimer(BACKOFF_TIMER);
				}
				else
				{
						//warp_userioboard_set_buzzer_en(1);
				}
			break;//END NACKPACKET
		}

		//return;
	}//END dstAddr == self

	//Relay address matches this node
	if(packet->header.relAddr == ( NODEID_TO_ADDR(myID)) ) {

		switch(packet->header.pktType){
			//If received packet is data
			case DATAPACKET:
			
//				warpmac_setDebugGPIO(0xF);

warpmac_setDebugGPIO(0x4,0x4);

				state = warpmac_finishPhyRecv();
//					warpmac_setDebugGPIO(0x0);	
	
				if((state&PHYRXSTATUS_GOOD)&&allowRelay){
warpmac_incrementLEDHigh();
			
//		if(enableStats) stats_numDataRx[myID][packet->header.srcAddr][relMode]++;
					//We can cooperate on this packet
					relayMode = 1;
					
					//Define and enable the cooperative autoResponse transmitter
					//Flag A will already be set (that actor is always enabled)
					

						//autoResp_action_coopTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_rx, PHY_AUTORESPONSE_ACT_USE_PRECFO, autoRespDelay_AFTx, (REQ_RLY_ME | REQ_NACK | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT | PHY_AUTORESPONSE_REQ_FLAGA));
						autoResp_action_coopTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_AF, 0, autoRespDelay_AFTx, (REQ_RLY_ME | REQ_NACK | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT | PHY_AUTORESPONSE_REQ_FLAGA));
						mimo_ofdmTxRx_setAction4(autoResp_action_coopTx);


					
					//AF recording must be disabled *after* the good pkt interrupt goes high
					// Doing it before will prevent the AF system from knowing when the incoming packet actually stopped
		
					warpphy_AFrecordEnable(0);
					
					//Increment the Rx packet buffer, to preserve the received data packet
					pktBuf_rx_ind = ((pktBuf_rx_ind + 1) % NUM_RX_PKTBUFS);
					pktBuf_rx = rxPktBufs[pktBuf_rx_ind];
                    
					//warpphy_setBuffs(pktBuf_tx_DATA, pktBuf_rx);
					warpmac_setRxBuffers(&rxBuffer, pktBuf_rx);
						
					
					warpphy_clearRxPktStatus();
					manualClear = 1;
					
					relayDestID = ADDR_TO_NODEID(packet->header.destAddr);
					relayLen = packet->header.length;
					//Finally, start a timeout, waiting for a ACK/NACK
					warpmac_clearTimer(TIMEOUT_TIMER);
					warpmac_setTimer(TIMEOUT_TIMER);
					
					////
				//warp_userioboard_buzzer_set(PERHIGH, DUTYHIGH);
				//warp_userioboard_set_buzzer_en(1&buzzerEnable);
				//warpmac_setTimer(BUZZER_TIMER);
					////
					
					return;
					//DEBUG print

				}

				if(state&PHYRXSTATUS_BAD){
				warpmac_incrementLEDLow();
									////
				//warp_userioboard_buzzer_set(PERLOW, DUTYLOW);
				//warp_userioboard_set_buzzer_en(1&buzzerEnable);
				//warpmac_setTimer(BUZZER_TIMER);

					////
					//Let the timeout handler reset things (like restarting AF capture, disabling coop autoResponse, etc.
				}
			
					
			break;//END DATAPACKET

			case NACKPACKET:
				if(enableStats) stats_numNACKRx[myID][packet->header.srcAddr][relMode]++;
			

				
									////
					//warp_userioboard_buzzer_set(PERLOW, DUTYLOW);
					//warp_userioboard_set_buzzer_en(1&buzzerEnable);
					//warpmac_setTimer(BUZZER_TIMER);

					////
					
				if(relayMode) {


				
					if(enableStats) if(enableStats) stats_numDataTx[packet->header.srcAddr][myID][relMode]++;
//CRH ADDME					if(enableStats) stats_numDataTx[][]++;
					
					

					//Go, go autoRepsonder AF Tx!

					
					
//					warpmac_setDebugGPIO(0xF);

					//Clear the timeout (started when we recevied the DATA packet)
					warpmac_clearTimer(TIMEOUT_TIMER);
					
					//Wait for the autoResponse transmission to finish
					warpmac_finishPhyXmit();

//					warpmac_setDebugGPIO(0x0);
					//Restart capturing the AF waveform, now that we've sent the good one we had
					//warpmac_setDebugGPIO(0xF);
					warpphy_AFrecordEnable(1);

					//Disable the cooperative autoResponse transmitter
					autoResp_action_coopTx = 0;
					mimo_ofdmTxRx_setAction4(autoResp_action_coopTx);
					
		

					
					
					relayMode = 0;
				}
				else{
				
				}
			break;//END NACKPACKET

			case ACKPACKET:
				//Clear the timeout (started when we recevied the DATA packet)
				warpmac_clearTimer(TIMEOUT_TIMER);

				//Restart capturing the AF waveform, now that we've sent the good one we had
				//warpmac_setDebugGPIO(0xF);
				warpphy_AFrecordEnable(1);
				
				//Disable the cooperative autoResponse transmitter
				autoResp_action_coopTx = 0;
				mimo_ofdmTxRx_setAction4(autoResp_action_coopTx);
				
	

		
				
				
				relayMode = 0;
			break;//END ACKPACKET
		}
	//	return;
	}
	
	
	
	if(enableStats){
	//	xil_printf("%d,%d,%d,%d\r\n",rtObserve.sequenceNumber,rtObserve.srcNode,rtObserve.destNode,rtObserve.relNode);
	
				
				unsigned char* stateAddr = (void *)pktBuf_payloadAddr+sizeof(warpnetEthernetPktHeader)+sizeof(warpnetControllerGroup) + 8;
				*stateAddr = warpmac_finishPhyRecv();
				
				warpmac_prepPktToNetwork((void *)pktBuf_payloadAddr, txEthPktHeader.pktLength);
				warpmac_startPktToNetwork(txEthPktHeader.pktLength);

	}
	
	return manualClear;

}

///@brief Main function
///
///This function configures MAC parameters, enables the underlying frameworks, and then loops forever.
int main(){		
	
	//Initialize global variables
	cfoVar = 38;
	currentAnt = 0;
	chan = 4;

	agcPrintMode = 0;
	randomData_Mode = 0;
	
	pktCount_good = 0;
	pktCount_bad = 0;

	//Not a relay by default
	relayMode = 0;

	
	debug_sisoMode = 0;
    ignoreSeqNums = 0;
    
        
	txPower = 0x3f;
	
	//Set the full-rate modulation to QPSK by default
//	pktFullRate = HDR_FULLRATE_QPSK;
	pktFullRate = HDR_FULLRATE_QAM_16;
	
	//Set the payload coding rate to NONE by default
	//Note: Reference Design 12 PHY does not provide channel coding
	pktCodeRate = CODE_RATE_NONE;
	
	//Initialize the framework
	warpmac_init();
	max_numTransmissions = 2;
	warpmac_setMaxResend(max_numTransmissions);
	warpmac_setMaxCW(5);

	//Select single-antenna Alamouti mode for both Tx and Rx
	if(debug_sisoMode)
	//	warpphy_setAntennaMode(TX_ANTMODE_SISO_ANTA, RX_ANTMODE_SISO_ANTA);
	warpphy_setAntennaMode(TX_ANTMODE_ALAMOUTI_2ANT, RX_ANTMODE_ALAMOUTI_ANTA);
	else
		warpphy_setAntennaMode(TX_ANTMODE_ALAMOUTI_ANTA, RX_ANTMODE_ALAMOUTI_ANTA);

	warpmac_setTimeout(140); //100
	warpmac_setSlotTime(22); //9 20
	
	//Read Dip Switch value from FPGA board.
	//This value will be used as an index into the routing table for other nodes
	myID = (unsigned short int)warpmac_getMyId();
	warpmac_leftHex(myID);
	//Define the available Rx pkt buffers (1 and 2 act as Ping and Pong for now)
	rxPktBufs[0] = 1;
	rxPktBufs[1] = 2;
	pktBuf_rx_ind = 0;

	pktBuf_rx = rxPktBufs[pktBuf_rx_ind];
	pktBuf_rx_emac = 3;
	pktBuf_tx_DATA = 4;
	pktBuf_tx_ACK = 29;
	pktBuf_tx_NACK = 30;
	pktBuf_tx_AF = 31;

	cfoDly = 16;
	antB_preambleShift = 3;

	autoRespDelay_NACKTx = 2; //100
	autoRespDelay_AFTx = 2;
	autoRespDelay_ReTx = 2;
	autoRespDelay_ACKTx = 0;
	
	rx_correThresh = 1400;
	

	
	//Rx buffer is where the EMAC will DMA Wireless payloads from
	warpmac_setRxBuffers(&rxBuffer, pktBuf_rx);
	//Tx buffer is where the EMAC will DMA Ethernet payloads to
	warpmac_setPHYTxBuffer(pktBuf_tx_DATA);
	warpmac_setEMACRxBuffer(pktBuf_rx_emac);//VERY VERY IMPORTANT
	
	//Copy this node's MAC address into the Tx buffer's source address field
	txBuffer.header.srcAddr = (unsigned short int)( NODEID_TO_ADDR(myID) );
	
	//Register callbacks

	
	warpmac_setCallback(EVENT_PHYGOODHEADER, (void *)phyRx_goodHeader_callback);
	warpmac_setCallback(EVENT_PHYBADHEADER, (void *)phyRx_badHeader_callback);
	warpmac_setCallback(EVENT_MGMTPKT, (void *)mgmtFromNetworkLayer_callback);
	warpmac_setCallback(EVENT_DATAFROMNETWORK, (void *)dataFromNetworkLayer_callback);
	warpmac_setCallback(EVENT_UARTRX, (void *)uartRecv_callback);
	warpmac_setCallback(EVENT_TIMER, (void *)timer_callback);
	
	warpmac_setCallback(EVENT_UPBUTTON, (void *)up);
	warpmac_setCallback(EVENT_MIDDLEBUTTON, (void *)middle);
	warpmac_setCallback(EVENT_LEFTBUTTON, (void *)left);
	warpmac_setCallback(EVENT_RIGHTBUTTON, (void *)right);
	
	//Configure a buzzer tone, to be enabled on odd error conditions
//	warp_userioboard_buzzer_set(40000, 13107);

	userIOBoard_LEDs = 1;
	//Initialize the LCD for slot 1 (i.e. don't flip the image) and non-inverted colors
	warp_userioboard_lcd_init(1, 0);
	warp_userioboard_set_lcd_charbuf(1);
	
	//Print some static lines to the user I/O board LCD
	//snprintf(charsToPrint, 16, " Ref Design v12 ", pktCount_bad);
	warp_userio_lcd_printline("RefDesign v14", 16, 1, 1);
	//snprintf(charsToPrint, 16, "  Rx Pkt Counts", pktCount_bad);
	warp_userio_lcd_printline("  Rx Pkt Counts ", 16, 3, 1);
	
	//Set the user I/O board LEDs
	warp_userioboard_set_leds(userIOBoard_LEDs);
	
	//Set the default center frequency
	warpphy_setChannel(GHZ_2, chan);
	
	//Enable carrier sensing
	warpmac_setCSMA(1);

/*****************************************/
/******** START autoResponse setup *******/
/*****************************************/

	/*****************************************/
	//Header Match Unit Setup
	/*****************************************/
	// 0: Destination address == self
	// 1: Relay address == self
	// 2: Packet type == DATAPACKET
	// 3: Packet type == NACK
	
	//Match condition 0: received header's destination address is me
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_DSTADDR, 2, htons(NODEID_TO_ADDR(myID)));
	mimo_ofdmTxRx_setMatch0(autoResp_matchCond);

	//Match condition 1: received header's relay address is me
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_RLYADDR, 2, htons(NODEID_TO_ADDR(myID)));
	mimo_ofdmTxRx_setMatch1(autoResp_matchCond);
	
	//Match condition 2: packet type is data
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_TYPE, 1, DATAPACKET);
	mimo_ofdmTxRx_setMatch2(autoResp_matchCond);
	
	//Match condition 3: packet type is NACK
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_TYPE, 1, NACKPACKET);
	mimo_ofdmTxRx_setMatch3(autoResp_matchCond);

	/*****************************************/
	//Header translation setup
	/*****************************************/
	
	//Configure the header translator to use the Rx pkt's src address as the outgoing pkt's dst address
	// Addresses are two bytes, so two entries in the header translator need to be overridden
	// Except for these bytes, the ACK/NACK pktBuf's contents will be sent unaltered
	// Macro is PHY_HEADERTRANSLATE_SET(templatePktBuf, byteAddrToOverwrite, srcPktBuf, srcByteAddr)
	PHY_HEADERTRANSLATE_SET(pktBuf_tx_ACK, (PKTHEADER_INDX_DSTADDR+0), pktBuf_rx, (PKTHEADER_INDX_SRCADDR+0));
	PHY_HEADERTRANSLATE_SET(pktBuf_tx_ACK, (PKTHEADER_INDX_DSTADDR+1), pktBuf_rx, (PKTHEADER_INDX_SRCADDR+1));
	PHY_HEADERTRANSLATE_SET(pktBuf_tx_ACK, (PKTHEADER_INDX_RLYADDR+0), pktBuf_rx, (PKTHEADER_INDX_RLYADDR+0));
	PHY_HEADERTRANSLATE_SET(pktBuf_tx_ACK, (PKTHEADER_INDX_RLYADDR+1), pktBuf_rx, (PKTHEADER_INDX_RLYADDR+1));
	PHY_HEADERTRANSLATE_SET(pktBuf_tx_NACK, (PKTHEADER_INDX_DSTADDR+0), pktBuf_rx, (PKTHEADER_INDX_SRCADDR+0));
	PHY_HEADERTRANSLATE_SET(pktBuf_tx_NACK, (PKTHEADER_INDX_DSTADDR+1), pktBuf_rx, (PKTHEADER_INDX_SRCADDR+1));
	PHY_HEADERTRANSLATE_SET(pktBuf_tx_NACK, (PKTHEADER_INDX_RLYADDR+0), pktBuf_rx, (PKTHEADER_INDX_RLYADDR+0));
	PHY_HEADERTRANSLATE_SET(pktBuf_tx_NACK, (PKTHEADER_INDX_RLYADDR+1), pktBuf_rx, (PKTHEADER_INDX_RLYADDR+1));

	//Create a template ACK packet
	templatePkt.header.fullRate = pktFullRate;
	templatePkt.header.codeRate = pktCodeRate;
	templatePkt.header.length = 0;
	templatePkt.header.srcAddr = (unsigned short)(NODEID_TO_ADDR(myID));
	templatePkt.header.pktType = ACKPACKET;
	
	//Copy the header down to the PHY's packet buffer
	// This doesn't actually send anything; the autoResponse system will use this template when sending ACKs
	warpmac_prepPhyForXmit(&templatePkt, pktBuf_tx_ACK);

	//Create a template NACK packet
	templatePkt.header.fullRate = pktFullRate;
	templatePkt.header.codeRate = pktCodeRate;
	templatePkt.header.length = 0;
	templatePkt.header.srcAddr = (unsigned short)(NODEID_TO_ADDR(myID));
	templatePkt.header.pktType = NACKPACKET;
	
	//Copy the header down to the PHY's packet buffer
	// This doesn't actually send anything; the autoResponse system will use this template when sending ACKs
	warpmac_prepPhyForXmit(&templatePkt, pktBuf_tx_NACK);
	
	/*****************************************/
	//Actions setup
	// Action definitions come last; bad things might happen if an action is enabled before the template pkt is ready
	/*****************************************/
	//Actors:
	// 0: ACK transmission for good header, good payload DATA
	// 1: NACK transmission for good header, bad payload DATA
	// 2: DATA retransmisson from source
	// 3: SetFlagA at relay
	// 4: AF retransmission from relay
	
	autoResp_action = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_ACK, PHY_AUTORESPONSE_ACT_TRANS_HDR, autoRespDelay_ACKTx, (REQ_DST_ME | REQ_DATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
	mimo_ofdmTxRx_setAction0(autoResp_action);
//	mimo_ofdmTxRx_setAction0(0); //Use this to disable ACKs
	
	autoResp_action = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_NACK, PHY_AUTORESPONSE_ACT_TRANS_HDR, autoRespDelay_NACKTx, (REQ_DST_ME | REQ_DATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_BADPKT));
//	autoResp_action = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_NACK, PHY_AUTORESPONSE_ACT_TRANS_HDR, autoRespDelay_NACKTx, (REQ_DST_ME | REQ_DATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT)); //Use for NACKs in place of ACKs
	mimo_ofdmTxRx_setAction1(autoResp_action);
	
//	autoResp_action_reTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_DATA, 0, autoRespDelay_ReTx, (REQ_DST_ME | REQ_NACK | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
//	mimo_ofdmTxRx_setAction2(autoResp_action_reTx);
	
	autoResp_action = PHY_AUTORESPONSE_ACTION_SETFLAGA_CONFIG((REQ_RLY_ME | REQ_DATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
	mimo_ofdmTxRx_setAction3(autoResp_action);
	
//	autoResp_action_coopTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_AF, 0, autoRespDelay_AFTx, (REQ_RLY_ME | REQ_NACK | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT | PHY_AUTORESPONSE_REQ_FLAGA));
//	autoResp_action_coopTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_rx, 0, autoRespDelay_AFTx, (REQ_RLY_ME | REQ_NACK | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT | PHY_AUTORESPONSE_REQ_FLAGA));
//	mimo_ofdmTxRx_setAction4(autoResp_action_coopTx);
	
/*****************************************/
/******** END autoResponse setup *******/
/*****************************************/
	
	//Enable local packet generation (ignoring Ethernet)
	warpmac_setDummyPacketMode(1);
	
	//Listen for new packets to send (either from Ethernet or local dummy packets)
	warpmac_enableDataFromNetwork();
	
	//Set the modulation scheme use for base rate (header) symbols
//	warpmac_setBaseRate(QPSK);
	warpmac_setBaseRate(BPSK);
	
	XTime rand_time;
	XTime_GetTime(&rand_time);
	
	//Seed Random Number Generator
	srand(myID ^ ((int) rand_time) ^ WarpRadio_v1_RSSIData(RADIO2_ADDR));
	
	
	unsigned int pktBuf_payloadAddr;
	
	
	
	
	xil_printf("Reference Design v15.04 DOCMAC\r\n");
	xil_printf("Beginning main loop\r\n");
	
	
	//////
	ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) & ~(COARSE_CFO_EN));
	xil_printf("Coarse CFO Disabled\r\n");

	//mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() | BYPASS_CARR_REC, DEFAULT_STATUSBITS);
	//xil_printf("Carrier Rec Bypass\r\n");

	//////
	int i,j;
	////Load Up Random Data into Pkt Buffers 3-28////
	for (i=3; i<=28; i++) {
		unsigned char* byteLoc = (unsigned char*)warpphy_getBuffAddr(i);
		for (j=0; j<2000; j++) {
			*(byteLoc+j) = (unsigned char)(rand()&0xFF);
		}
	}
	/////////////////////////////////////////////////
	
	//Hard-code which nodes send which Alamouti streams - relay always sense stream B
	if(myID == 0 || myID == 1)
		warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA);
	else if(myID == 2)
		warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA); //CRH
	
	//if(myID == 0)
	//{
	//Be the source
	//	warpmac_startPacketGeneration(1300, 1500); //900,1500
	//}
	
	respondToNacks = 1;
	buzzerEnable = 0;
	
	docPreambleScaling=2480;
	docPayloadScaling=9792;
	mimo_ofdmTx_setTxScaling(docPreambleScaling,docPayloadScaling);
	warpphy_setAntBPreambleShift(antB_preambleShift);
	
	warpphy_setTxPower(txPower);
	
	
	//WARPnet configuration
	txEthPktHeader.ethType = WARPNET_ETHTYPE_NODE2SVR;
	txEthPktHeader.srcAddr[0]=0x00;
	txEthPktHeader.srcAddr[1]=0x50;
	txEthPktHeader.srcAddr[2]=0xC2;
	txEthPktHeader.srcAddr[3]=0x63;
	txEthPktHeader.srcAddr[4]=0x3F;
	txEthPktHeader.srcAddr[5]=0x80+myID;
	//HARDCODED TO MACBOOK!!
	txEthPktHeader.dstAddr[0]=0x00;
	txEthPktHeader.dstAddr[1]=0x50;
	txEthPktHeader.dstAddr[2]=0xc2;
	txEthPktHeader.dstAddr[3]=0x63;
	txEthPktHeader.dstAddr[4]=0x3f;
	txEthPktHeader.dstAddr[5]=0xef;	

	sleep(8);
	unsigned char ethernetAddr[] = {0x00,0x50,0xC2,0x63,0x3F,0x80+myID};
	warpnet_setMacAddr((void*)&ethernetAddr);
	warpnet_sendGratuitousArp(myID);

	///////
	
	allowRelay = 0;
	alternating = 0;
//	if(myID==0) warpmac_startPacketGeneration(1300, 10000);

warpphy_AFrecordEnable(0);
warpphy_AFrecordEnable(1);
	
	while(1){
		warpmac_pollPeripherals();		
	}
	
	return;
}
