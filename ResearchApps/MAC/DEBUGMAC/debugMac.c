/*! \file debugMac.c
 \brief Top-level debug "MAC" for testing PHY/MAC builds between reference design releases
 
 @version 10
 @author Chris Hunter
 
 Doesn't actually implement a MAC, and traffic only flows one direction. This is used for testing/debugging low-level PHY and WARPMAC changes.
*/

#include "warpmac.h"
#include "warpphy.h"
#include "debugMac.h"
#include "xparameters.h"
#include "string.h"
#include "errno.h"
#include "stdlib.h"
#include "stdio.h"
#include "warp_userioboard_util.h"

//Lower level includes, for debug/development
#include "ofdm_txrx_mimo_regMacros.h"
#include "ofdm_agc_mimo_regMacros.h"
#include "warp_timer_regMacros.h"
#include "EEPROM.h"
#include "radio_controller_basic.h"
#include "radio_controller_ext.h"
#include "radio_controller_adv.h"
#include "radio_controller_5ghz.h"
#include "ascii_characters.h"
#include "xgpio.h"


unsigned char chan;
unsigned char dacGain_coarse;
unsigned int dacGain_fine;
unsigned char agcPrintMode;
unsigned int pktCount;
unsigned int agcGains;
unsigned int pktFullRate;
unsigned int pktCodeRate;
unsigned char TxGainBB;
unsigned char TxGainRF;
unsigned char fftScaling_Rx_1;
unsigned char fftScaling_Rx_2;
unsigned char fftScaling_Rx_3;
unsigned char fftScaling_Tx_1;
unsigned char fftScaling_Tx_2;
unsigned char fftScaling_Tx_3;
unsigned char agc_coarseThresh_1;
unsigned char agc_coarseThresh_2;
unsigned char agc_coarseThresh_3;
unsigned char updateFFTscaling;
unsigned char updateAGCthresh;
unsigned char userIOBoard_LEDs;
unsigned char charsToPrint[16];
unsigned char pktDetMask;

unsigned short radReg9;
unsigned char updateRadReg9, txBBGain, txUpconvLin, txVGALin;

unsigned int pktDet_rssi;

unsigned int pktCount_good, pktCount_bad;

unsigned int txScaling_preamble, txScaling_payload;
unsigned int pktDet_thresh, cs_thresh;

///Buffer to hold received packet
Macframe rxBuffer;

void left();
void right();
void up();
void middle();

///@brief Callback for the reception of Ethernet packets
///
///This function is called by the ethernet MAC drivers
///when a packet is available to send. This function fills
///the Macframe transmit buffer with the packet and sends
///it over the OFDM link
///@param length Length, in bytes, of received Ethernet frame
///@param payload address of first byte in Ethernet payload.
void emacRx_callback(Xuint32 length, char* payload){

//Pseudocode for workshop users:
//1) Instantiate a "Macframe" to hold a packet header
//2) Copy the "length" of the received Ethernet frame (argument of this function) into the appropriate field of the "phyHeader" in the "Macframe"
//3) Set the "fullRate" field of the "phyHeader" in the "Macframe" to "QPSK"
//4) Copy the header over the packet buffer 1 using the "warpmac_prepPhyForXmit" function.
//5) Send the contents of packet buffer 1 by using the "warpmac_startPhyXmit" function.
//6) Wait for the PHY transmitter to finish and enable the receiver by using the "warpmac_finishPhyXmit" function.

//Note: You may be wondering why the act of transmitting is broken up into three function calls (4,5,6 of pseudocode above).
//In this simple exercise, it seems a bit unnecessary. However, the reason for this division will become clear in later labs.

/**********************DELETE FOR WORKSHOP***************************/
	//Buffer for holding a packet-to-xmit
	Macframe txBuffer;
	//Set the length field in the header
	txBuffer.header.length = length;
	//Set the modulation scheme for the packet's full-rate symbols
	txBuffer.header.fullRate = pktFullRate;
	txBuffer.header.codeRate = pktCodeRate;
	//Copy the header over to packet buffer 1
	warpmac_prepPhyForXmit(&txBuffer,1);
	//Send packet buffer 1
	warpmac_startPhyXmit(1);
	//Wait for it to finish and enable the receiver
	warpmac_finishPhyXmit();
/**********************DELETE FOR WORKSHOP***************************/

}

