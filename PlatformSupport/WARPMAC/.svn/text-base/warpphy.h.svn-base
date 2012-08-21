/*! \file warpphy.h
\brief Header file for the WARPPHY functions

@version 15.22
@author Patrick Murphy and Chris Hunter

This header file contains the macros, function prototypes, and typedefs required for WARPPHY.
*/

//WARPPHY Interface
/***************CHANGELOG*****************

******************************************/
/*****************WARPPHY*****************
Description: This file specifies the
interface between to the PHY.
******************************************/

#ifndef WARPPHY_H
#define WARPPHY_H

//Flag to include a bunch of low-level debugging functions
// for tweaking values in the PHY cores
// These can be excluded for most applications, saving a lot of code space
#define INCLUDE_WARPPHY_DEBUG_FUNCTIONS 1

//Old design flow used OFDM_BASEADDR to refer to the PHY's base address
// New flow addresses registers directly, not relative to a base address
// This value is still defined to keep code from breaking
#define OFDM_BASEADDR 0

//PHY packet buffer is actually a PLB BRAM
// The base address is the address of the PLB BRAM controller
#define OFDM_PKTBUFF_BASEADDR XPAR_XPS_BRAM_IF_CNTLR_2_BASEADDR

//Masks for configuring modulation settings in the PHY
//Each is 8 copies of a 4-bit modulation value
#define MODMASK_BPSK 0x11111111
#define MODMASK_QPSK 0x22222222
#define MODMASK_16QAM 0x44444444
#define MODMASK_64QAM 0x66666666

#define MOD_UNCHANGED 0xFF

#define NUM_BASERATE_SYMBOLS_BPSK_CODED 8
#define NUM_BASERATE_SYMBOLS_QPSK_CODED 4
#define NUM_BASERATE_SYMBOLS_BPSK_UNCODED 4
#define NUM_BASERATE_SYMBOLS_QPSK_UNCODED 2

//Number of base rate OFDM symbols per packet
// Must correspond to base rate modulation, number of header bytes and header coding rate
#define NUM_BASERATE_SYMBOLS NUM_BASERATE_SYMBOLS_QPSK_CODED

//Define number of channel training symbols per packet - must be even!
// In SISO mode all symbols are used to train the H_AA channel
// In Alamouti, alternate symbols train H_AA and H_BA
// In 2x2, alternate symbols train H_AA/H_AB and H_BA/H_BB
#define NUM_TRAINING_SYMBOLS	2

//Number of packet buffers; each sub-buffer is 2KB, so a 64KB PLB BRAM hold 32 buffers
#define NUMPKTBUFFS 32

//Length of the running RSSI sum in the pkt detector
// #define'd here so it can be used again below
#define PKTDET_RSSI_SUMLEN		16

//Define an RSSI threshold big enough so that carrier sensing will never assert
// This is used to "disable" carrier sensing at run time
#define CSMA_DISABLED_THRESH	(1023*PKTDET_RSSI_SUMLEN)

//Initial FFT window offset (number of CP samples to use per Rx FFT)
#define INIT_RXFFTOFSET 10

//Code rate selection values, used in header.codeRate field per-packet
//#define CONVCODED_PHY 1
#define HDR_CODE_RATE_12 0
#define HDR_CODE_RATE_23 1
#define HDR_CODE_RATE_34 2
#define HDR_CODE_RATE_NONE 3

#define TIMER_MODE_CARRIERSENSE     1
#define TIMER_MODE_NOCARRIERSENSE   0

//Define scaling values for the PHY's FFT cores
#define TX_FFT_SCALING_STAGE1 1
#define TX_FFT_SCALING_STAGE2 2
#define TX_FFT_SCALING_STAGE3 3

// Was 1 2 1
#define RX_FFT_SCALING_STAGE1 0
#define RX_FFT_SCALING_STAGE2 1
#define RX_FFT_SCALING_STAGE3 1

//Define thresholds for the AGC
#define AGC_THRESH_1 0xE2 //-30
#define AGC_THRESH_2 0xCB //-53
#define AGC_THRESH_3 0xA6 //-90

//RX Status register values
#define PHYRXSTATUS_INCOMPLETE 0
#define PHYRXSTATUS_GOOD 0x5
#define PHYRXSTATUS_BAD 0xA
#define PHYRXSTATUS_PAYLOAD 0x3
#define PHYRXSTATUS_HEADER 0xC

//Antenna configuration constants
#define ANTMODE_UNCHANGED			0

#define ANTMODE_MASK_ANTSEL			0x00F
#define ANTMODE_MASK_PHYMODE		0x0F0
#define ANTMODE_MASK_PHYANTCFG		0xF00

#define ANTMODE_ANTSEL_RADA			0x001
#define ANTMODE_ANTSEL_RADB			0x002
#define ANTMODE_ANTSEL_BOTHRADS		(ANTMODE_ANTSEL_RADA | ANTMODE_ANTSEL_RADB)

#define PHYMODE_SISO				0x010
#define PHYMODE_ALAMOUTI			0x020
#define PHYMODE_2X2MULT				0x040

#define PHYANTCFG_TX_NORMAL			0x100
#define PHYANTCFG_TX_SWAPPED		0x200

