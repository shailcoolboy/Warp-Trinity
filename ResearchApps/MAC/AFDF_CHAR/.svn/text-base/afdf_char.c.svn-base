/*! \file afdf_char.c
 \brief Top-level "MAC" for characterizing AF and DF PHY performance
 
 @version 15.22
 @author Patrick Murphy
*/

#include "xparameters.h"
#include "warpnet.h"
#include "warpmac.h"
#include "warpphy.h"
#include "afdf_char.h"
#include "string.h"
#include "stdlib.h"
#include "stdio.h"
#include "xtime_l.h"

//Lower level includes, for debug/development
#include "ofdm_txrx_mimo_regMacros.h"
#include "ofdm_agc_mimo_regMacros.h"
#include "warp_timer_regMacros.h"
#include "radio_controller_basic.h"
#include "radio_controller_ext.h"
#include "radio_controller_adv.h"
#include "radio_controller_5ghz.h"
#include "ascii_characters.h"

#define AF_ONLY 0
#define DF_ONLY 0

//Node IDs
#define ID_SRC 0
#define ID_DST 1
#define ID_RLY 2

//Packet types
#define PKTTYPE_NCDATA 0x00
#define PKTTYPE_DFDATA 0xEE
#define PKTTYPE_AFDATA 0x55
#define PKTTYPE_AFGHDATA 0xC3
#define PKTTYPE_DFGHDATA 0x3C
#define PKTTYPE_NCMHOPDATA 0xA2

#define PKTTYPE_INVALID 0x88

unsigned char pktTypesToTx[6];
unsigned char numPktTypes;

//Match unit assignments
//#define REQ_DST_ME	PHY_AUTORESPONSE_REQ_MATCH0
#define REQ_RLY_ME	PHY_AUTORESPONSE_REQ_MATCH0
#define REQ_DFDATA	PHY_AUTORESPONSE_REQ_MATCH1
#define REQ_AFDATA	PHY_AUTORESPONSE_REQ_MATCH2
#define REQ_AFGHDATA	PHY_AUTORESPONSE_REQ_MATCH3
#define REQ_DFGHDATA	PHY_AUTORESPONSE_REQ_MATCH4
#define REQ_NCMHOPDATA	PHY_AUTORESPONSE_REQ_MATCH5

int myID;
unsigned char chan;
unsigned int pktFullRate;
unsigned int pktCodeRate;
unsigned int pktGen_length, pktGen_period;

unsigned char nonCoopTesting;
unsigned char coopTesting;

unsigned int autoResp_matchCond;
unsigned int autoResp_action;
unsigned int autoResp_action_relayTx;

unsigned char pktBuf_rx;
unsigned char pktBuf_tx_DATA;
unsigned char pktBuf_emac_rx;
unsigned char pktBuf_tx_AF;

unsigned char autoRespDelay_SrcReTx;
unsigned char autoRespDelay_RlyTx_DF;
unsigned char autoRespDelay_RlyTx_AF;
unsigned char pktDetBypass_txStartDly;

unsigned char txPower;

unsigned int preambleScaling;
unsigned int payloadScaling;
signed char agcTargetPwr;

unsigned short pktDet_corrThresh;
//unsigned char pktDet_corrWindowStart;
//unsigned char pktDet_corrWindowEnd;
//unsigned short longCorrCounterLoad;

unsigned int afScaling;

unsigned char reportCFOviaWarpnet;
unsigned char reportBERviaWarpnet;
unsigned char doRxPHYdump;

unsigned char FFT_offset;
unsigned int energyThresh;
unsigned int agcThresholds;

unsigned int agc_iirCoef_g, agc_iirCoef_fb;

warpnetObservePER perStruct_NC;
warpnetObservePER perStruct_DF;
warpnetObservePER perStruct_AF;
warpnetObservePER perStruct_AFGH;
warpnetObservePER perStruct_DFGH;
warpnetObservePER perStruct_NCMHOP;
warpnetObservePER perStruct_Other;

warpnetRxPHYdump rxPHYdumpStruct;

warpnetControllerGroup groupStruct;

Macframe rxFrame;
Macframe txFrame;

warpnetEthernetPktHeader txEthPktHeader;
warpnetEthernetPktHeader coprocEthPktHeader;
warpnetEthernetPktHeader coprocEthPktHeader;

unsigned char curPktType;
unsigned char curPktTypeInd;

unsigned short int txSequences[3];

void dataFromNetworkLayer_callback(Xuint32 length, char* payload)
{
	if(myID != ID_SRC)
	{	
		//Shouldn't happen; destination node won't start dummy pkt generation
		warpmac_waitForDMA();
		return;
	}

	void* txPktPtr;
	
	//Add to DF/AF cases to test coop-mhop
	//mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & ~(TX_AUTO_TWOTX_EN));
	
	if(coopTesting) {
		curPktTypeInd = (curPktTypeInd+1) % numPktTypes;
		curPktType = pktTypesToTx[curPktTypeInd];
		
		if(curPktType == PKTTYPE_NCDATA) perStruct_NC.numPkts_tx++;
		else if(curPktType == PKTTYPE_DFDATA) perStruct_DF.numPkts_tx++;
		else if(curPktType == PKTTYPE_AFDATA) perStruct_AF.numPkts_tx++;
		else if(curPktType == PKTTYPE_AFGHDATA) perStruct_AFGH.numPkts_tx++;
		else if(curPktType == PKTTYPE_DFGHDATA) perStruct_DFGH.numPkts_tx++;
		else if(curPktType == PKTTYPE_NCMHOPDATA) {
			perStruct_NCMHOP.numPkts_tx++;
			//Turn off two-Tx mode (gets re-enabled at end of this function)
			mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & ~(TX_AUTO_TWOTX_EN));
		}
	} else {
		curPktType = PKTTYPE_NCDATA;
		perStruct_NC.numPkts_tx++;
	}

	//Increment the sequence number
	//if(curPktType == PKTTYPE_NCDATA) {
	if(curPktTypeInd == 0) {
		//Only increment on the first packet of a cycle; this way NC/AF/DF all have same seq number, making log-file-parsing easier
		txSequences[ID_DST] = ( (txSequences[ID_DST]+1) & 0xFFFF);
	}

	//Set the length field in the header
	txFrame.header.length = length;

	//Set the modulation scheme for the packet's full-rate symbols
	txFrame.header.pktType = curPktType;
	txFrame.header.srcAddr = (unsigned short int)(NODEID_TO_ADDR(ID_SRC));
	txFrame.header.destAddr = (unsigned short int)(NODEID_TO_ADDR(ID_DST));
	txFrame.header.relAddr = (unsigned short int)(NODEID_TO_ADDR(ID_RLY));
	txFrame.header.fullRate = pktFullRate;
	txFrame.header.codeRate = pktCodeRate;
	txFrame.header.seqNum = txSequences[ID_DST];

	//Copy the header over to Tx packet buffer
	warpmac_prepPhyForXmit(&txFrame, pktBuf_tx_DATA);
	
	//Transmit the packet
	if(coopTesting) {
		//Configure the antenna mode (normal in slot1, swapped in slot2)
		warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA);
//		warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA_SWAPPED);

		//Disable the TxStart output going to the destination
		mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | (TX_START_D0_OUT_EN));
		mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & ~(TX_START_D1_OUT_EN));

		//Set the cyclic shift to 0
		mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & ~(0x3F00000));

		//Assert the dst node's pktDetReset for slot 1
		warpmac_setDebugGPIO(0x4, 0xF);
	}

	warpmac_startPhyXmit(pktBuf_tx_DATA);

	if(coopTesting) {
		usleep(20);

		mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & ~(TX_START_D0_OUT_EN));
		mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | (TX_START_D1_OUT_EN));}

	//Wait for it to finish
	warpmac_finishPhyXmit();

	if(coopTesting) {
		usleep(8); //leave enough time for all the energy to get through the emulator, to avoid false pkt det at dest at end of slot 1
		if(curPktType != PKTTYPE_NCDATA) {
			warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA_SWAPPED);
	//		warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA);
		}

		warpmac_setDebugGPIO(0x0, 0xF);

		//Wait long enough for the relay to finish receiving slot1
		usleep(autoRespDelay_SrcReTx/10);

		//Assert the relay's pktDet reset for slot2; this needs to happen before the relay's long correlation asserts
		warpmac_setDebugGPIO(0x2, 0xF);
		
		//PHY will start transmitting again automatically; wait for it to finish
		usleep(4);
		warpmac_finishPhyXmit();

		//Keep relay pkt det reset long enough to avoid bogus detection at end of slot 2
		usleep(10);
		warpmac_setDebugGPIO(0x0, 0xF);

		//Turn two-Tx mode back on (might have been disabled for NCMHOP)
		mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | (TX_AUTO_TWOTX_EN));
	}
	
	
	if(reportBERviaWarpnet) {
		//Send a copy of the just-transmitted packet to the BER calculating app
		//BER packets are built from:
		// Ethernet header [0:15]
		// MAC/PHY header [0:23] generated above
		// Actual transmitted payload (randomly generated and recorded in the PHY) [0:length-1]

		coprocEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(phyHeader) + length;
		coprocEthPktHeader.ethType = WARPNET_ETHTYPE_NODE2BER; 

		txPktPtr = (void *)warpphy_getBuffAddr(WARPNET_NODE2COPROC_PKTBUFFINDEX);
		memcpy(txPktPtr, &(coprocEthPktHeader), sizeof(warpnetEthernetPktHeader));
		txPktPtr += sizeof(warpnetEthernetPktHeader);
		memcpy(txPktPtr, (void*)&(txFrame.header), sizeof(phyHeader));
		txPktPtr += sizeof(phyHeader);
		
		memcpy(txPktPtr, (void *)(warpphy_getBuffAddr(pktBuf_tx_DATA)+sizeof(phyHeader)), length);

		warpmac_prepPktToNetwork((void *)warpphy_getBuffAddr(WARPNET_NODE2COPROC_PKTBUFFINDEX), coprocEthPktHeader.pktLength);
		warpmac_startPktToNetwork(coprocEthPktHeader.pktLength);
	}
	return;
}