///@brief Callback for the reception of bad wireless headers
///
///@param packet Pointer to received Macframe
void phyRx_badHeader_callback() {
	warpmac_incrementLEDLow();
	pktCount++;
//	if(pktCount%250 == 0 & agcPrintMode)
    if(agcPrintMode)
	{
		agcGains = ofdm_AGC_GetGains();
		pktDet_rssi = ofdm_txrx_mimo_ReadReg_Rx_PktDet_midPktRSSI_antA();
		xil_printf("(bad)\tAGC Gains: %d %d\t%d %d\t", agcGains&0x3, (agcGains>>2)&0x1F, (agcGains>>8)&0x3, (agcGains>>10)&0x1F);
		xil_printf("AGC Thresholds: %d / %d / %d\t", (0xFFFFFF00 | agc_coarseThresh_1), (0xFFFFFF00 | agc_coarseThresh_2), (0xFFFFFF00 | agc_coarseThresh_3) );
        xil_printf("RSSI (ant A): %d\r\n", pktDet_rssi);
	}

	userIOBoard_LEDs = userIOBoard_LEDs==0x80 ? 0x01 : (userIOBoard_LEDs << 1);
	warp_userioboard_set_leds(userIOBoard_LEDs);

	pktCount_bad++;
}

///@brief Callback for the reception of good wireless headers
///
///This function then polls the PHY to determine if the entire packet passes checksum
///thereby triggering the transmission of the received data over Ethernet.
///@param packet Pointer to received Macframe
void phyRx_goodHeader_callback(Macframe* packet){

/**********************DELETE FOR WORKSHOP***************************/	
	unsigned char state=INCOMPLETE;	
	while(state==INCOMPLETE){
		//Blocks until the PHY reports the received packet as either good or bad
		state = mimo_ofdmRx_getPayloadStatus();
	}

	pktCount++;
	if(pktCount%250 == 0 & agcPrintMode)
	{
		agcGains = ofdm_AGC_GetGains();
		pktDet_rssi = ofdm_txrx_mimo_ReadReg_Rx_PktDet_midPktRSSI_antA();
		xil_printf("(good)\tAGC Gains: %d %d\t%d %d\t", agcGains&0x3, (agcGains>>2)&0x1F, (agcGains>>8)&0x3, (agcGains>>10)&0x1F);
		xil_printf("AGC Thresholds: %d / %d / %d\t", (0xFFFFFF00 | agc_coarseThresh_1), (0xFFFFFF00 | agc_coarseThresh_2), (0xFFFFFF00 | agc_coarseThresh_3) );
        xil_printf("RSSI (ant A): %d\r\n", pktDet_rssi);
	}
	
	if(state&GOOD){
		warpmac_incrementLEDHigh();
		//Starts the DMA transfer of the payload into the EMAC
//		warpmac_prepEmacForXmit(packet);
		//Waits until the DMA transfer is complete, then starts the EMAC
//		warpmac_startEmacXmit(packet);			

		userIOBoard_LEDs = userIOBoard_LEDs==0x01 ? 0x80 : (userIOBoard_LEDs >> 1);
		warp_userioboard_set_leds(userIOBoard_LEDs);
		
		pktCount_good++;
	}
	
	if(state&BAD){
		//Bad packet, but good header
		warpmac_incrementLEDLow();
	}
/**********************DELETE FOR WORKSHOP***************************/
}
void getByte(unsigned char uartByte)
{
	if(uartByte != 0x0)
	{
		xil_printf("(%c)\t", uartByte);

		if(uartByte==ASCII_Z) {
			//Enable Alamouti mode
			mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() & (~RX_SISO_MODE), DEFAULT_STATUSBITS);
			mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() | RX_ALAMOUTI_MODE, DEFAULT_STATUSBITS);
			mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & (~TX_SISO_MODE));
			mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | TX_ALAMOUTI_MODE);
			mimo_ofdmRx_setRxScaling(0x08000800); 

			xil_printf("Enabled Alamouti\r\n");
		}
		if(uartByte==ASCII_z) {
			//Disable Alamouti mode
			mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() & (~RX_ALAMOUTI_MODE), DEFAULT_STATUSBITS);
			mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() | RX_SISO_MODE, DEFAULT_STATUSBITS);
			mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & (~TX_ALAMOUTI_MODE));
			mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | TX_SISO_MODE);
			mimo_ofdmRx_setRxScaling(0x10001000); 

			xil_printf("Disabled Alamouti\r\n");
		}
		
		
		if(uartByte==ASCII_T) {warpphy_set_B_KPPlus(0x20000);}
		if(uartByte==ASCII_t) {warpphy_set_B_KPMinus(0x20000);}
		if(uartByte==ASCII_G) {warpphy_set_B_KIPlus(0x100);}
		if(uartByte==ASCII_g) {warpphy_set_B_KIMinus(0x100);}
		
		if(uartByte==ASCII_P) {mimo_ofdmRx_setPNTrack_K(0x2700000); xil_printf("Enabled PN tracking\r\n");}
		if(uartByte==ASCII_p) {mimo_ofdmRx_setPNTrack_K(0); xil_printf("Disabled PN tracking\r\n");}

		if(uartByte==ASCII_C) {mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() | COARSE_CFO_EN, DEFAULT_STATUSBITS); xil_printf("Enabled coarse CFO\r\n");}
		if(uartByte==ASCII_c) {mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() & ~COARSE_CFO_EN, DEFAULT_STATUSBITS); xil_printf("Disabled coarse CFO\r\n");}
	
		if(uartByte==ASCII_A) warpphy_setTargetPlus();
		if(uartByte==ASCII_a) warpphy_setTargetMinus();
	
		if(uartByte==ASCII_N) warpphy_setNoiseTargetPlus();
		if(uartByte==ASCII_n) warpphy_setNoiseTargetMinus();

		if(uartByte==ASCII_s) {agcPrintMode = agcPrintMode^1; if(agcPrintMode) xil_printf("Enabled AGC print mode\r\n"); else xil_printf("Disabled AGC print mode\r\n");}

		if(uartByte==ASCII_u) {txUpconvLin = (txUpconvLin + 1)%4; updateRadReg9 = 1;}
		if(uartByte==ASCII_i) {txVGALin = (txVGALin + 1)%4; updateRadReg9 = 1;}
		if(uartByte==ASCII_o) {txBBGain = (txBBGain + 1)%4; updateRadReg9 = 1;}
		
		if(updateRadReg9)
		{
			radReg9 = (0x9) + (txBBGain << 4) + (txUpconvLin << 6) + (txVGALin << 10);
			transmit(radReg9); xil_printf("RadReg 9: bbG: %d, UpLin: %d, VGALin: %d\r\n", txBBGain, txUpconvLin, txVGALin);
			updateRadReg9 = 0;
		}
		
		if(uartByte==ASCII_m) {transmit(((0x0003<<4)+0x0009)); xil_printf("Set min Tx linearity\r\n");}
		if(uartByte==ASCII_M) {transmit(((0x03CF<<4)+0x0009)); xil_printf("Set max Tx linearity\r\n");}

		if(uartByte==ASCII_L) {WarpRadio_v1_RxLpfCornFreqCoarseAdj(1, FIRST_RADIO | SECOND_RADIO); xil_printf("RxLPF = 1\r\n");}
		if(uartByte==ASCII_l) {WarpRadio_v1_RxLpfCornFreqCoarseAdj(0, FIRST_RADIO | SECOND_RADIO); xil_printf("RxLPF = 0\r\n");}
		
		if(uartByte==ASCII_H) {WarpRadio_v1_RxHighPassCornerFreq(1, FIRST_RADIO | SECOND_RADIO); xil_printf("RxHPF = 1\r\n");}
		if(uartByte==ASCII_h) {WarpRadio_v1_RxHighPassCornerFreq(0, FIRST_RADIO | SECOND_RADIO); xil_printf("RxHPF = 0\r\n");}

		if(uartByte==ASCII_D) {RADIO_CONTROLLER_mWriteSlaveReg1(XPAR_RADIO_CONTROLLER_0_BASEADDR, (RADIO_CONTROLLER_mReadSlaveReg1(XPAR_RADIO_CONTROLLER_0_BASEADDR) | RAD_ADC_RX_DCS_MASK)); xil_printf("ADC DCS = 1\r\n");}
		if(uartByte==ASCII_d) {RADIO_CONTROLLER_mWriteSlaveReg1(XPAR_RADIO_CONTROLLER_0_BASEADDR, (RADIO_CONTROLLER_mReadSlaveReg1(XPAR_RADIO_CONTROLLER_0_BASEADDR) & ~RAD_ADC_RX_DCS_MASK)); xil_printf("ADC DCS = 0\r\n");}

		if(uartByte==ASCII_1) {fftScaling_Rx_1 = 0x3&(fftScaling_Rx_1+1); updateFFTscaling = 1;}
		if(uartByte==ASCII_2) {fftScaling_Rx_2 = 0x3&(fftScaling_Rx_2+1); updateFFTscaling = 1;}
		if(uartByte==ASCII_3) {fftScaling_Rx_3 = 0x3&(fftScaling_Rx_3+1); updateFFTscaling = 1;}

        if(uartByte==ASCII_7) {fftScaling_Tx_1 = 0x3&(fftScaling_Tx_1+1); updateFFTscaling = 1;}
		if(uartByte==ASCII_8) {fftScaling_Tx_2 = 0x3&(fftScaling_Tx_2+1); updateFFTscaling = 1;}
		if(uartByte==ASCII_9) {fftScaling_Tx_3 = 0x3&(fftScaling_Tx_3+1); updateFFTscaling = 1;}
        
		if(uartByte==ASCII_4) {agc_coarseThresh_1 = 0xFF&(agc_coarseThresh_1+1); updateAGCthresh = 1;}
		if(uartByte==ASCII_5) {agc_coarseThresh_2 = 0xFF&(agc_coarseThresh_2+1); updateAGCthresh = 1;}
		if(uartByte==ASCII_6) {agc_coarseThresh_3 = 0xFF&(agc_coarseThresh_3+1); updateAGCthresh = 1;}

		if(uartByte==ASCII_DOLLAR)	{agc_coarseThresh_1 = 0xFF&(agc_coarseThresh_1-1); updateAGCthresh = 1;}
		if(uartByte==ASCII_PERCENT)	{agc_coarseThresh_2 = 0xFF&(agc_coarseThresh_2-1); updateAGCthresh = 1;}
		if(uartByte==ASCII_CARROT)	{agc_coarseThresh_3 = 0xFF&(agc_coarseThresh_3-1); updateAGCthresh = 1;}

        if(uartByte==ASCII_f) { if(chan>1) chan--; warpphy_setChannel(GHZ_2, chan); xil_printf("Channe: %d\r\n", chan);}
        if(uartByte==ASCII_F) { if(chan<14) chan++; warpphy_setChannel(GHZ_2, chan); xil_printf("Channe: %d\r\n", chan);}
        
        if(uartByte==ASCII_q) {pktDet_thresh = pktDet_thresh - 100; ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(pktDet_thresh); xil_printf("PktDet Thresh: %d\r\n", pktDet_thresh); }
        if(uartByte==ASCII_Q) {pktDet_thresh = pktDet_thresh + 100; ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(pktDet_thresh); xil_printf("PktDet Thresh: %d\r\n", pktDet_thresh); }
        
        if(uartByte==ASCII_V) {
            txScaling_preamble = txScaling_preamble + 100; //Add (0.05/4)
            txScaling_payload = txScaling_payload + 400; //Add 0.05
            mimo_ofdmTx_setTxScaling(txScaling_preamble, txScaling_payload);
            xil_printf("TxScaling: Pre=%d Pay=%d\r\n", txScaling_preamble, txScaling_payload);
        }
        
        if(uartByte==ASCII_v) {
            txScaling_preamble = txScaling_preamble - 100; //Subtract (0.05/4)
            txScaling_payload = txScaling_payload - 400; //Subtract 0.05
            mimo_ofdmTx_setTxScaling(txScaling_preamble, txScaling_payload);
            xil_printf("TxScaling: Pre=%d Pay=%d\r\n", txScaling_preamble, txScaling_payload);
        }
        
        if(uartByte==ASCII_k) {ofdm_txrx_mimo_WriteReg_Rx_PktDet_setMask((pktDetMask++)%4); xil_printf("pktDetMask: %d\r\n", pktDetMask);}
        
		if(uartByte==ASCII_r) {xil_printf("Rx scaling: %x\r\n", XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_CONSTELLATION_SCALING_W));}
	
		if(updateFFTscaling)
		{
			mimo_ofdmTxRx_setFFTScaling((unsigned int)(((16*fftScaling_Rx_1 + 4*fftScaling_Rx_2 + 1*fftScaling_Rx_3)<<6 ) | (16*fftScaling_Tx_1 + 4*fftScaling_Tx_2 + 1*fftScaling_Tx_3)));
			xil_printf("FFT Tx Scaling: %d / %d / %d\r\n", fftScaling_Tx_1, fftScaling_Tx_2, fftScaling_Tx_3);
			xil_printf("FFT Rx Scaling: %d / %d / %d\r\n", fftScaling_Rx_1, fftScaling_Rx_2, fftScaling_Rx_3);
			updateFFTscaling = 0;
		}

		if(updateAGCthresh)
		{
			OFDM_AGC_MIMO_WriteReg_Thresholds(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR,  ((agc_coarseThresh_1&0xFF)<<16) + ((agc_coarseThresh_2&0xFF)<<8) + (agc_coarseThresh_3&0xFF) );
			xil_printf("AGC Thresholds: %d / %d / %d\r\n", (0xFFFFFF00 | agc_coarseThresh_1), (0xFFFFFF00 | agc_coarseThresh_2), (0xFFFFFF00 | agc_coarseThresh_3) );
			updateAGCthresh = 0;
		}
	}

	return;
}

