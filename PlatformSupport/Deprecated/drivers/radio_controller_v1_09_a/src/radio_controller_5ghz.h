// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/**
 * \file radio_controller_5ghz.h
 * \brief Header file for the functions controlling 5GHz functionality.
 *
 * @version 1.09
 * @author Siddharth Gupta
 *
 * 5GHz drivers for the radio controller. Has calls to changing the center frequency to that part
 * of the spectrum and setting up amplifiers.
 */

#ifndef RADIO_CONTROLLER_5GHZ_H
#define RADIO_CONTROLLER_5GHZ_H

/***************************** Include Files *******************************/

#include "radio_prototypes.h"

/****************************** Functions **********************************/

void WarpRadio_v1_5AmpEnable(unsigned int radios);

void WarpRadio_v1_5AmpDisable(unsigned int radios);

int WarpRadio_v1_SetCenterFreq5GHz(char freqset, unsigned int radios);


#endif