///@brief Callback for the reception of bad wireless headers
///
///@param packet Pointer to received Macframe
void phyRx_badHeader_callback() {
	unsigned char tmp_pktType;

	warpmac_incrementLEDLow();
	tmp_pktType = * ( (unsigned char *)(warpphy_getBuffAddr(pktBuf_rx) + PKTHEADER_INDX_TYPE));
	
	//Trust the packet type field if it's one of the three valid values; otherwise set it to an invalid value before dumping
	switch(tmp_pktType) {
		case PKTTYPE_AFDATA:
			perStruct_AF.numPkts_rx_badHdr++;
			break;
		case PKTTYPE_AFGHDATA:
			perStruct_AFGH.numPkts_rx_badHdr++;
			break;
		case PKTTYPE_DFGHDATA:
			perStruct_DFGH.numPkts_rx_badHdr++;
			break;
		case PKTTYPE_DFDATA:
			perStruct_DF.numPkts_rx_badHdr++;
			break;
		case PKTTYPE_NCMHOPDATA:
			perStruct_NCMHOP.numPkts_rx_badHdr++;
			break;
		case PKTTYPE_NCDATA:
			perStruct_NC.numPkts_rx_badHdr++;
			break;
		default:
			//Can't trust the type field; set the reported value to a known-invalid value
			perStruct_Other.numPkts_rx_badHdr++;
			tmp_pktType = PKTTYPE_INVALID;
			break;
	}
			
	if(doRxPHYdump) {
		Send_RxPHYdump(1, 1, 1, 1, tmp_pktType, 0);
	}

	return;
}


///@brief Callback for the reception of good wireless headers
///
///This function then polls the PHY to determine if the entire packet passes checksum
///thereby triggering the transmission of the received data over Ethernet.
///@param packet Pointer to received Macframe
int phyRx_goodHeader_callback(Macframe* packet)
{
	int i;
	unsigned char state = PHYRXSTATUS_INCOMPLETE;
	
	void* txPktPtr;

	unsigned char rxPktType;
	
	warpnetCFO cfoStruct;
	
	unsigned char* hdrPtr1;
	unsigned char* hdrPtr2;
	
	hdrPtr1 = (unsigned char*)&(packet->header);
	hdrPtr2 = (unsigned char*)(warpphy_getBuffAddr(pktBuf_rx));
	
	if( ((packet->header.srcAddr) != ID_SRC) | ((packet->header.destAddr) != ID_DST) | ((packet->header.relAddr) != ID_RLY)) {
		//Fake good header event; call the bad header handler, then return
		phyRx_badHeader_callback();
		return 0; //let WARPMAC clear the PHY status bits once reception is done
	}	
	
	rxPktType = (packet->header.pktType);

	if(reportCFOviaWarpnet) {
		cfoStruct.structID = STRUCTID_CFO;
		cfoStruct.nodeID = myID;
		cfoStruct.sequenceNumber = (packet->header.seqNum);

		//Read the coarse CFO estimate (ready after the preamble)
		cfoStruct.cfo_c = warpphy_getPreCFO_pkt_coarse();

		//The dst doesn't actually use this CFO, but providing it here makes log parsing much easier
		cfoStruct.txCFO = warpphy_getPreCFO_pktBuf(pktBuf_tx_DATA);
	}

	if(reportBERviaWarpnet) {
		//Send a copy of the just-received packet to the BER calculating app
		//BER packets are built from:
		// Ethernet header [0:15]
		// MAC/PHY header [0:23] generated above
		// Actual transmitted payload (randomly generated and recorded in the PHY) [0:length-1]
		coprocEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(phyHeader) + (packet->header.length);
		coprocEthPktHeader.ethType = WARPNET_ETHTYPE_NODE2BER; 

		txPktPtr = (void *)warpphy_getBuffAddr(WARPNET_NODE2COPROC_PKTBUFFINDEX);
		memcpy(txPktPtr, &(coprocEthPktHeader), sizeof(warpnetEthernetPktHeader));
		txPktPtr += sizeof(warpnetEthernetPktHeader);
		memcpy(txPktPtr, (void*)&(packet->header), sizeof(phyHeader));
		txPktPtr += sizeof(phyHeader);
	}

	//Blocks until the PHY declares the payload good or bad
	state = warpmac_finishPhyRecv();

	if(state & PHYRXSTATUS_GOOD)
	{
		warpmac_incrementLEDHigh();
		cfoStruct.pktStatus = (unsigned int)ofdm_txrx_mimo_ReadReg_Rx_packet_done();

		if(coopTesting) {
			if(rxPktType == PKTTYPE_AFDATA) {
				if(myID == ID_RLY) {
					perStruct_AF.numPkts_tx++;
					warpphy_AFrecordEnable(0);
					usleep(autoRespDelay_RlyTx_AF/10);
					warpmac_finishPhyXmit();
					warpphy_AFrecordEnable(1);
				}
				perStruct_AF.numPkts_rx_good++;
			}
			else if(rxPktType == PKTTYPE_AFGHDATA) {
				if(myID == ID_RLY) {
					perStruct_AFGH.numPkts_tx++;
					warpphy_AFrecordEnable(0);
					usleep(autoRespDelay_RlyTx_AF/10);
					warpmac_finishPhyXmit();
					warpphy_AFrecordEnable(1);
				}
				perStruct_AFGH.numPkts_rx_good++;
			}
			else if(rxPktType == PKTTYPE_DFDATA) {
				if(myID == ID_RLY) perStruct_DF.numPkts_tx++;
				perStruct_DF.numPkts_rx_good++;
			}
			else if(rxPktType == PKTTYPE_DFGHDATA) {
				if(myID == ID_RLY) perStruct_DFGH.numPkts_tx++;
				perStruct_DFGH.numPkts_rx_good++;
			}
			else if(rxPktType == PKTTYPE_NCMHOPDATA) {
				if(myID == ID_RLY) perStruct_NCMHOP.numPkts_tx++;
				perStruct_NCMHOP.numPkts_rx_good++;
			}
			else if(rxPktType == PKTTYPE_NCDATA) {
				perStruct_NC.numPkts_rx_good++;
			}
		} else {
			perStruct_NC.numPkts_rx_good++;
		}

	}
	else if(state & PHYRXSTATUS_BAD)
	{
		warpmac_incrementLEDLow();
		cfoStruct.pktStatus = (unsigned int)ofdm_txrx_mimo_ReadReg_Rx_packet_done();

		if(coopTesting) {
			if(rxPktType == PKTTYPE_AFDATA)
				perStruct_AF.numPkts_rx_goodHdrBadPyld++;
			else if(rxPktType == PKTTYPE_AFGHDATA) {
				if(myID == ID_RLY) {
					perStruct_AFGH.numPkts_tx++;
					warpphy_AFrecordEnable(0);
					usleep(autoRespDelay_RlyTx_AF/10);
					warpmac_finishPhyXmit();
					warpphy_AFrecordEnable(1);
				}
				perStruct_AFGH.numPkts_rx_goodHdrBadPyld++;
			}
			else if(rxPktType == PKTTYPE_DFDATA)
				perStruct_DF.numPkts_rx_goodHdrBadPyld++;
			else if(rxPktType == PKTTYPE_DFGHDATA) {
				if(myID == ID_RLY) perStruct_DFGH.numPkts_tx++;
				perStruct_DFGH.numPkts_rx_goodHdrBadPyld++;
			}
			else if(rxPktType == PKTTYPE_NCMHOPDATA)
				perStruct_NCMHOP.numPkts_rx_goodHdrBadPyld++;
			else if(rxPktType == PKTTYPE_NCDATA)
				perStruct_NC.numPkts_rx_goodHdrBadPyld++;
		} else {
			perStruct_NC.numPkts_rx_goodHdrBadPyld++;
		}
	}

	if(reportCFOviaWarpnet) {
		//Read the final CFO estimate (ready after the payload)
		cfoStruct.cfo_p = warpphy_getPreCFO_pkt_pilots();
		cfoStruct.cfo_b = warpphy_getPreCFO_pktBuf(pktBuf_rx);

		//Construct the CFO struct and send it to the server
		txEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetControllerGroup) + sizeof(warpnetCFO);

		txPktPtr = (void *)warpphy_getBuffAddr(WARPNET_NODE2SVR_PKTBUFFINDEX);
		memcpy(txPktPtr, &(txEthPktHeader), sizeof(warpnetEthernetPktHeader));
		memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader), &(groupStruct), sizeof(warpnetControllerGroup));
		memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader)+sizeof(warpnetControllerGroup), &(cfoStruct), sizeof(warpnetCFO));
		
		warpmac_prepPktToNetwork((void *)txPktPtr, txEthPktHeader.pktLength);
		warpmac_startPktToNetwork(txEthPktHeader.pktLength);
	}

	if(reportBERviaWarpnet) {
		memcpy(txPktPtr, (void *)(warpphy_getBuffAddr(pktBuf_rx)+sizeof(phyHeader)), packet->header.length);

		warpmac_prepPktToNetwork((void *)warpphy_getBuffAddr(WARPNET_NODE2COPROC_PKTBUFFINDEX), coprocEthPktHeader.pktLength);
		warpmac_startPktToNetwork(coprocEthPktHeader.pktLength);
	}

	//POM- only send PHYdump on GHBP or BH
