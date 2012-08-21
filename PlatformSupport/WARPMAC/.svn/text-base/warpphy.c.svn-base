/*! \file warpphy.c
 \brief Provide PHY-specific functions for interfacing WARPMAC (and MAC code) to the OFDM PHY peripherals
 
 @version 15.22
 @author Chris Hunter & Patrick Murphy
 
 Many of the register names and bit assignments in this file depend on the design of the OFDM PHY. You must
 use matching versions of WARPMAC, WARPPHY and ofdm_txrx_mimo. Refer to the wireless reference designs for
 known-good combinations of versions.
 */

//XPS-generated header with peripheral parameters
#include "warp_fpga_board.h"
#include "xparameters.h"

//Header for WARPPHY Interface
#include "warpphy.h"

//Header for WARPMAC framework (required for some global values)
#include "warpmac.h"

// These header files define some macros for reading/writing registers in the Sysgen-designed cores
// This layer of macros keep this code independent from the name of the sysgen core
//  (sysgen defines its register names as a function of the .mdl file name)
#include "ofdm_txrx_mimo_regMacros.h"
#include "ofdm_agc_mimo_regMacros.h"
#include "warp_timer_regMacros.h"

//Headers for other WARP peripheral cores
#include "EEPROM.h"
#include "radio_controller_basic.h"
#include "radio_controller_ext.h"
#include "radio_controller_adv.h"
#include "radio_controller_5ghz.h"

//Other standard header files
#include <stdio.h>
#include <string.h>

//********Globals********
int agc_targetRxPowerOut;
int agc_noisePowerEstimate;

unsigned char baseRateMod;
unsigned int numTrainingSyms;
unsigned int ofdmRx_pktDetDly;
unsigned int numBaseRate;
unsigned char txGain;
unsigned char RxSoftDecodingEn;
unsigned short pktDet_corrCounterLoad;
unsigned char pktDet_corrWindowStart;
unsigned char pktDet_corrWindowEnd;

unsigned int pktDet_energyThresh;
unsigned int pktDet_carrierSenseThresh;
unsigned char pktDet_threshMinDur;

unsigned int warpphy_txAntMode;
unsigned int warpphy_rxAntMode;
unsigned int activeRadios_Tx, activeRadios_Rx;
unsigned int activePHYStatusBits;
unsigned short longCorrThresh;
unsigned int afScaling;

unsigned short pktDetCFOsampCount;

unsigned int RxFFT_Window_Offset;
unsigned int txScaling_preamble;
unsigned int txScaling_payload;

unsigned int agcIIR_g, agcIIR_fb;


/////////////////////////////////