#define PHYANTCFG_RX_NORMAL			0x100
#define PHYANTCFG_RX_SWAPPED		0x200
#define PHYANTCFG_RX_SELDIV			0x400

#define TX_ANTMODE_SISO_ANTA				(ANTMODE_ANTSEL_RADA | PHYMODE_SISO | PHYANTCFG_TX_NORMAL)
#define TX_ANTMODE_SISO_ANTB				(ANTMODE_ANTSEL_RADB | PHYMODE_SISO | PHYANTCFG_TX_SWAPPED)
#define TX_ANTMODE_MULTPLX					(ANTMODE_ANTSEL_BOTHRADS | PHYMODE_2X2MULT | PHYANTCFG_TX_NORMAL)
#define TX_ANTMODE_MULTPLX_SWAPPED			(ANTMODE_ANTSEL_BOTHRADS | PHYMODE_2X2MULT | PHYANTCFG_TX_SWAPPED)
#define TX_ANTMODE_ALAMOUTI_2ANT			(ANTMODE_ANTSEL_BOTHRADS | PHYMODE_ALAMOUTI | PHYANTCFG_TX_NORMAL)
#define TX_ANTMODE_ALAMOUTI_2ANT_SWAPPED	(ANTMODE_ANTSEL_BOTHRADS | PHYMODE_ALAMOUTI | PHYANTCFG_TX_SWAPPED)
#define TX_ANTMODE_ALAMOUTI_ANTA			(ANTMODE_ANTSEL_RADA | PHYMODE_ALAMOUTI | PHYANTCFG_TX_NORMAL)
#define TX_ANTMODE_ALAMOUTI_ANTB			(ANTMODE_ANTSEL_RADB | PHYMODE_ALAMOUTI | PHYANTCFG_TX_NORMAL)
#define TX_ANTMODE_ALAMOUTI_ANTA_SWAPPED	(ANTMODE_ANTSEL_RADA | PHYMODE_ALAMOUTI | PHYANTCFG_TX_SWAPPED)
#define TX_ANTMODE_ALAMOUTI_ANTB_SWAPPED	(ANTMODE_ANTSEL_RADB | PHYMODE_ALAMOUTI | PHYANTCFG_TX_SWAPPED)

#define RX_ANTMODE_SISO_ANTA				(ANTMODE_ANTSEL_RADA | PHYMODE_SISO | PHYANTCFG_RX_NORMAL)
#define RX_ANTMODE_SISO_ANTB				(ANTMODE_ANTSEL_RADB | PHYMODE_SISO | PHYANTCFG_RX_SWAPPED)
#define RX_ANTMODE_SISO_SELDIV				(ANTMODE_ANTSEL_BOTHRADS | PHYMODE_SISO | PHYANTCFG_RX_SELDIV)
#define RX_ANTMODE_MULTPLX					(ANTMODE_ANTSEL_BOTHRADS | PHYMODE_2X2MULT | PHYANTCFG_RX_NORMAL)
#define RX_ANTMODE_ALAMOUTI_ANTA			(ANTMODE_ANTSEL_RADA | PHYMODE_ALAMOUTI | PHYANTCFG_RX_NORMAL)
#define RX_ANTMODE_ALAMOUTI_ANTB			(ANTMODE_ANTSEL_RADB | PHYMODE_ALAMOUTI | PHYANTCFG_RX_SWAPPED)
#define RX_ANTMODE_ALAMOUTI_SELDIV			(ANTMODE_ANTSEL_BOTHRADS | PHYMODE_ALAMOUTI | PHYANTCFG_RX_SELDIV)

//Bit masks for the options configured in Rx_ControlBits
#define RESET_BER 			0x1
#define REQ_LONG_CORR		0x2
//#define UNUSED			0x4
#define BIG_PKTBUF_MODE		0x8
#define RX_SISO_MODE		0x10
//#define UNUSED			0x20
//#define UNUSED			0x40
#define RECORD_CHAN_ESTS	0x80
#define RECORD_CHAN_ESTMAGS	0x100
#define BYPASS_CARR_REC		0x200
#define COARSE_CFO_EN		0x400
#define EXT_PKTDETRESET_EN	0x800
#define RSSI_GAIN_ADJ		0x1000
#define EQ_BYPASS_DIVISION  0x4000
#define TX_DISABLE_PKTDET	0x8000
#define SIMPLE_DYN_MOD_EN	0x10000
#define SWITCHING_DIV_EN	0x20000
#define SISO_ON_ANTB		0x40000
#define RESET_ON_BAD_HDR	0x80000
#define RX_ALAMOUTI_MODE	0x100000
#define FLEX_BER_MODE       0x200000
#define BER_IGNORE_HDR      0x400000
#define PHY_RADIO_RXEN		0x1000000
#define AF_SAVEWAVEFORM		0x2000000
#define AUTORESP_FLAGA_RST  0x4000000
#define AUTORESP_FLAGB_RST  0x8000000
#define COARSECFO_PKTDET_EN	0x10000000
#define CHANMAG_MASKING_EN	0x20000000
//#define UNUSED			0x40000000
#define RX_GLOBAL_RESET		0x80000000

//Bit masks for PreCFO_Options register
#define PRECFO_USECOARSE	0x00000001
#define PRECFO_USEPILOTS	0x00000002

