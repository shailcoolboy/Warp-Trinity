/*! \file warpmac.h
\brief Header file for the WARPMAC Framework.

@version 16.1
@author Chris Hunter and Patrick Murphy

This header file contains the macros, function prototypes, and typedefs required for WARPMAC.
*/

/*! \mainpage WARP APIs
* @version Used with Reference Design v16.1
*
* \section change_sec CHANGELOG
* http://warp.rice.edu/trac/wiki/OFDMReferenceDesign/Changelog
*
* \section intro_sec Introduction
*
* This document is the collective API for WARPMAC (the MAC design framework),
* WARPPHY (the PHY driver/interface), the radio controller driver and CSMAMAC (the carrier-sensing random access
* reference design).
*
* \section start_sec Getting Started
*
* Obtain the latest reference design: http://warp.rice.edu/trac/wiki/OFDMReferenceDesign .
* In addition to being in the repository, all the source code for WARPMAC is available in
* the reference design project and is configured to compile "as-is."
*
* \section licence_sec License
* http://warp.rice.edu/license/
*
*/

#ifndef WARPMAC_H
#define WARPMAC_H

#include "warp_fpga_board.h"
#include "xstatus.h"
#include "warpphy.h"

//Define which radios get used below
//RADIOx_ADDR are defined by the radio controller driver
//Address of the first radio
#define FIRST_RADIO RADIO2_ADDR
//Address of the second radio
#define SECOND_RADIO RADIO3_ADDR

//Helper macros for constructing headers
#define htons(A) ((((Xuint16)(A) & 0xff00) >> 8) | (((Xuint16)(A) & 0x00ff) << 8))
#define NODEID_TO_ADDR(theID)	( theID & 0xFFFF )
#define ADDR_TO_NODEID(theAddr)	( theAddr & 0xFFFF )

#define MY_XEM_MAX_FRAME_SIZE 2000

//Masks for supported modulation schemes; equivalent to number of bits per symbol
#define BPSK	1
#define QPSK	2
#define QAM_16	4
#define QAM_64	6

//Constants used for packet headers specifying full-rate modulation per-packet
// This constant fills in an 8-bit field in the header
// Each 4-bit nibble corresponds to an antenna
#define HDR_FULLRATE_BPSK		(BPSK | (BPSK<<4))
#define HDR_FULLRATE_QPSK		(QPSK | (QPSK<<4))
#define HDR_FULLRATE_QAM_16	(QAM_16 | (QAM_16<<4))
#define HDR_FULLRATE_QAM_64	(QAM_64 | (QAM_64<<4))

//2.4 GHz Band
#define GHZ_2 1
//5 GHz Band
#define GHZ_5 0

//Shortcuts for xparameters.h constants
// Device IDs
#define DMA_CTRL_DEVICE_ID		XPAR_DMACENTRAL_0_DEVICE_ID

//Average RSSI threshold for carrier sensing
#define THRESH_CARRIER_SENSE 5000

//Event ID's for callback registration
#define EVENT_UPBUTTON			1
#define EVENT_LEFTBUTTON		2
#define EVENT_RIGHTBUTTON		3
#define EVENT_MIDDLEBUTTON		4
#define EVENT_TIMER				5
#define EVENT_DATAFROMNETWORK	6
#define EVENT_MGMTPKT			7
#define EVENT_PHYGOODHEADER		8
#define EVENT_PHYBADHEADER		9
#define EVENT_UARTRX			10

//The number of bytes in the header must be fixed and known by every node ahead of time
// It also must occupy an integral number of OFDM symbols (i.e. the base-rate symbols)
#define NUM_HEADER_BYTES 24

#define NUM_PAYLOAD_CRC_BYTES	4
//#define NUM_PAYLOAD_TAIL_BYTES	1 //Use for coded PHY
#define NUM_PAYLOAD_TAIL_BYTES	0	//Use for uncoded PHY

//Assign IDs for various timers
#define TIMEOUT_TIMER	0
#define BACKOFF_TIMER	1
#define USER_TIMER_A	2
#define USER_TIMER_B	3
#define USER_TIMER_C	4
#define USER_TIMER_D	5
#define USERIO_TIMER	6
#define PKTGEN_TIMER	7

//Enable polling of timers that are actually used (6-7 are always enabled)
#define POLL_TIMER0
#define POLL_TIMER1
#define POLL_TIMER2
#define POLL_TIMER3
#define POLL_TIMER4
#define POLL_TIMER5

//Number of clock cycles in 1us (X for XMHz PLB hosting the timer core)
#define TIMERCLK_CYCLES_PER_USEC 80
#define TIMERCLK_CYCLES_PER_MSEC 80000