///@brief Initializes the OFDM PHY core
///The OFDM PHY and radio controller cores have many options which must be configured before they can
///be used over the air. This funciton configures these cores with sensible defaults.
int warpphy_init(){
	unsigned int i;
	xil_printf("  Initializing WARPPHY:\r\n");

	//Set the default antenna configuration
	warpphy_txAntMode = TX_ANTMODE_SISO_ANTA;
	warpphy_rxAntMode = RX_ANTMODE_SISO_ANTA;
	activePHYStatusBits = DEFAULT_STATUSBITS;

	//Hold the PHY in reset until everything it setup; the reset does not initialize the PHY's registers
	mimo_ofdmTx_disable();
	mimo_ofdmRx_disable();
	
	//Initialize global variables
	longCorrThresh = 9000;//3500; //2750
	
	afScaling = 2944;//6656; 

	//AGC target output power, in units of dBv (voltage at MAX2829 output)
    agc_targetRxPowerOut = -12;

	//AGC noise power estimate, in dBm
	agc_noisePowerEstimate = -95;

	//Base-rate modulation scheme; should be QPSK
    baseRateMod = QPSK;

	//Number of training symbol periods (all on 1 antenna for SISO, split across antennas for MIMO)
    numTrainingSyms = NUM_TRAINING_SYMBOLS;

	//Number of base rate OFDM symbols; every node must agree on this number ahead of time
	// IF FEC is enabled, the base rate symbols are always encoded at rate 1/2, so a 24-byte
	// header at QPSK occupies 4 symbols (instead of 2 when uncoded)
    numBaseRate = NUM_BASERATE_SYMBOLS;

	//Packet detection delay, in sys_clk cycles
    // The Rx PHY waits this long before searching for correlation peaks
    ofdmRx_pktDetDly = 124;

    //Tx RF gain (6-bit value in [0,63])
	txGain = 0x3f;

    //Tx scaling values; both are interpreted as UFix16_13 values
    // The ratio of preamble/payload values should be approx 1/4
	// Increasing these values will increase Tx power at the expense of clipping
    txScaling_preamble = 3072;
    txScaling_payload  = 12288;
    
    //Packet detector parameters
	// Energy threshold - X/16 = RSSI
    pktDet_energyThresh = 8000;

	//Carrier sensing threshold - 8192/16 = RSSI of 512 (approx -65dBm Rx power)
	pktDet_carrierSenseThresh = 8192;
	
	//Minimum duration of energy-above-energyThresh required to assert a packet detection
    pktDet_threshMinDur = 24;
	
	//Define the FFT start offset (FFT will use (15 - offset) samples of cyclic prefix to handle synchronization
    RxFFT_Window_Offset = INIT_RXFFTOFSET;

	//Set some magic numbers for the CFO correction calculations; these are only used for pre-correcting CFO in DF mode
	warpphy_setPilotCFOCorrection(0x8025AEE6);
	warpphy_setCoarseCFOCorrection(30533);

	/*****************Radio Setup******************/
	xil_printf("\tInitializing Radio Transmitter...\r\n");
	
	//The second argument sets the clock ratio in the radio controller's SPI controller
	// 1 is good for a 40MHz bus
	// 2 is the right value for an 80MHz bus
	WarpRadio_v1_Reset((unsigned int *)XPAR_RADIO_CONTROLLER_0_BASEADDR, 1);
	
	xil_printf("\tStarting TxDCO correction...\r\n");

	//Apply the stored TX DC offset correction values for each radio
	warpphy_applyTxDCOCalibration(FIRST_RADIO);
	warpphy_applyTxDCOCalibration(SECOND_RADIO);
	
	//Configure some MAX2829 Tx parameters for good wideband performance

	//Disable software control of the TxEn/RxEn signals; the PHY will control these
	WarpRadio_v1_RxEnSoftControlDisable(BOTH_RADIOS);
	WarpRadio_v1_TxEnSoftControlDisable(BOTH_RADIOS);
	
    //Set Tx bandwidth - 0x1 = 24MHz (minimum)
	WarpRadio_v1_TxLpfCornFreqCoarseAdj(0x1, BOTH_RADIOS);
	
	//Enable hardware control of Tx gains (handled by the radio controller Tx state machine)
	WarpRadio_v1_SoftwareTxGainControl(0, BOTH_RADIOS);
	
	//Four arguments: dly_TxEn, dly_TxStart, dly_GainRampEn, dly_PowerAmpEn, each in units of bus clock cycles
	WarpRadio_v1_SetTxTiming(BOTH_RADIOS, 0, 200, 100, 0);

	//Three arguments: targetGain, gainStep, stepInterval; max targetGain is 0x3F
	WarpRadio_v1_SetTxGainTiming(BOTH_RADIOS, txGain, 0xF, 1);
	
	//Set the MAX2829 Tx baseband gain; 0x3 is max gain
	WarpRadio_v1_BaseBandTxGain(0x3, BOTH_RADIOS);
	
	xil_printf("\tInitializing Radio Receiver...");

	//Enable hardware AGC control of receive gains & RxHP
	WarpRadio_v1_RxHpSoftControlDisable(BOTH_RADIOS);
	WarpRadio_v1_SoftwareRxGainControl(0, BOTH_RADIOS);

	//Set bandwith with RxHP=0; RxHighPassCornerFreq(0) is critical for good performance
	WarpRadio_v1_RxHighPassCornerFreq(0, BOTH_RADIOS);
	
	//Set Rx bandwidth; 0x0 = 15MHz (minimum)
	WarpRadio_v1_RxLpfCornFreqCoarseAdj(0, BOTH_RADIOS);
	
	xil_printf("complete!\r\n");
	/**********************************************************/
	
	/*******************Packet Detector************************/
	xil_printf("\tInitializing Packet Detection...");

	//Assert the packet detection output reset
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_ignoreDet(1);

	//Set the RSSI clock ratio; 0=sys_clk/4; 1=sys_clk/8
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setRSSIclkRatio(0);

    //Set the minimum energy duration
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setMinDuration(pktDet_threshMinDur);
	
    //Enable the carrier-sensing block's IDLE output (the timer can choose to use or ignore it)
	ofdm_txrx_mimo_WriteReg_Rx_CSMA_enableIdle(1);
	
    //Hold the packet detector's running sum in reset
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_resetSum(1);
	
	//Configure the packet detector's antenna masks (1=antA, 2=antB, 3=both)
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setMask(PKTDET_MASK_ANTA);
	
	//Set the packet detector's logic mode for the two antenna ports; 0 = AND, 1 = OR
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setMode(1);
	
	//Set the running sum length; 16 is a good default
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setAvgLen(PKTDET_RSSI_SUMLEN);
	
	//Set the detector's energy threshold; this value must be scaled relative to the sum-length
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(pktDet_energyThresh);
	
	//Set the carrier sensing threshold to a very high level, disabling it by default
	ofdm_txrx_mimo_WriteReg_Rx_CSMA_setThresh(CSMA_DISABLED_THRESH);

	//Set the DIFS period; this is the require IDLE time before the IDLE output will assert
    // Units are sys_clk/4 cycles (10MHz), so 300 = 30us
    // This delay must exceed the TxDATA->TxACK turn around time (currently 23us)
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setDIFSPeriod(300);
	
	//Deassert the running sum reset; the sum will run continuously after this
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_resetSum(0);
	
	//Set thresholds for the autoCorrelation detector
	//CorrThresh (UFix8_7): 0.7 ≈ 90
	//MinPoiwer (UFix12_0); 2048 is theoretical max, 100-300 is more realistic, 0 works too
	ofdm_txrx_mimo_WriteReg_Rx_PktDetCorr_params(90, 0);

	//Enable both the RSSI and autoCorrelation packet detectors
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_rssiDetEn(1);
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_corrDetEn(1);
	
	//Deassert the packet detection output reset; packet detection events will start after this
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_ignoreDet(0);
	
	xil_printf("complete!\r\n");
	/**********************************************************/
	
	/*************************PHY******************************/

	xil_printf("\tInitializing OFDM Transmitter...");
	
	//Clear all the match and action blocks in the auto response system
	mimo_ofdmTxRx_setAction0(0);
	mimo_ofdmTxRx_setAction1(0);
	mimo_ofdmTxRx_setAction2(0);
	mimo_ofdmTxRx_setAction3(0);
	mimo_ofdmTxRx_setAction4(0);
	mimo_ofdmTxRx_setAction5(0);
	mimo_ofdmTxRx_setMatch0(0);
	mimo_ofdmTxRx_setMatch1(0);
	mimo_ofdmTxRx_setMatch2(0);
	mimo_ofdmTxRx_setMatch3(0);
	mimo_ofdmTxRx_setMatch4(0);
	mimo_ofdmTxRx_setMatch5(0);
	mimo_ofdmTxRx_setMatch6(0);
	mimo_ofdmTxRx_setMatch7(0);

	//Fill in the header translator with non-translating values by default
	// This will "overwrite" the header with the same pktbuf/byte combos as the template buffer
	// User code will override some entries here to implement a protocol
	for(i=0; i<(32*32); i++)
	{
		//Each entry is a 10-bit number of {srcBuf[4:0], srcByteAddr[4:0]}
		XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXHEADERTRANSLATE+i*sizeof(int), (i & 0x3FF));
	}
	
	//Set the AF scaling
	mimo_ofdmRx_setAFTxScaling(afScaling);
	
	//Set the minimum magnitude for channels to use their pilots
	mimo_ofdmRx_setPilotCalcParams(0xFFF); //MinMag as UFix12_12 (41 ~= 0.01)
	
	//Configure the FFT scaling values in the PHY Tx and Rx
    // 6-bits each, 6LSB are Tx scaling; 6LSB+6 are Rx scaling
	mimo_ofdmTxRx_setFFTScaling((unsigned int)((
                                (16*RX_FFT_SCALING_STAGE1 + 4*RX_FFT_SCALING_STAGE2 + 1*RX_FFT_SCALING_STAGE3)<<6 ) | 
                                (16*TX_FFT_SCALING_STAGE1 + 4*TX_FFT_SCALING_STAGE2 + 1*TX_FFT_SCALING_STAGE3)));
	
	//Subcarrier indicies for pilot tones - the values here must line up with zeros in the modulation setup for each subcarrier
	// Subcarriers [-21,-7,7,21] are the default, matching the 802.11a spec
	mimo_ofdmTx_setPilotIndcies((7 + ((64-21)<<8) + ((64-7)<<16) + ((21)<<24) ));
	
	//Pilot tone values are Fix16_15, so
    // Pilot 1 should be negative, pilot 2 should be positive
	// 0x7FFF is +1, 0x8000 is -1
	// 0xA57D is ~-0.707, 0x5A82 is ~+0.707
	mimo_ofdmTxRx_setPilotValues( (0xA57D) + (0x5A82 << 16));
	
	//2 values in this write: number of training symbols and number of base rate symbols
	// The Tx/Rx nodes must agree on these values ahead of time
	warpphy_setTxNumSyms(numBaseRate, numTrainingSyms);
	warpphy_setRxNumSyms(numBaseRate, numTrainingSyms);
	
	//Scaling constant for the transmitted preamble; helps normalize the amplitude of the stored preamble and actual IFFT output
	mimo_ofdmTx_setTxScaling(txScaling_preamble, txScaling_payload);

	//Configure various options in the Tx PHY
	mimo_ofdmTx_setControlBits (
								(3 << 4) | //Preamble shift for antenna B
								((0&0x3F) << 20) | //Cyclic shift
								TX_PILOT_SCRAMBLING | //Pseudo-random scrambling of pilot tones
								TX_SOFTWARE_TXEN | //Use the PHY TxStart register to start the overall PHY/radio Tx state machine
								//TX_RANDOM_PAYLOAD | //Use random payload bytes (user must still provide valid header!)
								//TX_ALWAYS_USE_PRECFO | //Always apply Tx CFO, even if the packet isn't triggered by auto responders
								//TX_DISABLE_ANTB_PREAMBLE | //Disables preamble on antenna B
								0
								);
	
	//Shift antenna B preambles by -3 samples
	warpphy_setAntBPreambleShift(13);

	xil_printf("complete!\r\n");
	
	xil_printf("\tInitializing OFDM Receiver...");

	//Configure the FEC blocks
	// (CodingEn, SoftDecodingEn, ZeroTailEn, QPSK_Scaling, 16QAM_Scaling)
	mimo_ofdmTxRx_setFECoptions(1, 1, 0, 6, 16);
	
	//Configures the default number of samples of the cyclic prefix to use for synchronization offset tolerance
	// Larger values here reduce multipath tolerance
	mimo_ofdmRx_setFFTWindowOffset(INIT_RXFFTOFSET);
	
	//Scaling value is a 32-bit value, composed of two UFix16_11 values
	// So 0x08000800 scales A/B by exactly 1
	// This value is dependent on the number of training symbols
	// For SISO mode and numTraining=2, use 0x10001000 (the default)
	mimo_ofdmRx_setRxScaling(0x10001000); 
	
	//Long correlator parameters (for packet detection confirmation and symbol timing)
	// Top 16-bits are long-correlation threshold; 3000 works well over-the-air
	// Bottom 16-bits are sample index corresponding to the long correlation event
	//  (basically a magic number that aligns the Rx PHY state machine with the incoming packet)

	warpphy_setLongCorrThresh(longCorrThresh);
	
	//The correlator only accepts peaks inside a window relative to the energy detection event
	// Adjust the Start/End values below to grow/shrink the window as needed
	pktDet_corrWindowStart = 90-32;
	pktDet_corrWindowEnd = 180+32;

	pktDet_corrCounterLoad = 251;//232;
	pktDetCFOsampCount = 255;
	mimo_ofdmRx_setLongCorrParams(((pktDet_corrCounterLoad & 0x00FF)	<< 0 ) | \
								  ((pktDetCFOsampCount  & 0x00FF)	<< 8 ) | \
								  ((pktDet_corrWindowStart & 0xFF)	<< 16 ) | \
								  ((pktDet_corrWindowEnd & 0xFF)	<< 24 )); //corr window start/end

	//Sets the delay between the pkt detection assertion and the PHY searching for correlation peaks
	mimo_ofdmRx_setPktDetDly(ofdmRx_pktDetDly);
	mimo_ofdmRx_setCFOCalcDly(0);
	mimo_ofdmRx_setCFOMaxDiff(255); //UFix8_8 - 0.15 * 256 ≈ 38

	warpphy_setPreCFOoptions( (PRECFO_USECOARSE | PRECFO_USEPILOTS) );
	
	//Bottom 8 bits are the number of header bytes per packet; nodes must agree on this at build time
	//	bits[7:0]: number of header bytes (bytes in base-rate symbols)
	//Three more 8-bit values are stored here - each is an index of a byte in the header:
	//	bits[15:8]: less-significant byte of pkt length
	//	bits[23:16]: more-significant byte of pkt length
	//	bits[31:24]: dynamic modulation masks
	//	mimo_ofdmRx_setByteNums( (unsigned int)(NUM_HEADER_BYTES + (2<<8) + (3<<16) + (0<<24) ));
	mimo_ofdmRx_setByteNums( (unsigned int)(NUM_HEADER_BYTES + (3<<8) + (2<<16) + (0<<24) ));
	
	//Configure some sane defaults in the Rx PHY
	mimo_ofdmRx_setOptions
	(
		RESET_BER | //Hold the BER meter in reset
		REQ_LONG_CORR | //Require long correlation for packet detection
		//RSSI_GAIN_ADJ | //Compensate RSSI input to pkt detector for RF gain changes
		//BYPASS_CARR_REC | //Hold the Rx DDS in reset (ignoring any coarse CFO estimate)
		COARSE_CFO_EN | //Enable coarse CFO estimation
		TX_DISABLE_PKTDET | //Ignore packet detection during Tx
		SIMPLE_DYN_MOD_EN | //Use the header's fullRate field for demodulation
		RESET_ON_BAD_HDR | //Reset Rx PHY if header fails CRC
		RECORD_CHAN_ESTS | //Enable the channel estimate recording buffer
		RECORD_CHAN_ESTMAGS | //Enable the channel estimate recording buffer
		//CHANMAG_MASKING_EN | //Enable channel magnitude masking
		0,
		activePHYStatusBits
	);
	
	//Set the modulation masks to sane defaults
	// 0xF enables dynamic modulation for that path
	warpphy_set_modulation(baseRateMod, 0xF, 0xF, 0xF, 0xF);

	//Set the antenna modes to SISO by default
	warpphy_setAntennaMode(TX_ANTMODE_SISO_ANTA, RX_ANTMODE_SISO_ANTA);
	
	warpphy_setNumTrainingSyms(NUM_TRAINING_SYMBOLS);

	//Set min chanest magnitudes (UFix16_15 values; set to zero to effectively disable)
	warpphy_setChanEstMinMags(0);
	
	//Set AF blanking interval (set to zeros to disable)
	warpphy_setAFblanking(0, 0);
	
	XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_FIXEDPKTLEN_W, 0);
	
	xil_printf("complete!\r\n");
	/**********************************************************/
	
	/***************************AGC****************************/
	xil_printf("\tInitializing AGC...");
	//agcIIR_fb = 0x20990; //20kHz cutoff, Fix18_17
	//agcIIR_g =  0x1fb38; //20kHz cutoff, UFix18_17
	agcIIR_fb = 0x20000; //0kHz cutoff, Fix18_17
	agcIIR_g =  0x20000; //0kHz cutoff, UFix18_17
	ofdm_AGC_Initialize(agc_noisePowerEstimate);
	ofdm_AGC_setNoiseEstimate(agc_noisePowerEstimate);

	ofdm_AGC_SetDCO(0x6); //enable both subtraction and IIR filter
	
	ofdm_AGC_SetTarget(agc_targetRxPowerOut);
	ofdm_AGC_Reset();

	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_DCO_IIR_COEF_FB, agcIIR_fb);
	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_DCO_IIR_COEF_GAIN, agcIIR_g);
	
	xil_printf("complete!\r\n");
	/**********************************************************/
	
	/**************************Timer***************************/
	//Initialize the timer hardware; the individual timers will get setup in WARPMAC
	warp_timer_init();
	/**********************************************************/
	
	//Finally enable the PHY
	mimo_ofdmTx_enable();
	mimo_ofdmRx_enable();
	
	return 0;
}

