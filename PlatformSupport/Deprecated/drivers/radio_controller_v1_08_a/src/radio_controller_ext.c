// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/***************************** Include Files *******************************/

#include "radio_controller_ext.h"

/****************************** Functions **********************************/

// Enable a radio's 2.4GHz power amplifier
void WarpRadio_v1_24AmpEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | (radios & RAD_24PA_MASK))); // Enable 2.4GHz amp
}

// Disable a radio's 2.4GHz power amplifier
void WarpRadio_v1_24AmpDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & ~(radios & RAD_24PA_MASK))); // Disable 2.4GHz amp
}

/*
// Select a configuration for the Antennas and Transmit and Receive paths.
// Applies to 'radios' specified.
// 		mode = 1:	Antenna 1 for TX and RX
//		mode = 2:	Antenna 2 for TX and RX
//		mode = 3:	Antenna 1 for TX and Antenna 2 for RX
//		mode = 4:	Antenna 1 for RX and Antenna 2 for TX
char WarpRadio_v1_AntennaConfig(char mode, unsigned int radios);
*/

// Reads the LockDetect pin of the 'radios' specified. Outputs lock detects as {LD4, LD3, LD2, LD1}
// from the radios. An output of 1 indicates that the radio is locked while 0 indicates that it is not.
char WarpRadio_v1_LockDetect(unsigned int radios) {

	return ((RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & RAD_LD_MASK) >> 8);
}

// Enable or disable Transmit VGA Gain Programming using software. Affects 'radios'
// 'mode' 0: Transmit VGA Gain programmed with external ports
//		  1: Transmit VGA Gain programmed with TxVGAGainControl function
// Returns INVALID_MODE if the mode is an invalid input.
char WarpRadio_v1_SoftwareTxGainControl(short mode, unsigned int radios) {

	if (mode == 0 | mode == 1) {
		RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

		mode = mode & 0x0001;
		mode = mode << 10;
		int mask = 0xFBFF;

		if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
			unsigned int reg9 = REG_RAD1_TX_LINEARITY & mask;
			reg9 = reg9 + mode;
			transRadio(0x0001, ((reg9<<4)+0x0009));

			REG_RAD1_TX_LINEARITY = (short)reg9;
		}
		if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
			unsigned int reg9 = REG_RAD2_TX_LINEARITY & mask;
			reg9 = reg9 + mode;
			transRadio(0x0002, ((reg9<<4)+0x0009));

			REG_RAD2_TX_LINEARITY = (short)reg9;
		}
		if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
			unsigned int reg9 = REG_RAD3_TX_LINEARITY & mask;
			reg9 = reg9 + mode;
			transRadio(0x0004, ((reg9<<4)+0x0009));

			REG_RAD3_TX_LINEARITY = (short)reg9;
		}
		if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
			unsigned int reg9 = REG_RAD4_TX_LINEARITY & mask;
			reg9 = reg9 + mode;
			transRadio(0x0008, ((reg9<<4)+0x0009));

			REG_RAD4_TX_LINEARITY = (short)reg9;
		}
	}
	else {
		return INVALID_MODE;
	}

	return WARP_SUCCESS;
}

// Set the Transmit Baseband Gain. Affects only the 'radios' specified.
// 'value':
//		00: max baseband gain - 5db
//		01: max baseband gain - 3db
//		10: max baseband gain - 1.5db
//		11: max baseband gain
void WarpRadio_v1_BaseBandTxGain(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x0003;
	int mask = 0xFFFC;

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg9 = REG_RAD1_TX_LINEARITY & mask;
		reg9 = reg9 + value;
		transRadio(0x0001, ((reg9<<4)+0x0009));

		REG_RAD1_TX_LINEARITY = (short)reg9;
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg9 = REG_RAD2_TX_LINEARITY & mask;
		reg9 = reg9 + value;
		transRadio(0x0002, ((reg9<<4)+0x0009));

		REG_RAD2_TX_LINEARITY = (short)reg9;
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg9 = REG_RAD3_TX_LINEARITY & mask;
		reg9 = reg9 + value;
		transRadio(0x0004, ((reg9<<4)+0x0009));

		REG_RAD3_TX_LINEARITY = (short)reg9;
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg9 = REG_RAD4_TX_LINEARITY & mask;
		reg9 = reg9 + value;
		transRadio(0x0008, ((reg9<<4)+0x0009));

		REG_RAD4_TX_LINEARITY = (short)reg9;
	}
}

