// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/***************************** Include Files *******************************/

#include "radio_controller_5ghz.h"

/****************************** Functions **********************************/

// Enable a radio's 5GHz power amplifier
void WarpRadio_v1_5AmpEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | (radios & RAD_5PA_MASK))); // Enable 5GHz amp
}

// Disable a radio's 5GHz power amplifier
void WarpRadio_v1_5AmpDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & ~(radios & RAD_5PA_MASK))); // Disable 5GHz amp
}

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
int WarpRadio_v1_SetCenterFreq5GHz(char freqset, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned int reg3;
	unsigned int reg4;
	unsigned int reg5;
	int band5;							// Defines whether the frequency is in the upper 5GHz band or in the lower 5GHz band.
	int retval;							// Return value from the function
	unsigned int mask5gl1 = 0x0001;
	unsigned int mask5gl2 = 0xFFBF;
	unsigned int mask5gh = 0x0041;

	switch(freqset) {					// Switch on the frequency set given as input.
		case(1) : {
			reg3 = 0x30CF3;				// Set a value of 0x30CF for Register 3
			reg4 = 0x0CCC4;				// Set a value of 0x3333 for Register 4
			retval = 5180;				// Set the return value to the frequency that has been set.
			band5 = 1;					// Set the band5 value that it is in the lower 5GHz band.
			break;
		}
		case(2) : {
			reg3 = 0x00D03;
			reg4 = 0x00004;
			retval = 5200;
			band5 = 1;
			break;
		}
		case(3) : {
			reg3 = 0x00D03;
			reg4 = 0x33334;
			retval = 5220;
			band5 = 1;
			break;
		}
		case(4) : {
			reg3 = 0x10D13;
			reg4 = 0x26664;
			retval = 5240;
			band5 = 1;
			break;
		}
		case(5) : {
			reg3 = 0x20D23;
			reg4 = 0x19994;
			retval = 5260;
			band5 = 1;
			break;
		}
		case(6) : {
			reg3 = 0x30D33;
			reg4 = 0x0CCC4;
			retval = 5280;
			band5 = 1;
			break;
		}
		case(7) : {
			reg3 = 0x00D43;
			reg4 = 0x00004;
			retval = 5300;
			band5 = 1;
			break;
		}
		case(8) : {
			reg3 = 0x00D43;
			reg4 = 0x33334;
			retval = 5320;
			band5 = 1;
			break;
		}
		case(9) : {
			reg3 = 0x00DC3;
			reg4 = 0x00004;
			retval = 5500;
			band5 = 2;
			break;
		}
		case(10) : {
			reg3 = 0x00DC3;
			reg4 = 0x33334;
			retval = 5520;
			band5 = 2;
			break;
		}
		case(11) : {
			reg3 = 0x10DD3;
			reg4 = 0x26664;
			retval = 5540;
			band5 = 2;
			break;
		}
		case(12) : {
			reg3 = 0x20DE3;
			reg4 = 0x19994;
			retval = 5560;
			band5 = 2;
			break;
		}
		case(13) : {
			reg3 = 0x30DF3;
			reg4 = 0x0CCC4;
			retval = 5580;
			band5 = 2;
			break;
		}
		case(14) : {
			reg3 = 0x00E03;
			reg4 = 0x00004;
			retval = 5600;
			band5 = 2;
			break;
		}
		case(15) : {
			reg3 = 0x00E03;
			reg4 = 0x33334;
			retval = 5620;
			band5 = 2;
			break;
		}
		case(16) : {
			reg3 = 0x10E13;
			reg4 = 0x26664;
			retval = 5640;
			band5 = 2;
			break;
		}
		case(17) : {
			reg3 = 0x20E23;
			reg4 = 0x19994;
			retval = 5660;
			band5 = 2;
			break;
		}
		case(18) : {
			reg3 = 0x30E33;
			reg4 = 0x0CCC4;
			retval = 5680;
			band5 = 2;
			break;
		}
		case(19) : {
			reg3 = 0x00E43;
			reg4 = 0x00004;
			retval = 5700;
			band5 = 2;
			break;
		}
		case(20) : {
			reg3 = 0x00E53;
			reg4 = 0x33334;
			retval = 5745;
			band5 = 2;
			break;
		}
		case(21) : {
			reg3 = 0x10E63;
			reg4 = 0x26664;
			retval = 5765;
			band5 = 2;
			break;
		}
		case(22) : {
			reg3 = 0x20E73;
			reg4 = 0x19994;
			retval = 5785;
			band5 = 2;
			break;
		}
		case(23) : {
			reg3 = 0x30E83;
			reg4 = 0x0CCC4;
			retval = 5805;
			band5 = 2;
			break;
		}
		default : {
			retval = INVALID_FREQ;
		}
	}

	if(retval != -1) {						// Check if an invalid freqency set has been provided and if so do not change freqency

		transmit(reg3);			// Transmit register 3 value
		transmit(reg4);			// Transmit register 4 value

		reg3 = reg3>>4;
		reg4 = reg4>>4;

		if (band5 == 1) {									// Check if the freqency is in the lower 5GHz band
			if((radios & RAD1MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD1_BAND_SELECT | mask5gl1;							// Set the band in register 5 to 5GHz
				reg5 = reg5 & mask5gl2;											// Set the band range in the register 5 to the lower 5GHz band

				transRadio(0x0001, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio(0x0001, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio(0x0001, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD1_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD1_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD1_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
			if((radios & RAD2MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD2_BAND_SELECT | mask5gl1;							// Set the band in register 5 to 5GHz
				reg5 = reg5 & mask5gl2;											// Set the band range in the register 5 to the lower 5GHz band

				transRadio(0x0002, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio(0x0002, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio(0x0002, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD2_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD2_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD2_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
			if((radios & RAD3MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD3_BAND_SELECT | mask5gl1;							// Set the band in register 5 to 5GHz
				reg5 = reg5 & mask5gl2;											// Set the band range in the register 5 to the lower 5GHz band

				transRadio(0x0004, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio(0x0004, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio(0x0004, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD3_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD3_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD3_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
			if((radios & RAD4MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD4_BAND_SELECT | mask5gl1;							// Set the band in register 5 to 5GHz
				reg5 = reg5 & mask5gl2;											// Set the band range in the register 5 to the lower 5GHz band

				transRadio(0x0008, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio(0x0008, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio(0x0008, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD4_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD4_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD4_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
		}

		if (band5 == 2) {									// Check if the freqency is in the upper 5GHz band
			if((radios & RAD1MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD1_BAND_SELECT | mask5gh;							// Set the band in register 5 to 5GHz and upper 5GHz band

				transRadio(0x0001, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio(0x0001, (((reg5 | 0x0080)<<4)+0x0002));	// Start auto band switch to the new value.
				transRadio(0x0001, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD1_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD1_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD1_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
			if((radios & RAD2MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD2_BAND_SELECT | mask5gh;							// Set the band in register 5 to 5GHz and upper 5GHz band

				transRadio(0x0002, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio(0x0002, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio(0x0002, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD2_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD2_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD2_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
			if((radios & RAD3MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD3_BAND_SELECT | mask5gh;							// Set the band in register 5 to 5GHz and upper 5GHz band

				transRadio(0x0004, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio(0x0004, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio(0x0004, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD3_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD3_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD3_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
			if((radios & RAD4MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD4_BAND_SELECT | mask5gh;							// Set the band in register 5 to 5GHz and upper 5GHz band

				transRadio(0x0008, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio(0x0008, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio(0x0008, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD4_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD4_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD4_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
		}
	}
	return retval;		// Return either the new freqency that has been set or return -1 to indicate that the frequency set given was invalid
}