///@brief Clears any pending Rx pkt status in the PHY. Was warpphy_pktAck() in previous versions.
///
///The Rx PHY blocks after asserting either its good or bad packet status bits. The bits
///are cleared by asserting then de-asserting a register bit per status bit. This funciton clears
///both good and bad pkt bits; there is no harm in clearing a status bit that isn't actually asserted.
void warpphy_clearRxPktStatus(){
	
	//The TxRx_Interrupt_PktBuf_Ctrl register has many bits.
	// bits[2:0] are the Rx status enables
	// bits[6:4] are the Rx status resets
	// bit[3] and bit[7] are used for the TxDone status and are preserved here
	ofdm_txrx_mimo_WriteReg_TxRx_Interrupt_PktBuf_Ctrl(OFDM_BASEADDR, ofdm_txrx_mimo_ReadReg_TxRx_Interrupt_PktBuf_Ctrl(OFDM_BASEADDR) | DEFAULT_STATUSBITRESETS);
	ofdm_txrx_mimo_WriteReg_TxRx_Interrupt_PktBuf_Ctrl(OFDM_BASEADDR, ofdm_txrx_mimo_ReadReg_TxRx_Interrupt_PktBuf_Ctrl(OFDM_BASEADDR) &  ~DEFAULT_STATUSBITRESETS);

	return;
}

///@brief Releases the OFDM Rx PHY master reset
///
///De-asserting RX_GLOBAL_RESET allows the Rx PHY to begin processing packets.
void mimo_ofdmRx_enable(){
	
	//Clear any stale interrupts; this should never really be required
	warpphy_clearRxPktStatus();
	
	//De-asert the global reset
	ofdm_txrx_mimo_WriteReg_Rx_ControlBits(OFDM_BASEADDR, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(OFDM_BASEADDR) & ~RX_GLOBAL_RESET);
	
	return;
}

///@brief Holds the OFDM Rx PHY in reset
///
///Asserting the RX_GLOBAL_RESET bit clears nearly all the state in the OFDM Rx. Configuration registers are not cleared.
void mimo_ofdmRx_disable(){
	
	//Assert the global reset
	ofdm_txrx_mimo_WriteReg_Rx_ControlBits(OFDM_BASEADDR, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(OFDM_BASEADDR) | RX_GLOBAL_RESET);

	//Clear any stale interrupts; this should never really be required
	warpphy_clearRxPktStatus();
	
	return;
}

///@brief Configures options in the Rx PHY
///
///@param someOptions 32-bit options value, composed on bitwise OR'd values from warpphy.h
///@param blockingStatusBits Configures which PHY Rx events block future receptions (good/bad header/payload)
void mimo_ofdmRx_setOptions(unsigned int someOptions, unsigned int blockingStatusBits){
	
	//Write the full controlBits register
	ofdm_txrx_mimo_WriteReg_Rx_ControlBits(OFDM_BASEADDR, someOptions);
	
	//The interrupt control bits are in the Interrupt_PktBuf_Ctrl register - bits[7:4]
	//Clear the interrupt control bits
	ofdm_txrx_mimo_WriteReg_TxRx_Interrupt_PktBuf_Ctrl(OFDM_BASEADDR, ofdm_txrx_mimo_ReadReg_TxRx_Interrupt_PktBuf_Ctrl(OFDM_BASEADDR) & 0xFFFFFF00);
	
	//Write just the interrupt control bits
	ofdm_txrx_mimo_WriteReg_TxRx_Interrupt_PktBuf_Ctrl(OFDM_BASEADDR, ofdm_txrx_mimo_ReadReg_TxRx_Interrupt_PktBuf_Ctrl(OFDM_BASEADDR) | (ALL_STATUSBITS_ENABLE & blockingStatusBits));
	
	return;
}

///@brief Returns the current value of the Rx PHY configuration register
///
/// Returns the value of the OFDM Rx ControlBits register. Use the bit masks from warpphy.h to decode the indivitual bits.
unsigned int mimo_ofdmRx_getOptions(){
	
	return ofdm_txrx_mimo_ReadReg_Rx_ControlBits(OFDM_BASEADDR);
}


///@brief Holds the OFDM Tx in reset
///
/// Holds the OFDM Tx in reset; this prevents any state changes in the Tx PHY. Configuration registers are not affected.
void mimo_ofdmTx_disable(){
	
	//Assert the OFDM Tx master reset and pktDone reset
	ofdm_txrx_mimo_WriteReg_Tx_Start_Reset_Control(OFDM_BASEADDR, TX_MASTER_RESET);
	
	return;
}

///@brief Releases the OFDM Tx reset
///
/// Releases the OFDM Tx reset
void mimo_ofdmTx_enable(){
	
	//Assert then clear the OFDM Tx master reset and pktDone reset
	ofdm_txrx_mimo_WriteReg_Tx_Start_Reset_Control(OFDM_BASEADDR, TX_MASTER_RESET);
	ofdm_txrx_mimo_WriteReg_Tx_Start_Reset_Control(OFDM_BASEADDR, 0x0);
	
	return;
}


