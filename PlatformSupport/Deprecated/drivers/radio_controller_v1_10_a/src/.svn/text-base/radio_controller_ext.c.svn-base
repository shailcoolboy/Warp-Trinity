// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/**
 * \file radio_controller_ext.c
 * \brief Extended functionality of the radio boards, over the basic controller.
 *
 * @version 1.09
 * @author Siddharth Gupta
 *
 * Drivers for more complex functions of the radio boards. This includes finer control of receive
 * and transmit gains, both in hardware and software, transmit state machine and control
 * of filter parameters.
 */

/***************************** Include Files *******************************/

#include "radio_controller_ext.h"

/****************************** Functions **********************************/

/**
 * @brief Enable the 2.4GHz power amplifier.
 *
 * Enable the 2.4GHz amplifier for the boards specified. The amplifier turns on during the
 * transmit state machine's execution.
 *
 * @param radios Radio boards affected.
 */
void WarpRadio_v1_24AmpEnable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)radio_controller_baseaddr) | (radios & RAD_24PA_MASK))); // Enable 2.4GHz amp
}

/**
 * @brief Disable the 2.4GHz power amplifier.
 *
 * Disable the 2.4GHz amplifier for the boards specified. Unless an amplifier is enabled, none
 * will turn on during transmit.
 *
 * @param radios Radio boards affected.
 */
void WarpRadio_v1_24AmpDisable(unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg1((volatile)radio_controller_baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)radio_controller_baseaddr) & ~(radios & RAD_24PA_MASK))); // Disable 2.4GHz amp
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

/**
 * @brief Read lock detect from the radio.
 * 
 * Reads the LockDetect pin of the radios requested. Outputs lock detects as {LD4, LD3, LD2, LD1}.
 * Not requested radios have a zero on the output.
 *
 * @param radios Radios to read from
 * @return An output of 1 indicates that the radio is locked while 0 indicates that it is not.
 */
char WarpRadio_v1_LockDetect(unsigned int radios) {

	return (((RADIO_CONTROLLER_mReadSlaveReg1((volatile)radio_controller_baseaddr) & RAD_LD_MASK) >> 8) & radios);
}

/**
 * @brief Control transmit gain in software/hardware.
 *
 * Enable or disable transmit VGA Gain programming using software. If in software, TxVGAGainControl 
 * must be used to set gain value. If not, then the transmit state machine must be setup to use
 * gain values.
 *
 * @see WarpRadio_v1_TxVGAGainControl, WarpRadio_v1_setTxGainTiming
 * @param mode 0: Transmit VGA Gain programmed with external ports, 1: Transmit VGA Gain programmed with TxVGAGainControl function
 * @param radios Radios affected.
 * @return Returns INVALID_MODE if the mode is an invalid input, WARP_SUCCESS if successful.
 */
