// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/**
 * \file radio_controller_adv.c
 * \brief C code for advanced functions allowing for finer control.
 *
 * @version 1.09
 * @author Siddharth Gupta
 *
 * This file contains controls the advanced functionality of the radio boards, such as
 * DAC phase offsets, and all the various shutdown and standby states.
 */


/***************************** Include Files *******************************/

#include "radio_controller_adv.h"

/****************************** Functions **********************************/

/**
 * @brief Shuts down the radio.
 * 
 * This function shuts down the radios specified. Forcibly turns off transmit and recieve modes as well as shuts down
 * amplifiers.
 * @param radios Refers to the radios in the slots that will be shut down.
 */
void WarpRadio_v1_SHDNEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) & ~(radios & (RAD_RXEN_MASK | RAD_TXEN_MASK)))); // Disable Rx and Tx
	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) | (radios & RAD_SHDN_MASK))); // Turn on Shdn
}

/**
 * @brief Starts up the radio.
 * 
 * This function starts up the radios specified to the standby state.
 * Receive and transmit are still off.
 *
 * @param radios Refers to the radios in the slots that will be started up.
 */
void WarpRadio_v1_SHDNDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) & ~(radios & RAD_SHDN_MASK))); // Disable SHDN
}

/**
 * @brief SHDN control is thorugh software function calls.
 *
 * Enable SHDN software control. In this situation the SHDNEnable and Disable functions control the SHDN pin.
 *
 * @param radios Radios affected.
 */
void WarpRadio_v1_SHDNSoftControlEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) & ~(radios & RAD_SHDN_CON_MASK))); // Enable software control
}

/**
 * @brief SHDN control is thorugh hardware ports.
 *
 * Disable SHDN software control. In this situation the SHDN external port on the radio bridge must be used.
 *
 * @param radios Radios affected.
 */
void WarpRadio_v1_SHDNSoftControlDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) | (radios & RAD_SHDN_CON_MASK))); // Disable software control
}

/**
 * @brief Receive Enable control is thorugh software function calls.
 *
 * Enable Receive Enable software control. In this situation the RxEnable and Disable functions control the RxEn pin.
 *
 * @param radios Radios affected.
 */
void WarpRadio_v1_RxEnSoftControlEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) & ~(radios & RAD_RXEN_CON_MASK))); // Enable software control
}

/**
 * @brief Receive Enable control is thorugh hardware ports.
 *
 * Disable Receive Enable software control. In this situation the RxEn external port on the radio bridge must be used.
 *
 * @param radios Radios affected.
 */
void WarpRadio_v1_RxEnSoftControlDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) | (radios & RAD_RXEN_CON_MASK))); // Disable software control
}

/**
 * @brief Transmit Enable control is thorugh software function calls.
 *
 * Enable Transmit Enable software control. In this situation the TxEnable and Disable functions control the TxEn pin.
 *
 * @param radios Radios affected.
 */
void WarpRadio_v1_TxEnSoftControlEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) & ~(radios & RAD_TXEN_CON_MASK))); // Enable software control
}

/**
 * @brief Transmit Enable control is thorugh hardware ports.
 *
 * Disable Transmit Enable software control. In this situation the TxEn external port on the radio bridge must be used.
 *
 * @param radios Radios affected.
 */
void WarpRadio_v1_TxEnSoftControlDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) | (radios & RAD_TXEN_CON_MASK))); // Disable software control
}

/**
 * @brief RxHp control is thorugh software function calls.
 *
 * Enable RxHp software control. In this situation the RxHpEnable and Disable functions control the RxHp pin.
 *
 * @param radios Radios affected.
 */
void WarpRadio_v1_RxHpSoftControlEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) & ~(radios & RAD_RXHP_CON_MASK))); // Enable software control
}

/**
 * @brief RxHp control is thorugh hardware ports.
 *
 * Disable RxHp software control. In this situation the RxHp external port on the radio bridge must be used.
 *
 * @param radios Radios affected.
 */
void WarpRadio_v1_RxHpSoftControlDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) | (radios & RAD_RXHP_CON_MASK))); // Disable software control
}