///@brief Initiates the transmission of a packet
///
///Starts the transmission of a packet from the OFDM Tx PHY. If blocking is enabled, this function returns only
///after the transmission finishes. In this mode, the radio receiver is automatically re-enabled. If blocking is disabled,
///the receiver must be re-enabled in user code later.
///
///@param block DEPRECATED Selects whether this funciton blocks until the transmission finishes; use TXBLOCK or TXNOBLOCK
inline int warpphy_pktTx(unsigned int block){
	
	
	/* Should there be a check here whether the Rx PHY is receiving a packet?
	 And what should happen if it is? It's sort of carrier sensing, but if
	 CSMA is disabled, should the Tx pkt be discarded, or held until the Rx
	 is no longer busy...
	 */
	
	//Pulse the PHY's TxEn register bit. This will propogate to the radio bridge to activate
	// the radio controller's Tx state machine for whatever radio is enabled (by setAntennaMode() )
	mimo_ofdmTx_setStartTx(1);
	mimo_ofdmTx_setStartTx(0);
	
	//Sleep long enough for the PHY to start transmitting; depends on second argument to SetTxTiming
	usleep(6);
	
	//Return successfully
	return 0;
}

///@brief Polls PHY transmitter and re-enables reception upon completion
///
///This function blocks until the transmitter is complete and then re-enables
///reception by enabing the radio receiver and enabling packet detection.
int warpphy_waitForTx(){

	//warpmac_setDebugGPIO(0xF);

	//Poll the PHY transmitter until it's finished transmitting
	while(ofdm_txrx_mimo_ReadReg_Tx_PktRunning(OFDM_BASEADDR) & OFDM_TX_BUSY) {
		//warpmac_incrementLEDLow();
	}

	//Workaround for very rare PHY race condition, where a goodHeader event occurred immediately
	// before the transmission
	warpphy_clearRxPktStatus();

	return 0;
}


///@brief Sets the packet buffer indicies for the OFDM Tx and Rx PHY.
///
///The PLB_BRAM used a the PHY packet buffer is large enough to hold many PHY packets.
///This BRAM is divided into many sub-buffers; the PHY can be set to use any sub-buffer for Tx or Rx.
///
///@param txBufOffset 6-bit integer selecting the sub-buffer for the PHY Tx
///@param rxBufOffset 6-bit integer selecting the sub-buffer for the PHY Rx
void warpphy_setBuffs(unsigned char txBufOffset, unsigned char rxBufOffset){
	
	//TxRx_Interrupt_PktBuf_Ctrl[21:16] compose the Rx buffer offset
	//TxRx_Interrupt_PktBuf_Ctrl[13:8]  compose the Tx buffer offset

	//First, zero out the current pkt buff offsets
	//Preserve the bottom 8 bits of the register (used for interrupt control)
	ofdm_txrx_mimo_WriteReg_TxRx_Interrupt_PktBuf_Ctrl(OFDM_BASEADDR, ofdm_txrx_mimo_ReadReg_TxRx_Interrupt_PktBuf_Ctrl(OFDM_BASEADDR) & 0x000000FF);
	
	//Then write the new pkt buff offsets
	ofdm_txrx_mimo_WriteReg_TxRx_Interrupt_PktBuf_Ctrl(OFDM_BASEADDR,
		ofdm_txrx_mimo_ReadReg_TxRx_Interrupt_PktBuf_Ctrl(OFDM_BASEADDR) |
		( (txBufOffset & 0x3F) << 8 ) |
		( (rxBufOffset & 0x3F) << 16 )
	);

	return;
}

void warpphy_AFrecordEnable(unsigned char recordEn)
{
	if(recordEn)
	{
		mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() | AF_SAVEWAVEFORM, activePHYStatusBits);
	}
	else
	{
		mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() & ~(AF_SAVEWAVEFORM), activePHYStatusBits);
	}
	
	return;
}

///@brief Configures the PHY for the chosen antenna modes (SISO, Alamouti, multiplexing, etc.)
///
///@param txMode Constant (defined in warphphy.h) specifying the Tx antenna mode
///@param rxMode Constant (defined in warphphy.h) specifying the Rx antenna mode
int warpphy_setAntennaMode(unsigned int txMode, unsigned int rxMode)
{
	//Reset the Tx and Rx PHYs during this reconfiguration
	// This will interrupt any active Tx/Rx events but won't clear any registers
	mimo_ofdmRx_disable();
	mimo_ofdmTx_disable();
	
	//Tx configuration
	if(txMode != ANTMODE_UNCHANGED)
	{
		//Update the gloabl variable (used throughout to calculate "magic" numbers for the PHY)
		warpphy_txAntMode = txMode;

		//Take software control and disable both radio's Tx paths
		// The correct radios will be re-enabled below
		WarpRadio_v1_TxEnSoftControlEnable(BOTH_RADIOS);
		WarpRadio_v1_TxRxDisable(BOTH_RADIOS);

		//Enable hardware Tx control of either or both radios
		switch(txMode & ANTMODE_MASK_ANTSEL)
		{
			case ANTMODE_ANTSEL_RADA:
				activeRadios_Tx = FIRST_RADIO;
				WarpRadio_v1_TxEnSoftControlDisable(FIRST_RADIO);
				break;
				
			case ANTMODE_ANTSEL_RADB:
				activeRadios_Tx = SECOND_RADIO;
				WarpRadio_v1_TxEnSoftControlDisable(SECOND_RADIO);
				break;
				
			case ANTMODE_ANTSEL_BOTHRADS:
				activeRadios_Tx = BOTH_RADIOS;
				WarpRadio_v1_TxEnSoftControlDisable(BOTH_RADIOS);
				break;

			default:
				xil_printf("Invalid Tx antenna mode!\r\n");
				return -1;
				break;
		}

		//Configure the PHY's Tx mode
		switch(txMode & ANTMODE_MASK_PHYMODE)
		{
			case PHYMODE_SISO:
				//Set SISO mode, disable MIMO modes in the Tx PHY registers
				mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & ~(TX_ALAMOUTI_MODE) );
				mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | TX_SISO_MODE);
				break;
				
			case PHYMODE_2X2MULT:
				//Disable SISO/Alamouti modes in the Tx PHY registers
				mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & ~(TX_SISO_MODE | TX_ALAMOUTI_MODE) );
				break;

			case PHYMODE_ALAMOUTI:
				//Set Alamouti mode, disable SISO mode in the Tx PHY registers
				mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & ~(TX_SISO_MODE) );
				mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | TX_ALAMOUTI_MODE);
				break;

			default:
				xil_printf("Invalid Tx PHY mode!\r\n");
				return -1;
				break;
		}

		//Configure the PHY's Tx antenna configuration
		switch(txMode & ANTMODE_MASK_PHYANTCFG)
		{
			case PHYANTCFG_TX_NORMAL:
				mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & ~(TX_SWAP_ANTENNAS) );
				break;

			case PHYANTCFG_TX_SWAPPED:
				mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | TX_SWAP_ANTENNAS);
				break;

			default:
				xil_printf("Invalid Tx PHYANT mode!\r\n");
				return -1;
				break;
		}
	}

	if(rxMode != ANTMODE_UNCHANGED)
	{
		//Update the gloabl variable (used throughout to calculate "magic" numbers for the PHY)
		warpphy_rxAntMode = rxMode;

		//Take software control and disable both radio's Rx paths
		// The correct radios will be re-enabled below
		WarpRadio_v1_RxEnSoftControlEnable(BOTH_RADIOS);
		WarpRadio_v1_TxRxDisable(BOTH_RADIOS);
	
		//Enable hardware Rx control of either or both radios
		switch(rxMode & ANTMODE_MASK_ANTSEL)
		{
			case ANTMODE_ANTSEL_RADA:
				activeRadios_Rx = FIRST_RADIO;
				WarpRadio_v1_RxEnSoftControlDisable(FIRST_RADIO);
				ofdm_txrx_mimo_WriteReg_Rx_PktDet_setMask(PKTDET_MASK_ANTA);
				break;
				
			case ANTMODE_ANTSEL_RADB:
				activeRadios_Rx = SECOND_RADIO;
				WarpRadio_v1_RxEnSoftControlDisable(SECOND_RADIO);
				ofdm_txrx_mimo_WriteReg_Rx_PktDet_setMask(PKTDET_MASK_ANTB);
				break;
				
			case ANTMODE_ANTSEL_BOTHRADS:
				activeRadios_Rx = BOTH_RADIOS;
				WarpRadio_v1_RxEnSoftControlDisable(BOTH_RADIOS);
				ofdm_txrx_mimo_WriteReg_Rx_PktDet_setMask(PKTDET_MASK_ANTA | PKTDET_MASK_ANTB);
				break;
				
			default:
				xil_printf("Invalid Rx antenna mode!\r\n");
				return -1;
				break;
		}
		
		
		//Configure the PHY's Rx mode
		switch(rxMode & ANTMODE_MASK_PHYMODE)
		{
			case PHYMODE_SISO:
				//Set SISO mode, disable MIMO modes in the Rx PHY registers
				mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() & ~(RX_ALAMOUTI_MODE), activePHYStatusBits);
				mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() | RX_SISO_MODE, activePHYStatusBits);
				mimo_ofdmRx_setRxScaling(0x10001000); 
				break;
				
			case PHYMODE_2X2MULT:
				//Disable SISO/Alamouti modes in the Rx PHY registers
				mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() & ~(RX_ALAMOUTI_MODE | RX_SISO_MODE), activePHYStatusBits);
				mimo_ofdmRx_setRxScaling(0x08000800); 
				break;
				
			case PHYMODE_ALAMOUTI:
				//Set Alamouti mode, disable SISO mode in the Rx PHY registers
				mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() & ~(RX_SISO_MODE), activePHYStatusBits);
				mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() |  RX_ALAMOUTI_MODE, activePHYStatusBits);
				mimo_ofdmRx_setRxScaling(0x08000800); 
				break;
				
			default:
				xil_printf("Invalid Rx PHY mode!\r\n");
				return -1;
				break;
		}
		
		//Configure the PHY's Rx antenna configuration
		switch(rxMode & ANTMODE_MASK_PHYANTCFG)
		{
			case PHYANTCFG_RX_NORMAL:
				mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() & ~(SISO_ON_ANTB | SWITCHING_DIV_EN), activePHYStatusBits);
				break;
				
			case PHYANTCFG_RX_SWAPPED:
				mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() & ~(SWITCHING_DIV_EN), activePHYStatusBits);
				mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() | SISO_ON_ANTB, activePHYStatusBits);
				break;
				
			case PHYANTCFG_RX_SELDIV:
				mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() & ~(SISO_ON_ANTB), activePHYStatusBits);
				mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() | SWITCHING_DIV_EN, activePHYStatusBits);
				break;
				
			default:
				xil_printf("Invalid Rx PHYANT mode!\r\n");
				return -1;
				break;
				
		}
	}

	//Finally, re-enbale the PHY Tx/Rx subsystems
	mimo_ofdmRx_enable();
	mimo_ofdmTx_enable();

	//Pulse the PHY's RxEn register to re-enable receive paths on the active radios
	// This must occur after calling ofdmRx_enable, as this register's output is ignored while the Rx PHY is in reset
	mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() | PHY_RADIO_RXEN, activePHYStatusBits);
	mimo_ofdmRx_setOptions(mimo_ofdmRx_getOptions() & ~(PHY_RADIO_RXEN), activePHYStatusBits);
	
	return 0;
}

