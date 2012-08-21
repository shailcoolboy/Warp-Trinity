// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

// Basic drivers for radio controller. Has all the basic functions related to sending
// and receiving bits over the air and changing the center frequency of transmission.

#ifndef RADIO_CONTROLLER_BASIC_H
#define RADIO_CONTROLLER_BASIC_H

/***************************** Include Files *******************************/

#include "radio_prototypes.h"

/****************************** Functions **********************************/

void WarpRadio_v1_clkRatio(unsigned int val);

// Reset all the radio boards including the radio and DAC chips along with their associated registers.
// Goes through a set of instructions to achieve a reset of the radios. This must be called at the start of time
// and affects all connected radio boards.
void WarpRadio_v1_Reset(unsigned int* baseaddr);

// Enables the transmit enable mode on the Radios specified.
// Forcibly turns off the recieve enable mode. 'radios' refers to the Radios in the slots whose transmit mode is turned on.
void WarpRadio_v1_TxEnable(unsigned int radios);

// Enables the recieve mode in the radio board. On calling this function the transmit mode is forcibly turned off.
// 'radios' refers to the Radios in the slots that will have their recieve mode turned on.
void WarpRadio_v1_RxEnable(unsigned int radios);

// Disables the receive and/or transmit modes in the radios specified. 'radios' refers to the
// Radios in the slots whose recieve mode will be turned off. Enables the TxEnable state machine
// that also controlls turning on of the amplifiers.
void WarpRadio_v1_TxRxDisable(unsigned int radios);

// Function used to shift the center frequency on the Radio within the 2.4GHz band.
// 'freqset' defines which frequency to shift to.
//		1: 2412MHz
//		2: 2417MHz
//		3: 2422MHz
//		4: 2427MHz
//		5: 2432MHz
//		6: 2437MHz
//		7: 2442MHz
//		8: 2447MHz
//		9: 2452MHz
//		10: 2457MHz
//		11: 2462MHz
//		12: 2467MHz
//		13: 2472MHz
//		14: 2484MHz
// 'radios' defines which radios are affected by this function call.
// Returns INVALID_FREQ if given frequency set is not valid.
int WarpRadio_v1_SetCenterFreq2GHz(char freqset, unsigned int radios);

// Returns the DIPSW values of the radio specified. Can return value for only one of the radios at one time.
char WarpRadio_v1_DIPSW(unsigned int radio);

// Adjust the DC Offset on the I and Q channels of the DAC. 'chan' = ICHAN changes the I channel DC offset while
// 'chan' = QCHAN affects the DC offset of the Q channel. The value can be a maximum of 1023 and minimum of -1024
// and goes to the registers as required by the channel setting. 'radios' refer to the Radios that are being
// affected by this function.
// Returns INVALID_MODE if the mode is incorrect. Returns OUT_OF_RANGE is the value given
// is out of the range that can be supported. Returns WARP_SUCCESS if successful change.
int WarpRadio_v1_DACOffsetAdj(char chan, short value, unsigned int radios);


#endif
