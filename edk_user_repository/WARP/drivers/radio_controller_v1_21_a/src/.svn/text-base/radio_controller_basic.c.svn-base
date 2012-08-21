// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/**
 * \file radio_controller_basic.c
 * \brief Code file for the most basic functions that are needed for communication with the radio boards.
 *
 * @version 1.09
 * @author Siddharth Gupta
 *
 * Basic drivers for radio controller. Has all the basic functions related to sending
 * and receiving bits over the air and changing the center frequency of transmission.
 */

/***************************** Include Files *******************************/

#include "radio_controller_basic.h"

/****************************** Functions **********************************/

/**
 * @brief Start of time reset function.
 *
 * Reset all the radio boards including the radio and DAC chips along with their associated registers.
 * Goes through a set of instructions to achieve a reset of the radios. This must be called at the start of time
 * and affects all connected radio boards.
 *
 * @param baseaddress Base address of the radio_controller core; usually defined as XPAR_RADIO_CONTROLLER_0_BASEADDR by XPS
 * @param clkRatio Ratio of bus clock to SPI clock; use 1 for 40MHz bus, 2 for 80MHz bus
 */
void WarpRadio_v1_Reset(unsigned int* baseaddress, unsigned int clkRatio) {

	radio_controller_baseaddr = baseaddress;

	RADIO_CONTROLLER_mWriteSlaveReg5((volatile)radio_controller_baseaddr, 0x3410);			// Set the value of the Control Register to 0x00003410 for DACs
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)radio_controller_baseaddr, clkRatio);		// Set the value for the Divider Register to 0x00000001

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASKDAC & (RADIO1_ADDR | RADIO2_ADDR | RADIO3_ADDR | RADIO4_ADDR)));		// Select all DACs

	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)radio_controller_baseaddr, RAD_TX_DAC_RESET_MASK); // Turn on DacReset
	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)radio_controller_baseaddr) & ~(RAD_TX_DAC_RESET_MASK))); // Turn off DacReset

	transmitdac(0x0004);					// Transmit a value of 0x04 for Register 0 for DAC to use only 1 refernce register


	RADIO_CONTROLLER_mWriteSlaveReg5((volatile)radio_controller_baseaddr, 0x3412);			// Set the value of the Control Register to 0x00003412 for Radio
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)radio_controller_baseaddr, clkRatio-1);		// Set the value for the Divider Register to 0x00000000

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & (RADIO1_ADDR | RADIO2_ADDR | RADIO3_ADDR | RADIO4_ADDR)));		// Select the radios that will be affected by this function call in store in Slave Select

	// Go through reset procedure
	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, ~(RAD_SHDN_MASK | RAD_SHDN_CON_MASK | RAD_TXEN_MASK | RAD_TXEN_CON_MASK | RAD_RXEN_MASK | RAD_RXEN_CON_MASK | RAD_RXHP_MASK | RAD_RXHP_CON_MASK));
	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) | RAD_SHDN_MASK)); // Asset Shutdown
	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) | (RAD_TXEN_MASK | RAD_RXEN_MASK))); // Enable Rx and Tx
	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) & ~(RAD_TXEN_MASK | RAD_RXEN_MASK))); // Disable Rx and Tx
	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) & ~RAD_SHDN_MASK)); // De-asset Shutdown

	// Start initialization
	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) | RAD_RXHP_CON_MASK)); // Set RxHP control to HW
	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)radio_controller_baseaddr) | RAD_24PA_MASK)); // Antsw[1] to 1 and enable 2.4GHz amplifier
	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)radio_controller_baseaddr) & ~RAD_ADC_RX_DCS_MASK)); // DCS to 0
	RADIO_CONTROLLER_mWriteSlaveReg2((volatile)radio_controller_baseaddr, 0x00000000 & ~(RAD_ADC_RX_PWDNA_MASK | RAD_ADC_RX_PWDNB_MASK | RAD_RSSI_ADC_SLEEP_MASK)); // Enable all ADCs

	transmit(0x0C218);			// Set value of 0x0C21 to register 8 in the radio
	REG_RAD1_RX_CONTROL = (short)0x0C21;			// Update local copies of the registers in the radio
	REG_RAD2_RX_CONTROL = (short)0x0C21;
	REG_RAD3_RX_CONTROL = (short)0x0C21;
	REG_RAD4_RX_CONTROL = (short)0x0C21;

	// Setup for 20MHz radio reference clock
	transmit(0x18225);
	REG_RAD1_BAND_SELECT = (short)0x1822;
	REG_RAD2_BAND_SELECT = (short)0x1822;
	REG_RAD3_BAND_SELECT = (short)0x1822;
	REG_RAD4_BAND_SELECT = (short)0x1822;

	// Setup for 40MHz radio reference clock
	//transmit(0x18245);
	//REG_RAD1_BAND_SELECT = (short)0x1824;
	//REG_RAD2_BAND_SELECT = (short)0x1824;
	//REG_RAD3_BAND_SELECT = (short)0x1824;
	//REG_RAD4_BAND_SELECT = (short)0x1824;

	unsigned int reg2 = REG_RAD1_STANDBY | 0x2000;
	transmit(((reg2<<4)+0x0002));
	REG_RAD1_STANDBY = (short)reg2;
	REG_RAD2_STANDBY = (short)reg2;
	REG_RAD3_STANDBY = (short)reg2;
	REG_RAD4_STANDBY = (short)reg2;

	unsigned int reg5 = REG_RAD1_BAND_SELECT | 0x2000;
	transmit(((reg5<<4)+0x0005));
	REG_RAD1_BAND_SELECT = (short)reg5;
	REG_RAD2_BAND_SELECT = (short)reg5;
	REG_RAD3_BAND_SELECT = (short)reg5;
	REG_RAD4_BAND_SELECT = (short)reg5;

	unsigned int reg9 = REG_RAD1_TX_LINEARITY | 0x0003;
	transmit(((reg9<<4)+0x0009));
	REG_RAD1_TX_LINEARITY = (short)reg9;
	REG_RAD2_TX_LINEARITY = (short)reg9;
	REG_RAD3_TX_LINEARITY = (short)reg9;
	REG_RAD4_TX_LINEARITY = (short)reg9;

	//Setup the deault TxTiming values for all four radios
	//Field assignments in these four registers (everything endian-swapped):
	// bits[0:7]: delay for gain ramp start (default = 100 cycles)
	// bits[8:15] delay for power amp start (default = 0 cycles)
	// bits[16:23] delay for radio TxEn start (default = 0 cycles)
	RADIO_CONTROLLER_mWriteSlaveReg13((volatile)radio_controller_baseaddr,(unsigned int)( (100 << 24) + (0 << 16) + (0 << 8) ) );
	RADIO_CONTROLLER_mWriteSlaveReg14((volatile)radio_controller_baseaddr,(unsigned int)( (100 << 24) + (0 << 16) + (0 << 8) ) );
	RADIO_CONTROLLER_mWriteSlaveReg15((volatile)radio_controller_baseaddr,(unsigned int)( (100 << 24) + (0 << 16) + (0 << 8) ) );
	RADIO_CONTROLLER_mWriteSlaveReg16((volatile)radio_controller_baseaddr,(unsigned int)( (100 << 24) + (0 << 16) + (0 << 8) ) );

	//Setup the deault TxGainTiming values for all four radios
	// bits[0:5]: target gain (default = 0x3f = max Tx gain)
	// bits[6:9]: gain step (default = 0xF = max gain step)
	// bits[10:13]: gain time step (default = 2 = min gain time step)
	// bits[16:27]: delay for TxStart (default = 200 cycles)
	RADIO_CONTROLLER_mWriteSlaveReg9((volatile)radio_controller_baseaddr,(unsigned int)((0x3F << 26) | (0xF << 22) | ((2) << 18) | (200 << 4)));
	RADIO_CONTROLLER_mWriteSlaveReg10((volatile)radio_controller_baseaddr,(unsigned int)((0x3F << 26) | (0xF << 22) | ((2) << 18) | (200 << 4)));
	RADIO_CONTROLLER_mWriteSlaveReg11((volatile)radio_controller_baseaddr,(unsigned int)((0x3F << 26) | (0xF << 22) | ((2) << 18) | (200 << 4)));
	RADIO_CONTROLLER_mWriteSlaveReg12((volatile)radio_controller_baseaddr,(unsigned int)((0x3F << 26) | (0xF << 22) | ((2) << 18) | (200 << 4)));

	return;
}