//Bit masks for Tx Start/Reset register
#define TX_MASTER_RESET		0x1
#define TX_START			0x2

//Bit masks for OFDM Tx options
#define TX_SISO_MODE				0x00000001
#define TX_ALAMOUTI_MODE			0x00000002
#define TX_DISABLE_ANTB_PREAMBLE	0x00000004
#define TX_PILOT_SCRAMBLING			0x00000008
#define TX_PREAMBLE_B_DLY			0x000000F0 //4-bit value
#define TX_RANDOM_PAYLOAD			0x00000100
#define TX_SWAP_ANTENNAS			0x00000200
#define TX_SOFTWARE_TXEN			0x00000400
#define TX_EXTERNAL_TXEN			0x00000800
#define TX_ALWAYS_USE_PRECFO		0x00001000
#define TX_CAPTURE_RANDOM_PAYLOAD	0x00002000
#define TX_AUTO_TWOTX_EN			0x00004000
#define TX_START_D0_OUT_EN			0x00008000
#define TX_START_D1_OUT_EN			0x00010000
#define TX_ALT_INTERPFILT			0x00020000
#define TX_CONJ_ANTB_STS			0x00040000
#define TX_CONJ_ANTB_LTS			0x00080000

//Bit masks for Tx_Delays register
#define TX_EXTAUTO_TXEN_DLY_LSB		0 //0x000000FF //8-bit value
#define TX_AUTOTX_EXTRA_DLY_LSB		8 //0x00000F00 //4-bit value
#define TX_START_D_OUTPUTS_DLY_LSB	12 //0x000FF000 //8-bit value

//Bit masks for the Tx/Rx status bits
#define RXSTATUS_PKTDONE_RST	0x1
#define RXSTATUS_HEADER_RST		0x2
#define TXSTATUS_DONE_RST		0x4

#define RXSTATUS_GOODPKT		0x8
#define RXSTATUS_BADPKT			0x10
#define RXSTATUS_GOODHEADER		0x20
#define RXSTATUS_BADHEADER		0x40
#define TXSTATUS_DONE			0x80

#define ALL_STATUSBITS_ENABLE (RXSTATUS_GOODHEADER|RXSTATUS_BADHEADER|RXSTATUS_BADPKT|RXSTATUS_GOODPKT|TXSTATUS_DONE)
#define DEFAULT_STATUSBITS (RXSTATUS_GOODHEADER|RXSTATUS_BADHEADER|RXSTATUS_BADPKT|RXSTATUS_GOODPKT)
#define DEFAULT_STATUSBITRESETS (RXSTATUS_HEADER_RST|RXSTATUS_PKTDONE_RST|TXSTATUS_DONE_RST)

//Define which radios get used
//RADIOx_ADDR are defined by the radio controller driver
#define FIRST_RADIO RADIO2_ADDR
#define SECOND_RADIO RADIO3_ADDR
#define BOTH_RADIOS (FIRST_RADIO | SECOND_RADIO)

//Shorthand for configuring the radio controller's selected band
#define GHZ_5 0
#define GHZ_2 1

//Bit masks for OFDM Tx status register
#define OFDM_TX_BUSY		0x1
#define OFDM_TX_HEADERBUSY	0x2

//Bits 0xF0 are used for 4-bit preable shift value
#define TX_SISO_ON_ANTB 0x100

//MAC2PHY Options
#define TXBLOCK		0x0
#define TXNOBLOCK	0x1

//Macros for accessing the OFDM packet buffer; buff is an integer in [0,NUMPKTBUFFS-1]
#define warpphy_copyBytesToPhy(buff,src,len) memcpy(OFDM_PKTBUFF_BASEADDR + buff * 0x1000,(src),(len))
#define warpphy_copyBytesFromPhy(buff,dest,len) memcpy((dest), OFDM_PKTBUFF_BASEADDR + buff * 0x1000, (len))

//Macro to retrieve the physical memory address for a given packet buffer index 
// PHY packet buffers are 2048 bytes (0x800) each
// The current PHY has 32 buffers, so the buffer index is masked to 5 bits
//   here to avoid returning bogus buffer addresses
#define warpphy_getBuffAddr(c) (OFDM_PKTBUFF_BASEADDR + (c & 0x1F)*(0x800))

//Macros to read/write PHY registers
#define mimo_ofdmTx_setStartTx(c) 	ofdm_txrx_mimo_WriteReg_Tx_Start_Reset_Control(OFDM_BASEADDR, ( (c<<1) & TX_START) )
#define mimo_ofdmRx_setByteNums(c) ofdm_txrx_mimo_WriteReg_Rx_pktByteNums(OFDM_BASEADDR, c)
#define mimo_ofdmRx_setRxScaling(c) ofdm_txrx_mimo_WriteReg_Rx_Constellation_Scaling(OFDM_BASEADDR, c)
#define mimo_ofdmRx_setLongCorrParams(c) ofdm_txrx_mimo_WriteReg_Rx_PktDet_LongCorr_Params(OFDM_BASEADDR, c)

#define mimo_ofdmTx_setPilotIndcies(c) ofdm_txrx_mimo_WriteReg_TxRx_Pilots_Index(0, c)
#define mimo_ofdmTxRx_setPilotValues(c) ofdm_txrx_mimo_WriteReg_TxRx_Pilots_Values(0, c)