//	if(doRxPHYdump && (state & PHYRXSTATUS_BAD) ) {
	if(doRxPHYdump) {
		Send_RxPHYdump(1, 1, 1, 1, packet->header.pktType, packet->header.seqNum);
	}
	
	//Return 1, indicating this function already waited for and cleared the PHY Rx status bits
	warpphy_clearRxPktStatus();

	return 1;
}

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
			case ASCII_S:
				warpphy_setAntennaMode(TX_ANTMODE_SISO_ANTB, RX_ANTMODE_SISO_ANTB);
				xil_printf("SISO Mode - Radio 3 Selected\r\n");
				break;
			case ASCII_s:
				warpphy_setAntennaMode(TX_ANTMODE_SISO_ANTA, RX_ANTMODE_SISO_ANTA);
				xil_printf("SISO Mode - Radio 2 Selected\r\n");
				break;
			case ASCII_a:
				afScaling -= 128;
				mimo_ofdmRx_setAFTxScaling(afScaling);
				xil_printf("AF Scaling: %d\r\n", afScaling);
				break;
			case ASCII_A:
				afScaling += 128;
				mimo_ofdmRx_setAFTxScaling(afScaling);
				xil_printf("AF Scaling: %d\r\n", afScaling);
				break;
			case ASCII_G:
				agcTargetPwr++;
				ofdm_AGC_SetTarget(agcTargetPwr);
				xil_printf("AGC target: %d\r\n", agcTargetPwr);
				break;
			case ASCII_g:
				agcTargetPwr--;
				ofdm_AGC_SetTarget(agcTargetPwr);
				xil_printf("AGC target: %d\r\n", agcTargetPwr);
				break;
			case ASCII_X:
				warpphy_incrementTxScaling(10, 0);
				break;
			case ASCII_x:
				warpphy_incrementTxScaling(-10, 0);
				break;
			case ASCII_Y:
				warpphy_incrementTxScaling(0, 10);
				break;
			case ASCII_y:
				warpphy_incrementTxScaling(0, -10);
				break;
			case ASCII_W:
				FFT_offset = FFT_offset + 1;
				xil_printf("FFT_offset: %d\r\n", FFT_offset);
				mimo_ofdmRx_setFFTWindowOffset(FFT_offset);
				break;
			case ASCII_w:
				FFT_offset = (FFT_offset == 0) ? 0 : (FFT_offset - 1);
				xil_printf("FFT_offset: %d\r\n", FFT_offset);
				mimo_ofdmRx_setFFTWindowOffset(FFT_offset);
				break;
			case ASCII_D:
				energyThresh += 100;
				xil_printf("PktDet Thresh: %d\r\n", energyThresh);
				ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(energyThresh);
				break;
				
			case ASCII_d:
				energyThresh -= 100;
				xil_printf("PktDet Thresh: %d\r\n", energyThresh);
				ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(energyThresh);
				break;

			case ASCII_C:
				pktDet_corrThresh += 50;
				xil_printf("LongCorr: %d\r\n", pktDet_corrThresh);
				warpphy_setLongCorrThresh(pktDet_corrThresh);
				break;
			case ASCII_c:
				pktDet_corrThresh -= 50;
				xil_printf("LongCorr: %d\r\n", pktDet_corrThresh);
				warpphy_setLongCorrThresh(pktDet_corrThresh);
				break;
				
			case ASCII_T:
				txPower++;
				xil_printf("Tx Pwr: %d\r\n", txPower);
				warpphy_setTxPower(txPower);
				break;
			case ASCII_t:
				txPower--;
				xil_printf("Tx Pwr: %d\r\n", txPower);
				warpphy_setTxPower(txPower);
				break;
				
			default:
				xil_printf("Undefined command\r\n");
				break;
		}
	}
	
	return;
}