/**
 * @brief Enable transmit mode on radios.
 *
 * Enables the transmit enable mode on the radios specified. Before transmit is turned on the recieve
 * mode is turned off. Enables the TxEnable state machine that also controls turning on of the amplifiers.
 * 
 * @param radios Refers to the radios in the slots whose transmit mode is turned on.
 */
void WarpRadio_v1_TxEnable(unsigned int radios) {

	unsigned int tmpReg = 0;
	
	//Swap the antenna switch to map the Tx port to antenna port 1
	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)radio_controller_baseaddr) | (radios & RAD_ANTSW_MASK)));

	//Read the current radio controller Tx/Rx mode register into a temporary variable
	tmpReg = RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr);

	//De-assert the RxEnable bits for the selected radios (no harm if they're already disabled)
	tmpReg = tmpReg & ~(radios & RAD_RXEN_MASK);

	//Assert the TxEnable bits for the selected radios (no harm if they're already enabled)
	tmpReg = tmpReg | (radios & RAD_TXEN_MASK);

	//Write the update register contents back to the radio controller
	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, tmpReg);

	return;
}


/**
 * @brief Enable recieve mode on radios.
 *
 * Enables the recieve mode in the radio board. On calling this function the transmit mode is forcibly turned off.
 *
 * @param radios Refers to the radios in the slots that will have their recieve mode turned on.
 */