#define mimo_ofdmTxRx_setFECoptions(codingEn, softEn, zeroTail, scale_qpsk, scale_16qam) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_FEC_CONFIG_W, ( \
	((codingEn<<0)	& 0x1) | \
	((softEn<<1)	& 0x2) | \
	((zeroTail<<2)	& 0x4) | \
	((scale_qpsk<<4) & 0xF0) | \
	((scale_16qam<<8) & 0x1F00)))

//#define warpphy_setChanEstMinMags(chanAA, chanBA) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_CHANEST_MINMAG_W, ( (chanAA & 0xFFFF) | ( (chanBA & 0xFFFF)<<16)))
#define warpphy_setChanEstMinMags(estmag) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_CHANEST_MINMAG_W, (estmag))

#define warpphy_setAFblanking(start, stop) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_AF_BLANKING_W, ( (start & 0xFFF) | ( (stop & 0xFFF) << 16)))

#define warpphy_setTxNumSyms(numBR, numT) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TX_OFDM_SYMCOUNTS_W, ( (numT & 0xF) | ( (numBR & 0x1F)<<8) ) )
#define warpphy_setRxNumSyms(numBR, numT) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_OFDM_SYMBOLCOUNTS_W, ( (numT & 0xF) | ( (numBR & 0x1F)<<16) ) )

#define warpphy_setPreCFOoptions(c) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PRECFO_OPTIONS_W, c)
#define warpphy_getPreCFO_pktBuf(bufInd) XIo_In32( (XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTBUFFREQOFFSETS + (4*((bufInd)&0x1F))) )
#define warpphy_setPreCFO_pktBuf(bufInd, cfoVal) XIo_Out32( (XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTBUFFREQOFFSETS + (4*((bufInd)&0x1F))), cfoVal)

#define warpphy_getPreCFO_pkt_coarse() XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_COARSECFOEST)
#define warpphy_getPreCFO_pkt_pilots() XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PILOTCFOEST)
#define warpphy_setPilotCFOCorrection(c) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PRECFO_PILOTCALCCORRECTION_W, c)

#define warpphy_setCoarseCFOCorrection(c) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_COARSECFO_CORRECTION_W, c)

#define mimo_ofdmTx_setTxScaling(pre, pay) ofdm_txrx_mimo_WriteReg_Tx_Scaling(OFDM_BASEADDR, ((0xFFFF & pre) | (0xFFFF0000 & (pay<<16))) )

#define mimo_ofdmTx_setControlBits(c) ofdm_txrx_mimo_WriteReg_Tx_ControlBits(OFDM_BASEADDR, c)
#define mimo_ofdmTx_getOptions() ofdm_txrx_mimo_ReadReg_Tx_ControlBits(OFDM_BASEADDR)

#define mimo_ofdmTx_setDelays(extTxEn, extraAutoTx, txStartOut) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TX_DELAYS_W, ( \
	( (extTxEn&0xFF)	<< TX_EXTAUTO_TXEN_DLY_LSB) | \
	( (extraAutoTx&0xF)	<< TX_AUTOTX_EXTRA_DLY_LSB) | \
	( (txStartOut&0xFF)	<< TX_START_D_OUTPUTS_DLY_LSB)))

#define mimo_ofdmTxRx_setFFTScaling(c) ofdm_txrx_mimo_WriteReg_TxRx_FFT_Scaling(OFDM_BASEADDR, c)
#define mimo_ofdmRx_setFFTWindowOffset(c) ofdm_txrx_mimo_WriteReg_Rx_PktDet_Delay(OFDM_BASEADDR, (ofdm_txrx_mimo_ReadReg_Rx_PktDet_Delay(OFDM_BASEADDR) & 0xFFFFE07F) | ((c&0x3F)<<7))

#define mimo_ofdmRx_setPktDetDly(c) ofdm_txrx_mimo_WriteReg_Rx_PktDet_Delay(OFDM_BASEADDR, (ofdm_txrx_mimo_ReadReg_Rx_PktDet_Delay(OFDM_BASEADDR) & 0xFFFFFF80)| (c&0x7F))
#define mimo_ofdmRx_setCFOCalcDly(c) ofdm_txrx_mimo_WriteReg_Rx_PktDet_Delay(OFDM_BASEADDR, (ofdm_txrx_mimo_ReadReg_Rx_PktDet_Delay(OFDM_BASEADDR) & ~0x001F0000) | ( (c&0x1F)<<16 ))
#define mimo_ofdmRx_setCFOMaxDiff(c) ofdm_txrx_mimo_WriteReg_Rx_PktDet_Delay(OFDM_BASEADDR, (ofdm_txrx_mimo_ReadReg_Rx_PktDet_Delay(OFDM_BASEADDR) & ~0xFF000000) | ( (c&0xFF)<<24 ))

#define mimo_ofdmTx_setPktDoneReset(c) ofdm_txrx_mimo_WriteReg_Tx_Start_Reset_Control(OFDM_BASEADDR, (c<<2)&0x4)
#define mimo_ofdmRx_getPayloadStatus() (PHYRXSTATUS_PAYLOAD & ofdm_txrx_mimo_ReadReg_Rx_packet_done(OFDM_BASEADDR))
#define mimo_ofdmRx_getHeaderStatus() ((PHYRXSTATUS_HEADER & ofdm_txrx_mimo_ReadReg_Rx_packet_done(OFDM_BASEADDR)))
#define mimo_ofdmRx_getPktStatus()	(((PHYRXSTATUS_PAYLOAD | PHYRXSTATUS_HEADER) & ofdm_txrx_mimo_ReadReg_Rx_packet_done(OFDM_BASEADDR)))