//Poll the user I/O every 1 msec
#define USERIO_POLLRATE 1000*TIMERCLK_CYCLES_PER_USEC

///Structure contains the header contents of a packet
typedef struct {
	///Physical layer header struct
	phyHeader header;
} Macframe __attribute__((__aligned__(8)));

///Structure of miscellaneous control bits needed for correct operation of the MAC.
typedef struct {
	///Timeout time of system
	volatile unsigned int timeout;
	///Smallest time interval in system
	volatile unsigned int slotTime;
	///Maximum number of retransmissions before dropping a packet
	volatile unsigned char maxReSend;
	///Maximum contention window index: [0, 2^(maxCW+4)-1]
	volatile unsigned char maxCW;
	///Current contention window index
	volatile unsigned char currentCW;
	///Whether the Emac is currently enabled
	volatile unsigned char enableDataFromNetwork;
	volatile unsigned char pktBuf_phyTx;
	volatile unsigned char pktBuf_phyRx;
	volatile unsigned char pktBuf_emacRx;
	volatile unsigned char dummyPacketMode;

	///Constellation order of the full rate symbols
	volatile unsigned char mod_fullRateA;
	//volatile unsigned char mod_fullRateB;
} Maccontrol;

//Function prototypes
void nullCallback(void* param);
int nullCallback_i(void* param);
void warpmac_init();
inline void warpmac_pollPeripherals();
inline void warpmac_pollPhy();
inline void warpmac_pollTimer();
inline void warpmac_pollDataSource();
inline void phyRx_goodHeader_handler();
inline void phyRx_badHeader_handler();
void emacRx_handler();
inline void warpmac_waitForDMA();
inline void warpmac_clearTimer(unsigned char theTimer);
inline void warpmac_startTimer(unsigned char theTimer, unsigned char mode);
void warpmac_setTimer(int type);
inline unsigned int randNum(unsigned int N);
inline int warpmac_carrierSense();
inline void warpmac_prepPktToNetwork(void* thePkt, unsigned int length);
inline void warpmac_startPktToNetwork(unsigned int length);
void warpmac_setCallback(int eventID, void(*handler)());
void warpmac_setBaseRate(unsigned char rate);
int warpmac_setAntennaMode(unsigned int txMode, unsigned int rxMode);
void warpmac_prepPhyForXmit(Macframe* packet, unsigned char buffer);
inline void warpmac_startPhyXmit(unsigned char buffer);
void warpmac_finishPhyXmit();
inline void warpmac_setRxBuffers(Macframe* rxFrame, unsigned char phyRxBuff);
inline void warpmac_setPHYTxBuffer(unsigned char txBuff);
inline void warpmac_setEMACRxBuffer(unsigned char emacRxBuff);
int warpmac_decrementRemainingReSend(Macframe* packet);
void warpmac_resetCurrentCW();
inline void warpmac_setMaxResend(unsigned int c);
inline void warpmac_setMaxCW(unsigned int c);
inline void warpmac_setTimeout(unsigned int time);
inline void warpmac_setSlotTime(unsigned int time);
inline int warpmac_inTimeout();
inline int warpmac_inBackoff();
inline void warpmac_setCSMA(char mode);
inline void warpmac_setDebugGPIO(unsigned char val, unsigned char mask);
inline void warpmac_enableDataFromNetwork();
inline void warpmac_disableDataFromNetwork();
inline char warpmac_finishPhyRecv();
void warpmac_uartRecvHandler(void *CallBackRef);
inline void warpmac_setDummyPacketMode(char mode);
void warpmac_startPacketGeneration(unsigned int length, unsigned int interval);
void warpmac_stopPacketGeneration();
int warpmac_getMyId();

inline void printBytes(unsigned char* data, int length);

//**********START***********//
// FPGA Board Specific Code //
//**************************//
#ifdef WARP_FPGA_BOARD_V1_2
void userIO_handler(void *InstancePtr);
void warpmac_incrementLEDLow();
void warpmac_incrementLEDHigh();
unsigned char sevenSegmentMap(unsigned char x);
void warpmac_leftHex(unsigned char x);
void warpmac_rightHex(unsigned char x);

#elif defined WARP_FPGA_BOARD_V2_2
void userIO_handler(void *InstancePtr);
void warpmac_incrementLEDLow();
void warpmac_incrementLEDHigh();
void warpmac_leftHex(unsigned char x);
void warpmac_rightHex(unsigned char x);
void warpmac_middleHex(unsigned char x);
#endif//ifdef WARP_FPGA_BOARD_V1_2

#endif//ifndef WARPMAC_H