void WarpRadio_v1_RxEnable(unsigned int radios) {

	unsigned int tmpReg = 0;
	
	//Swap the antenna switch to map the Rx port to antenna port 1
	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)radio_controller_baseaddr) & ~(radios & RAD_ANTSW_MASK)));

	//Read the current radio controller Tx/Rx mode register into a temporary variable
	tmpReg = RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr);

	//De-assert the TxEnable bits for the selected radios (no harm if they're already disabled)
	tmpReg = tmpReg & ~(radios & RAD_TXEN_MASK);

	//Assert the RxEnable bits for the selected radios (no harm if they're already enabled)
	tmpReg = tmpReg | (radios & RAD_RXEN_MASK);

	//Write the update register contents back to the radio controller
	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, tmpReg);

	return;
}

/**
 * @brief Disable transmit or receive mode.
 *
 * Disables the receive and/or transmit modes in the radios specified.
 *
 * @param radios Refers to the radios in the slots that are affected. 
 */
void WarpRadio_v1_TxRxDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg0((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)radio_controller_baseaddr) & ~(radios & (RAD_TXEN_MASK | RAD_RXEN_MASK)))); // Disable Tx and Rx
}

/**
 * @brief Tune the radio to a frequency in the 2.4GHz band.
 *
 * Function used to shift the center frequency on the radio within the 2.4GHz band. Also enables the
 * 2.4GHz amplifier for the transmit state machine.
 *		-# 2412MHz
 *		-# 2417MHz
 *		-# 2422MHz
 *		-# 2427MHz
 *		-# 2432MHz
 *		-# 2437MHz
 *		-# 2442MHz
 *		-# 2447MHz
 *		-# 2452MHz
 *		-# 2457MHz
 *		-# 2462MHz
 *		-# 2467MHz
 *		-# 2472MHz
 *		-# 2484MHz
 *
 * @param freqset The frequency channel to use, selected from above list
 * @param radios Defines which radios are affected by this function call.
 * @return Returns INVALID_FREQ if given frequency set is not valid.
 */