#define mimo_ofdmRx_setAFTxScaling(c) ofdm_rx_mimo_WriteReg_Rx_AFScaling(0, c)

#define mimo_ofdmRx_setPilotCalcParams(minMag) ofdm_rx_mimo_WriteReg_Rx_PilotCalcParams(0, (minMag & 0xFFF))

//Timer Defines
#define TIMER_A 0
#define TIMER_B 1
#define TIMER_C 2
#define TIMER_D 3

#define TIMER_A_DONE 0x1
#define TIMER_B_DONE 0x100
#define TIMER_C_DONE 0x10000
#define TIMER_D_DONE 0x1000000

#define TIMER_A_ACTIVE 0x2
#define TIMER_B_ACTIVE 0x200
#define TIMER_C_ACTIVE 0x20000
#define TIMER_D_ACTIVE 0x2000000

#define TIMER_A_PAUSED 0x4
#define TIMER_B_PAUSED 0x400
#define TIMER_C_PAUSED 0x40000
#define TIMER_D_PAUSED 0x4000000

//Byte indicies of various header fields (used for the autoRepsonse setup)
#define PKTHEADER_INDX_SRCADDR	4
#define PKTHEADER_INDX_DSTADDR	6
#define PKTHEADER_INDX_RLYADDR	8
#define PKTHEADER_INDX_TYPE		10
#define PKTHEADER_INDX_RETX		11
#define PKTHEADER_INDX_SEQ		12
#define PKTHEADER_INDX_PREVCHECK 20
#define PKTHEADER_INDX_CHECK	22

///Structure contains PHY header
typedef struct {
	///Full-rate modulation order
	unsigned char fullRate;		//0
	///Rate for convolutional error correction code
	unsigned char codeRate;			//1
	///The length of the packet (in bytes). NOTE: This should only specify the length of the payload to-be-sent.
	unsigned short int length;		//2
	///Source MAC address.
	unsigned short int srcAddr;		//4
	///Destination MAC address.
	unsigned short int destAddr;	//6
	///Relay MAC address.
	unsigned short int relAddr;		//8
	///Type of packet this particular Macframe corresponds to (e.g. DATA, ACKPACKET, etc.)
	unsigned char pktType;			//10
	///Reserved byte
	unsigned char remainingTx;		//11
	///Sequence number of this packet
	unsigned int seqNum;			//12-15
	///Reserved byte
	unsigned short int timeLeft;
	unsigned char cogParam;
	unsigned char reserved0;
	unsigned char reserved1; //20
	unsigned char reserved2; //21

	///Checksum of the packet will be automatically inserted by PHY
	unsigned short int checksum;	//22
} phyHeader;

//Prototypes for functions in warpphy.c
int warpphy_init();
void warpphy_clearRxInterrupts();
void warpphy_clearTxInterrupts();
int warpphy_pktTx(unsigned int block);
void mimo_ofdmRx_enable();
void mimo_ofdmRx_disable();
void mimo_ofdmRx_setOptions(unsigned int someOptions, unsigned int intType);
unsigned int mimo_ofdmRx_getOptions();
void mimo_ofdmTx_disable();
void mimo_ofdmTx_enable();
void warpphy_setBuffs(unsigned char txBufOffset, unsigned char rxBufOffset);
void warpphy_setNumTrainingSyms(unsigned int numTraining);
void warpphy_setPktDlyPlus();
void warpphy_setPktDlyMinus();
void warpphy_set_PN_KPlus(unsigned int increment);
void warpphy_set_PN_KMinus(unsigned int decrement);
void warpphy_set_CFODebugOutput(unsigned char outputSel);
void print_CFO_constants();
void warpphy_set_B_KPPlus(unsigned int increment);
void warpphy_set_B_KPMinus(unsigned int decrement);
void warpphy_set_B_KIPlus(unsigned int increment);
void warpphy_set_B_KIMinus(unsigned int decrement);
void warpphy_set_FFTOffset_Plus();
void warpphy_set_FFTOffset_Minus();
void warpphy_setNoiseTargetPlus();
void warpphy_setNoiseTargetMinus();
void warpphy_setTargetPlus();
void warpphy_setTargetMinus();
void warpphy_set_modulation(unsigned char baseRate, unsigned char TxAntAFullRate, unsigned char TxAntBFullRate, unsigned char RxAntAFullRate, unsigned char RxAntBFullRate);
int warpphy_setChannel(unsigned char band, unsigned int chan);
int warpphy_applyTxDCOCorrection(unsigned int radioSelection);
void warpphy_clearRxHeaderInterrupt();
void warpphy_setPktDetPlus(unsigned int offset);
void warpphy_setPktDetMinus(unsigned int offset);
void warpphy_setCSMAPlus(unsigned int offset);
void warpphy_setCSMAMinus(unsigned int offset);
int warpphy_isFree();
char warpphy_pollRxStatus(unsigned char type);
void ofdm_AGC_SetTarget(unsigned int target);
inline void ofdm_AGC_SetDCO(unsigned int AGCstate);
void ofdm_AGC_Reset();
void ofdm_AGC_MasterReset();
void ofdm_AGC_Initialize(int noise_estimate);
void ofdm_AGC_setNoiseEstimate(int noise_estimate);
unsigned int ofdm_AGC_GetGains(void);
void ofdm_timer_start();
void ofdm_timer_stop();
void ofdm_timer_clearInterrupt();
int warpphy_setTxPower(unsigned char txPwr);
int warpphy_setAntennaMode(unsigned int txMode, unsigned int rxMode);
void warpphy_incrementTxScaling(int incr_preamble, int incr_payload);
void warpphy_setLongCorrThresh(unsigned short thresh);
void warpphy_setEnergyDetThresh(unsigned short thresh);
void warpphy_clearAutoResponseFlag(unsigned char flagID);
void warpphy_setAntBPreambleShift(unsigned char shift);
void warpphy_AFrecordEnable(unsigned char recordEn);
void warpphy_setNumBaseRateSyms(unsigned int numSyms);
void warpphy_setAutoCorrDetParams(unsigned short corrThresh, unsigned short energyThresh);
void warpphy_setCarrierSenseThresh(unsigned short thresh);