// This function adjusts the total transmit gain. The 6 bits of this function map to
// B6:B1. 000000 is the lowest possible gain.
void WarpRadio_v1_TxVGAGainControl(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x003F;
	int mask = 0xFFC0;

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg12 = REG_RAD1_TX_VGA_GAIN & mask;
		reg12 = reg12 + value;
		transRadio(0x0001, ((reg12<<4)+0x000C));

		REG_RAD1_TX_VGA_GAIN = (short)reg12;
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg12 = REG_RAD2_TX_VGA_GAIN & mask;
		reg12 = reg12 + value;
		transRadio(0x0002, ((reg12<<4)+0x000C));

		REG_RAD2_TX_VGA_GAIN = (short)reg12;
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg12 = REG_RAD3_TX_VGA_GAIN & mask;
		reg12 = reg12 + value;
		transRadio(0x0004, ((reg12<<4)+0x000C));

		REG_RAD3_TX_VGA_GAIN = (short)reg12;
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg12 = REG_RAD4_TX_VGA_GAIN & mask;
		reg12 = reg12 + value;
		transRadio(0x0008, ((reg12<<4)+0x000C));

		REG_RAD4_TX_VGA_GAIN = (short)reg12;
	}
}


// Enable or disable Recieve VGA/LNA Gain Programming using software. Affects 'radios'
// 'mode' 0: Recieve VGA/LNA Gain programmed with external hardware ports
//		  1: Receive VGA Gain programmed with RxVGAGainControl and RxLNAGainControl functions
// Returns INVALID_MODE if the mode is an invalid input.
char WarpRadio_v1_SoftwareRxGainControl(short mode, unsigned int radios) {

	if (mode == 0 | mode == 1) {
		RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

		mode = mode & 0x0001;
		mode = mode << 12;
		int mask = 0xEFFF;

		if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
			unsigned int reg8 = REG_RAD1_RX_CONTROL & mask;
			reg8 = reg8 + mode;
			transRadio(0x0001, ((reg8<<4)+0x0008));

			REG_RAD1_RX_CONTROL = (short)reg8;
		}
		if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
			unsigned int reg8 = REG_RAD2_RX_CONTROL & mask;
			reg8 = reg8 + mode;
			transRadio(0x0002, ((reg8<<4)+0x0008));

			REG_RAD2_RX_CONTROL = (short)reg8;
		}
		if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
			unsigned int reg8 = REG_RAD3_RX_CONTROL & mask;
			reg8 = reg8 + mode;
			transRadio(0x0004, ((reg8<<4)+0x0008));

			REG_RAD3_RX_CONTROL = (short)reg8;
		}
		if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
			unsigned int reg8 = REG_RAD4_RX_CONTROL & mask;
			reg8 = reg8 + mode;
			transRadio(0x0008, ((reg8<<4)+0x0008));

			REG_RAD4_RX_CONTROL = (short)reg8;
		}
	}
	else {
		return INVALID_MODE;
	}

	return WARP_SUCCESS;
}


// This function combined with RxVGAGainControl adjusts the total recieve gain. The 2 bits of this function map to
// B7:B6. 00 is the lowest possible gain.
void WarpRadio_v1_RxLNAGainControl(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x0003;
	value = value << 5;
	int mask = 0xFF9F;

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg11 = REG_RAD1_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio(0x0001, ((reg11<<4)+0x000B));

		REG_RAD1_RX_GAIN = (short)reg11;
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg11 = REG_RAD2_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio(0x0002, ((reg11<<4)+0x000B));

		REG_RAD2_RX_GAIN = (short)reg11;
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg11 = REG_RAD3_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio(0x0004, ((reg11<<4)+0x000B));

		REG_RAD3_RX_GAIN = (short)reg11;
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg11 = REG_RAD4_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio(0x0008, ((reg11<<4)+0x000B));

		REG_RAD4_RX_GAIN = (short)reg11;
	}
}

// This function combined with RxLNAGainControl adjusts the total recieve gain. The 5 bits of this function map to
// B5:B1. 00000 is the lowest possible gain.
void WarpRadio_v1_RxVGAGainControl(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x001F;
	int mask = 0xFFE0;

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg11 = REG_RAD1_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio(0x0001, ((reg11<<4)+0x000B));

		REG_RAD1_RX_GAIN = (short)reg11;
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg11 = REG_RAD2_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio(0x0002, ((reg11<<4)+0x000B));

		REG_RAD2_RX_GAIN = (short)reg11;
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg11 = REG_RAD3_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio(0x0004, ((reg11<<4)+0x000B));

		REG_RAD3_RX_GAIN = (short)reg11;
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg11 = REG_RAD4_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio(0x0008, ((reg11<<4)+0x000B));

		REG_RAD4_RX_GAIN = (short)reg11;
	}
}