///@brief Fast and dangerous way of switching TX PHY mode... note... this function cannot change physical radios
///
///@param txMode Constant (defined in warphphy.h) specifying the Tx antenna mode
int warpphy_setTxAntennaSwap(unsigned int txMode)
{
	//Tx configuration
	if(txMode != ANTMODE_UNCHANGED)
	{
		//Update the gloabl variable (used throughout to calculate "magic" numbers for the PHY)
		warpphy_txAntMode = txMode;
		
		//Configure the PHY's Tx antenna configuration
		switch(txMode & ANTMODE_MASK_PHYANTCFG)
		{
			case PHYANTCFG_TX_NORMAL:
				mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() & ~(TX_SWAP_ANTENNAS) );
				break;
				
			case PHYANTCFG_TX_SWAPPED:
				mimo_ofdmTx_setControlBits(mimo_ofdmTx_getOptions() | TX_SWAP_ANTENNAS);
				break;
				
			default:
				xil_printf("Invalid Tx PHYANT mode!\r\n");
				return -1;
				break;
		}
	}
		
	return 0;
}

inline void warpphy_clearAutoResponseFlag(unsigned char flagID){

	switch(flagID)
	{
		case AUTORESP_FLAGID_A:
			ofdm_txrx_mimo_WriteReg_Rx_ControlBits(OFDM_BASEADDR, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(OFDM_BASEADDR) | (AUTORESP_FLAGA_RST));
			ofdm_txrx_mimo_WriteReg_Rx_ControlBits(OFDM_BASEADDR, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(OFDM_BASEADDR) & ~(AUTORESP_FLAGA_RST));
			break;
		case AUTORESP_FLAGID_B:
			ofdm_txrx_mimo_WriteReg_Rx_ControlBits(OFDM_BASEADDR, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(OFDM_BASEADDR) | (AUTORESP_FLAGB_RST));
			ofdm_txrx_mimo_WriteReg_Rx_ControlBits(OFDM_BASEADDR, ofdm_txrx_mimo_ReadReg_Rx_ControlBits(OFDM_BASEADDR) & ~(AUTORESP_FLAGB_RST));
			break;
	}

	return;
}

///@brief Sets the number of training symbol periods used per packet
///
///Configures the number of training symbols which are transmitted with each packet. The Tx and Rx nodes must be
///configured for the same number. In SISO mode, the single channel is trained c times. In MIMO mode, each channel
///is trained c/2 times
///
///@param numTraining number of training periods; must be even
void warpphy_setNumTrainingSyms(unsigned int numTraining){
	//Update the global variable; used each time a packet is transmitted
	numTrainingSyms = numTraining;
	
	//Configure the PHY
	warpphy_setTxNumSyms(numBaseRate, numTrainingSyms);
	warpphy_setRxNumSyms(numBaseRate, numTrainingSyms);
}

void warpphy_setNumBaseRateSyms(unsigned int numSyms){
	//Update the global variable; used each time a packet is transmitted
	numBaseRate = numSyms;
	
	//Configure the PHY
	warpphy_setTxNumSyms(numBaseRate, numTrainingSyms);
	warpphy_setRxNumSyms(numBaseRate, numTrainingSyms);
}

///@brief Configure the flexible modulation/demodulation in the OFDM PHY
///
///The OFDM PHY supports flexible modulation, allowing any combination of schemes per subcarrier
///Currently this code supports simple dynamic modulation, with 48 of 64 subcarriers assigned to carry data, 4 for pilots and 12 empty.
///The modulation scheme in the 48 data subcarriers is set by this funciton.
///NOTE: When FEC is enabled the modulation rate of all data bearing subcarriers must be the same and one of BPSK/QPSK/16-QAM
///
///@param baseRate Modulation scheme for base rate symbols
///@param TxAntAFullRate Modulation scheme for Tx full rate symbols on antenna A
///@param TxAntBFullRate Modulation scheme for Tx full rate symbols on antenna B
///@param RxAntAFullRate Modulation scheme for Rx full rate symbols on antenna A
///@param RxAntBFullRate Modulation scheme for Rx full rate symbols on antenna B
void warpphy_set_modulation(unsigned char baseRate, unsigned char TxAntAFullRate, unsigned char TxAntBFullRate, unsigned char RxAntAFullRate, unsigned char RxAntBFullRate)
{
	unsigned int modIndex;

	//Define the standard subcarrier mapping - 48 used for data (0xF here), 4 pilots & 12 unused (0x0 here)
	// The vector contains 192 elements:
	//    0:63 - Antenna A full rate masks for subcarriers [0,1,2,...31,-31,-30,...-1]
	//  64:127 - Antenna B full rate masks for subcarriers [0,1,2,...31,-31,-30,...-1]
	// 128:191 - Base rate masks for subcarriers [0,1,2,...31,-31,-30,...-1]
	//The default masks are 3 copies of the same 64-length vector; yes, it's inefficient, but this scheme maintains flexibility in changing the mapping per antenna
	unsigned char modMasks[192] = {
			0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF,
			0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF,
			0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF
	};

	//The PHY's shared memories for modulation masks have 192 4-bit entries; each entry's address is 4-byte aligned (hence the *sizeof(int) below )
	if(TxAntAFullRate != MOD_UNCHANGED)
	{
		//Configure Tx antenna A full rate
		for(modIndex=0; modIndex<64; modIndex++)
		{
			XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXMODULATION+(modIndex*sizeof(int)), modMasks[modIndex] & TxAntAFullRate);
		}
	}

	if(TxAntBFullRate != MOD_UNCHANGED)
	{
		//Configure Tx antenna B full rate
		for(modIndex=64; modIndex<128; modIndex++)
		{
			XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXMODULATION+(modIndex*sizeof(int)), modMasks[modIndex] & TxAntBFullRate);
		}
	}
	
	if(RxAntAFullRate != MOD_UNCHANGED)
	{
		//Configure Rx antenna A full rate
		for(modIndex=0; modIndex<64; modIndex++)
		{
			XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RXMODULATION+(modIndex*sizeof(int)), modMasks[modIndex] & RxAntAFullRate);
		}
	}

	if(RxAntBFullRate != MOD_UNCHANGED)
	{
		//Configure Rx antenna B full rate
		for(modIndex=64; modIndex<128; modIndex++)
		{
			XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RXMODULATION+(modIndex*sizeof(int)), modMasks[modIndex] & RxAntBFullRate);
		}
	}
	
	//Update the global baseRate modulation variable
	if(baseRate != MOD_UNCHANGED)
	{
		baseRateMod = baseRate;
	
		//Configure the Tx and Rx base rate
		for(modIndex=128; modIndex<192; modIndex++)
		{
			XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXMODULATION+(modIndex*sizeof(int)), modMasks[modIndex] & baseRate);
			XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RXMODULATION+(modIndex*sizeof(int)), modMasks[modIndex] & baseRate);
		}
	}

	return;
}

