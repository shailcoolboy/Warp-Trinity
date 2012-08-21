// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/**
 * \file radio_controller_basic.h
 * \brief Header file for the most basic functions that are needed for communication with the radio boards.
 *
 * @version 1.09
 * @author Siddharth Gupta
 *
 * Basic drivers for radio controller. Has all the basic functions related to sending
 * and receiving bits over the air and changing the center frequency of transmission.
 */

#ifndef RADIO_CONTROLLER_BASIC_H
#define RADIO_CONTROLLER_BASIC_H

/***************************** Include Files *******************************/

// H file that contains prototypes for all the defines and local copies of radio registers.
#include "radio_prototypes.h"

/****************************** Functions **********************************/

void WarpRadio_v1_Reset(unsigned int* baseaddress, unsigned int clkRatio);

void WarpRadio_v1_TxEnable(unsigned int radios);

void WarpRadio_v1_RxEnable(unsigned int radios);

void WarpRadio_v1_TxRxDisable(unsigned int radios);

int WarpRadio_v1_SetCenterFreq2GHz(char freqset, unsigned int radios);

char WarpRadio_v1_DIPSW(unsigned int radio);

int WarpRadio_v1_DACOffsetAdj(char chan, short value, unsigned int radios);


#endif
