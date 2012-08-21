// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

// Drivers for radio controller. Has functions related to using radios in
// the 5GHz spectrum range

#ifndef RADIO_CONTROLLER_5GHZ_H
#define RADIO_CONTROLLER_5GHZ_H

/***************************** Include Files *******************************/

#include "radio_prototypes.h"

/****************************** Functions **********************************/

// Turns on a radio's 5GHz power amplifier
void WarpRadio_v1_5AmpEnable(unsigned int radios);

// Turns off a radio's 5GHz power amplifier
void WarpRadio_v1_5AmpDisable(unsigned int radios);

// Function used to shift the center frequency on the Radio within the 5GHz band.
// 'freqset' defines which frequency to shift to.
//		1: 5180MHz
//		2: 5200MHz
//		3: 5220MHz
//		4: 5240MHz
//		5: 5260MHz
//		6: 5280MHz
//		7: 5300MHz
//		8: 5320MHz
//		9: 5500MHz
//		10: 5520MHz
//		11: 5540MHz
//		12: 5560MHz
//		13: 5580MHz
//		14: 5600MHz
//		15: 5620MHz
//		16: 5640MHz
//		17: 5660MHz
//		18: 5680MHz
//		19: 5700MHz
//		20: 5745MHz
//		21: 5765MHz
//		22: 5785MHz
//		23: 5805MHz
// 'radios' defines which radios are affected by this function call.
// If the given frequency set is not valid INVALID_FREQ is returned
int WarpRadio_v1_SetCenterFreq5GHz(char freqset, unsigned int radios);


#endif
