// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/**
 * \file radio_controller_ext.h
 * \brief Header file for extended functionality of the radio boards, over the basic controller.
 *
 * @version 1.09
 * @author Siddharth Gupta
 *
 * Drivers for more complex functions of the radio boards. This includes finer control of receive
 * and transmit gains, both in hardware and software, transmit state machine and control
 * of filter parameters.
 */

#ifndef RADIO_CONTROLLER_EXT_H
#define RADIO_CONTROLLER_EXT_H

/***************************** Include Files *******************************/

#include "radio_prototypes.h"

/****************************** Functions **********************************/

void WarpRadio_v1_24AmpEnable(unsigned int radios);

void WarpRadio_v1_24AmpDisable(unsigned int radios);

// Select a configuration for the Antennas and Transmit and Receive paths.
// Applies to 'radios' specified.
// 		mode = 1:	Antenna 1 for TX and RX
//		mode = 2:	Antenna 2 for TX and RX
//		mode = 3:	Antenna 1 for TX and Antenna 2 for RX
//		mode = 4:	Antenna 1 for RX and Antenna 2 for TX
//char WarpRadio_v1_AntennaConfig(char mode, unsigned int radios);

char WarpRadio_v1_LockDetect(unsigned int radios);

char WarpRadio_v1_SoftwareTxGainControl(short mode, unsigned int radios);

void WarpRadio_v1_BaseBandTxGain(char value, unsigned int radios);

void WarpRadio_v1_TxVGAGainControl(char value, unsigned int radios);

char WarpRadio_v1_SoftwareRxGainControl(short mode, unsigned int radios);

void WarpRadio_v1_RxLNAGainControl(char value, unsigned int radios);

void WarpRadio_v1_RxVGAGainControl(char value, unsigned int radios);

void WarpRadio_v1_SetTxTiming(unsigned int radios, unsigned char dly_TxEn, unsigned short dly_TxStart, unsigned char dly_GainRampEn, unsigned char dly_PowerAmpEn);

void WarpRadio_v1_SetTxGainTiming(unsigned int radios, unsigned char TxGainTarget, unsigned char TxGainStep, unsigned char TxGainTimeStep);

void WarpRadio_v1_TxLpfCornFreqCoarseAdj(char value, unsigned int radios);

void WarpRadio_v1_RxLpfCornFreqCoarseAdj(char value, unsigned int radios);

char WarpRadio_v1_RxLpfCornFreqFineAdj(char value, unsigned int radios);

void WarpRadio_v1_RxHighPassCornerFreq(char value, unsigned int radios);

unsigned int WarpRadio_v1_RSSIData(unsigned int radios);

#endif
