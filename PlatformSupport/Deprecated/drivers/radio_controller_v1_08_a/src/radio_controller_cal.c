// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/***************************** Include Files *******************************/

#include "radio_controller_cal.h"

/****************************** Functions **********************************/

// Put the radio into transmit calibration mode. 'radios' refers to the radios that will be put into
// calibration. Forcibly removed from receive calibration mode.
void WarpRadio_v1_TxCalibration(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned int calreg = 0x04026;					// Set the bit in register 6 to enable TX calibration mode

	transmit(calreg);						// Transmit the new value

	calreg = calreg>>4;								// Bit shift to the right to remove register number

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		REG_RAD1_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		REG_RAD2_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		REG_RAD3_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		REG_RAD4_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
}

// Put the radio into receive calibration mode. 'radios' refers to the radios that will be put into
// calibration. Forcibly removed from receive calibration mode.
void WarpRadio_v1_RxCalibration(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned calreg = 0x1C016;					// Set the bit in register 6 to enable RX calibration mode
												// and set the Gain control bits to 34db

	transmit(calreg);					// Transmit the new value

	calreg = calreg>>4;							// Bit shift to the right to remove register number

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		REG_RAD1_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		REG_RAD2_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		REG_RAD3_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		REG_RAD4_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
}

// Takes the specified radios out of transmit and recieve calibration mode. 'radios' refers the Radios in the
// slots that will be affected. This function works exactly the same way as the function above.
void WarpRadio_v1_NoCalibration(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned calreg = 0x1C006;

	transmit(calreg);

	calreg = calreg>>4;

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		REG_RAD1_CALIBRATION = (short)calreg;
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		REG_RAD2_CALIBRATION = (short)calreg;
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		REG_RAD3_CALIBRATION = (short)calreg;
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		REG_RAD4_CALIBRATION = (short)calreg;
	}
}

// Sets the gain for Transmitter I/Q Calibration LO Leakage and Sideband-Detector Gain Control.
// Returns NOT_IN_CALIBRATION if any of the radios for which the gain is being set in not
// in calibration mode. Returns INVALID_GAIN if the gain set value given is not valid. Returns
// WARP_SUCCESS if value changed successfully. To be in calibration mode set
// TxCalibration.
// gain = 0 -> 8db
// gain = 1 -> 18db
// gain = 2 -> 24db
// gain = 3 -> 34db
char WarpRadio_v1_TxCalGain(char gain, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned int mask = 0x0002;							// Mask to check if in transmit calibration mode.

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		if ((REG_RAD1_CALIBRATION & mask) == 0x0) {		// If the transmit calibration bit is 0 then return NOT_IN_CALIBRATION
			return NOT_IN_CALIBRATION;
		}
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		if ((REG_RAD2_CALIBRATION & mask) == 0x0) {		// If the transmit calibration bit is 0 then return NOT_IN_CALIBRATION
			return NOT_IN_CALIBRATION;
		}
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		if ((REG_RAD3_CALIBRATION & mask) == 0x0) {		// If the transmit calibration bit is 0 then return NOT_IN_CALIBRATION
			return NOT_IN_CALIBRATION;
		}
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		if ((REG_RAD4_CALIBRATION & mask) == 0x0) {		// If the transmit calibration bit is 0 then return NOT_IN_CALIBRATION
			return NOT_IN_CALIBRATION;
		}
	}

	unsigned int calreg;

	switch(gain) {						// Switch on the gain value and figure out the value to transmit on the basis of the
		case(0) : {						// required gain for the radios specified.
			calreg = 0x04026;
			break;
		}
		case(1) : {
			calreg = 0x0C026;
			break;
		}
		case(2) : {
			calreg = 0x14026;
			break;
		}
		case(3) : {
			calreg = 0x1C026;
			break;
		}
		default : {
			return OUT_OF_RANGE;
		}
	}

	transmit(calreg);					// Transmit the value for the Calibration Register and store the values in the local
												// copies.
	calreg = calreg>>4;

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		REG_RAD1_CALIBRATION = (short)calreg;
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		REG_RAD2_CALIBRATION = (short)calreg;
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		REG_RAD3_CALIBRATION = (short)calreg;
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		REG_RAD4_CALIBRATION = (short)calreg;
	}

	return WARP_SUCCESS;
}

// Enable or disable the Rx baseband section of the reciever. Mode = 0 disables the value while mode = 1
// enables the value. Returns INVALID_MODE if the mode is invalid. Returns WARP_SUCCESS if successfully manage
// to change the value.
char WarpRadio_v1_TxCalRxEnable(char mode, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

		unsigned int modeon = 0x0040;
		unsigned int modeoff = 0xFFBF;

		if (mode == 0) {
			if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
				unsigned int reg2 = REG_RAD1_STANDBY & modeoff;			// Set the required bit to 0

				transRadio(0x0001, ((reg2<<4)+0x0002));		// Transmit the value and store to the local copy

				REG_RAD1_STANDBY = (short)reg2;
			}
			if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
				unsigned int reg2 = REG_RAD2_STANDBY & modeoff;

				transRadio(0x0002, ((reg2<<4)+0x0002));

				REG_RAD2_STANDBY = (short)reg2;
			}
			if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
				unsigned int reg2 = REG_RAD3_STANDBY & modeoff;

				transRadio(0x0004, ((reg2<<4)+0x0002));

				REG_RAD3_STANDBY = (short)reg2;
			}
			if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
				unsigned int reg2 = REG_RAD4_STANDBY & modeoff;

				transRadio(0x0008, ((reg2<<4)+0x0002));

				REG_RAD4_STANDBY = (short)reg2;
			}
		}
		else if (mode == 1) {
			if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
				unsigned int reg2 = REG_RAD1_STANDBY | modeon;			// Set the required bit to 1.

				transRadio(0x0001, ((reg2<<4)+0x0002));		// Transmit the value and store to the local copy

				REG_RAD1_STANDBY = (short)reg2;
			}
			if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
				unsigned int reg2 = REG_RAD2_STANDBY | modeon;

				transRadio(0x0002, ((reg2<<4)+0x0002));

				REG_RAD2_STANDBY = (short)reg2;
			}
			if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
				unsigned int reg2 = REG_RAD3_STANDBY | modeon;

				transRadio(0x0004, ((reg2<<4)+0x0002));

				REG_RAD3_STANDBY = (short)reg2;
			}
			if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
				unsigned int reg2 = REG_RAD4_STANDBY | modeon;

				transRadio(0x0008, ((reg2<<4)+0x0002));

				REG_RAD4_STANDBY = (short)reg2;
			}
		}
		else {
			return INVALID_MODE;
		}
	return WARP_SUCCESS;
}



