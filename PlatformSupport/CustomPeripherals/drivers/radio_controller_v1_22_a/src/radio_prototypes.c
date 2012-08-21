// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/**
 * \file radio_prototypes.c
 * \brief Initializes the registers to their default values.
 *
 * @version 1.09
 * @author Siddharth Gupta
 *
 */

// This file initializes the local copies of the radio registers.

/***************************** Include Files *******************************/

#include "radio_prototypes.h"

/************************ Variable Initializations *************************/

// These are local copies of the registers in the chip on WARP Radio Board
// daughtercard. These are modified on every command sent to the radio by
// all the radio libraries.

// RADIO 1
unsigned short REG_RAD1_REGISTER_0 = 0x1140;
unsigned short REG_RAD1_REGISTER_1 = 0x00CA;
unsigned short REG_RAD1_STANDBY = 0x1007;
unsigned short REG_RAD1_INTEGER_DIVIDER_RATIO = 0x30A2;
unsigned short REG_RAD1_FRACTIONAL_DIVIDER_RATIO = 0x1DDD;
unsigned short REG_RAD1_BAND_SELECT = 0x1824;
unsigned short REG_RAD1_CALIBRATION = 0x1C00;
unsigned short REG_RAD1_LOWPASS_FILTER = 0x002A;
unsigned short REG_RAD1_RX_CONTROL = 0x0025;
unsigned short REG_RAD1_TX_LINEARITY = 0x03CF;
unsigned short REG_RAD1_PA_BIAS_DAC = 0x03C0;
unsigned short REG_RAD1_RX_GAIN = 0x007F;
unsigned short REG_RAD1_TX_VGA_GAIN = 0x0000;

// RADIO 2
unsigned short REG_RAD2_REGISTER_0 = 0x1140;
unsigned short REG_RAD2_REGISTER_1 = 0x00CA;
unsigned short REG_RAD2_STANDBY = 0x1007;
unsigned short REG_RAD2_INTEGER_DIVIDER_RATIO = 0x30A2;
unsigned short REG_RAD2_FRACTIONAL_DIVIDER_RATIO = 0x1DDD;
unsigned short REG_RAD2_BAND_SELECT = 0x1824;
unsigned short REG_RAD2_CALIBRATION = 0x1C00;
unsigned short REG_RAD2_LOWPASS_FILTER = 0x002A;
unsigned short REG_RAD2_RX_CONTROL = 0x0025;
unsigned short REG_RAD2_TX_LINEARITY = 0x03CF;
unsigned short REG_RAD2_PA_BIAS_DAC = 0x03C0;
unsigned short REG_RAD2_RX_GAIN = 0x007F;
unsigned short REG_RAD2_TX_VGA_GAIN = 0x0000;

// RADIO 3
unsigned short REG_RAD3_REGISTER_0 = 0x1140;
unsigned short REG_RAD3_REGISTER_1 = 0x00CA;
unsigned short REG_RAD3_STANDBY = 0x1007;
unsigned short REG_RAD3_INTEGER_DIVIDER_RATIO = 0x30A2;
unsigned short REG_RAD3_FRACTIONAL_DIVIDER_RATIO = 0x1DDD;
unsigned short REG_RAD3_BAND_SELECT = 0x1824;
unsigned short REG_RAD3_CALIBRATION = 0x1C00;
unsigned short REG_RAD3_LOWPASS_FILTER = 0x002A;
unsigned short REG_RAD3_RX_CONTROL = 0x0025;
unsigned short REG_RAD3_TX_LINEARITY = 0x03CF;
unsigned short REG_RAD3_PA_BIAS_DAC = 0x03C0;
unsigned short REG_RAD3_RX_GAIN = 0x007F;
unsigned short REG_RAD3_TX_VGA_GAIN = 0x0000;

