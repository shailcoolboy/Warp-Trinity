// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

// Drivers for radio controller. Has increased functionality over basic
// controlling the receive and transmit gains, amplifier functionality and
// behavior of transmit enable state machine

#ifndef RADIO_CONTROLLER_EXT_H
#define RADIO_CONTROLLER_EXT_H

/***************************** Include Files *******************************/

#include "radio_prototypes.h"

/****************************** Functions **********************************/

// Enable a radio's 2.4GHz power amplifier
void WarpRadio_v1_24AmpEnable(unsigned int radios);

// Disable a radio's 2.4GHz power amplifier
void WarpRadio_v1_24AmpDisable(unsigned int radios);

// Select a configuration for the Antennas and Transmit and Receive paths.
// Applies to 'radios' specified.
// 		mode = 1:	Antenna 1 for TX and RX
//		mode = 2:	Antenna 2 for TX and RX
//		mode = 3:	Antenna 1 for TX and Antenna 2 for RX
//		mode = 4:	Antenna 1 for RX and Antenna 2 for TX
//char WarpRadio_v1_AntennaConfig(char mode, unsigned int radios);

// Reads the LockDetect pin of the 'radios' specified. Outputs lock detects as {LD4, LD3, LD2, LD1}
// from the radios. An output of 1 indicates that the radio is locked while 0 indicates that it is not.
char WarpRadio_v1_LockDetect(unsigned int radios);

// Enable or disable Transmit VGA Gain Programming using software. Affects 'radios'
// 'mode' 0: Transmit VGA Gain programmed with external hardware ports
//		  1: Transmit VGA Gain programmed with TxVGAGainControl function
// Returns INVALID_MODE if the mode is an invalid input.
char WarpRadio_v1_SoftwareTxGainControl(short mode, unsigned int radios);

// Set the Transmit Baseband Gain. Affects only the 'radios' specified.
// 'value':
//		00: max baseband gain - 5db
//		01: max baseband gain - 3db
//		10: max baseband gain - 1.5db
//		11: max baseband gain
void WarpRadio_v1_BaseBandTxGain(char value, unsigned int radios);

// This function adjusts the total transmit gain. The 6 bits of this function map to
// B6:B1. 000000 is the lowest possible gain.
void WarpRadio_v1_TxVGAGainControl(char value, unsigned int radios);

// Enable or disable Recieve VGA/LNA Gain Programming using software. Affects 'radios'
// 'mode' 0: Recieve VGA/LNA Gain programmed with external hardware ports
//		  1: Receive VGA Gain programmed with RxVGAGainControl and RxLNAGainControl functions
// Returns INVALID_MODE if the mode is an invalid input.
char WarpRadio_v1_SoftwareRxGainControl(short mode, unsigned int radios);

// This function combined with RxVGAGainControl adjusts the total recieve gain. The 2 bits of this function map to
// B7:B6. 00 is the lowest possible gain.
void WarpRadio_v1_RxLNAGainControl(char value, unsigned int radios);

// This function combined with RxLNAGainControl adjusts the total recieve gain. The 5 bits of this function map to
// B5:B1. 00000 is the lowest possible gain.
void WarpRadio_v1_RxVGAGainControl(char value, unsigned int radios);

// Sets the timing parameters for each transmission in TxEnable state machine
// dly_TxEn = clock cycles to wait before turning on transmit enable
// dly_TxStart = clock cycles to wait before sending enabling data transmission model
// dly_GainRampEn = clock cycles to wait before turning on gain ramp cycle
// dly_PowerAmpEn = clock cycles to wait before turning on amplifier
void WarpRadio_v1_SetTxTiming(unsigned int radios, unsigned char dly_TxEn, unsigned char dly_TxStart, unsigned char dly_GainRampEn, unsigned char dly_PowerAmpEn);

// Sets the parameters for automatic Tx gain ramping in TxEnable state machine
// TxGainTarget = target transmit gain, x0 to x3F
// TxGainStep = step with which to ramp to required gain
// TxGainTimeStep = time paused on each gain step
void WarpRadio_v1_SetTxGainTiming(unsigned int radios, unsigned char TxGainTarget, unsigned char TxGainStep, unsigned char TxGainTimeStep);

// Set the Transmit Low Pass Filter Corner Frequency. This is the Coarse adjustment for the frequency and affects
// the 'radios' specified.
// 'value':
//		00: undefined
//		01: 12MHz (nominal mode)
//		10: 18MHz (turbo mode 1)
//		11: 24MHz (turbo mode 2)
void WarpRadio_v1_TxLpfCornFreqCoarseAdj(char value, unsigned int radios);

// Set the Recieve Lowpass Filter Corner Frequency. This is the Coarse adjustment and affects only the 'radios' specified
// 'value':
//		00: 7.5MHz
//		01: 9.5MHz (nominal mode)
//		10: 14MHz (turbo mode 1)
//		11: 18MHz (turbo mode 2)
void WarpRadio_v1_RxLpfCornFreqCoarseAdj(char value, unsigned int radios);

// Set the Recieve Lowpass Filter Corner Frequency. This is the Fine adjustment and affects only the 'radios' specified
// 'value':
//		000: 90%
//		001: 95%
//		010: 100%
//		011: 105%
//		100: 110%
//		101-111: not applicable
// Returns OUT_OF_RANGE if value is out of range
char WarpRadio_v1_RxLpfCornFreqFineAdj(char value, unsigned int radios);

// Set the Recieve Highpass Filter Corner Frequency when RXHP=0. Affected Slots are defined in 'radios'
// 'value':	0:100Hz
//			1:30kHz
void WarpRadio_v1_RxHighPassCornerFreq(char value, unsigned int radios);

// Reads the RSSI values for a single radio
// argument 'radios' must select exactly 1 radio
unsigned int WarpRadio_v1_RSSIData(unsigned int radios);

#endif