// Sets the timing parameters for each transmission in TxEnable state machine
// dly_TxEn = clock cycles to wait before turning on transmit enable
// dly_TxStart = clock cycles to wait before sending enabling data transmission model
// dly_GainRampEn = clock cycles to wait before turning on gain ramp cycle
// dly_PowerAmpEn = clock cycles to wait before turning on amplifier
void WarpRadio_v1_SetTxTiming(unsigned int radios, unsigned char dly_TxEn, unsigned char dly_TxStart, unsigned char dly_GainRampEn, unsigned char dly_PowerAmpEn) {

	//GainRampEn - slv_reg_N[0:7]
	//PowerAmpEn - slv_reg_N[8:15]
	//TxEn - slv_reg_N[16:23]
	//TxStart - slv_reg_N[24:31]

	if(((SLAVEMASK & radios) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg13((volatile)baseaddr,(unsigned int)( (dly_GainRampEn << 24) + (dly_PowerAmpEn << 16) + (dly_TxEn << 8) + dly_TxStart ));
	}
	if(((SLAVEMASK & radios) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg14((volatile)baseaddr,(unsigned int)( (dly_GainRampEn << 24) + (dly_PowerAmpEn << 16) + (dly_TxEn << 8) + dly_TxStart ));
	}
	if(((SLAVEMASK & radios) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg15((volatile)baseaddr,(unsigned int)( (dly_GainRampEn << 24) + (dly_PowerAmpEn << 16) + (dly_TxEn << 8) + dly_TxStart ));
	}
	if(((SLAVEMASK & radios) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg16((volatile)baseaddr,(unsigned int)( (dly_GainRampEn << 24) + (dly_PowerAmpEn << 16) + (dly_TxEn << 8) + dly_TxStart ));
	}

	return;
}


// Sets the parameters for automatic Tx gain ramping in TxEnable state machine
// TxGainTarget = target transmit gain, x0 to x3F
// TxGainStep = step with which to ramp to required gain
// TxGainTimeStep = time paused on each gain step
void WarpRadio_v1_SetTxGainTiming(unsigned int radios, unsigned char TxGainTarget, unsigned char TxGainStep, unsigned char TxGainTimeStep) {

	//TxGainTarget is a 6-bit value in the MSB of the register (slv_reg_N[0:5])
	//TxGainStep is a 4-bit value (slv_reg_N[6:9])
	//TxGainTimeStep is a 4-bit value (slv_reg_N[10:13])

	if(((SLAVEMASK & radios) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg9((volatile)baseaddr,(unsigned int)( ((0x3f & TxGainTarget) << 26) | ((0xf & TxGainStep) << 22) | ((0xf & TxGainTimeStep) << 18)));
	}
	if(((SLAVEMASK & radios) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg10((volatile)baseaddr,(unsigned int)( ((0x3f & TxGainTarget) << 26) | ((0xf & TxGainStep) << 22) | ((0xf & TxGainTimeStep) << 18)));
	}
	if(((SLAVEMASK & radios) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg11((volatile)baseaddr,(unsigned int)( ((0x3f & TxGainTarget) << 26) | ((0xf & TxGainStep) << 22) | ((0xf & TxGainTimeStep) << 18)));
	}
	if(((SLAVEMASK & radios) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg12((volatile)baseaddr,(unsigned int)( ((0x3f & TxGainTarget) << 26) | ((0xf & TxGainStep) << 22) | ((0xf & TxGainTimeStep) << 18)));
	}

	return;
}

// Set the Transmit Low Pass Filter Corner Frequency. This is the Coarse adjustment for the frequency and affects
// the 'radios' specified.
// 'value':
//		00: undefined
//		01: 12MHz (nominal mode)
//		10: 18MHz (turbo mode 1)
//		11: 24MHz (turbo mode 2)
void WarpRadio_v1_TxLpfCornFreqCoarseAdj(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x0003;						// Pick the last 2 bits of the value provided.
	value = value << 5;							// Shift the bits to the right location.
	int mask = 0xFF9F;							// Mask to empty the value currently in the register.

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg7 = REG_RAD1_LOWPASS_FILTER & mask;		// Empty the two bits
		reg7 = reg7 + value;									// Put the new value in
		transRadio(0x0001, ((reg7<<4)+0x0007));		// Transmit the new value

		REG_RAD1_LOWPASS_FILTER = (short)reg7;					// Store to the local copies
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg7 = REG_RAD2_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio(0x0002, ((reg7<<4)+0x0007));

		REG_RAD2_LOWPASS_FILTER = (short)reg7;
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg7 = REG_RAD3_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio(0x0004, ((reg7<<4)+0x0007));

		REG_RAD3_LOWPASS_FILTER = (short)reg7;
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg7 = REG_RAD4_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio(0x0008, ((reg7<<4)+0x0007));

		REG_RAD4_LOWPASS_FILTER = (short)reg7;
	}
}

// Set the Recieve Lowpass Filter Corner Frequency. This is the Coarse adjustment and affects only the 'radios' specified
// 'value':
//		00: 7.5MHz
//		01: 9.5MHz (nominal mode)
//		10: 14MHz (turbo mode 1)
//		11: 18MHz (turbo mode 2)
void WarpRadio_v1_RxLpfCornFreqCoarseAdj(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x0003;
	value = value << 3;
	int mask = 0xFFE7;

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg7 = REG_RAD1_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio(0x0001, ((reg7<<4)+0x0007));

		REG_RAD1_LOWPASS_FILTER = (short)reg7;
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg7 = REG_RAD2_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio(0x0002, ((reg7<<4)+0x0007));

		REG_RAD2_LOWPASS_FILTER = (short)reg7;
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg7 = REG_RAD3_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio(0x0004, ((reg7<<4)+0x0007));

		REG_RAD3_LOWPASS_FILTER = (short)reg7;
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg7 = REG_RAD4_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio(0x0008, ((reg7<<4)+0x0007));

		REG_RAD4_LOWPASS_FILTER = (short)reg7;
	}
}

// Set the Recieve Lowpass Filter Corner Frequency. This is the Fine adjustment and affects only the 'radios' specified
// 'value':
//		000: 90%
//		001: 95%
//		010: 100%
//		011: 105%
//		100: 110%
//		101-111: not applicable
// Returns OUT_OF_RANGE if value is out of range
char WarpRadio_v1_RxLpfCornFreqFineAdj(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x0007;
	int mask = 0xFFF8;

	if (value == 5 || value == 6 || value == 7) {				// Make sure the the value is not out of the specified range.
		return OUT_OF_RANGE;
	}

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg7 = REG_RAD1_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio(0x0001, ((reg7<<4)+0x0007));

		REG_RAD1_LOWPASS_FILTER = (short)reg7;
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg7 = REG_RAD2_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio(0x0002, ((reg7<<4)+0x0007));

		REG_RAD2_LOWPASS_FILTER = (short)reg7;
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg7 = REG_RAD3_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio(0x0004, ((reg7<<4)+0x0007));

		REG_RAD3_LOWPASS_FILTER = (short)reg7;
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg7 = REG_RAD4_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio(0x0008, ((reg7<<4)+0x0007));

		REG_RAD4_LOWPASS_FILTER = (short)reg7;
	}
	return WARP_SUCCESS;
}


// Set the Recieve Highpass Filter Corner Frequency when RXHP=0. Affected Slots are defined in 'radios'
// 'value':	0:100Hz
//			1:30kHz
void WarpRadio_v1_RxHighPassCornerFreq(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x0001;
	value = value << 2;
	int mask = 0xFFFB;

	if((radios & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg8 = REG_RAD1_RX_CONTROL & mask;
		reg8 = reg8 + value;
		transRadio(0x0001, ((reg8<<4)+0x0008));

		REG_RAD1_RX_CONTROL = (short)reg8;
	}
	if((radios & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg8 = REG_RAD2_RX_CONTROL & mask;
		reg8 = reg8 + value;
		transRadio(0x0002, ((reg8<<4)+0x0008));

		REG_RAD2_RX_CONTROL = (short)reg8;
	}
	if((radios & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg8 = REG_RAD3_RX_CONTROL & mask;
		reg8 = reg8 + value;
		transRadio(0x0004, ((reg8<<4)+0x0008));

		REG_RAD3_RX_CONTROL = (short)reg8;
	}
	if((radios & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg8 = REG_RAD4_RX_CONTROL & mask;
		reg8 = reg8 + value;
		transRadio(0x0008, ((reg8<<4)+0x0008));

		REG_RAD4_RX_CONTROL = (short)reg8;
	}
}

// Reads the RSSI values for a single radio
// argument 'radios' must select exactly 1 radio
unsigned int WarpRadio_v1_RSSIData(unsigned int radios) {
	
	unsigned int rssi = 0;

	if(radios & RAD1MASK)
		rssi = RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0x3FF;

	else if(radios & RAD2MASK)
		rssi = (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0x3FF0000)>>16;

	else if(radios & RAD3MASK)
		rssi = RADIO_CONTROLLER_mReadSlaveReg4((volatile)baseaddr) & 0x3FF;

	else if(radios & RAD4MASK)
		rssi = (RADIO_CONTROLLER_mReadSlaveReg4((volatile)baseaddr) & 0x3FF0000)>>16;

	return rssi;
}