///@brief Main function
///
///This function configures MAC parameters, enables the underlying frameworks, and then loops forever.
int main(){		
	xil_printf("DEBUGMAC\r\n");

	updateFFTscaling = 0;
	updateAGCthresh = 0;
	pktCount = 0;
	chan = 9;
	dacGain_coarse = 0;
	dacGain_fine = 255;
	agcPrintMode = 0;
    pktDetMask = 1;
    
	pktFullRate = HDR_FULLRATE_QPSK;
	
	pktCodeRate = CODE_RATE_NONE;
	TxGainBB = 3;
	TxGainRF = 0x3F;
	userIOBoard_LEDs = 1;
	pktCount_good = 0;
	pktCount_bad = 0;
	
	fftScaling_Rx_1 = RX_FFT_SCALING_STAGE1;
	fftScaling_Rx_2 = RX_FFT_SCALING_STAGE2;
	fftScaling_Rx_3 = RX_FFT_SCALING_STAGE3;
	fftScaling_Tx_1 = TX_FFT_SCALING_STAGE1;
	fftScaling_Tx_2 = TX_FFT_SCALING_STAGE2;
	fftScaling_Tx_3 = TX_FFT_SCALING_STAGE3;
	
	agc_coarseThresh_1 = 0xE2; //-30
	agc_coarseThresh_2 = 0xCB; //-53
	agc_coarseThresh_3 = 0xA6; //-90

    txScaling_preamble = 2080;
    txScaling_payload = 8192;

	radReg9 = 0x0003;
	updateRadReg9 = 0;
	txBBGain = 0x0;
	txUpconvLin = 0x0;
	txVGALin = 0x0;
	
	
	
	pktDet_thresh = 4000;
    cs_thresh = 6000;
    
    //Initialize the framework
	warpmac_init();
	
	//Rx Buffer where the wireless PHY will write packets
	warpmac_setRxBuffer(&rxBuffer,0);
	//Tx buffer is where the EMAC will DMA payloads to
	warpmac_setTxBuffer(1);
	
	//Connect the various user-level callbacks
	warpmac_setBadHeaderCallback((void *)phyRx_badHeader_callback);
	warpmac_setGoodHeaderCallback((void *)phyRx_goodHeader_callback);
	warpmac_setEmacCallback((void *)emacRx_callback);
	warpmac_setUpButtonCallback((void *)up);
	warpmac_setMiddleButtonCallback((void *)middle);
	warpmac_setLeftButtonCallback((void *)left);
	warpmac_setRightButtonCallback((void *)right);
	warpmac_setUartRecvCallback((void *)getByte);
	
    
    ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(pktDet_thresh);
	ofdm_txrx_mimo_WriteReg_Rx_CSMA_setThresh(cs_thresh);
    
    //Set the default center frequency
	warpphy_setChannel(GHZ_2, chan);
	
	//Enable carrier sensing
	warpmac_enableCSMA();
	
	//Enable Ethernet
	warpmac_enableEthernet();
	
	//Set the modulation scheme use for base rate (header) symbols
	warpmac_setBaseRate(QPSK);
    
	OFDM_AGC_MIMO_WriteReg_Thresholds(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR,  ((agc_coarseThresh_1&0xFF)<<16) + ((agc_coarseThresh_2&0xFF)<<8) + (agc_coarseThresh_3&0xFF) );

	//Set initial Tx gains; controlled by push buttons below
	WarpRadio_v1_SetTxGainTiming(FIRST_RADIO | SECOND_RADIO, TxGainRF, 0xF, 1);
	WarpRadio_v1_BaseBandTxGain(TxGainBB, FIRST_RADIO | SECOND_RADIO);

	//Initialize the LCD for slot 1 (i.e. don't flip the image) and non-inverted colors
	warp_userioboard_lcd_init(1, 0);
	warp_userioboard_set_lcd_charbuf(1);
	
	snprintf(charsToPrint, 16, "Ref Design v12a");
	warp_userio_lcd_printline(charsToPrint, 16, 1, 1);

	snprintf(charsToPrint, 16, "  Rx Pkt Counts");
	warp_userio_lcd_printline(charsToPrint, 16, 3, 1);
	
	warp_userioboard_set_leds(userIOBoard_LEDs);

	if(warpmac_getMyId())
	{
		while(1){
			warpmac_pollPeripherals();
		}
	}
	else
	{
		xil_printf("Debug menu:\r\n");
		
		while(1)
		{
			warpmac_pollPeripherals();
		}
	}
	return;
}