void mgmtFromNetworkLayer_callback(Xuint32 length, char* payload) {
	
	void* rxPktPtr;
	void* txPktPtr;
	
	int i, numRxStructs;
	unsigned char rxSeqNum, theStructID;
	
	//Typed pointers for interpreting received structs
	warpnetEthernetPktHeader* pktHeader;
	warpnetControllerGroup* groupStructCopy;
	warpnetCommand* commandStruct;
	warpnetControl* controlStruct;
	warpnetPHYctrl* phyCtrlStruct;
	warpnetRequest* reqStruct;

	warpnetObservePER* perStructPtr;
	warpnetPERreq* perReqPtr;
	unsigned char tmpReqType;
	
	//Local ACK struct, used to send responses to the server
	warpnetAck ackStruct;

	//Interpret the received bytes as an Ethernet packet
	pktHeader = (warpnetEthernetPktHeader*)payload;
	
	if((pktHeader->ethType) != WARPNET_ETHTYPE_SVR2NODE) {
		//Should never happen; all management packets are type WARPNET_ETHTYPE_SVR2NODE
		return;
	}
	
	numRxStructs = pktHeader->numStructs;
	rxSeqNum = pktHeader->seqNum;

	//Initialize the rx pointer to the first byte past the Ethernet header
	rxPktPtr = (void*)(payload + sizeof(warpnetEthernetPktHeader));

	//Iterate over each pair of warpnetControllerGroup / otherStruct in the server message
	for(i=0; i<numRxStructs; i++) {

		if( ( ((int)rxPktPtr) - ((int)payload) ) >= length) {
			xil_printf("Error! Mgmt pktLength too short for numStructs\r\n");
			return;
		}
		
		//Alternate structs (starting with the first) are always warpnetControllerGroup
		groupStructCopy = (warpnetControllerGroup*)rxPktPtr;
		rxPktPtr += sizeof(warpnetControllerGroup);
	
		//Extract the first byte of the actual struct and interpret as the structID
		theStructID = *( (unsigned char *)rxPktPtr );
		//xil_printf("Mgmt Pkt: StructID=0x%x\r\n", theStructID);
		
		switch(theStructID)
		{
			case STRUCTID_COMMAND:
				commandStruct = (warpnetCommand*)rxPktPtr;
				rxPktPtr += sizeof(warpnetCommand);

				if((commandStruct->nodeID) == myID) {

					//Send an ACK struct back to the server
					ackStruct.structID = STRUCTID_COMMAND_ACK;
					ackStruct.nodeID = myID;
					ackStruct.cmdID = commandStruct->cmdID;
					
					txEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetControllerGroup) + sizeof(warpnetAck);
					txEthPktHeader.numStructs = 1;
					
					txPktPtr = (void *)warpphy_getBuffAddr(WARPNET_NODE2SVR_PKTBUFFINDEX);
					memcpy(txPktPtr, (void *)&(txEthPktHeader), sizeof(warpnetEthernetPktHeader));
					memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader), (void *)groupStructCopy, sizeof(warpnetControllerGroup));
					memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader)+sizeof(warpnetControllerGroup), (void *)&(ackStruct), sizeof(warpnetAck));

					warpmac_prepPktToNetwork(txPktPtr, txEthPktHeader.pktLength);
					warpmac_startPktToNetwork(txEthPktHeader.pktLength);

					//Process the received struct
					processCommand(commandStruct);
				}
				break;
				
			case STRUCTID_CONTROL:
				controlStruct = (warpnetControl*)rxPktPtr;
				rxPktPtr += sizeof(warpnetControl);

				if((controlStruct->nodeID) == myID) {
					
					//Send an ACK struct back to the server
					ackStruct.structID = STRUCTID_CONTROL_ACK;
					ackStruct.nodeID = myID;
					
					txEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetControllerGroup) + sizeof(warpnetAck);
					txEthPktHeader.numStructs = 1;
					
					txPktPtr = (void *)warpphy_getBuffAddr(WARPNET_NODE2SVR_PKTBUFFINDEX);
					memcpy(txPktPtr, (void *)&(txEthPktHeader), sizeof(warpnetEthernetPktHeader));
					memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader), (void *)groupStructCopy, sizeof(warpnetControllerGroup));
					memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader)+sizeof(warpnetControllerGroup), (void *)&(ackStruct), sizeof(warpnetAck));
					
					warpmac_prepPktToNetwork(txPktPtr, txEthPktHeader.pktLength);
					warpmac_startPktToNetwork(txEthPktHeader.pktLength);
					
					//Process the received struct
					processControl(controlStruct);
				}
				break;
			case STRUCTID_PHYCTRL:
				phyCtrlStruct = (warpnetPHYctrl*)rxPktPtr;
				rxPktPtr += sizeof(warpnetPHYctrl);
				
				if((phyCtrlStruct->nodeID) == myID) {
					//Send an ACK struct back to the server
					ackStruct.structID = STRUCTID_PHYCTRL_ACK;
					ackStruct.nodeID = myID;
					
					txEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetControllerGroup) + sizeof(warpnetAck);
					txEthPktHeader.numStructs = 1;
					
					txPktPtr = (void *)warpphy_getBuffAddr(WARPNET_NODE2SVR_PKTBUFFINDEX);
					memcpy(txPktPtr, (void *)&(txEthPktHeader), sizeof(warpnetEthernetPktHeader));
					memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader), (void *)groupStructCopy, sizeof(warpnetControllerGroup));
					memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader)+sizeof(warpnetControllerGroup), (void *)&(ackStruct), sizeof(warpnetAck));
					
					warpmac_prepPktToNetwork(txPktPtr, txEthPktHeader.pktLength);
					warpmac_startPktToNetwork(txEthPktHeader.pktLength);
					
					//Process the received struct
					processPHYControl(phyCtrlStruct);
				}
				break;
			case STRUCTID_OBSERVE_PER_REQ:
				perReqPtr = (warpnetPERreq*)rxPktPtr;
				rxPktPtr += sizeof(warpnetPERreq);

				if((perReqPtr->nodeID) == myID) {
					
					if(coopTesting) {
						tmpReqType = (unsigned char)perReqPtr->reqType;

						if(tmpReqType == PKTTYPE_DFDATA)
							perStructPtr = &perStruct_DF;
						else if(tmpReqType == PKTTYPE_AFDATA)
							perStructPtr = &perStruct_AF;
						else if(tmpReqType == PKTTYPE_AFGHDATA)
							perStructPtr = &perStruct_AFGH;
						else if(tmpReqType == PKTTYPE_DFGHDATA)
							perStructPtr = &perStruct_DFGH;
						else if(tmpReqType == PKTTYPE_NCMHOPDATA)
							perStructPtr = &perStruct_NCMHOP;
						else if(tmpReqType == PKTTYPE_INVALID)
							perStructPtr = &perStruct_Other;
						else //if(tmpReqType == PKTTYPE_NCDATA)
							perStructPtr = &perStruct_NC;

						perStructPtr->reqType = tmpReqType;
					} else {
						perStructPtr = &perStruct_NC;
					}

					perStructPtr->reqNum = (unsigned char)perReqPtr->reqNum;

					txEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetControllerGroup) + sizeof(warpnetObservePER);
					txEthPktHeader.numStructs = 1;
					
					txPktPtr = (void *)warpphy_getBuffAddr(WARPNET_NODE2SVR_PKTBUFFINDEX);
					memcpy(txPktPtr, (void *)&(txEthPktHeader), sizeof(warpnetEthernetPktHeader));
					memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader), (void *)groupStructCopy, sizeof(warpnetControllerGroup));
					memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader)+sizeof(warpnetControllerGroup), (void *)perStructPtr, sizeof(warpnetObservePER));
					
					warpmac_prepPktToNetwork(txPktPtr, txEthPktHeader.pktLength);
					warpmac_startPktToNetwork(txEthPktHeader.pktLength);
				}
				break;
				
			default:
				//Unrecognized structID; do nothing
				//xil_printf("Unknown structID: 0x%x\r\n", theStructID);
				break;
		}//END switch(theStructID)
				
				
	}//END for(0...numStructs-1)
		
	return;
}

void processPHYControl(warpnetPHYctrl* phyCtrlStruct) {
	//Interpret the PHY control parameters
	//PHYCtrol params:
	//param0: txStartOut delay
	//param1: artificial txCFO
	//param2: minPilotChanMag
	//param3: 
	// [0-0x01]: PHYCTRL_BER_EN: enable BER reporting
	// [1-0x02]: PHYCTRL_CFO_EN: enable CFO reporting
	// [2-0x04]: PHYCTRL_PHYDUMP_EN: enable Rx PHY dumping
	// [3-0x08]: PHYTRCL_EXTPKTDET_EN: use only ext pkt det
	// [4-0x10]: PHYCTRL_COOP_EN: 0=nonCoop, 1=coopMode
	// [5-0x20]: PHYCTRL_CFO_CORR_EN: 0=bypass CFO correction, 1=enable CFO correction
	// [6-0x40]: PHYCTRL_SWAP_ANT: 0=AntA, 1=AntA_Swapped
	//param4:
	// [ 7:0]: src re-Tx delay
	// [ 7:0]: relay AF Tx delay (only used when in COOP_TESTING)
	// [15:8]: relay DF Tx delay (only used when in COOP_TESTING)
	//param5: 
	// [17: 0]: AGC IIR coef FB
	//param6: (0 ignores)
	// [31:16]: H_BA minEstMag (UFix16_15)
	// [15: 0]: H_AA minEstMag (UFix16_15)
	//param7: (0 ignores)
	// [27:16]: AF blank stop
	// [11: 0]: AF blank start
	//param8: 
	// [17: 0]: AGC IIR coef g
	//param9: (Tx pkt types)
	// [31: 0]: OR'd combination of PHYCTRL_TX_*
	
	int i;
	unsigned int txCFO;
	unsigned int minChanMag;
	unsigned int configBits;
	
//param0
	pktDetBypass_txStartDly = (phyCtrlStruct->param0) & 0xFF;
	mimo_ofdmTx_setDelays(autoRespDelay_SrcReTx, 0, pktDetBypass_txStartDly);
	
//param1
	txCFO = phyCtrlStruct->param1;
	if(txCFO != 0) {
		warpphy_setPreCFO_pktBuf(pktBuf_tx_DATA, txCFO);
		mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | (TX_ALWAYS_USE_PRECFO));
	} else {
		warpphy_setPreCFO_pktBuf(pktBuf_tx_DATA, 0);
		mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & (~TX_ALWAYS_USE_PRECFO));
	}
		
//param2
	minChanMag = (phyCtrlStruct->param2) & 0xFFF;
	mimo_ofdmRx_setPilotCalcParams(minChanMag);

//param3
	configBits = (phyCtrlStruct->param3) & 0xFFFF;

	reportCFOviaWarpnet = 0;
	reportBERviaWarpnet = 0;
	doRxPHYdump = 0;
	coopTesting = 0;
	nonCoopTesting = 0;
	
	if( configBits & 0x1 ) {
		reportBERviaWarpnet = 1;
	} else {
		reportBERviaWarpnet = 0;
	}

	if( configBits & 0x2 ) {
		reportCFOviaWarpnet = 1;
	} else {
		reportCFOviaWarpnet = 0;
	}

	if( configBits & 0x4 ) {
		doRxPHYdump = 1;
	} else {
		doRxPHYdump = 0;
	}

	if( configBits & 0x8 ) {
		//Bypass long correlation checking
		ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) & ~(REQ_LONG_CORR));

		//Set the correlation and energy thresholds to max values (effectively disabling them)
		warpphy_setLongCorrThresh(0xFFFF);
		ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(0xFFFF);
		
		//Enable external pktDet input and bypass coarse CFO (it uses the long correlator too)
		ofdm_txrx_mimo_WriteReg_Rx_PktDet_extDetEn(1);
		ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) | (BYPASS_CARR_REC));
		warpphy_setPreCFOoptions( (PRECFO_USEPILOTS) );
		
		//Set the pktDet->payload delay
		mimo_ofdmRx_setPktDetDly(48); //works together with phyCtrl0.param0 = 51 to line up coop tx/rx with fake pkt det
	} else {
		//Reset the various pktDetection-dependent parameters to their defaults
		ofdm_txrx_mimo_WriteReg_Rx_PktDet_extDetEn(0);
		ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) | (REQ_LONG_CORR));
		ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) & ~(BYPASS_CARR_REC));
		warpphy_setPreCFOoptions( (PRECFO_USECOARSE | PRECFO_USEPILOTS) );
		warpphy_setLongCorrThresh(pktDet_corrThresh);
		ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(energyThresh);
		mimo_ofdmRx_setPktDetDly(124);
	}		

	if( configBits & 0x10 ) {
		//Enable cooperative testing
		coopTesting = 1;
		nonCoopTesting = 0;
		warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA);
		ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) | (EXT_PKTDETRESET_EN));
	} else {
		//Disable cooperative testing
		coopTesting = 0;
		nonCoopTesting = 1;
		warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA);
		ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) & ~(EXT_PKTDETRESET_EN));
	}
	
	if( configBits & 0x20 ) {
		ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) & ~(BYPASS_CARR_REC));
		warpphy_setPreCFOoptions( (PRECFO_USECOARSE | PRECFO_USEPILOTS) );