//warp_timer function prototypes
void warp_timer_start(unsigned char timer);
void warp_timer_pause(unsigned char timer);
void warp_timer_resume(unsigned char timer);
void warp_timer_setMode(unsigned char timer, unsigned char mode);
void warp_timer_resetDone(unsigned char timer);
void warp_timer_resetAllDoneStatus();
void warp_timer_setTimer(unsigned char timer, unsigned int slotTime, unsigned int slotCount);
void warp_timer_init();
unsigned char warp_timer_getStatus(unsigned char timer);
unsigned char warp_timer_isDone(unsigned char timer);
unsigned char warp_timer_isActive(unsigned char timer);
unsigned char warp_timer_isPaused(unsigned char timer);
unsigned int warp_timer_getStatuses();
unsigned char warp_timer_getDoneStatus();
void warpphy_saveAFpkt(unsigned char doSave);
int warpphy_setTxAntennaSwap(unsigned int txMode);
unsigned int warpphy_returnGainsDB();

//Register access macros
#define mimo_ofdmTxRx_getAction0() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION0_R))
#define mimo_ofdmTxRx_getAction1() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION1_R))
#define mimo_ofdmTxRx_getAction2() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION2_R))
#define mimo_ofdmTxRx_getAction3() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION3_R))
#define mimo_ofdmTxRx_getAction4() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION4_R))
#define mimo_ofdmTxRx_getAction5() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION5_R))
#define mimo_ofdmTxRx_getAction6() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION6_R))
#define mimo_ofdmTxRx_getAction7() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION7_R))

#define mimo_ofdmTxRx_setAction0(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION0_W, d))
#define mimo_ofdmTxRx_setAction1(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION1_W, d))
#define mimo_ofdmTxRx_setAction2(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION2_W, d))
#define mimo_ofdmTxRx_setAction3(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION3_W, d))
#define mimo_ofdmTxRx_setAction4(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION4_W, d))
#define mimo_ofdmTxRx_setAction5(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION5_W, d))
#define mimo_ofdmTxRx_setAction6(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION6_W, d))
#define mimo_ofdmTxRx_setAction7(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_ACTION7_W, d))

#define mimo_ofdmTxRx_getMatch0() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH0_R))
#define mimo_ofdmTxRx_getMatch1() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH1_R))
#define mimo_ofdmTxRx_getMatch2() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH2_R))
#define mimo_ofdmTxRx_getMatch3() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH3_R))
#define mimo_ofdmTxRx_getMatch4() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH4_R))
#define mimo_ofdmTxRx_getMatch5() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH5_R))
#define mimo_ofdmTxRx_getMatch6() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH6_R))
#define mimo_ofdmTxRx_getMatch7() (XIo_In32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH7_R))

#define mimo_ofdmTxRx_setMatch0(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH0_W, d))
#define mimo_ofdmTxRx_setMatch1(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH1_W, d))
#define mimo_ofdmTxRx_setMatch2(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH2_W, d))
#define mimo_ofdmTxRx_setMatch3(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH3_W, d))
#define mimo_ofdmTxRx_setMatch4(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH4_W, d))
#define mimo_ofdmTxRx_setMatch5(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH5_W, d))
#define mimo_ofdmTxRx_setMatch6(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH6_W, d))
#define mimo_ofdmTxRx_setMatch7(d) (XIo_Out32((unsigned int)XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_AUTOREPLY_MATCH7_W, d))

//Match definition fields for match units 0-5 (comparison of incoming header with static value)
#define PHY_AUTORESPONSE_MATCH_BYTEADDR_MASK	0x0000001F
#define PHY_AUTORESPONSE_MATCH_BYTEADDR_OFFSET	0

#define PHY_AUTORESPONSE_MATCH_LENGTH_MASK		0x00000060
#define PHY_AUTORESPONSE_MATCH_LENGTH_OFFSET	5

