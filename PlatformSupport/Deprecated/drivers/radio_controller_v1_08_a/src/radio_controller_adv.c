// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/***************************** Include Files *******************************/

#include "radio_controller_adv.h"

/****************************** Functions **********************************/

// This function shuts down the radios specified. Forcibly turns off transmit and recieve modes as well as shuts down
// amplifiers. 'radios' refers to the Radios in the slots that will be shut down.
void WarpRadio_v1_SHDNEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & ~(radios & (RAD_RXEN_MASK | RAD_TXEN_MASK)))); // Disable Rx and Tx
	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | (radios & RAD_SHDN_MASK))); // Turn on Shdn
}

// Takes the specified radios out of shutdown mode. The transmit and recieve modes are still disabled. 'radios' refers
// to the the Radios in the slots affected by this function. Behaves the same as the previous function.
void WarpRadio_v1_SHDNDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & ~(radios & RAD_SHDN_MASK))); // Disable SHDN
}

// Enable SHDN software control. In this situation the SHDNEnable and Disable functions control the SHDN pin
void WarpRadio_v1_SHDNSoftControlEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & ~(radios & RAD_SHDN_CON_MASK))); // Enable software control
}

// Disable SHDN software control. In this situation the SHDN pin is controlled by the SHDN external port on the radio_bridge
void WarpRadio_v1_SHDNSoftControlDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | (radios & RAD_SHDN_CON_MASK))); // Disable software control
}

// Enable RxEn software control. In this situation the RxEnable and Disable functions control the RxEn pin
void WarpRadio_v1_RxEnSoftControlEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & ~(radios & RAD_RXEN_CON_MASK))); // Enable software control
}

// Disable RxEn software control. In this situation the RxEn pin is controlled by the RxEn external port on the radio_bridge
void WarpRadio_v1_RxEnSoftControlDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | (radios & RAD_RXEN_CON_MASK))); // Disable software control
}

// Enable TxEn software control. In this situation the TxEnable and Disable functions control the TxEn pin
void WarpRadio_v1_TxEnSoftControlEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & ~(radios & RAD_TXEN_CON_MASK))); // Enable software control
}

// Disable TxEn software control. In this situation the TxEn pin is controlled by the TxEn external port on the radio_bridge
void WarpRadio_v1_TxEnSoftControlDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | (radios & RAD_TXEN_CON_MASK))); // Disable software control
}

// Enable RxHP software control. In this situation the RxHPEnable and Disable functions control the RxHP pin
void WarpRadio_v1_RxHpSoftControlEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & ~(radios & RAD_RXHP_CON_MASK))); // Enable software control
}

// Disable RxHP software control. In this situation the RxHP pin is controlled by the RxHP external port on the radio_bridge
void WarpRadio_v1_RxHpSoftControlDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | (radios & RAD_RXHP_CON_MASK))); // Disable software control
}

// Enable the RXHP bit in the 'radios' specified.
// Behaves similar to previous functions.
void WarpRadio_v1_RxHpEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | (radios & RAD_RXHP_MASK))); // Turn on RxHP
}

// Disable the RXHP bit in the 'radios' specified.
// Behaves similar to previous functions.
void WarpRadio_v1_RxHpDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & ~(radios & RAD_RXHP_MASK))); // Turn off RxHP
}

// Enable or disable RSSI High Bandwidth. Mode:0 disables high bandwidth, Mode:1 enables
// high bandwidth. Requires radios for which it applies. Return INVALID_MODE if
// mode is incorrect. Returns WARP_SUCCESS if successful change.
char WarpRadio_v1_RssiHighBandwidth(char mode, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned int modeon = 0x0800;
	unsigned int modeoff = 0xF7FF;

	if (mode == 0) {
		if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
			unsigned int reg7 = REG_RAD1_LOWPASS_FILTER & modeoff;

			transRadio(0x0001, ((reg7<<4)+0x0007));

			REG_RAD1_LOWPASS_FILTER = (short)reg7;
		}
		if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
			unsigned int reg7 = REG_RAD2_LOWPASS_FILTER & modeoff;

			transRadio(0x0002, ((reg7<<4)+0x0007));

			REG_RAD2_LOWPASS_FILTER = (short)reg7;
		}
		if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
			unsigned int reg7 = REG_RAD3_LOWPASS_FILTER & modeoff;

			transRadio(0x0004, ((reg7<<4)+0x0007));

			REG_RAD3_LOWPASS_FILTER = (short)reg7;
		}
		if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
			unsigned int reg7 = REG_RAD4_LOWPASS_FILTER & modeoff;

			transRadio(0x0008, ((reg7<<4)+0x0007));

			REG_RAD4_LOWPASS_FILTER = (short)reg7;
		}
	}
	else if (mode == 1) {
		if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
			unsigned int reg7 = REG_RAD1_LOWPASS_FILTER | modeon;

			transRadio(0x0001, ((reg7<<4)+0x0007));

			REG_RAD1_LOWPASS_FILTER = (short)reg7;
		}
		if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
			unsigned int reg7 = REG_RAD2_LOWPASS_FILTER | modeon;

			transRadio(0x0002, ((reg7<<4)+0x0007));

			REG_RAD2_LOWPASS_FILTER = (short)reg7;
		}
		if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
			unsigned int reg7 = REG_RAD3_LOWPASS_FILTER | modeon;

			transRadio(0x0004, ((reg7<<4)+0x0007));

			REG_RAD3_LOWPASS_FILTER = (short)reg7;
		}
		if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
			unsigned int reg7 = REG_RAD4_LOWPASS_FILTER | modeon;

			transRadio(0x0008, ((reg7<<4)+0x0007));

			REG_RAD4_LOWPASS_FILTER = (short)reg7;
		}
	}
	else {
		return INVALID_MODE;
	}
	return WARP_SUCCESS;
}