// RADIO 4
unsigned short REG_RAD4_REGISTER_0 = 0x1140;
unsigned short REG_RAD4_REGISTER_1 = 0x00CA;
unsigned short REG_RAD4_STANDBY = 0x1007;
unsigned short REG_RAD4_INTEGER_DIVIDER_RATIO = 0x30A2;
unsigned short REG_RAD4_FRACTIONAL_DIVIDER_RATIO = 0x1DDD;
unsigned short REG_RAD4_BAND_SELECT = 0x1824;
unsigned short REG_RAD4_CALIBRATION = 0x1C00;
unsigned short REG_RAD4_LOWPASS_FILTER = 0x002A;
unsigned short REG_RAD4_RX_CONTROL = 0x0025;
unsigned short REG_RAD4_TX_LINEARITY = 0x03CF;
unsigned short REG_RAD4_PA_BIAS_DAC = 0x03C0;
unsigned short REG_RAD4_RX_GAIN = 0x007F;
unsigned short REG_RAD4_TX_VGA_GAIN = 0x0000;


/***************************** Functions ******************************/

// slv_reg8 is the transmit register where the value to be transmitted is to be stored.
// The last 4 bits of the transmitted value should be the register that needs to be set while
// the first 14 bits are the numbers that need to be set in that register.
// slv_reg5 is the Control Register. 0x00003412 is the startup value to be set for the system.
// 0x00003512 lets the core know to transmit the value in the transmit register.
// slv_reg6 is the Divider Register. The startup value that needs to be set is 0x00000000.
// slv_reg7 is the Slave Select Register. This decides which of the radios recieve the transmitted
// value. Daughtercard slot 1 is 0x00000001. Slot 2 is 0x00000002. Slot 3 is 0x00000004.
// Slot 4 is 0x00000008. Multiple slots can also be selected at the same time.

/**
 * @brief Send information via SPI interface.
 *
 * Function used to send values to the radio. Waits until the controller is done transmitting
 * before it returning. Slave select must be correctly set before being used.
 *
 * @param val Value to be sent to the radio.
 */
void transmit(int val) {

	RADIO_CONTROLLER_mWriteSlaveReg8((volatile)radio_controller_baseaddr, val);					// Set the transmit register to the value that should be transmitted.

	RADIO_CONTROLLER_mWriteSlaveReg5((volatile)radio_controller_baseaddr, 0x3512);				// Sets the GO_BSY to high so it starts transmitting.

	while(RADIO_CONTROLLER_mReadSlaveReg5((volatile)radio_controller_baseaddr) == 0x3512) {		// Wait for the controller to finish transmitting.
	}

}


/**
 * @brief Send data to a subset of radios via SPI
 *
 * Using transmit() it sends data to radio but also allows for temporarily changing the slave select
 * to apply to some of the radios and not all.
 *
 * @param ssval Slave select input
 * @param val Value to be sent
 */
void transRadio(int ssval, unsigned int val) {

	unsigned int temp = RADIO_CONTROLLER_mReadSlaveReg7((volatile)radio_controller_baseaddr);	// Store the current value of the Slave Select. Needed as this function is
																				// used when calling the function for a single radio but still using more
	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, ssval);				// Set the Slave Select to the new value.
	transmit(val);											// Transmit the new value
	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, temp);					// Return the Slave Select to its initial value.

}

/**
 * @brief Send information to the DAC registers.
 *
 * Use to send information to DAC registers. Waits until the controller is done transmitting
 * before it returning. Slave select must be correctly set before being used.
 *
 * @param val Value to be sent. 16 bits wide, first 8 register number, last 8 data for that register.
 */
void transmitdac(int val) {

	RADIO_CONTROLLER_mWriteSlaveReg8((volatile)radio_controller_baseaddr, val);

	RADIO_CONTROLLER_mWriteSlaveReg5((volatile)radio_controller_baseaddr, 0x3510);

	while(RADIO_CONTROLLER_mReadSlaveReg5((volatile)radio_controller_baseaddr) == 0x3510) {
	}

}