//		warpphy_setPreCFOoptions( (PRECFO_USECOARSE) ); //POM- disabling pilot estimator for now!
	} else {
		ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) | BYPASS_CARR_REC);
		warpphy_setPreCFOoptions( (PRECFO_USEPILOTS) );
	}

	if( configBits & 0x40 ) {
		warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA_SWAPPED);
	} else {
		warpphy_setTxAntennaSwap(TX_ANTMODE_ALAMOUTI_ANTA);
	}

//param4
	//Update role-specific parameters
	if(myID == ID_SRC) {
		autoRespDelay_SrcReTx = (phyCtrlStruct->param4) & 0xFF;
		mimo_ofdmTx_setDelays(autoRespDelay_SrcReTx, 0, pktDetBypass_txStartDly);
	}
	else if(myID == ID_RLY) {
		autoRespDelay_RlyTx_AF = ((phyCtrlStruct->param4) & 0xFF);
		autoRespDelay_RlyTx_DF = (((phyCtrlStruct->param4) & 0xFF00)>>8);
	}

//param5: IIR coef FB //Fix18_17
	if((phyCtrlStruct->param5) > 0) {
		agc_iirCoef_fb = ((phyCtrlStruct->param5) & 0x3FFFF);
		XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_DCO_IIR_COEF_FB, agc_iirCoef_fb);
	}

//param6: chan est mag masking
	if((phyCtrlStruct->param6) > 0) {
		ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) | CHANMAG_MASKING_EN);
		warpphy_setChanEstMinMags( (phyCtrlStruct->param6) );//((phyCtrlStruct->param6) & 0xFFFF), ( ((phyCtrlStruct->param6) & 0xFFFF0000)>>16) );
	} else {
		ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) & ~(CHANMAG_MASKING_EN));
		warpphy_setChanEstMinMags(0);//, 0);
	}
	
//param7: AF interval masking
	if((phyCtrlStruct->param7) > 0) {
		//Set AF blanking interval (set to zeros to disable)
		warpphy_setAFblanking((phyCtrlStruct->param7) & 0x0FFF, ( ((phyCtrlStruct->param7) & 0x0FFF0000)>>16));
	} else {
		//Set AF blanking interval (set to zeros to disable)
		warpphy_setAFblanking(0, 0);
	}
	
//param8: IIR coef G //UFix18_17
	if((phyCtrlStruct->param8) > 0) {
		agc_iirCoef_g = ((phyCtrlStruct->param8) & 0x3FFFF);
		XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_DCO_IIR_COEF_GAIN, agc_iirCoef_g);
	}
	
//param9: Scheme en/disable
	if((phyCtrlStruct->param9) > 0x0) {
		numPktTypes = 0;

		if((phyCtrlStruct->param9) & 0x01) {pktTypesToTx[numPktTypes] = PKTTYPE_NCDATA; numPktTypes++;}
		if((phyCtrlStruct->param9) & 0x02) {pktTypesToTx[numPktTypes] = PKTTYPE_DFDATA; numPktTypes++;}
		if((phyCtrlStruct->param9) & 0x04) {pktTypesToTx[numPktTypes] = PKTTYPE_AFDATA; numPktTypes++;}
		if((phyCtrlStruct->param9) & 0x08) {pktTypesToTx[numPktTypes] = PKTTYPE_AFGHDATA; numPktTypes++;}
		if((phyCtrlStruct->param9) & 0x10) {pktTypesToTx[numPktTypes] = PKTTYPE_DFGHDATA; numPktTypes++;}
		if((phyCtrlStruct->param9) & 0x20) {pktTypesToTx[numPktTypes] = PKTTYPE_NCMHOPDATA; numPktTypes++;}
		
		//Safety check- if no type was enabled, revert to NC only
		if(numPktTypes == 0) {pktTypesToTx[numPktTypes] = PKTTYPE_NCDATA; numPktTypes = 1;}
	}

	setupNodeBehaviors();
	return;
}

void processControl(warpnetControl* controlStruct) {
	unsigned char newMod, newCode;
	
	pktGen_length = controlStruct->pktGen_length;
	pktGen_period = controlStruct->pktGen_period;

	txPower = ((controlStruct->txPower) & 0x3F);
	warpphy_setTxPower(txPower);

	newMod = ((controlStruct->modOrderPayload) & 0xF);
	newCode = (((controlStruct->modOrderPayload) & 0xF0)>>4);
	
	switch(newMod) {
		case 1:
			pktFullRate = HDR_FULLRATE_BPSK;
			break;
		case 2:
			pktFullRate = HDR_FULLRATE_QPSK;
			break;
		case 4:
			pktFullRate = HDR_FULLRATE_QAM_16;
			break;
		case 6:
			pktFullRate = HDR_FULLRATE_QAM_64;
			break;
		default:
			pktFullRate = HDR_FULLRATE_QPSK;
			break;
	}

	switch(newCode) {
		case HDR_CODE_RATE_12:
			pktCodeRate = HDR_CODE_RATE_12;
			break;
		case HDR_CODE_RATE_23:
			pktCodeRate = HDR_CODE_RATE_23;
			break;
		case HDR_CODE_RATE_34:
			pktCodeRate = HDR_CODE_RATE_34;
			break;
		case HDR_CODE_RATE_NONE:
			pktCodeRate = HDR_CODE_RATE_NONE;
			break;
		default:
			pktCodeRate = HDR_CODE_RATE_NONE;
			break;
	}
	
	switch(controlStruct->modOrderHeader) {
		case 1:
			warpmac_setBaseRate(BPSK);
			break;
		case 2:
			warpmac_setBaseRate(QPSK);
			break;
		default:
			warpmac_setBaseRate(QPSK);
			break;
	}
	
	chan = controlStruct->channel;
	warpphy_setChannel(GHZ_2, chan);
}

void processCommand(warpnetCommand* commandStruct) {
	switch(commandStruct->cmdID){
		case COMMANDID_STARTTRIAL:
			warpmac_startPacketGeneration(pktGen_length, pktGen_period);
			break;
		case COMMANDID_STOPTRIAL:
			warpmac_stopPacketGeneration();
			break;
		case COMMANDID_RESET_PER:
			curPktType = PKTTYPE_NCDATA;

			perStruct_NC.numPkts_tx = 0;
			perStruct_NC.numPkts_rx_good = 0;
			perStruct_NC.numPkts_rx_goodHdrBadPyld = 0;
			perStruct_NC.numPkts_rx_badHdr = 0;

			if(coopTesting) {
				perStruct_DF.numPkts_tx = 0;
				perStruct_DF.numPkts_rx_good = 0;
				perStruct_DF.numPkts_rx_goodHdrBadPyld = 0;
				perStruct_DF.numPkts_rx_badHdr = 0;
				
				perStruct_AF.numPkts_tx = 0;
				perStruct_AF.numPkts_rx_good = 0;
				perStruct_AF.numPkts_rx_goodHdrBadPyld = 0;
				perStruct_AF.numPkts_rx_badHdr = 0;
				
				perStruct_AFGH.numPkts_tx = 0;
				perStruct_AFGH.numPkts_rx_good = 0;
				perStruct_AFGH.numPkts_rx_goodHdrBadPyld = 0;
				perStruct_AFGH.numPkts_rx_badHdr = 0;
				
				perStruct_DFGH.numPkts_tx = 0;
				perStruct_DFGH.numPkts_rx_good = 0;
				perStruct_DFGH.numPkts_rx_goodHdrBadPyld = 0;
				perStruct_DFGH.numPkts_rx_badHdr = 0;
				
				perStruct_NCMHOP.numPkts_tx = 0;
				perStruct_NCMHOP.numPkts_rx_good = 0;
				perStruct_NCMHOP.numPkts_rx_goodHdrBadPyld = 0;
				perStruct_NCMHOP.numPkts_rx_badHdr = 0;
				
				perStruct_Other.numPkts_tx = 0;
				perStruct_Other.numPkts_rx_good = 0;
				perStruct_Other.numPkts_rx_goodHdrBadPyld = 0;
				perStruct_Other.numPkts_rx_badHdr = 0;
			}
			break;
		default:
			//Unknown command; do nothing
			xil_printf("processCommand: unknown command: 0x%x\r\n", commandStruct->cmdID);
			break;
	}

	return;
}

