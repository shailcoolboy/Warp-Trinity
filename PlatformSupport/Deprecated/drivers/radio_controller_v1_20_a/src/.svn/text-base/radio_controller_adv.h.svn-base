// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/**
 * \file radio_controller_adv.h
 * \brief Header file for advanced functions of the radio controller.
 *
 * @version 1.09
 * @author Siddharth Gupta
 *
 * This file contains controls the advanced functionality of the radio boards, such as
 * DAC phase offsets, and all the various shutdown and standby states.
 */
 
#ifndef RADIO_CONTROLLER_ADV_H
#define RADIO_CONTROLLER_ADV_H

/***************************** Include Files *******************************/

#include "radio_prototypes.h"

/****************************** Functions **********************************/

void WarpRadio_v1_SHDNEnable(unsigned int radios);

void WarpRadio_v1_SHDNDisable(unsigned int radios);

void WarpRadio_v1_SHDNSoftControlEnable(unsigned int radios);

void WarpRadio_v1_SHDNSoftControlDisable(unsigned int radios);

void WarpRadio_v1_RxEnSoftControlEnable(unsigned int radios);

void WarpRadio_v1_RxEnSoftControlDisable(unsigned int radios);

void WarpRadio_v1_TxEnSoftControlEnable(unsigned int radios);

void WarpRadio_v1_TxEnSoftControlDisable(unsigned int radios);

void WarpRadio_v1_RxHpSoftControlEnable(unsigned int radios);

void WarpRadio_v1_RxHpSoftControlDisable(unsigned int radios);

void WarpRadio_v1_RxHpEnable(unsigned int radios);

void WarpRadio_v1_RxHpDisable(unsigned int radios);

char WarpRadio_v1_RssiHighBandwidth(char mode, unsigned int radios);

// Returns the temp of the 'radio' specified.
//char WarpRadio_v1_RSSITemp(unsigned char radio);

int WarpRadio_v1_DACSleep(char mode, unsigned int radios);

int WarpRadio_v1_DACFineGainAdj(char chan, unsigned char value, unsigned int radios);

int WarpRadio_v1_DACCoarseGainAdj(char chan, unsigned char value, unsigned int radios);

void WarpRadio_v1_ADCPdwn(char chan, unsigned char value, unsigned int radios);

#endif