///@brief Set the center frequency of the radio transceivers
///@param band Selects 2.4GHz or 5GHz bands (using GHZ_2 or GHZ_5)
///@param chan Selects the channel number in the chosen band
///@return Returns -1 if an invalid band or channel was specified; otherwise returns the new center frequency in MHz
int warpphy_setChannel(unsigned char band, unsigned int chan){
	int newFreq = -1;
	
	if (band == GHZ_2){
		newFreq = WarpRadio_v1_SetCenterFreq2GHz(chan, FIRST_RADIO | SECOND_RADIO);
	}
	if (band == GHZ_5){
		newFreq = WarpRadio_v1_SetCenterFreq5GHz(chan, FIRST_RADIO | SECOND_RADIO);
	}
		
	return newFreq;
}

///@brief Set the center frequency of the radio transceivers independently
///@param antA_band Selects 2.4GHz or 5GHz bands (using GHZ_2 or GHZ_5) for antenna A
///@param antB_band Selects 2.4GHz or 5GHz bands (using GHZ_2 or GHZ_5) for antenna B
///@param antA_chan Selects the channel number in the chosen band for antenna A
///@param antB_chan Selects the channel number in the chosen band for antenna B
///@return Returns -1 if an invalid band or channel was specified; otherwise returns the new center frequency for antenna A in MHz
int warpphy_setSeparateChannels(unsigned char antA_band, unsigned int antA_chan, unsigned char antB_band, unsigned int antB_chan){

	int newFreq_A = -1;
	int newFreq_B = -1;
	
	if (antA_band == GHZ_2)
		newFreq_A = WarpRadio_v1_SetCenterFreq2GHz(antA_chan, FIRST_RADIO);
	if (antB_band == GHZ_2)
		newFreq_B = WarpRadio_v1_SetCenterFreq2GHz(antB_chan, SECOND_RADIO);
	if (antA_band == GHZ_5)
		newFreq_A = WarpRadio_v1_SetCenterFreq5GHz(antA_chan, FIRST_RADIO);
	if (antB_band == GHZ_5)
		newFreq_B = WarpRadio_v1_SetCenterFreq5GHz(antB_chan, SECOND_RADIO);
	if(newFreq_A == -1 || newFreq_B == -1)
		return -1;
	else
		return newFreq_A;
}

///@brief Applies TX DC offset calibration to the specified radios; the calibration values are stored in the radio's EEPROM
///@param radioSelection OR'd combinaton of RADIOx_ADDR values, specifying which radios to update
///@return Returns -1 if an EEPROM error occurs; returns 0 if successful
int warpphy_applyTxDCOCalibration(unsigned int radioSelection)
{
	int eepromStatus = 0;
	short calReadback = 0;
	signed short best_I, best_Q;
	unsigned char radioNum;
	Xuint8 memory[8], version, revision, valid, MAC[6], i;
	Xuint16 serial;

	//Radio selection will be 0x11111111, 0x22222222, 0x44444444 or 0x88888888
	// corresponding to radios in slots 1, 2, 3 or 4
	// We need the slot number to initialize the EEPROM
	radioNum = (radioSelection & 0xF) == 1 ? 1 : ( (radioSelection & 0xF) == 2 ? 2 : ( (radioSelection & 0xF) == 4 ? 3 : 4 ) );
//	xil_printf("Applying TxDCO correction for radio %d\r\n", radioNum);

	//Mimic the radio test code, in hopes of a more stable EEPROM read...
	//Choose the EEPROM on the selected radio board; second arg is [0,1,2,3,4] for [FPGA, radio1, radio2, radio3, radio4]
	eepromStatus = WarpEEPROM_EEPROMSelect((unsigned int *)XPAR_EEPROM_0_MEM0_BASEADDR, 0);
	if(eepromStatus != 0)
	{
		xil_printf("EEPROM Select Failed!\r\n");
		return;
	}
	
	//Initialize the EEPROM controller
	eepromStatus = WarpEEPROM_Initialize((unsigned int *)XPAR_EEPROM_0_MEM0_BASEADDR);
	if(eepromStatus != 0)
	{
		xil_printf("EEPROM Init Returned %x\r\n", eepromStatus);
		xil_printf("EEPROM Init Failed!\r\n");
	return;
	}

	//Select the EEPROM on the current radio board
	eepromStatus = WarpEEPROM_EEPROMSelect((unsigned int*)XPAR_EEPROM_0_MEM0_BASEADDR, radioNum);

	if(eepromStatus != 0)
	{
		xil_printf("TxDCO: EEPROM error\r\n");
		return -1;
	}
	
	//Read the first page from the EERPOM
	WarpEEPROM_ReadMem((unsigned int*)XPAR_EEPROM_0_MEM0_BASEADDR, 0, 0, memory);
	version = (memory[0] & 0xE0) >> 5;
	revision = (memory[1] & 0xE0) >> 5;
	valid = memory[1] & 0x1F;

//	xil_printf("\r\n\r\nEEPROM Values for Radio Board in Slot %d\r\n", radioNum);

//	xil_printf("    WARP Radio Board Version %d.%d\r\n", version, revision);

	serial = WarpEEPROM_ReadWARPSerial((unsigned int*)XPAR_EEPROM_0_MEM0_BASEADDR);

//	xil_printf("    Serial Number (WARP): WR-a-%05d\r\n", serial);

	WarpEEPROM_ReadDSSerial((unsigned int*)XPAR_EEPROM_0_MEM0_BASEADDR, memory);
//	print("    EEPROM Hard-wired Serial Number: ");
//	for(i=1;i<7;i++)
//		xil_printf(" %x",memory[7-i]);
//	xil_printf("\r\n\r\n");
	//Read the Tx DCO values
	calReadback = WarpEEPROM_ReadRadioCal((unsigned int*)XPAR_EEPROM_0_MEM0_BASEADDR, 2, 1);
	
	//Scale the stored values
	best_I = (signed short)(((signed char)(calReadback & 0xFF))<<1);
	best_Q = (signed short)(((signed char)((calReadback>>8) & 0xFF))<<1);
	
	xil_printf("\t\tTxDCO values for radio %d - I: %d\tQ: %d\r\n", radioNum, best_I, best_Q);
	
	//Finally, write the Tx DCO values to the DAC
	WarpRadio_v1_DACOffsetAdj(ICHAN, best_I, radioSelection);
	WarpRadio_v1_DACOffsetAdj(QCHAN, best_Q, radioSelection);
	
	return 0;
}


/******* AGC core control functions ********/

unsigned int warpphy_returnGainsDB(){
/*	int rfGain;
	switch(warpphy_returnAGCgainRF(antenna)){
		case 0:
			rfGain=1;
		break;
		case 1:
			rfGain=16;
		break;
		case 2:
			rfGain=31.5;
		break;
	}
	xil_printf("BBGAIN %d\r\n",(warpphy_returnAGCgainBB(antenna)<<1));
	return ((warpphy_returnAGCgainBB(antenna)<<1) + rfGain);
*/

unsigned int rfGain,bbGain,gainDB,rfGainDB,bbGainDB;
unsigned int agcGains;
	

		agcGains = ofdm_AGC_GetGains();
		rfGain = agcGains&0x3;
		bbGain = (agcGains>>2)&0x1F;
		
		switch(rfGain){
		case 0:
			rfGainDB=1;
		break;
		case 1:
			rfGainDB=1;
		break;
		case 2:
			rfGainDB=16;
		break;
		case 3:
			rfGainDB=32; //really 31.5...
		break;
	}
	
	bbGainDB=bbGain<<1;
	gainDB = bbGainDB + rfGainDB;
       return gainDB;

	
	
	
}




inline void ofdm_AGC_SetDCO(unsigned int AGCstate){

	// register bits:
	// [1:0]- DCO mode
	//   0x0=bypass DCO correction entirely
	//   0x1=bypass IIR filter, allow subtraction
	//   0x2=enable IIR filter, allow subtraction
	// [2]- enable subtraction (only has effect if [1:0] != 0)
	// Valid values:
	// [1 1 0]=0x6: Enable filter, use subtraction
	OFDM_AGC_MIMO_WriteReg_Bits(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, (AGCstate & 0x7));
	
	return;
}

void ofdm_AGC_Reset(){
	
	// Cycle the agc's software reset port
	
	OFDM_AGC_MIMO_WriteReg_SRESET_IN(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 1);
	usleep(10);
	OFDM_AGC_MIMO_WriteReg_SRESET_IN(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0);
	usleep(100);
	
	return;
}