//This function should only be called after the packet payload status is known!
void Send_RxPHYdump(int sendEVMperSC, int sendEVMperSym, int sendChanEstAA, int sendChanEstBA, unsigned char pktType, unsigned short seqNum) {
	void* txPktPtr;
	void* txPktPtr_d;
	int i;
	
	txPktPtr = (void *)warpphy_getBuffAddr(WARPNET_NODE2COPROC_PKTBUFFINDEX);
	
	coprocEthPktHeader.ethType = WARPNET_ETHTYPE_NODE2COPROC;
	coprocEthPktHeader.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetRxPHYdump);
	rxPHYdumpStruct.includedData = 0;
	rxPHYdumpStruct.rxStatus = mimo_ofdmRx_getPktStatus();
	rxPHYdumpStruct.rssi = (ofdm_txrx_mimo_ReadReg_Rx_PktDet_midPktRSSI_antA());
	rxPHYdumpStruct.rxGains = (ofdm_txrx_mimo_ReadReg_Rx_Gains(0));
	rxPHYdumpStruct.pktType = pktType;
	rxPHYdumpStruct.seqNum = seqNum;
	rxPHYdumpStruct.cfoEst_coarse = warpphy_getPreCFO_pkt_coarse();
	rxPHYdumpStruct.cfoEst_pilots = warpphy_getPreCFO_pkt_pilots();
	
	memcpy(txPktPtr, &(coprocEthPktHeader), sizeof(warpnetEthernetPktHeader));
	txPktPtr_d = txPktPtr + sizeof(warpnetEthernetPktHeader);
	txPktPtr += sizeof(warpnetEthernetPktHeader) + sizeof(warpnetRxPHYdump);
	
	if(sendEVMperSC) {
		coprocEthPktHeader.pktLength += RXPHYDUMP_SIZE_EVMPERSC;
		rxPHYdumpStruct.includedData |= RXPHYDUMP_INCLUDE_EVMPERSC;

		memcpy(txPktPtr, (void *)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_EVM_PERSC, RXPHYDUMP_SIZE_EVMPERSC);
		txPktPtr += RXPHYDUMP_SIZE_EVMPERSC;
	}
	if(sendEVMperSym) {
		coprocEthPktHeader.pktLength += RXPHYDUMP_SIZE_EVMPERSYM;
		rxPHYdumpStruct.includedData |= RXPHYDUMP_INCLUDE_EVMPERSYM;

		memcpy(txPktPtr, (void *)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_EVM_PERSYM, RXPHYDUMP_SIZE_EVMPERSYM);
		txPktPtr += RXPHYDUMP_SIZE_EVMPERSYM;
	}
	if(sendChanEstAA) {
		coprocEthPktHeader.pktLength += RXPHYDUMP_SIZE_CHANEST;
		rxPHYdumpStruct.includedData |= RXPHYDUMP_INCLUDE_CHANESTAA;
		
		//A-A estimates are the first set in the buffer
		memcpy(txPktPtr, (void *)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_CHANNELESTIMATES, RXPHYDUMP_SIZE_CHANEST);
		txPktPtr += RXPHYDUMP_SIZE_CHANEST;
	}
	if(sendChanEstBA) {
		coprocEthPktHeader.pktLength += RXPHYDUMP_SIZE_CHANEST;
		rxPHYdumpStruct.includedData |= RXPHYDUMP_INCLUDE_CHANESTBA;

		//B-A estimates are the third set in the buffer (after AA and AB)
		memcpy(txPktPtr, (void *)(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_CHANNELESTIMATES+2*RXPHYDUMP_SIZE_CHANEST), RXPHYDUMP_SIZE_CHANEST);
		txPktPtr += RXPHYDUMP_SIZE_CHANEST;
	}
	
	memcpy(txPktPtr_d, &(rxPHYdumpStruct), sizeof(warpnetRxPHYdump));

	warpmac_prepPktToNetwork((void *)warpphy_getBuffAddr(WARPNET_NODE2COPROC_PKTBUFFINDEX), coprocEthPktHeader.pktLength);
	warpmac_startPktToNetwork(coprocEthPktHeader.pktLength);
}

///@brief Main function
///
///This function configures MAC parameters, enables the underlying frameworks, and then loops forever.
int main(){		
	xil_printf("AFDF_CHAR v15.22\r\n");
	
	int i;
	
	curPktType = PKTTYPE_NCDATA;
	
	chan = 9;

	pktBuf_rx = 1;
	pktBuf_tx_DATA = 0;
	pktBuf_emac_rx = 3;
	pktBuf_tx_AF = 31;
	
	txSequences[ID_SRC] = 0;
	txSequences[ID_DST] = 0;
	txSequences[ID_RLY] = 0;
	
	reportCFOviaWarpnet = 0;
	reportBERviaWarpnet = 0;
	doRxPHYdump = 0;
	nonCoopTesting = 1;
	coopTesting = 0;
	
	pktGen_length = 1412;
	pktGen_period = 10000;

//Over the air delays (S->R delay = 0):
	autoRespDelay_SrcReTx = 251;
	autoRespDelay_RlyTx_DF = 104; //was 52 - doubled precision in v15.14
	autoRespDelay_RlyTx_AF = 104; //was 52 - doubled precision in v15.14

//Emulator delays (S->R delay = 1µs)
	autoRespDelay_SrcReTx = 251;
	autoRespDelay_RlyTx_DF = 94;//was 47 - doubled precision in v15.14
	autoRespDelay_RlyTx_AF = 94;//was 47 - doubled precision in v15.14
	pktDetBypass_txStartDly = 80;
	
	//Set the full-rate modulation to QPSK by default
	pktFullRate = HDR_FULLRATE_QPSK;
	pktCodeRate = CODE_RATE_12;
	
	txPower = 0x3f;
	warpphy_setTxPower(txPower);

	//Initialize the MAC/PHY frameworks
	warpmac_init();
	
	//Read Dip Switch value from FPGA board.
	//This value will be used as an index into the routing table for other nodes
	myID = warpmac_getMyId();
	warpmac_rightHex(myID);
					 
	//Configure the PHY and radio antenna modes
	warpphy_setAntennaMode(TX_ANTMODE_ALAMOUTI_ANTA, RX_ANTMODE_ALAMOUTI_ANTA);
//	warpphy_setAntennaMode(TX_ANTMODE_SISO_ANTA, RX_ANTMODE_SISO_ANTA);
	
	//Set the modulation scheme use for base rate (header) symbols
	warpmac_setBaseRate(QPSK);
	
	//Connect the various user-level callbacks
	warpmac_setCallback(EVENT_PHYGOODHEADER, (void *)phyRx_goodHeader_callback);
	warpmac_setCallback(EVENT_PHYBADHEADER, (void *)phyRx_badHeader_callback);
	warpmac_setCallback(EVENT_MGMTPKT, (void *)mgmtFromNetworkLayer_callback);
	warpmac_setCallback(EVENT_DATAFROMNETWORK, (void *)dataFromNetworkLayer_callback);
	warpmac_setCallback(EVENT_UARTRX, (void *)uartRecv_callback);

    //Set the default center frequency
	warpphy_setChannel(GHZ_2, chan);
	
//Set some PHY parameters
	//v22 default: dec2hex(round(1.00115 * 2^31))
//	warpphy_setPilotCFOCorrection(0x8025AEE6);
	//From experiments of fixed CFO=305Hz, using only pilot estimator
	//warpphy_setPilotCFOCorrection(0x821D7F92);

	//round(2^32*(2.9e-5 + 5e-6))
	//warpphy_setCoarseCFOCorrection(146029);
	//round( mean(( cfo - (m(3:end-3)-cff))')*2^32 ) (from experiments)
//	warpphy_setCoarseCFOCorrection(30533);
	
	//Preamble/payload scaling (UFix16_13)
	// 2480 = 0.302
	// 9792 = 1.195
// 	preambleScaling = 3072;//2480;
//	payloadScaling = 12288;//9792;
//	mimo_ofdmTx_setTxScaling(preambleScaling, payloadScaling);
	
	pktDet_corrThresh = 7000;
	warpphy_setLongCorrThresh(pktDet_corrThresh);
	
	//pktDet_corrWindowStart = 90-32;
	//pktDet_corrWindowEnd = 180+32;
	//longCorrCounterLoad = 245+6; //after comparing to v18
	//mimo_ofdmRx_setLongCorrParams( (longCorrCounterLoad&0xFF) | ((pktDet_corrWindowStart&0xFF)<<16) | ((pktDet_corrWindowEnd&0xFF)<<24));
	//mimo_ofdmRx_setPktDetDly(124);
//	ofdm_txrx_mimo_WriteReg_Rx_ControlBits(0, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(0) | (LOWPREC_LONGCORR));


	energyThresh = 4000;
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(energyThresh);

	//MinMag as UFix12_12
	//mimo_ofdmRx_setPilotCalcParams(0xFFF);

//	FFT_offset = 10;
//	mimo_ofdmRx_setFFTWindowOffset(FFT_offset);
	
	//Interpreted as Fix4_0 (1=1, 2=2, 15=-1, 14=-2, 13=-3, 12=-4)
//	warpphy_setAntBPreambleShift(13);

	//AF Tx scaling (UFix18_12)
	// 4096 = 1
	// 6656 = 1.625
	// 8192 = 2
	// 10240 = 2.5
	// 12288 = 3
//	afScaling = 2944;
//	mimo_ofdmRx_setAFTxScaling(afScaling);
	

	mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | (TX_RANDOM_PAYLOAD | TX_CAPTURE_RANDOM_PAYLOAD | TX_START_D0_OUT_EN | TX_START_D1_OUT_EN));

	//POM: Testing non-random payloads
	//mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | (TX_START_D0_OUT_EN | TX_START_D1_OUT_EN));
	//mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & ~(TX_RANDOM_PAYLOAD | TX_CAPTURE_RANDOM_PAYLOAD));
	//bzero((void *)warpphy_getBuffAddr(pktBuf_tx_DATA), (size_t)1500);

	agcTargetPwr = -13; //was -13 throgh v21
	ofdm_AGC_SetTarget(agcTargetPwr);
	
	//Set min chanest magnitudes (UFix16_15 values)
	warpphy_setChanEstMinMags(0);//0x8000, 0x8000);

	//Set AF blanking interval (set to zeros to disable)
	warpphy_setAFblanking(0, 0);

	//firpm filt
	mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | TX_ALT_INTERPFILT);
	
	//Set MAX2829 Rx bandwidth to its minimum (helps supress out-of-band noise)
	WarpRadio_v1_RxLpfCornFreqCoarseAdj(0x0, RADIO2_ADDR);
	WarpRadio_v1_RxLpfCornFreqFineAdj(0x0, RADIO2_ADDR);
	
	numPktTypes = 1;
	pktTypesToTx[0] = PKTTYPE_NCDATA;
	curPktTypeInd = 0;
	
