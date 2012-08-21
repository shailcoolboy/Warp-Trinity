// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

// Drivers for radio controller. Has functions relating to the calibration of
// the radios.

#ifndef RADIO_CONTROLLER_CAL_H
#define RADIO_CONTROLLER_CAL_H

/***************************** Include Files *******************************/

#include "radio_prototypes.h"

/****************************** Functions **********************************/

// Put the radio into transmit calibration mode. 'radios' refers to the radios that will be put into
// calibration. Forcibly removed from receive calibration mode.
void WarpRadio_v1_TxCalibration(unsigned int radios);

// Put the radio into receive calibration mode. 'radios' refers to the radios that will be put into
// calibration. Forcibly removed from receive calibration mode.
void WarpRadio_v1_RxCalibration(unsigned int radios);

// Takes the specified radios out of transmit and recieve calibration mode. 'radios' refers the Radios in the
// slots that will be affected. This function works exactly the same way as the function above.
void WarpRadio_v1_NoCalibration(unsigned int radios);

// Sets the gain for Transmitter I/Q Calibration LO Leakage and Sideband-Detector Gain Control.
// Returns NOT_IN_CALIBRATION if any of the radios for which the gain is being set in not
// in calibration mode. Returns INVALID_GAIN if the gain set value given is not valid. Returns
// WARP_SUCCESS if value changed successfully. To be in calibration mode set
// TxCalibration.
// gain = 0 -> 8db
// gain = 1 -> 18db
// gain = 2 -> 24db
// gain = 3 -> 34db
char WarpRadio_v1_TxCalGain(char gain, unsigned int radios);

// Enable or disable the Rx baseband section of the reciever. Mode = 0 disables the value while mode = 1
// enables the value. Returns INVALID_MODE if the mode is invalid. Returns WARP_SUCCESS if successfully manage
// to change the value.
char WarpRadio_v1_TxCalRxEnable(char mode, unsigned int radios);


#endif