void ofdm_AGC_MasterReset(){
	
	// Cycle the master reset register in the AGC and enable it
	
	OFDM_AGC_MIMO_WriteReg_AGC_EN(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0);
	usleep(10);
	OFDM_AGC_MIMO_WriteReg_MRESET_IN(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0);
	usleep(10);
	OFDM_AGC_MIMO_WriteReg_MRESET_IN(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 1);
	usleep(10);
	OFDM_AGC_MIMO_WriteReg_MRESET_IN(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0);
	usleep(10);
	OFDM_AGC_MIMO_WriteReg_AGC_EN(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 1);
	
	return;
}

void ofdm_AGC_Initialize(int noise_estimate){
	
	int g_bbset = 0;
	
	// First set all standard parameters
	
	// Turn off both resets and the master enable
	OFDM_AGC_MIMO_WriteReg_AGC_EN(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0);
	OFDM_AGC_MIMO_WriteReg_SRESET_IN(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0);
	OFDM_AGC_MIMO_WriteReg_MRESET_IN(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0);
	
	// An adjustment parameter
	OFDM_AGC_MIMO_WriteReg_ADJ(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 8);
	
	// Timing for the DC-offset correction
//	OFDM_AGC_MIMO_WriteReg_DCO_Timing(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0x46403003); //as used through v21
	OFDM_AGC_MIMO_WriteReg_DCO_Timing(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0x463C2C03); //
	
	// Initial baseband gain setting
	OFDM_AGC_MIMO_WriteReg_GBB_init(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 52);
	
	// RF gain AGCstate thresholds
	OFDM_AGC_MIMO_WriteReg_Thresholds(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 
		((AGC_THRESH_1&0xFF)<<16) +
		((AGC_THRESH_2&0xFF)<<8) + 
		 (AGC_THRESH_3&0xFF)
	);
	
	// Overall AGC timing
//	OFDM_AGC_MIMO_WriteReg_Timing(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0x9A962A28);//0x826E3C0A;
//	OFDM_AGC_MIMO_WriteReg_Timing(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0xAA962A28);//added time between GBB change and AGC_DONE (pom 2010-06-19)
//	OFDM_AGC_MIMO_WriteReg_Timing(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0xEAC65A58);
	OFDM_AGC_MIMO_WriteReg_Timing(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0xFAC62A28);//delayed I/Q sensitive steps by 12 samples for new Rx filter latency
	
	// vIQ and RSSI average lengths
	OFDM_AGC_MIMO_WriteReg_AVG_LEN(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0x10F); //103
	
	// Disable DCO, disable DCO subtraction
	OFDM_AGC_MIMO_WriteReg_Bits(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, 0x0);
	
	// Compute and set the initial g_BB gain value from the noise estimate
	// The initial g_bb sets noise to -19 db, assuming 32 db RF gain
	
	g_bbset = -19 - 32 - noise_estimate;
	OFDM_AGC_MIMO_WriteReg_GBB_init(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, g_bbset);
	
	// Perform a master reset
	ofdm_AGC_MasterReset();
	
	// Agc is now reset and enabled, ready to go!
	return;
}


void ofdm_AGC_setNoiseEstimate(int noise_estimate){
	int g_bbset;
	
	g_bbset = -19 - 32 - noise_estimate;
	
	OFDM_AGC_MIMO_WriteReg_GBB_init(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, g_bbset);
	
	return;
}

unsigned int ofdm_AGC_GetGains(void){
	
	unsigned int gBB_A, gRF_A, gBB_B, gRF_B, gains;
	
	// Get the gains from the registers
	gBB_A = OFDM_AGC_MIMO_ReadReg_GBB_A(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR);
	gRF_A = OFDM_AGC_MIMO_ReadReg_GRF_A(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR);
	
	gBB_B = OFDM_AGC_MIMO_ReadReg_GBB_B(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR);
	gRF_B = OFDM_AGC_MIMO_ReadReg_GRF_B(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR);
	
	// First concatenate the two radios together, into the gRF register
	// 2 lowest bits are RF, 5 higher bits are BB, last bit is unused
	// Multiply by 2^2, shift gBB right by 2 bits
	
	gRF_A = gRF_A + (gBB_A * 4);
	gRF_B = gRF_B + (gBB_B * 4);
	
	// Multiply by 2^8 shift gRF right by 8 bits
	gains = gRF_A + (gRF_B * 256);
	
	// Returns hi[0 gBB_B g_RF_B | 0 g_BB_A g_RF_A]lo
	return gains;
}

void ofdm_AGC_SetTarget(unsigned int target){
	OFDM_AGC_MIMO_WriteReg_T_dB(XPAR_OFDM_AGC_MIMO_OPBW_0_BASEADDR, target);
	return;
}
/******* END AGC core control functions ********/



/******* WARP Timer core control functions *******/
void warp_timer_start(unsigned char timer) {
	warp_timer_WriteReg_control(warp_timer_ReadReg_control() | (TIMER_MASK_CALC(timer) & TIMER_CONTROL_START_MASK));
	warp_timer_WriteReg_control(warp_timer_ReadReg_control() & ~(TIMER_MASK_CALC(timer) & TIMER_CONTROL_START_MASK));
}

void warp_timer_pause(unsigned char timer) {
	warp_timer_WriteReg_control(warp_timer_ReadReg_control() | (TIMER_MASK_CALC(timer) & TIMER_CONTROL_PAUSE_MASK));
}

void warp_timer_resume(unsigned char timer) {
	warp_timer_WriteReg_control(warp_timer_ReadReg_control() & ~(TIMER_MASK_CALC(timer) & TIMER_CONTROL_PAUSE_MASK));
}

void warp_timer_setMode(unsigned char timer, unsigned char mode) {
	if(mode == 1)
		warp_timer_WriteReg_control(warp_timer_ReadReg_control() | (TIMER_MASK_CALC(timer) & TIMER_CONTROL_MODE_MASK));
	else
		warp_timer_WriteReg_control(warp_timer_ReadReg_control() & ~(TIMER_MASK_CALC(timer) & TIMER_CONTROL_MODE_MASK));
}

void warp_timer_resetDone(unsigned char timer) {
	warp_timer_WriteReg_control(warp_timer_ReadReg_control() | (TIMER_MASK_CALC(timer) & TIMER_CONTROL_RESETDONE_MASK));
	warp_timer_WriteReg_control(warp_timer_ReadReg_control() & ~(TIMER_MASK_CALC(timer) & TIMER_CONTROL_RESETDONE_MASK));
}

void warp_timer_resetAllDoneStatus() {
	warp_timer_WriteReg_control(warp_timer_ReadReg_control() | (TIMER_CONTROL_RESETDONE_MASK));
	warp_timer_WriteReg_control(warp_timer_ReadReg_control() & ~(TIMER_CONTROL_RESETDONE_MASK));
}

void warp_timer_setTimer(unsigned char timer, unsigned int slotTime, unsigned int slotCount) {
	switch(timer) {
	case 0:
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER0_SLOTCOUNT, (Xuint32)(slotCount));
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS01_SLOTTIME, ( (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS01_SLOTTIME) & 0xFFFF0000) | slotTime) );
		return;
	case 1:
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER1_SLOTCOUNT, (Xuint32)(slotCount));
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS01_SLOTTIME, ( (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS01_SLOTTIME) & 0x0000FFFF) | (slotTime<<16) ) ); 
		return;
	case 2:
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER2_SLOTCOUNT, (Xuint32)(slotCount));
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS23_SLOTTIME, ( (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS23_SLOTTIME) & 0xFFFF0000) | slotTime) );
		return;
	case 3:
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER3_SLOTCOUNT, (Xuint32)(slotCount));
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS23_SLOTTIME, ( (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS23_SLOTTIME) & 0x0000FFFF) | (slotTime<<16) ) );
		return;
	case 4:
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER4_SLOTCOUNT, (Xuint32)(slotCount));
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS45_SLOTTIME, ( (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS45_SLOTTIME) & 0xFFFF0000) | slotTime) );
		return;
	case 5:
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER5_SLOTCOUNT, (Xuint32)(slotCount));
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS45_SLOTTIME, ( (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS45_SLOTTIME) & 0x0000FFFF) | (slotTime<<16) ) );
		return;
	case 6:
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER6_SLOTCOUNT, (Xuint32)(slotCount));
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS67_SLOTTIME, ( (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS67_SLOTTIME) & 0xFFFF0000) | slotTime) );
		return;
	case 7:
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER7_SLOTCOUNT, (Xuint32)(slotCount));
		XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS67_SLOTTIME, ( (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS67_SLOTTIME) & 0x0000FFFF) | (slotTime<<16) ) );
		return;
	default:
		return;
	}
}