/*** WARPnet Measurement/Control Setup ***/
	groupStruct.controllerID = 0;
	groupStruct.controllerGrp = 0;
	groupStruct.access = 1;
	groupStruct.reserved0 = 0;
	
	//WARPnet configuration
	txEthPktHeader.ethType = WARPNET_ETHTYPE_NODE2SVR;
	txEthPktHeader.srcAddr[0]=0x00;
	txEthPktHeader.srcAddr[1]=0x50;
	txEthPktHeader.srcAddr[2]=0xC2;
	txEthPktHeader.srcAddr[3]=0x63;
	txEthPktHeader.srcAddr[4]=0x3F;
	txEthPktHeader.srcAddr[5]=0x80+myID;

	coprocEthPktHeader.ethType = WARPNET_ETHTYPE_NODE2COPROC;
	coprocEthPktHeader.srcAddr[0]=0x00;
	coprocEthPktHeader.srcAddr[1]=0x50;
	coprocEthPktHeader.srcAddr[2]=0xC2;
	coprocEthPktHeader.srcAddr[3]=0x63;
	coprocEthPktHeader.srcAddr[4]=0x3F;
	coprocEthPktHeader.srcAddr[5]=0x80+myID;
	
	coprocEthPktHeader.numStructs = 1;


	//Linux eth1: 00:50:C2:63:3F:FC
	txEthPktHeader.dstAddr[0]=0x00;
	txEthPktHeader.dstAddr[1]=0x50;
	txEthPktHeader.dstAddr[2]=0xC2;
	txEthPktHeader.dstAddr[3]=0x63;
	txEthPktHeader.dstAddr[4]=0x3F;
	txEthPktHeader.dstAddr[5]=0xFC;
	
	//Linux eth1: 00:50:C2:63:3F:FC
	coprocEthPktHeader.dstAddr[0]=0x00;
	coprocEthPktHeader.dstAddr[1]=0x50;
	coprocEthPktHeader.dstAddr[2]=0xC2;
	coprocEthPktHeader.dstAddr[3]=0x63;
	coprocEthPktHeader.dstAddr[4]=0x3F;
	coprocEthPktHeader.dstAddr[5]=0xFC;

/*
	//Macbook #1
	txEthPktHeader.dstAddr[0]=0x00;
	txEthPktHeader.dstAddr[1]=0x17;
	txEthPktHeader.dstAddr[2]=0xf2;
	txEthPktHeader.dstAddr[3]=0xdb;
	txEthPktHeader.dstAddr[4]=0x05;
	txEthPktHeader.dstAddr[5]=0x07;

	 //Macbook #1
	 coprocEthPktHeader.dstAddr[0]=0x00;
	 coprocEthPktHeader.dstAddr[1]=0x17;
	 coprocEthPktHeader.dstAddr[2]=0xf2;
	 coprocEthPktHeader.dstAddr[3]=0xdb;
	 coprocEthPktHeader.dstAddr[4]=0x05;
	 coprocEthPktHeader.dstAddr[5]=0x07;
 */
	
	
	
	perStruct_DF.structID = STRUCTID_OBSERVE_PER;
	perStruct_DF.nodeID = myID;
	perStruct_DF.reqNum = 0;
	perStruct_DF.reqType = PKTTYPE_DFDATA;
	perStruct_DF.numPkts_tx = 0;
	perStruct_DF.numPkts_rx_good = 0;
	perStruct_DF.numPkts_rx_goodHdrBadPyld = 0;
	perStruct_DF.numPkts_rx_badHdr = 0;

	perStruct_AF.structID = STRUCTID_OBSERVE_PER;
	perStruct_AF.nodeID = myID;
	perStruct_AF.reqNum = 0;
	perStruct_AF.reqType = PKTTYPE_AFDATA;
	perStruct_AF.numPkts_tx = 0;
	perStruct_AF.numPkts_rx_good = 0;
	perStruct_AF.numPkts_rx_goodHdrBadPyld = 0;
	perStruct_AF.numPkts_rx_badHdr = 0;
	
	perStruct_AFGH.structID = STRUCTID_OBSERVE_PER;
	perStruct_AFGH.nodeID = myID;
	perStruct_AFGH.reqNum = 0;
	perStruct_AFGH.reqType = PKTTYPE_AFGHDATA;
	perStruct_AFGH.numPkts_tx = 0;
	perStruct_AFGH.numPkts_rx_good = 0;
	perStruct_AFGH.numPkts_rx_goodHdrBadPyld = 0;
	perStruct_AFGH.numPkts_rx_badHdr = 0;
	
	perStruct_DFGH.structID = STRUCTID_OBSERVE_PER;
	perStruct_DFGH.nodeID = myID;
	perStruct_DFGH.reqNum = 0;
	perStruct_DFGH.reqType = PKTTYPE_DFGHDATA;
	perStruct_DFGH.numPkts_tx = 0;
	perStruct_DFGH.numPkts_rx_good = 0;
	perStruct_DFGH.numPkts_rx_goodHdrBadPyld = 0;
	perStruct_DFGH.numPkts_rx_badHdr = 0;

	perStruct_NCMHOP.structID = STRUCTID_OBSERVE_PER;
	perStruct_NCMHOP.nodeID = myID;
	perStruct_NCMHOP.reqNum = 0;
	perStruct_NCMHOP.reqType = PKTTYPE_NCMHOPDATA;
	perStruct_NCMHOP.numPkts_tx = 0;
	perStruct_NCMHOP.numPkts_rx_good = 0;
	perStruct_NCMHOP.numPkts_rx_goodHdrBadPyld = 0;
	perStruct_NCMHOP.numPkts_rx_badHdr = 0;
	
	perStruct_NC.structID = STRUCTID_OBSERVE_PER;
	perStruct_NC.nodeID = myID;
	perStruct_NC.reqNum = 0;
	perStruct_NC.reqType = PKTTYPE_NCDATA;
	perStruct_NC.numPkts_tx = 0;
	perStruct_NC.numPkts_rx_good = 0;
	perStruct_NC.numPkts_rx_goodHdrBadPyld = 0;
	perStruct_NC.numPkts_rx_badHdr = 0;
	
	perStruct_Other.structID = STRUCTID_OBSERVE_PER;
	perStruct_Other.nodeID = myID;
	perStruct_Other.reqNum = 0;
	perStruct_Other.reqType = PKTTYPE_INVALID;
	perStruct_Other.numPkts_tx = 0;
	perStruct_Other.numPkts_rx_good = 0;
	perStruct_Other.numPkts_rx_goodHdrBadPyld = 0;
	perStruct_Other.numPkts_rx_badHdr = 0;
	
	rxPHYdumpStruct.structID = STRUCTID_RXPHYDUMP;
	rxPHYdumpStruct.nodeID = myID;
	rxPHYdumpStruct.pktType = PKTTYPE_NCDATA;
	rxPHYdumpStruct.seqNum = 0;
	
	/*
	sleep(8);
	unsigned char ethernetAddr[] = {0x00,0x50,0xC2,0x63,0x3F,0x80+myID};
	warpnet_setMacAddr((void*)&ethernetAddr);
	warpnet_sendGratuitousArp(myID);
	*/
	
	setupNodeBehaviors();

	//Rx Buffer where the wireless PHY will write packets
	warpmac_setRxBuffers(&rxFrame, pktBuf_rx);
	
	//Tx buffer is where the EMAC will DMA payloads to
	warpmac_setEMACRxBuffer(pktBuf_emac_rx);
	warpmac_setPHYTxBuffer(pktBuf_tx_DATA);

	//Listen for new packets to send (either from Ethernet or local dummy packets)
	warpmac_enableDataFromNetwork();
	warpmac_setDummyPacketMode(1);
	
	while(1){
		warpmac_pollPeripherals();
	}
	
	return;
}