/**
 * @brief Enable RxHp on radios.
 *
 * Enables the RxHp on the radios specified. Must be software control mode to work.
 * 
 * @param radios Refers to the radios affected.
 */
void WarpRadio_v1_RxHpEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) | (radios & RAD_RXHP_MASK))); // Turn on RxHP
}

/**
 * @brief Disable RxHp on radios.
 *
 * Disables the RxHp bit in the radios specified.
 *
 * @param radios Refers to the radios affected.
 */
void WarpRadio_v1_RxHpDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) & ~(radios & RAD_RXHP_MASK))); // Turn off RxHP
}

/**
 * @brief Enable or disable RSSI High Bandwidth.
 * @param mode 0 disables high bandwidth, 1 enables high bandwidth.
 * @param radios The radios that are affected.
 * @return Returns INVALID_MODE if mode is incorrect, WARP_SUCCESS if successful change.
 */
char WarpRadio_v1_RssiHighBandwidth(char mode, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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

/**
 * @brief Sleep or un-sleep DAC.
 *
 * This function either puts the DAC on the specified radios to sleep or takes them out of sleep.
 *
 * @param mode 0 not in sleep, 1 enable sleep.
 * @param radios The radios that are affected.
 * @return Returns INVALID_MODE if mode is incorrect, WARP_SUCCESS if successful change.
 */
int WarpRadio_v1_DACSleep(char mode, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASKDAC & radios));		// Select the dacs that need to be affected

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

/**
 * @brief Adjust output fine gain for DAC.
 * 
 * Adjust the Fine Gain for output current on the I and Q channels of the DAC. The value must be
 * 8 bits wide at most.
 *
 * @param chan ICHAN changes the I channel fine gain, QCHAN affects the fine gain of the Q channel.
 * @param value The value is 8 bits wide and goes to the registers.
 * @param radios The dacs of the radios affected.
 * @return Returns INVALID_MODE if the mode is incorrect, WARP_SUCCESS if successful change.
 */
int WarpRadio_v1_DACFineGainAdj(char chan, unsigned char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASKDAC & radios));			// Select the dacs that need to be affected

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

/**
 * @brief Adjust output coarse gain for DAC.
 * 
 * Adjust the Coarse Gain for output current on the I and Q channels of the DAC. The value must be
 * 8 bits wide at most.
 *
 * @param chan ICHAN changes the I channel fine gain, QCHAN affects the fine gain of the Q channel.
 * @param value The value is 4 bits wide and goes to the registers.
 * @param radios The dacs of the radios affected.
 * @return Returns INVALID_MODE if the mode is incorrect, WARP_SUCCESS if successful change.
 */
int WarpRadio_v1_DACCoarseGainAdj(char chan, unsigned char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASKDAC & radios));		// Select the dacs that need to be affected

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

/**
 * @brief Power up/down the ADC on radio
 *
 * Controls power down and power up functionality of the two channels of the ADC. Both channels
 * can be done by ORing the chan values together.
 *
 * @param chan ICHAN is for I channel QCHAN is for Q channel.
 * @param value 0 is to power up 1 is to power down.
 * @param radios ADCs on radios affected.
 */
void WarpRadio_v1_ADCPdwn(char chan, unsigned char value, unsigned int radios) {

	if (chan == ICHAN) {
		if (value == 0) {
			RADIO_CONTROLLER_mWriteSlaveReg2((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)radio_controller_baseaddr) & ~(radios & RAD_ADC_RX_PWDNA_MASK)));
		}
		else if (value == 1) {
			RADIO_CONTROLLER_mWriteSlaveReg2((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)radio_controller_baseaddr) | (radios & RAD_ADC_RX_PWDNA_MASK)));
		}
	}
	else if (chan == QCHAN) {
		if (value == 0) {
			RADIO_CONTROLLER_mWriteSlaveReg2((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)radio_controller_baseaddr) & ~(radios & RAD_ADC_RX_PWDNB_MASK)));
		}
		else if (value == 1) {
			RADIO_CONTROLLER_mWriteSlaveReg2((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)radio_controller_baseaddr) | (radios & RAD_ADC_RX_PWDNB_MASK)));
		}
	}
}