int WarpRadio_v1_SetCenterFreq2GHz(char freqset, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned int reg3;
	unsigned int reg4;
	unsigned int reg5;
	int retval;							// Return value from the function
	unsigned int mask2g = 0xFF3E;		// Mask to set frequency band to 2.4Ghz

	switch(freqset) {					// Switch on the frequency set given as input.
		case(1) : {
			reg3 = 0x00A03;				// Set a value of 0x00A0 for Register 3
			reg4 = 0x33334;				// Set a value of 0x3333 for Register 4
			retval = 2412;				// Set the return value to the frequency that has been set.
			break;
		}
		case(2) : {
			reg3 = 0x20A13;
			reg4 = 0x08884;
			retval = 2417;
			break;
		}
		case(3) : {
			reg3 = 0x30A13;
			reg4 = 0x1DDD4;
			retval = 2422;
			break;
		}
		case(4) : {
			reg3 = 0x00A13;
			reg4 = 0x33334;
			retval = 2427;
			break;
		}
		case(5) : {
			reg3 = 0x20A23;
			reg4 = 0x08884;
			retval = 2432;
			break;
		}
		case(6) : {
			reg3 = 0x30A23;
			reg4 = 0x1DDD4;
			retval = 2437;
			break;
		}
		case(7) : {
			reg3 = 0x00A23;
			reg4 = 0x33334;
			retval = 2442;
			break;
		}
		case(8) : {
			reg3 = 0x20A33;
			reg4 = 0x08884;
			retval = 2447;
			break;
		}
		case(9) : {
			reg3 = 0x30A33;
			reg4 = 0x1DDD4;
			retval = 2452;
			break;
		}
		case(10) : {
			reg3 = 0x00A33;
			reg4 = 0x33334;
			retval = 2457;
			break;
		}
		case(11) : {
			reg3 = 0x20A43;
			reg4 = 0x08884;
			retval = 2462;
			break;
		}
		case(12) : {
			reg3 = 0x30A43;
			reg4 = 0x1DDD4;
			retval = 2467;
			break;
		}
		case(13) : {
			reg3 = 0x00A43;
			reg4 = 0x33334;
			retval = 2472;
			break;
		}
		case(14) : {
			reg3 = 0x10A53;
			reg4 = 0x26664;
			retval = 2484;
			break;
		}
		default : {
			retval = INVALID_FREQ;
		}
	}

	if(retval != -1) {						// Check if an invalid freqency set has been provided and if so do not change freqency

		transmit(reg3);			// Transmit the new register 3 value
		transmit(reg4);			// Transmit the new register 4 value

		reg3 = reg3>>4;						// Bit shift the register values to the right and remove the register number from the
		reg4 = reg4>>4;						// value.

		if((radios & RAD1MASK) > 0) {	// Check if the Slave is in use

			reg5 = REG_RAD1_BAND_SELECT & mask2g;					// Pick up local copy of the register and set the band to 2.4Ghz

			transRadio(0x0001, ((reg5<<4)+0x0005));		// Transmit new register 5 value and add the register number as last 4 bits

			REG_RAD1_BAND_SELECT = (short)reg5;						// Set local copies of registers to new values.
			REG_RAD1_INTEGER_DIVIDER_RATIO = (short)reg3;
			REG_RAD1_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
		}
		if((radios & RAD2MASK) > 0) {	// Check if the Slave is in use

			reg5 = REG_RAD2_BAND_SELECT & mask2g;					// Pick up local copy of the register and set the band to 2.4Ghz

			transRadio(0x0002, ((reg5<<4)+0x0005));		// Transmit new register 5 value and add the register number as last 4 bits

			REG_RAD2_BAND_SELECT = (short)reg5;						// Set local copies of registers to new values.
			REG_RAD2_INTEGER_DIVIDER_RATIO = (short)reg3;
			REG_RAD2_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
		}
		if((radios & RAD3MASK) > 0) {	// Check if the Slave is in use

			reg5 = REG_RAD3_BAND_SELECT & mask2g;					// Pick up local copy of the register and set the band to 2.4Ghz

			transRadio(0x0004, ((reg5<<4)+0x0005));		// Transmit new register 5 value and add the register number as last 4 bits

			REG_RAD3_BAND_SELECT = (short)reg5;						// Set local copies of registers to new values.
			REG_RAD3_INTEGER_DIVIDER_RATIO = (short)reg3;
			REG_RAD3_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
		}
		if((radios & RAD4MASK) > 0) {	// Check if the Slave is in use

			reg5 = REG_RAD4_BAND_SELECT & mask2g;					// Pick up local copy of the register and set the band to 2.4Ghz

			transRadio(0x0008, ((reg5<<4)+0x0005));		// Transmit new register 5 value and add the register number as last 4 bits

			REG_RAD4_BAND_SELECT = (short)reg5;						// Set local copies of registers to new values.
			REG_RAD4_INTEGER_DIVIDER_RATIO = (short)reg3;
			REG_RAD4_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
		}
	}


	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)radio_controller_baseaddr) & ~(radios & RAD_5PA_MASK))); // Disable 5GHz amp
	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)radio_controller_baseaddr) | (radios & RAD_24PA_MASK))); // Enable 2.4GHz amp

	return retval;		// Return either the new freqency that has been set or return -1 to indicate that the frequency set given was invalid
}