unsigned char warp_timer_getStatus(unsigned char timer) {
	return (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER_STATUS) >> (timer*4)) & 0xf;
}

unsigned char warp_timer_isDone(unsigned char timer) {
	return (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER_STATUS) & TIMER_MASK_CALC(timer) & TIMER_STATUS_DONE_MASK) != 0;
}

unsigned char warp_timer_isActive(unsigned char timer) {
	return (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER_STATUS) & TIMER_MASK_CALC(timer) & TIMER_STATUS_RUNNING_MASK) != 0;
}

unsigned char warp_timer_isPaused(unsigned char timer) {
	return (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER_STATUS) & TIMER_MASK_CALC(timer) & TIMER_STATUS_PASUED_MASK) != 0;
}

unsigned int warp_timer_getStatuses() {
	return XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER_STATUS);
}

unsigned char warp_timer_getDoneStatus() {
	return (XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER_STATUS) & TIMER_STATUS_DONE_MASK);
}

void warp_timer_init(){
	//Clear all start/pause/mode/donereset bits
	XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER_CONTROL, 0);

	//Set sane values for the slot times and slot counts
	warp_timer_setTimer(0, 500, 32);
	warp_timer_setTimer(1, 500, 32);
	warp_timer_setTimer(2, 500, 32);
	warp_timer_setTimer(3, 500, 32);
	warp_timer_setTimer(4, 500, 32);
	warp_timer_setTimer(5, 500, 32);
	warp_timer_setTimer(6, 500, 32);
	warp_timer_setTimer(7, 500, 32);

	//Clear any stale timer-done status bits
	warp_timer_resetAllDoneStatus();
	return;
}
/******* END WARP Timer core control functions *******/

///@brief Set the transmit power (via the radio's RF VGA)
///@param txPwr Desired transmit power; must be integer in [0,63]
///@return Returns -1 if an invalid power is requested; 0 on success
int warpphy_setTxPower(unsigned char txPwr)
{
	if(txPwr > 63)
		return -1;
	else
		WarpRadio_v1_SetTxGainTiming(FIRST_RADIO | SECOND_RADIO, (0x3F & txPwr), 0xF, 1);

	return 0;
}

void warpphy_setAutoCorrDetParams(unsigned short corrThresh, unsigned short energyThresh) {
	ofdm_txrx_mimo_WriteReg_Rx_PktDetCorr_params(corrThresh, energyThresh);
	return;
}

void warpphy_setLongCorrThresh(unsigned short thresh) {
	pktDet_carrierSenseThresh = thresh;
	XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PKTDET_LONGCORR_THRESHOLDS_W, thresh);
}

void warpphy_setCarrierSenseThresh(unsigned short thresh) {
	longCorrThresh = thresh;
	ofdm_txrx_mimo_WriteReg_Rx_CSMA_setThresh(pktDet_carrierSenseThresh);
}

void warpphy_setEnergyDetThresh(unsigned short thresh) {
	pktDet_energyThresh = thresh;
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(thresh);
}


void warpphy_setAntBPreambleShift(unsigned char shift)
{
	mimo_ofdmTx_setControlBits( (mimo_ofdmTx_getOptions() & ~(0xF0)) | ((shift&0xF)<<4) );
}

/*********************************************************************/
/* A whole bunch of debugging functions - these will go away someday */
/*********************************************************************/

#if INCLUDE_WARPPHY_DEBUG_FUNCTIONS

void warpphy_incrementTxScaling(int incr_preamble, int incr_payload)
{
	txScaling_preamble += incr_preamble;
	txScaling_payload += incr_payload;
	mimo_ofdmTx_setTxScaling(txScaling_preamble, txScaling_payload);
	xil_printf("TxScaling: Preamble = %d\tPayload = %d\r\n", txScaling_preamble, txScaling_payload);
	return;
}


void warpphy_setPktDlyPlus(){
	ofdmRx_pktDetDly++;
	xil_printf("+ofdmRx_pktDetDly = %d\r\n", ofdmRx_pktDetDly);
	mimo_ofdmRx_setPktDetDly(ofdmRx_pktDetDly);
}
void warpphy_setPktDlyMinus(){
	ofdmRx_pktDetDly--;
	xil_printf("-ofdmRx_pktDetDly = %d\r\n", ofdmRx_pktDetDly);
	mimo_ofdmRx_setPktDetDly(ofdmRx_pktDetDly);
}

/*********************/
/* Other PHY options */
/*********************/

void warpphy_set_FFTOffset_Plus(){
	RxFFT_Window_Offset++;
	mimo_ofdmRx_setFFTWindowOffset(RxFFT_Window_Offset);
	xil_printf("Rx FFT Offset: %d\r\n", RxFFT_Window_Offset);
}

void warpphy_set_FFTOffset_Minus(){
	RxFFT_Window_Offset--;
	mimo_ofdmRx_setFFTWindowOffset(RxFFT_Window_Offset);
	xil_printf("Rx FFT Offset: %d\r\n", RxFFT_Window_Offset);
}

void warpphy_setNoiseTargetPlus(){
	agc_noisePowerEstimate++;
	xil_printf("+Noise Estimate = %d\r\n", agc_noisePowerEstimate);
	ofdm_AGC_setNoiseEstimate(agc_noisePowerEstimate);
}

void warpphy_setNoiseTargetMinus(){
	agc_noisePowerEstimate--;
	xil_printf("-Noise Estimate = %d\r\n", agc_noisePowerEstimate);
	ofdm_AGC_setNoiseEstimate(agc_noisePowerEstimate);
}

void warpphy_setTargetPlus(){
	agc_targetRxPowerOut++;
	xil_printf("+agc_targetRxPowerOut = %d\r\n", agc_targetRxPowerOut);
	ofdm_AGC_SetTarget(agc_targetRxPowerOut);
}

void warpphy_setTargetMinus(){
	agc_targetRxPowerOut--;
	xil_printf("-agc_targetRxPowerOut = %d\r\n", agc_targetRxPowerOut);
	ofdm_AGC_SetTarget(agc_targetRxPowerOut);
}

void warpphy_setPktDetPlus(unsigned int offset){
	pktDet_energyThresh=pktDet_energyThresh+offset;
	//ofdm_pktDetector_mimo_WriteReg_pktDet_avgThresh(PKTDET_BASEADDR, pktDet_energyThresh);
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(pktDet_energyThresh);
	xil_printf("pktDet_energyThresh = %d\r\n",pktDet_energyThresh);
}

void warpphy_setPktDetMinus(unsigned int offset){
	pktDet_energyThresh=pktDet_energyThresh-offset;
	//ofdm_pktDetector_mimo_WriteReg_pktDet_avgThresh(PKTDET_BASEADDR, pktDet_energyThresh);
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(pktDet_energyThresh);
	
	xil_printf("pktDet_energyThresh = %d\r\n",pktDet_energyThresh);
}

void warpphy_setPktDetMinDurPlus(unsigned int offset){
	pktDet_threshMinDur = pktDet_threshMinDur + offset;

	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setMinDuration(pktDet_threshMinDur);
	xil_printf("Minimum Duration = %d\r\n", pktDet_threshMinDur);
}

void warpphy_setPktDetMinDurMinus(unsigned int offset){
	pktDet_threshMinDur = pktDet_threshMinDur - offset;
	
	ofdm_txrx_mimo_WriteReg_Rx_PktDet_setMinDuration(pktDet_threshMinDur);
	xil_printf("Minimum Duration = %d\r\n", pktDet_threshMinDur);
}

void warpphy_setCSMAPlus(unsigned int offset){
	pktDet_carrierSenseThresh = pktDet_carrierSenseThresh + offset;

	ofdm_txrx_mimo_WriteReg_Rx_CSMA_setThresh(pktDet_carrierSenseThresh);
	xil_printf("Carrier Sense Thresh = %d\r\n", pktDet_carrierSenseThresh);
}

void warpphy_setCSMAMinus(unsigned int offset){
	pktDet_carrierSenseThresh = pktDet_carrierSenseThresh - offset;
    
	ofdm_txrx_mimo_WriteReg_Rx_CSMA_setThresh(pktDet_carrierSenseThresh);
	xil_printf("Carrier Sense Thresh = %d\r\n", pktDet_carrierSenseThresh);
}

void warpphy_setGainPlus(unsigned int offset){
	txGain=txGain+offset;
	WarpRadio_v1_SetTxGainTiming(FIRST_RADIO | SECOND_RADIO, txGain, 0xF, 2);
	xil_printf("TxGain = %x\r\n",txGain);
}

void warpphy_setGainMinus(unsigned int offset){
	txGain=txGain-offset;
	WarpRadio_v1_SetTxGainTiming(FIRST_RADIO | SECOND_RADIO, txGain, 0xF, 2);
	xil_printf("TxGain = %x\r\n",txGain);
}


#endif

