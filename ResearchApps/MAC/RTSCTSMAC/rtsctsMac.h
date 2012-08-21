/*! \file rtsctsMac.h
\brief Header file for the RTS/CTS MAC.

@author Keith Wilhelm

This header file contains the macros, function prototypes, and typedefs required for RTS/CTS MAC.
*/



#ifndef RTSCTSMAC_H
#define RTSCTSMAC_H


///timeout timer
#define TIMEOUT 0
///backoff timer
#define BACKOFF 1
///NAV timer
#define NAV 2

//Creating states for modulation rates (note different than MASKs!)
#define LOWEST_RATE  1
#define BPSK_MOD	   1
#define QPSK_MOD	   2
#define QAM16_MOD	   3
#define QAM64_MOD	   4
#define HIGHEST_RATE 4

//mrateMode states
#define BPSK_MODE	  		0
#define QPSK_MODE	  		1
#define QAM16_MODE  		2
#define BPSKRTS_MODE	  	3
#define QPSKRTS_MODE	  	4
#define QAM16RTS_MODE  	5

//rtsScheme states
#define DISABLED  		0
#define ENABLED	  		1

///Union for breaking unsigned shorts into 2 unsigned chars and vice versa
typedef union {
	unsigned short uint16;
	unsigned char uint8[2];
} UTime;

void increaseRate();
void decreaseRate();
unsigned char convertMasktoState(unsigned char rate_mask);
unsigned char convertStatetoMask(unsigned char rate_state);
void incrementMrateMode();

void initTX();
void sendCTS(Macframe* packet);
void sendDAT();
void sendBCD();
void dropPacket();
void updateTimer(unsigned char type, unsigned int newTime);

int rtsmac_phyRx_goodHeader_callback(Macframe* packet);
int rtsmac_phyRx_badHeader_callback();
int rtsmac_emacRx_callback(Xuint32 length, char* payload);
int rtsmac_timer_callback(unsigned char timerType);

void initDelays();
void initAddresses();
void initHeaders();
void rtsmac_left();
void rtsmac_right();
void rtsmac_middle();
void rtsmac_up();
void printState();
void clearPktCtr();
void printStatistics();

#endif
