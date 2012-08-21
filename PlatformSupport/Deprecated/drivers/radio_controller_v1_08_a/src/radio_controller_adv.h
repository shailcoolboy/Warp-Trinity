// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

// Drivers for radio controller. Has all the basic functions related to sending and receiving bits over
// the air and changing the center frequency of transmission.

#ifndef RADIO_CONTROLLER_ADV_H
#define RADIO_CONTROLLER_ADV_H

/***************************** Include Files *******************************/

#include "radio_prototypes.h"

/****************************** Functions **********************************/

// This function shuts down the radios specified. Forcibly turns off transmit and recieve modes as well as shuts down
// amplifiers. 'radios' refers to the Radios in the slots that will be shut down.
void WarpRadio_v1_SHDNEnable(unsigned int radios);

// Takes the specified radios out of shutdown mode. The transmit and recieve modes are still disabled. 'radios' refers
// to the the Radios in the slots affected by this function. Behaves the same as the previous function.
void WarpRadio_v1_SHDNDisable(unsigned int radios);

// Enable SHDN software control. In this situation the SHDNEnable and Disable functions control the SHDN pin
void WarpRadio_v1_SHDNSoftControlEnable(unsigned int radios);

// Disable SHDN software control. In this situation the SHDN pin is controlled by the SHDN external port on the radio_bridge
void WarpRadio_v1_SHDNSoftControlDisable(unsigned int radios);

// Enable RxEn software control. In this situation the RxEnable and Disable functions control the RxEn pin
void WarpRadio_v1_RxEnSoftControlEnable(unsigned int radios);

// Disable RxEn software control. In this situation the RxEn pin is controlled by the RxEn external port on the radio_bridge
void WarpRadio_v1_RxEnSoftControlDisable(unsigned int radios);

// Enable TxEn software control. In this situation the TxEnable and Disable functions control the TxEn pin
void WarpRadio_v1_TxEnSoftControlEnable(unsigned int radios);

// Disable TxEn software control. In this situation the TxEn pin is controlled by the TxEn external port on the radio_bridge
void WarpRadio_v1_TxEnSoftControlDisable(unsigned int radios);

// Enable RxHP software control. In this situation the RxHPEnable and Disable functions control the RxHP pin
void WarpRadio_v1_RxHpSoftControlEnable(unsigned int radios);

// Disable RxHP software control. In this situation the RxHP pin is controlled by the RxHP external port on the radio_bridge
void WarpRadio_v1_RxHpSoftControlDisable(unsigned int radios);

// Enable the RXHP bit in the 'radios' specified.
// Behaves similar to previous functions.
void WarpRadio_v1_RxHpEnable(unsigned int radios);

// Disable the RXHP bit in the 'radios' specified.
// Behaves similar to previous functions.
void WarpRadio_v1_RxHpDisable(unsigned int radios);

// Enable or disable RSSI High Bandwidth. Mode:0 disables high bandwidth, Mode:1 enables
// high bandwidth. Requires baseaddress and radios for which it applies. Return INVALID_MODE if
// mode is incorrect. Returns WARP_SUCCESS if successful change.
char WarpRadio_v1_RssiHighBandwidth(char mode, unsigned int radios);

// Returns the temp of the 'radio' specified.
//char WarpRadio_v1_RSSITemp(unsigned char radio);

// This function puts the DAC to sleep or takes it out of sleep mode. 'mode'=0 keeps it out of sleep mode while 'mode=1
// puts it in sleep mode. The DACs that are affected are specified in 'dacs'.
int WarpRadio_v1_DACSleep(char mode, unsigned int radios);

// Adjust the Fine Gain on the I and Q channels of the DAC. 'chan' = ICHAN changes the I channel fine gain while
// 'chan' = QCHAN affects the fine gain of the Q channel. The value is 8 bits wide and goes to the registers as
// required by the channel setting. 'dacs' refer to the DACs that are being affected by this function.
// Returns INVALID_MODE if the mode is incorrect. Returns WARP_SUCCESS if successful change.
int WarpRadio_v1_DACFineGainAdj(char chan, unsigned char value, unsigned int radios);

// Adjust the Coarse Gain on the I and Q channels of the DAC. 'chan' = ICHAN changes the I channel coarse gain while
// 'chan' = QCHAN affects the coarse gain of the Q channel. The value is 4 bits wide and goes to the registers as
// required by the channel setting. 'dacs' refer to the DACs that are being affected by this function.
// Returns INVALID_MODE if the mode is incorrect. Returns WARP_SUCCESS if successful change.
int WarpRadio_v1_DACCoarseGainAdj(char chan, unsigned char value, unsigned int radios);

// Controls power down and power up functionality of the two channels of the ADC.
//    chan = ICHAN is for I channel and chan = QCHAN is for Q channel.
//    value = 0 is to power up and value = 1 is to power down.
void WarpRadio_v1_ADCPdwn(char chan, unsigned char value, unsigned int radios);

#endif