/**
 * @brief Read DIPSW of a radio.
 *
 * Returns the DIPSW values of the radio specified. Can return value for only one of the radios at one time.
 *
 * @param radio Radio from which to read the value.
 */
char WarpRadio_v1_DIPSW(unsigned int radio) {

	if((radio & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg3((volatile)radio_controller_baseaddr) & RAD_DIPSW_L_MASK) >> 10);
	}
	else if((radio & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg3((volatile)radio_controller_baseaddr) & RAD_DIPSW_H_MASK) >> 26);
	}
	else if((radio & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg4((volatile)radio_controller_baseaddr) & RAD_DIPSW_L_MASK) >> 10);
	}
	else if((radio & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg4((volatile)radio_controller_baseaddr) & RAD_DIPSW_H_MASK) >> 26);
	}
	else {
		return 0;
	}
}

/**
 * @brief Adjust DC offset for DAC.
 *
 * Adjust the DC Offset on the I and Q channels of the DAC. Only the I or Q can be adjusted at one time.
 * Value must be within the defined range to be correctly written to the DAC registers.
 * 
 * @param chan ICHAN or QCHAN, referring to the I channel or the Q channel.
 * @param value DC offset value to be written. Ranges from -1023 to 1024.
 * @param radios Radios that have their offset value set.
 * @return INVALID_MODE if the mode is incorrect, OUT_OF_RANGE is the value given
 * is out of the range that can be supported, WARP_SUCCESS if successful change.
 */
int WarpRadio_v1_DACOffsetAdj(char chan, short value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg5((volatile)radio_controller_baseaddr, 0x3410);			// Set the value of the Control Register to 0x00003410 for DACs
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)radio_controller_baseaddr, 0x00000001);		// Set the value for the Divider Register to 0x00000001

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASKDAC & radios));		// Select the dacs that need to be affected

	if (value > 1023 || value < -1024) {			// Make sure the value is in range.
		return OUT_OF_RANGE;
	}

	short reg8;
	if (value < 0) {								// If the value is negative then store set the first bit of second register
		reg8 = 0x0080;								// to 1
	}
	else {
		reg8 = 0x0000;								// Or if positive set it to 0.
	}

	value = abs(value);

	short reg7 = ((value & 0x03FC) >> 2);			// b9:b2 of the value are the 8 bits in the first register
	reg8 = reg8 + (value & 0x0003);					// b1:b0 of the value are the last 2 bits in the second register

	if (chan == ICHAN) {
		transmitdac((0x0700 + reg7));		// if I channel then store the first register to Register 7
		transmitdac((0x0800 + reg8));		// and the second register to Register 8
	}
	else if (chan == QCHAN) {
		transmitdac((0x0B00 + reg7));		// if I channel then store the first register to Register B
		transmitdac((0x0C00 + reg8));		// and the second register to Register C
	}
	else {
		return INVALID_MODE;
	}

	RADIO_CONTROLLER_mWriteSlaveReg5((volatile)radio_controller_baseaddr, 0x3412);			// Set the value of the Control Register to 0x00003412 for Radio
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)radio_controller_baseaddr, 0x00000000);		// Set the value for the Divider Register to 0x00000000

	return WARP_SUCCESS;
}