#define PHY_AUTORESPONSE_MATCH_VALUE_MASK		0xFFFFFF00
#define PHY_AUTORESPONSE_MATCH_VALUE_OFFSET		8

#define PHY_AUTORESPONSE_MATCH_VALUE_MAP(c)		((c<<PHY_AUTORESPONSE_MATCH_VALUE_OFFSET) & PHY_AUTORESPONSE_MATCH_VALUE_MASK)
#define PHY_AUTORESPONSE_MATCH_LENGTH_MAP(c)	((c<<PHY_AUTORESPONSE_MATCH_LENGTH_OFFSET) & PHY_AUTORESPONSE_MATCH_LENGTH_MASK)
#define PHY_AUTORESPONSE_MATCH_BYTEADDR_MAP(c)	((c<<PHY_AUTORESPONSE_MATCH_BYTEADDR_OFFSET) & PHY_AUTORESPONSE_MATCH_BYTEADDR_MASK)

#define PHY_AUTORESPONSE_MATCH_CONFIG(addr, len, val) (PHY_AUTORESPONSE_MATCH_BYTEADDR_MAP(addr) | PHY_AUTORESPONSE_MATCH_LENGTH_MAP(len) | PHY_AUTORESPONSE_MATCH_VALUE_MAP(val))

//Match definition fields for match units 6-7 (comparison of incoming header with previously received header corresponding to saved waveform)
#define PHY_AUTORESPONSE_MATCH_RXADDR0_OFFSET		0
#define PHY_AUTORESPONSE_MATCH_RXADDR0_MASK			(0x0000001F<< PHY_AUTORESPONSE_MATCH_RXADDR0_OFFSET)
#define PHY_AUTORESPONSE_MATCH_PREVADDR0_OFFSET		5
#define PHY_AUTORESPONSE_MATCH_PREVADDR0_MASK		(0x0000001F<< PHY_AUTORESPONSE_MATCH_PREVADDR0_OFFSET)

#define PHY_AUTORESPONSE_MATCH_RXADDR1_OFFSET		10
#define PHY_AUTORESPONSE_MATCH_RXADDR1_MASK			(0x0000001F<< PHY_AUTORESPONSE_MATCH_RXADDR1_OFFSET)
#define PHY_AUTORESPONSE_MATCH_PREVADDR1_OFFSET		15
#define PHY_AUTORESPONSE_MATCH_PREVADDR1_MASK		(0x0000001F<< PHY_AUTORESPONSE_MATCH_PREVADDR1_OFFSET)
#define PHY_AUTORESPONSE_MATCH_ADDR1_EN				0x40000000

#define PHY_AUTORESPONSE_MATCH_RXADDR2_OFFSET		20
#define PHY_AUTORESPONSE_MATCH_RXADDR2_MASK			(0x0000001F<< PHY_AUTORESPONSE_MATCH_RXADDR2_OFFSET)
#define PHY_AUTORESPONSE_MATCH_PREVADDR2_OFFSET		25
#define PHY_AUTORESPONSE_MATCH_PREVADDR2_MASK		(0x0000001F<< PHY_AUTORESPONSE_MATCH_PREVADDR2_OFFSET)
#define PHY_AUTORESPONSE_MATCH_ADDR2_EN				0x80000000

//Macro to help define header comparison match configuration registers
#define PHY_AUTORESPONSE_MATCH_HDRCOMP_CONFIG(rxAddr0, prevAddr0, rxAddr1, prevAddr1, useAddr1, rxAddr2, prevAddr2, useAddr2) (\
( (rxAddr0 << PHY_AUTORESPONSE_MATCH_RXADDR0_OFFSET) & PHY_AUTORESPONSE_MATCH_RXADDR0_MASK) | \
( (rxAddr1 << PHY_AUTORESPONSE_MATCH_RXADDR1_OFFSET) & PHY_AUTORESPONSE_MATCH_RXADDR1_MASK) | \
( (rxAddr2 << PHY_AUTORESPONSE_MATCH_RXADDR2_OFFSET) & PHY_AUTORESPONSE_MATCH_RXADDR2_MASK) | \
( (prevAddr0 << PHY_AUTORESPONSE_MATCH_PREVADDR0_OFFSET) & PHY_AUTORESPONSE_MATCH_PREVADDR0_MASK) | \
( (prevAddr1 << PHY_AUTORESPONSE_MATCH_PREVADDR1_OFFSET) & PHY_AUTORESPONSE_MATCH_PREVADDR1_MASK) | \
( (prevAddr2 << PHY_AUTORESPONSE_MATCH_PREVADDR2_OFFSET) & PHY_AUTORESPONSE_MATCH_PREVADDR2_MASK) | \
( useAddr1 ? PHY_AUTORESPONSE_MATCH_ADDR1_EN : 0) | \
( useAddr2 ? PHY_AUTORESPONSE_MATCH_ADDR2_EN : 0) )


//Action fields
#define PHY_AUTORESPONSE_ACT_ID_MASK	0x00FC0000
#define PHY_AUTORESPONSE_ACT_ID_OFFSET	18

#define PHY_AUTORESPONSE_ACT_PARAM_MASK		0xFF000000
#define PHY_AUTORESPONSE_ACT_PARAM_OFFSET	24
#define PHY_AUTORESPONSE_MAP_ACT_PARAM(c)	((c<<PHY_AUTORESPONSE_ACT_PARAM_OFFSET) & PHY_AUTORESPONSE_ACT_PARAM_MASK)