///@brief Callback for the depression of the left push button
///
///This button selects the left radio (slot 2) for Tx and Rx
void left(){
	
	switch(pktFullRate)
	{
		case HDR_FULLRATE_BPSK:
			pktFullRate = HDR_FULLRATE_BPSK;
			xil_printf("Tx: BPSK\r\n");
		break;
		case HDR_FULLRATE_QPSK:
			pktFullRate = HDR_FULLRATE_BPSK;
			xil_printf("Tx: BPSK\r\n");
		break;
		case HDR_FULLRATE_QAM_16:
			pktFullRate = HDR_FULLRATE_QPSK;
			xil_printf("Tx: QPSK\r\n");
		break;
		case HDR_FULLRATE_QAM_64:
			pktFullRate = HDR_FULLRATE_QAM_16;
			xil_printf("Tx: 16-QAM\r\n");
		break;
		default:
			pktFullRate = HDR_FULLRATE_QPSK;
			xil_printf("Tx: QPSK\r\n");
		break;
	}

}

///@brief Callback for the depression of the right push button
///
///This button selects the right radio (slot 3) for Tx and Rx
void right(){
	switch(pktFullRate)
	{
		case HDR_FULLRATE_BPSK:
			pktFullRate = HDR_FULLRATE_QPSK;
			xil_printf("Tx: QPSK\r\n");
		break;
		case HDR_FULLRATE_QPSK:
			pktFullRate = HDR_FULLRATE_QAM_16;
			xil_printf("Tx: 16-QAM\r\n");
		break;
		case HDR_FULLRATE_QAM_16:
			pktFullRate = HDR_FULLRATE_QAM_64;
			xil_printf("Tx: 64-QAM\r\n");
		break;
		case HDR_FULLRATE_QAM_64:
			pktFullRate = HDR_FULLRATE_QAM_64;
			xil_printf("Tx: 64-QAM\r\n");
		break;
		default:
			pktFullRate = HDR_FULLRATE_QPSK;
			xil_printf("Tx: QPSK\r\n");
		break;
	}
}