/*
// Returns the temp of the 'radio' specified.
char WarpRadio_v1_RSSITemp(unsigned char radio) {

	return 0;
}
*/

// This function puts the DAC to sleep or takes it out of sleep mode. 'mode'=0 keeps it out of sleep mode while 'mode=1
// puts it in sleep mode. The DACs that are affected are specified in 'dacs'.
int WarpRadio_v1_DACSleep(char mode, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASKDAC & radios));		// Select the dacs that need to be affected

	if (mode == 1) {									// Check if DACs need to put to sleep.
		transmitdac(0x0014);					// Transmit the sleep bit = 1 for the required DACs
	}
	else if (mode == 0) {
		transmitdac(0x0004);					// Remove the DACs specified from sleep mode.
	}
	else {
		return INVALID_MODE;
	}

	return WARP_SUCCESS;
}

// Adjust the Fine Gain on the I and Q channels of the DAC. 'chan' = ICHAN changes the I channel fine gain while
// 'chan' = QCHAN affects the fine gain of the Q channel. The value is 8 bits wide and goes to the registers as
// required by the channel setting. 'dacs' refer to the DACs that are being affected by this function.
// Returns INVALID_MODE if the mode is incorrect. Returns WARP_SUCCESS if successful change.
int WarpRadio_v1_DACFineGainAdj(char chan, unsigned char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASKDAC & radios));			// Select the dacs that need to be affected

	value = value & 0x00FF;								// Use only the last 8 bits of the value

	if (chan == ICHAN) {								// If called on I channel send the values to register 5
		transmitdac(0x0500 + value);
	}
	else if (chan == QCHAN) {							// If called on Q channel send the values to register 9
		transmitdac(0x0900 + value);
	}
	else {
		return INVALID_MODE;
	}
	return WARP_SUCCESS;
}

// Adjust the Coarse Gain on the I and Q channels of the DAC. 'chan' = ICHAN changes the I channel coarse gain while
// 'chan' = QCHAN affects the coarse gain of the Q channel. The value is 4 bits wide and goes to the registers as
// required by the channel setting. 'dacs' refer to the DACs that are being affected by this function.
// Returns INVALID_MODE if the mode is incorrect. Returns WARP_SUCCESS if successful change.
int WarpRadio_v1_DACCoarseGainAdj(char chan, unsigned char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASKDAC & radios));		// Select the dacs that need to be affected

	value = value & 0x000F;							// Use only last 4 bits

	if (chan == ICHAN) {
		transmitdac(0x0600 + value);
	}
	else if (chan == QCHAN) {
		transmitdac(0x0A00 + value);
	}
	else {
		return INVALID_MODE;
	}
	return WARP_SUCCESS;
}

// Controls power down and power up functionality of the two channels of the ADC.
//    chan = ICHAN is for I channel and chan = QCHAN is for Q channel.
//    value = 0 is to power up and value = 1 is to power down.
void WarpRadio_v1_ADCPdwn(char chan, unsigned char value, unsigned int radios) {

	if (chan == ICHAN) {
		if (value == 0) {
			RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & ~(radios & RAD_ADC_RX_PWDNA_MASK)));
		}
		else if (value == 1) {
			RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | (radios & RAD_ADC_RX_PWDNA_MASK)));
		}
	}
	else if (chan == QCHAN) {
		if (value == 0) {
			RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & ~(radios & RAD_ADC_RX_PWDNB_MASK)));
		}
		else if (value == 1) {
			RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | (radios & RAD_ADC_RX_PWDNB_MASK)));
		}
	}
}