#define PHY_AUTORESPONSE_ACT_TRANS_HDR	0x00010000
#define PHY_AUTORESPONSE_ACT_USE_PRECFO	0x00020000
#define PHY_AUTORESPONSE_ACT_RETX_CRC	0x00000200
#define PHY_AUTORESPONSE_ACT_SWAP_ANT	0x00000400

#define PHY_AUTORESPONSE_REQ_GOODHDR	0x000800
#define PHY_AUTORESPONSE_REQ_BADPKT		0x001000
#define PHY_AUTORESPONSE_REQ_GOODPKT	0x002000

#define PHY_AUTORESPONSE_REQ_FLAGA		0x004000
#define PHY_AUTORESPONSE_REQ_FLAGB		0x008000

#define PHY_AUTORESPONSE_REQ_MATCH0		0x001
#define PHY_AUTORESPONSE_REQ_MATCH1		0x002
#define PHY_AUTORESPONSE_REQ_MATCH2		0x004
#define PHY_AUTORESPONSE_REQ_MATCH3		0x008
#define PHY_AUTORESPONSE_REQ_MATCH4		0x010
#define PHY_AUTORESPONSE_REQ_MATCH5		0x020
#define PHY_AUTORESPONSE_REQ_MATCH6		0x040
#define PHY_AUTORESPONSE_REQ_MATCH7		0x080

#define PHY_AUTORESPONSE_REQ_MATCHALL	(PHY_AUTORESPONSE_REQ_MATCH0 | PHY_AUTORESPONSE_REQ_MATCH1 | PHY_AUTORESPONSE_REQ_MATCH2 | PHY_AUTORESPONSE_REQ_MATCH3 | PHY_AUTORESPONSE_REQ_MATCH4 | PHY_AUTORESPONSE_REQ_MATCH5 | PHY_AUTORESPONSE_REQ_MATCH6 | PHY_AUTORESPONSE_REQ_MATCH7)
#define PHY_AUTORESPONSE_REQ_ALLCONDS	(PHY_AUTORESPONSE_REQ_MATCHALL | PHY_AUTORESPONSE_REQ_FLAGA | PHY_AUTORESPONSE_REQ_FLAGB | PHY_AUTORESPONSE_REQ_GOODHDR | PHY_AUTORESPONSE_REQ_BADPKT | PHY_AUTORESPONSE_REQ_GOODPKT)

//ActionIDs
#define PHY_AUTORESPONSE_ACTID_DISABLED		((00<<PHY_AUTORESPONSE_ACT_ID_OFFSET) & PHY_AUTORESPONSE_ACT_ID_MASK)
#define PHY_AUTORESPONSE_ACTID_SETFLAGA		((62<<PHY_AUTORESPONSE_ACT_ID_OFFSET) & PHY_AUTORESPONSE_ACT_ID_MASK)
#define PHY_AUTORESPONSE_ACTID_SETFLAGB		((61<<PHY_AUTORESPONSE_ACT_ID_OFFSET) & PHY_AUTORESPONSE_ACT_ID_MASK)
#define PHY_AUTORESPONSE_ACTID_TXPKTBUF(c)	((   c<<PHY_AUTORESPONSE_ACT_ID_OFFSET) & PHY_AUTORESPONSE_ACT_ID_MASK)

#define PHY_HEADERTRANSLATE_SET(actionBuf, txByteNum, srcBuf, srcByteNum) \
	XIo_Out32(\
	(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXHEADERTRANSLATE + ((actionBuf)*32*sizeof(int)) + ((txByteNum)*sizeof(int))),\
	(((srcBuf) & 0x1F)<<5) | ((srcByteNum) & 0x1F))

//Macro to help construct autoResponse Tx actions
#define PHY_AUTORESPONSE_TXACTION_CONFIG(pktBuf, actionOptions, delay, conditions) (\
	(PHY_AUTORESPONSE_ACTID_TXPKTBUF(pktBuf) ) | \
	(actionOptions & (PHY_AUTORESPONSE_ACT_SWAP_ANT | PHY_AUTORESPONSE_ACT_TRANS_HDR | PHY_AUTORESPONSE_ACT_USE_PRECFO)) | \
	(PHY_AUTORESPONSE_MAP_ACT_PARAM(delay) ) | \
	(conditions & (PHY_AUTORESPONSE_REQ_ALLCONDS)))

//Macro to help construct autoResponse action for setting Flag A
#define PHY_AUTORESPONSE_ACTION_SETFLAGA_CONFIG(conditions) (PHY_AUTORESPONSE_ACTID_SETFLAGA | (conditions & (PHY_AUTORESPONSE_REQ_ALLCONDS)))

//Macro to help construct autoResponse action for setting Flag B
#define PHY_AUTORESPONSE_ACTION_SETFLAGB_CONFIG(conditions) (PHY_AUTORESPONSE_ACTID_SETFLAGB | (conditions & (PHY_AUTORESPONSE_REQ_ALLCONDS)))

//Flag IDs for user functions
#define AUTORESP_FLAGID_A 1
#define AUTORESP_FLAGID_B 2

#endif