void setupNodeBehaviors()
{
	//Disable all actors by default
	mimo_ofdmTxRx_setAction0(0);
	mimo_ofdmTxRx_setAction1(0);
	mimo_ofdmTxRx_setAction2(0);
	mimo_ofdmTxRx_setAction3(0);
	mimo_ofdmTxRx_setAction4(0);
	mimo_ofdmTxRx_setAction5(0);
	
	//Match conditions
	//Match condition 0: received header's destination address is me
	//autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_DSTADDR, 2, htons(NODEID_TO_ADDR(myID)));
	//mimo_ofdmTxRx_setMatch0(autoResp_matchCond);
	
	//Match condition 0: received header's relay address is me
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_RLYADDR, 2, htons(NODEID_TO_ADDR(myID)));
	mimo_ofdmTxRx_setMatch0(autoResp_matchCond);
	
	//Match condition 1: packet type is PKTTYPE_DFDATA
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_TYPE, 1, PKTTYPE_DFDATA);
	mimo_ofdmTxRx_setMatch1(autoResp_matchCond);
	
	//Match condition 2: packet type is PKTTYPE_AFDATA
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_TYPE, 1, PKTTYPE_AFDATA);
	mimo_ofdmTxRx_setMatch2(autoResp_matchCond);

	//Match condition 3: packet type is PKTTYPE_AFGHDATA
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_TYPE, 1, PKTTYPE_AFGHDATA);
	mimo_ofdmTxRx_setMatch3(autoResp_matchCond);
	
	//Match condition 4: packet type is PKTTYPE_DFGHDATA
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_TYPE, 1, PKTTYPE_DFGHDATA);
	mimo_ofdmTxRx_setMatch4(autoResp_matchCond);

	//Match condition 5: packet type is REQ_NCMHOPDATA
	autoResp_matchCond = PHY_AUTORESPONSE_MATCH_CONFIG(PKTHEADER_INDX_TYPE, 1, PKTTYPE_NCMHOPDATA);
	mimo_ofdmTxRx_setMatch5(autoResp_matchCond);
	
	//Set Tx delays (src-reTx, autoRespExtra, txStart outputs)
	mimo_ofdmTx_setDelays(autoRespDelay_SrcReTx, 0, pktDetBypass_txStartDly);

	if(coopTesting) {
		if(myID == ID_SRC) {
			//Enable auto-TwoTx mode, so the source transmits every packet twice back-to-back
			mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | (TX_AUTO_TWOTX_EN));

			//Disable packet detection at the src; it never receives packets
			ofdm_txrx_mimo_WriteReg_Rx_PktDet_ignoreDet(1);
		}
		else if(myID == ID_RLY) {
			//Relay transmits after receiving DATA packet from src
			//autoResp_action_relayTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_rx, (PHY_AUTORESPONSE_ACT_SWAP_ANT | PHY_AUTORESPONSE_ACT_USE_PRECFO), autoRespDelay_RlyTx_DF, (REQ_RLY_ME | REQ_DFDATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
			//autoResp_action_relayTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_rx, (0), autoRespDelay_RlyTx_DF, (REQ_RLY_ME | REQ_DFDATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
			autoResp_action_relayTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_rx, (PHY_AUTORESPONSE_ACT_USE_PRECFO), autoRespDelay_RlyTx_DF, (REQ_RLY_ME | REQ_DFDATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
			mimo_ofdmTxRx_setAction0(autoResp_action_relayTx);

			autoResp_action_relayTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_AF, (0), autoRespDelay_RlyTx_AF, (REQ_RLY_ME | REQ_AFDATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
			mimo_ofdmTxRx_setAction1(autoResp_action_relayTx);

			autoResp_action_relayTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_tx_AF, (0), autoRespDelay_RlyTx_AF, (REQ_RLY_ME | REQ_AFGHDATA | PHY_AUTORESPONSE_REQ_GOODHDR));
			mimo_ofdmTxRx_setAction2(autoResp_action_relayTx);

			autoResp_action_relayTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_rx, (PHY_AUTORESPONSE_ACT_USE_PRECFO | PHY_AUTORESPONSE_ACT_RETX_CRC), autoRespDelay_RlyTx_DF, (REQ_RLY_ME | REQ_DFGHDATA | PHY_AUTORESPONSE_REQ_GOODHDR));
			//POM: temporarily refdefining DFGH to be DF w/out prespin!
//			autoResp_action_relayTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_rx, (0), autoRespDelay_RlyTx_DF, (REQ_RLY_ME | REQ_DFGHDATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
			mimo_ofdmTxRx_setAction3(autoResp_action_relayTx);
			
			autoResp_action_relayTx = PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf_rx, (0), autoRespDelay_RlyTx_DF, (REQ_RLY_ME | REQ_NCMHOPDATA | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_GOODPKT));
			mimo_ofdmTxRx_setAction4(autoResp_action_relayTx);
			
			warpphy_AFrecordEnable(1);
		}
		else if(myID == ID_DST)
		{
		}
	} //END if(coopTesting)

	if(nonCoopTesting) {
		if(myID == ID_SRC)
		{
			mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & ~(TX_AUTO_TWOTX_EN));

			//Disable packet detection at the src; it never receives packets
			ofdm_txrx_mimo_WriteReg_Rx_PktDet_ignoreDet(1);
		}
		else if(myID == ID_RLY)
		{
			mimo_ofdmTxRx_setAction0(0);
			mimo_ofdmTxRx_setAction1(0);
			mimo_ofdmTxRx_setAction2(0);
		}
		else if(myID == ID_DST)
		{
		}
	} //END if(nonCoopTesting)
	return;
}

void setDACinterp(unsigned int mode, unsigned int radios) {
	unsigned int divreg;
	

	divreg = RADIO_CONTROLLER_mReadSlaveReg6(XPAR_RADIO_CONTROLLER_0_BASEADDR);
	RADIO_CONTROLLER_mWriteSlaveReg5((volatile)XPAR_RADIO_CONTROLLER_0_BASEADDR, 0x3410);			// Set the value of the Control Register to 0x00003410 for DACs
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)XPAR_RADIO_CONTROLLER_0_BASEADDR, 0x00000001);		// Set the value for the Divider Register to 0x00000001
	
	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)XPAR_RADIO_CONTROLLER_0_BASEADDR, (SLAVEMASKDAC & radios));		// Select the dacs that need to be affected

	transmitdac( (0x0104 | ( (mode & 0x3)<<6) ) );

	transmitdac( (0x0300 | ( (mode & 0x30)>>4)) );

	if((mode&0x33) > 0) {
		//Enable the AD9777 PLL
		transmitdac(0x0480);
	} else {
		//Disable the AD9777 PLL
		transmitdac(0x0400);
	}

	transmitdac(0x060F);
	transmitdac(0x0A0F);
	
	RADIO_CONTROLLER_mWriteSlaveReg5((volatile)XPAR_RADIO_CONTROLLER_0_BASEADDR, 0x3412);			// Set the value of the Control Register to 0x00003412 for Radio
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)XPAR_RADIO_CONTROLLER_0_BASEADDR, divreg);		// Set the value for the Divider Register to 0x00000000

	return;
}