char WarpRadio_v1_SoftwareTxGainControl(short mode, unsigned int radios) {

	if (mode == 0 | mode == 1) {
		RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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

/**
 * @brief Set the transmit baseband gain.
 *
 * Set the transmit baseband gain. Always set by software.
 * Gains:
 *		- 00: max baseband gain - 5db
 *		- 01: max baseband gain - 3db
 *		- 10: max baseband gain - 1.5db
 *		- 11: max baseband gain
 * 
 * @param value Value from the above list corresponding to the gain needed.
 * @param radios The radios affected.
 */
void WarpRadio_v1_BaseBandTxGain(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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

/**
 * @brief Adjust total transmit gain.
 *
 * This function adjusts the total transmit gain when using software control.
 * The 6 bits of this function map to B6:B1 of the gain bus. 000000 is the lowest possible gain.
 *
 * @see WarpRadio_v1_SoftwareTxGainControl
 * @param value Gain value, 6 bits wide.
 * @param radios Radios affected.
 */
void WarpRadio_v1_TxVGAGainControl(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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


/**
 * @brief Control recieve gain in software/hardware.
 *
 * Enable or disable receive VGA/LNA Gain programming using software. If in software, RxVGAGainControl
 * and RxLNAGainControl must be used to set gain value.
 *
 * @see WarpRadio_v1_RxVGAGainControl, WarpRadio_v1_RxLNAGainControl
 * @param mode 0: Receive VGA/LNA Gain programmed with external ports, 1: programmed with functions mentioned above
 * @param radios Radios affected.
 * @return Returns INVALID_MODE if the mode is an invalid input, WARP_SUCCESS if successful.
 */
char WarpRadio_v1_SoftwareRxGainControl(short mode, unsigned int radios) {

	if (mode == 0 | mode == 1) {
		RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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


/**
 * @brief Adjust upper receive gain.
 *
 * This function combined with RxVGAGainControl adjusts the total recieve gain when using software
 * control. The 2 bits of this function map to B7:B6 of gain bus. 00 is the lowest possible gain.
 *
 * @see WarpRadio_v1_SoftwareRxGainControl, WarpRadio_v1_RxVGAGainControl
 * @param value Gain value, 2 bits wide.
 * @param radios Radios affected.
 */
void WarpRadio_v1_RxLNAGainControl(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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

/**
 * @brief Adjust lower receive gain.
 *
 * This function combined with RxLNAGainControl adjusts the total recieve gain when using software
 * control. The 5 bits of this function map to B5:B1 of gain bus. 00000 is the lowest possible gain.
 *
 * @see WarpRadio_v1_SoftwareRxGainControl, WarpRadio_v1_RxLNAGainControl
 * @param value Gain value, 5 bits wide.
 * @param radios Radios affected.
 */
void WarpRadio_v1_RxVGAGainControl(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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


/**
 * @brief Setup timing parameters for the transmit state machine.
 *
 * The transmit state machine gets triggered by the TxEnable function. When called, there is a delay
 * in turning on the TxEnable pin, the trigger for data transmission, the amplifier and the gain ramp
 * cycle (parameters set by WarpRadio_v1_SetTxGainTiming). All these paramenters are setup here.
 * For the gain parameters to be valid, must be in hardware gain control. Atleast one amplifier
 * must be enabled for the power amp enable to work.
 *
 * @see WarpRadio_v1_SetTxGainTiming
 * @param radios Radios affected by these settings.
 * @param dly_TxEn OPB clock cycles to wait before turning on transmit enable. dly_TxEn=0 enables TxEn forever; dly_TxEn=255 disables TxEn forever
 * @param dly_TxStart OPB clock cycles to wait before sending enabling data transmission model. dly_TxStart=0 enables TxStart forever; dly_TxStart=255 disables TxStart forever
 * @param dly_GainRampEn OPB clock cycles to wait before turning on gain ramp cycle. dly_GainRampEn=255 disables the gain ramp
 * @param dly_PowerAmpEn OPB clock cycles to wait before turning on amplifier.  dly_PowerAmpEn=0 enables PowerAmpEn forever; dly_PowerAmpEn=255 disables PowerAmpEn forever
 */
void WarpRadio_v1_SetTxTiming(unsigned int radios, unsigned char dly_TxEn, unsigned char dly_TxStart, unsigned char dly_GainRampEn, unsigned char dly_PowerAmpEn) {

	//GainRampEn - slv_reg_N[0:7]
	//PowerAmpEn - slv_reg_N[8:15]
	//TxEn - slv_reg_N[16:23]
	//TxStart - slv_reg_N[24:31]

	if(((SLAVEMASK & radios) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg13((volatile)radio_controller_baseaddr,(unsigned int)( (dly_GainRampEn << 24) + (dly_PowerAmpEn << 16) + (dly_TxEn << 8) + dly_TxStart ));
	}
	if(((SLAVEMASK & radios) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg14((volatile)radio_controller_baseaddr,(unsigned int)( (dly_GainRampEn << 24) + (dly_PowerAmpEn << 16) + (dly_TxEn << 8) + dly_TxStart ));
	}
	if(((SLAVEMASK & radios) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg15((volatile)radio_controller_baseaddr,(unsigned int)( (dly_GainRampEn << 24) + (dly_PowerAmpEn << 16) + (dly_TxEn << 8) + dly_TxStart ));
	}
	if(((SLAVEMASK & radios) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg16((volatile)radio_controller_baseaddr,(unsigned int)( (dly_GainRampEn << 24) + (dly_PowerAmpEn << 16) + (dly_TxEn << 8) + dly_TxStart ));
	}

	return;
}

/**
 * @brief Setup gain parameters for transmit state machine.
 *
 * The gain parameters are used when the gain ramp is triggered by WarpRadio_v1_SetTxTiming.
 * The gain ramping is automatic and for it to be valid, the gain settings for transmit must be
 * in hardware control as the ramping is done using the gain bus.
 *
 * @see WarpRadio_v1_SetTxTiming, WarpRadio_v1_SoftwareTxGainControl
 * @param radios Radios affected by these settings.
 * @param TxGainTarget Target transmit gain, x0 to x3F
 * @param TxGainStep Step with which to ramp to required gain
 * @param TxGainTimeStep Time paused on each gain step
 */
void WarpRadio_v1_SetTxGainTiming(unsigned int radios, unsigned char TxGainTarget, unsigned char TxGainStep, unsigned char TxGainTimeStep) {

	//TxGainTarget is a 6-bit value in the MSB of the register (slv_reg_N[0:5])
	//TxGainStep is a 4-bit value (slv_reg_N[6:9])
	//TxGainTimeStep is a 4-bit value (slv_reg_N[10:13])

	if(((SLAVEMASK & radios) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg9((volatile)radio_controller_baseaddr,(unsigned int)( ((0x3f & TxGainTarget) << 26) | ((0xf & TxGainStep) << 22) | ((0xf & TxGainTimeStep) << 18)));
	}
	if(((SLAVEMASK & radios) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg10((volatile)radio_controller_baseaddr,(unsigned int)( ((0x3f & TxGainTarget) << 26) | ((0xf & TxGainStep) << 22) | ((0xf & TxGainTimeStep) << 18)));
	}
	if(((SLAVEMASK & radios) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg11((volatile)radio_controller_baseaddr,(unsigned int)( ((0x3f & TxGainTarget) << 26) | ((0xf & TxGainStep) << 22) | ((0xf & TxGainTimeStep) << 18)));
	}
	if(((SLAVEMASK & radios) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg12((volatile)radio_controller_baseaddr,(unsigned int)( ((0x3f & TxGainTarget) << 26) | ((0xf & TxGainStep) << 22) | ((0xf & TxGainTimeStep) << 18)));
	}

	return;
}

/**
 * @brief Set lowpass filter corner frequency on transmit (coarse adjustment).
 *
 * Set the Transmit Lowpass Filter Corner Frequency. This is the Coarse adjustment.
 * The values are chosen from the following list:
 *		- 0: undefined
 *		- 1: 12MHz (nominal mode)
 *		- 2: 18MHz (turbo mode 1)
 *		- 3: 24MHz (turbo mode 2)
 *
 * @param value Chosed from the above list.
 * @param radios Radios affected.
 * @return Returns OUT_OF_RANGE if value is out of range, WARP_SUCCESS if successful.
 */
void WarpRadio_v1_TxLpfCornFreqCoarseAdj(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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

/**
 * @brief Set lowpass filter corner frequency on receive (coarse adjustment).
 *
 * Set the Recieve Lowpass Filter Corner Frequency. This is the Coarse adjustment.
 * The values are chosen from the following list:
 *		- 0: 7.5MHz
 *		- 1: 9.5MHz (nominal mode)
 *		- 2: 14MHz (turbo mode 1)
 *		- 3: 18MHz (turbo mode 2)
 *
 * @param value Chosed from the above list.
 * @param radios Radios affected.
 * @return Returns OUT_OF_RANGE if value is out of range, WARP_SUCCESS if successful.
 */
void WarpRadio_v1_RxLpfCornFreqCoarseAdj(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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

/**
 * @brief Set lowpass filter corner frequency on receive (fine adjustment).
 *
 * Set the Recieve Lowpass Filter Corner Frequency. This is the Fine adjustment.
 * The values are chosen from the following list:
 *		- 000: 90%
 *		- 001: 95%
 *		- 010: 100%
 *		- 011: 105%
 *		- 100: 110%
 *		- 101-111: not applicable
 *
 * @param value Chosed from the above list.
 * @param radios Radios affected.
 * @return Returns OUT_OF_RANGE if value is out of range, WARP_SUCCESS if successful.
 */
char WarpRadio_v1_RxLpfCornFreqFineAdj(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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


/**
 * @brief Set corner frequency for receive high pass filter.
 *
 * Set the Recieve Highpass Filter Corner Frequency when RXHP=0.
 *
 * @param value 0: 100Hz, 1: 30kHz
 * @param radios Radios affected by function.
 */
void WarpRadio_v1_RxHighPassCornerFreq(char value, unsigned int radios) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)radio_controller_baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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

/**
 * @brief Read instantaneous RSSI.
 * 
 * Reads the RSSI values for a single radio only.
 *
 * @param radios Radio from to read data.
 * @return RSSI data
 */
unsigned int WarpRadio_v1_RSSIData(unsigned int radios) {
	
	unsigned int rssi = 0;

	if(radios & RAD1MASK)
		rssi = RADIO_CONTROLLER_mReadSlaveReg3((volatile)radio_controller_baseaddr) & 0x3FF;

	else if(radios & RAD2MASK)
		rssi = (RADIO_CONTROLLER_mReadSlaveReg3((volatile)radio_controller_baseaddr) & 0x3FF0000)>>16;

	else if(radios & RAD3MASK)
		rssi = RADIO_CONTROLLER_mReadSlaveReg4((volatile)radio_controller_baseaddr) & 0x3FF;

	else if(radios & RAD4MASK)
		rssi = (RADIO_CONTROLLER_mReadSlaveReg4((volatile)radio_controller_baseaddr) & 0x3FF0000)>>16;

	return rssi;
}