///@brief Callback for the depression of the up push button
///
///This button increments the 2.4GHz channel being used
void up(){
	TxGainRF = (TxGainRF+1) & 0x3F;
	WarpRadio_v1_SetTxGainTiming(FIRST_RADIO | SECOND_RADIO, TxGainRF, 0xF, 1);
	WarpRadio_v1_TxVGAGainControl(TxGainRF, FIRST_RADIO | SECOND_RADIO);
	xil_printf("TxGainRF: %x\r\n", TxGainRF);
}

///@brief Callback for the depression of the middle push button
///
///This button decrements the 2.4GHz channel being used
void middle(){
	TxGainRF = (TxGainRF-1) & 0x3F;
	WarpRadio_v1_SetTxGainTiming(FIRST_RADIO | SECOND_RADIO, TxGainRF, 0xF, 1);
	WarpRadio_v1_TxVGAGainControl(TxGainRF, FIRST_RADIO | SECOND_RADIO);
	xil_printf("TxGainRF: %x\r\n", TxGainRF);
}


/*

///@brief Callback for the depression of the left push button
///
///This button selects the left radio (slot 2) for Tx and Rx
void left(){
	warpphy_setTargetMinus();
}

///@brief Callback for the depression of the right push button
///
///This button selects the right radio (slot 3) for Tx and Rx
void right(){
	warpphy_setTargetPlus();
}

#define DAC_COARSE 1
//#define DAC_FINE 1

///@brief Callback for the depression of the up push button
///
///This button increments the 2.4GHz channel being used
void up(){
	RADIO_CONTROLLER_mWriteSlaveReg5((volatile)radio_controller_baseaddr, 0x3410);                  // Set the value of the Control Register to 0x00003410 for DACs
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)radio_controller_baseaddr, 1);                // Set the value for the Divider Register to 0x00000001
	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASKDAC & (RADIO1_ADDR | RADIO2_ADDR | RADIO3_ADDR | RADIO4_ADDR)));                // Select all DACs

#ifdef DAC_COARSE
	dacGain_coarse++;
	if(dacGain_coarse > 15)
		dacGain_coarse = 0;
	
	WarpRadio_v1_DACCoarseGainAdj(ICHAN, dacGain_coarse, RADIO2_ADDR);
	WarpRadio_v1_DACCoarseGainAdj(QCHAN, dacGain_coarse, RADIO2_ADDR);
	xil_printf("Set DAC coarse gain = %d\r\n", dacGain_coarse);
#endif

#ifdef DAC_FINE
	dacGain_fine++;
	if(dacGain_fine > 255)
		dacGain_fine = 0;


	WarpRadio_v1_DACFineGainAdj(ICHAN, dacGain_fine, RADIO2_ADDR);
	WarpRadio_v1_DACFineGainAdj(QCHAN, dacGain_fine, RADIO2_ADDR);
	xil_printf("Set DAC fine gain = %d\r\n", dacGain_fine);
#endif
}

///@brief Callback for the depression of the middle push button
///
///This button decrements the 2.4GHz channel being used
void middle(){
	RADIO_CONTROLLER_mWriteSlaveReg5((volatile)radio_controller_baseaddr, 0x3410);                  // Set the value of the Control Register to 0x00003410 for DACs
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)radio_controller_baseaddr, 1);                // Set the value for the Divider Register to 0x00000001
	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASKDAC & (RADIO1_ADDR | RADIO2_ADDR | RADIO3_ADDR | RADIO4_ADDR)));                // Select all DACs

#ifdef DAC_COARSE
	dacGain_coarse--;
	if(dacGain_coarse > 15)
		dacGain_coarse = 15;
	
	WarpRadio_v1_DACCoarseGainAdj(ICHAN, dacGain_coarse, RADIO2_ADDR);
	WarpRadio_v1_DACCoarseGainAdj(QCHAN, dacGain_coarse, RADIO2_ADDR);
	xil_printf("Set DAC coarse gain = %d\r\n", dacGain_coarse);
#endif

#ifdef DAC_FINE
	dacGain_fine--;
	if(dacGain_fine > 255)
		dacGain_fine = 255;


	WarpRadio_v1_DACFineGainAdj(ICHAN, dacGain_fine, RADIO2_ADDR);
	WarpRadio_v1_DACFineGainAdj(QCHAN, dacGain_fine, RADIO2_ADDR);
	xil_printf("Set DAC fine gain = %d\r\n", dacGain_fine);
#endif
}
*/
