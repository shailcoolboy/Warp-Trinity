/* Copyright (c) 2006 Rice University */
/* All Rights Reserved */
/* This code is covered by the Rice-WARP license */
/* See http://warp.rice.edu/license/ for details */

//////////////////////////////////////////////////////////////////////////////
// Filename:          drivers/radio_controller_v1_03_a/src/radio_controller.c
// Version:           1.03.a
// Description:       radio_controller Driver Source File
// Date:              Sat Apr 15 16:16:29 2006 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////

// In the entire library 'baseaddr' would refer to the base address of the Radio Controller peripheral.
// This library is made to work with Radio Controller v1.03.a
//
// slv_reg7 is the transmit register where the value to be transmitted is to be stored.
// The last 4 bits of the transmitted value should be the register that needs to be set while
// the first 14 bits are the numbers that need to be set in that register.
// slv_reg4 is the Control Register. 0x00003412 is the startup value to be set for the system.
// 0x00003512 lets the core know to transmit the value in the transmit register.
// slv_reg5 is the Divider Register. The startup value that needs to be set is 0x00000000.
// slv_reg6 is the Slave Select Register. This decides which of the radios recieve the transmitted
// value. Daughtercard slot 1 is 0x00000001. Slot 2 is 0x00000002. Slot 3 is 0x00000004.
// Slot 4 is 0x00000008. Multiple slots can also be selected at the same time.



/***************************** Include Files *******************************/

#include "radio_controller.h"
#include "math.h"


/*************************** Radio Library ****************************/

/*********Static Copies of Registers in MAX2829******/

// Local copies of all the registers in the Radio. Are updated everytime a register value in the Radio is
// changed.

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
unsigned short REG_RAD1_TX_LINEARITY = 0x0200;
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
unsigned short REG_RAD2_TX_LINEARITY = 0x0200;
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
unsigned short REG_RAD3_TX_LINEARITY = 0x0200;
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
unsigned short REG_RAD4_TX_LINEARITY = 0x0200;
unsigned short REG_RAD4_PA_BIAS_DAC = 0x03C0;
unsigned short REG_RAD4_RX_GAIN = 0x007F;
unsigned short REG_RAD4_TX_VGA_GAIN = 0x0000;

/******************* Masks **************************/

#define RAD1MASK 0x0001
#define RAD2MASK 0x0002
#define RAD3MASK 0x0004
#define RAD4MASK 0x0008
#define SLAVEMASK 0x000F


/******************** Functions *********************/


// Function used to send values to the radio. Waits until the controller is still in transmit mode
// before it continues to return to where it was called.
// Slave Select needs to be set to the right values before this function can be called.
// 'val' is the value that needs to be set. This value must include the register number as well.

void transmit(unsigned int* baseaddr, int val) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, val);					// Set the transmit register to the value that should be transmitted.

	RADIO_CONTROLLER_mWriteSlaveReg4((volatile)baseaddr, 0x3512);					// Sets the GO_BSY to high so it starts transmitting.

	while(RADIO_CONTROLLER_mReadSlaveReg4((volatile)baseaddr) == 0x3512) {		// Wait for the controller to finish transmitting.
	}

}


// Function used to send values to radio. Uses the previous function to send but the slave
// select can also be set to send to the correct radios. 'ssval' is the value to be written to the
// Slave Select Register. 'val' is the value to be sent to the radio. Must include the register number in it.

void transRadio(unsigned int* baseaddr, int ssval, unsigned int val) {

	unsigned int temp = RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr);		// Store the current value of the Slave Select. Needed as this function is
																		// used when calling the function for a single radio but still using more
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, ssval);					// Set the Slave Select to the new value.
	transmit((volatile)baseaddr, val);											// Transmit the new value
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, temp);					// Return the Slave Select to its initial value.

}

// Initialize the SPI controller to the configurations required for Radios. Before any readio functions are called
// this function must be called to initilize the SPI. If DAC functions need to be used in the middle call the WarpDac_InitializeSPI
// to set up the controller to transmit DAC values. One can switch between the DAC and the radios as long the respective
// InitializeSPI functions are called before use.
// Sets the MAX2829 control register and divider register.
// Does not have a return value
void WarpRadio_InitializeSPI(unsigned int* baseaddr) {

	RADIO_CONTROLLER_mWriteSlaveReg4((volatile)baseaddr, 0x3412);			// Set the value of the Control Register to 0x00003412.

	RADIO_CONTROLLER_mWriteSlaveReg5((volatile)baseaddr, 0x00000000);		// Set the value for the Divider Register to 0x00000000.
}

// This function initializes the selected radios. Some register values need to be changed from the default
// and those changes are applied in this function. 'radios' is the value that is applied to the Slave Select Register.
// This function must be called at the start of the program and needs to be called only once.
void WarpRadio_InitializeRadio(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));		// Select the radios that will be affected by this function call in store in Slave Select

	transmit((volatile)baseaddr, 0x0C218);	// Set value of 0x0C00 to register 8 in the radio
	transmit((volatile)baseaddr, 0x18225);	// Set value of 0x1822 to register 5 in the radios that are defined by
	/// **** to shift to a 40MHz clock use next line instead of previous line, also change in if statements below
	//transmit((volatile)baseaddr, 0x18245);

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {						// Make sure that radio 1 is to be used.
		REG_RAD1_RX_CONTROL = (short)0x0C21;						// Update local copies of the registers in the radio
		REG_RAD1_BAND_SELECT = (short)0x1822;
		//REG_RAD1_BAND_SELECT = (short)0x1824;
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | 0x00000090)); // Set Antsw0 to 1 and RXHP software control on
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFF7DFF)); // Turn off the Sleep for RSSI and DCS goes to 0
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {						// Make sure that radio 2 is to be used.
		REG_RAD2_RX_CONTROL = (short)0x0C21;						// Update local copies of the registers in the radio
		REG_RAD2_BAND_SELECT = (short)0x1822;
		//REG_RAD2_BAND_SELECT = (short)0x1824;
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | 0x00000090)); // Set Antsw0 to 1 and RXHP software control on
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFF7DFF)); // Turn off the Sleep for RSSI and DCS goes to 0
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {						// Make sure that radio 3 is to be used.
		REG_RAD3_RX_CONTROL = (short)0x0C21;						// Update local copies of the registers in the radio
		REG_RAD3_BAND_SELECT = (short)0x1822;
		//REG_RAD3_BAND_SELECT = (short)0x1824;
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | 0x00000090)); // Set Antsw0 to 1 and RXHP software control on
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFF7DFF)); // Turn off the Sleep for RSSI and DCS goes to 0
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {						// Make sure that radio 4 is to be used.
		REG_RAD4_RX_CONTROL = (short)0x0C21;						// Update local copies of the registers in the radio
		REG_RAD4_BAND_SELECT = (short)0x1822;
		//REG_RAD4_BAND_SELECT = (short)0x1824;
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) | 0x00000090)); // Set Antsw0 to 1 and RXHP software control on
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFF7DFF)); // Turn off the Sleep for RSSI and DCS goes to 0
	}
}

// Enables the recieve mode in the radio board. On calling this function the transmit mode is forcibly turned off.
// Also makes sure that the amplifiers are off. 'radios' refers to the Radios in the slots that will have their recieve
// mode turned on.
void WarpRadio_RxEnable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFEB9)); // Disable Rx and Tx, set antsw[0]=0 //FF79
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | 0x00000088)); // Disable SHDN and amplifiers, set antsw[1]=1 //0179
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | 0x00000004));	// Turn on the recieve enable mode
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFEB9)); // Disable Rx and Tx, set antsw[0]=0 //FF79
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | 0x00000088)); // Disable SHDN and amplifiers, set antsw[1]=1 //0179
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | 0x00000004));	// Turn on the recieve enable mode
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFEB9)); // Disable Rx and Tx, set antsw[0]=0 //FF79
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | 0x00000088)); // Disable SHDN and amplifiers, set antsw[1]=1 //0179
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | 0x00000004));	// Turn on the recieve enable mode
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFEB9)); // Disable Rx and Tx, set antsw[0]=0 //FF79
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) | 0x00000088)); // Disable SHDN and amplifiers, set antsw[1]=1 //0179
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) | 0x00000004));	// Turn on the recieve enable mode
	}
}

// Disables the receive mode in the radios specified. 'radios' refers to the Radios in the slots whose recieve mode will be turned
// off.
void WarpRadio_RxDisable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFFFB)); // Turn off receive enable bit
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFFFB)); // Turn off receive enable bit
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFFFB)); // Turn off receive enable bit
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFFFB)); // Turn off receive enable bit
	}

}

// Enable the radio's 2.4 GHz amp
void WarpRadio_24AmpEnable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | 0x00000020)); // Turn on 2.4GHz amp
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | 0x00000020)); // Turn on 2.4GHz amp
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | 0x00000020)); // Turn on 2.4GHz amp
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) | 0x00000020)); // Turn on 2.4GHz amp
	}

}

// Disable the radio's 2.4 GHz amp
void WarpRadio_24AmpDisable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFFDF)); // Turn off 2.4GHz amp
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFFDF)); // Turn off 2.4GHz amp
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFFDF)); // Turn off 2.4GHz amp
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFFDF)); // Turn off 2.4GHz amp
	}

}

// Enable the radio's 5 GHz amp
void WarpRadio_5AmpEnable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | 0x00000040)); // Turn on 5GHz amp
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | 0x00000040)); // Turn on 5GHz amp
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | 0x00000040)); // Turn on 5GHz amp
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) | 0x00000040)); // Turn on 5GHz amp
	}

}

// Disable the radio's 5 GHz amp
void WarpRadio_5AmpDisable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFFBF)); // Turn off 2.4GHz amp
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFFBF)); // Turn off 2.4GHz amp
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFFBF)); // Turn off 2.4GHz amp
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFFBF)); // Turn off 2.4GHz amp
	}

}


// Enables the transmit enable mode on the Radios specified. Also turns on the 2.4Ghz amplifier currently.
// Forcibly turns off the recieve enable mode. 'radios' refers to the Radios in the slots whose transmit mode is turned on.
void WarpRadio_TxEnable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFE79)); // Disable Rx, set ant switch[1]=0
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | 0x0000010A)); // 162 Turn on transmit mode, and antsw[0]
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFE79)); // Disable Rx, set ant switch[1]=0
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | 0x0000010A)); // Turn on transmit mode, and antsw[0]
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFE79)); // Disable Rx, set ant switch[1]=0
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | 0x0000010A)); // Turn on transmit mode, and antsw[0]
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFE79)); // Disable Rx, set ant switch[1]=0
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) | 0x0000010A)); // Turn on transmit mode, and antsw[0]
	}

}


// Disables the transmit mode on the Radios specified. Both amplifiers are also turned off.
// 'radios' refers to the Radios in the slots whose transmit mode is turned off.
void WarpRadio_TxDisable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFFFD)); // Turn off transmit mode
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFFFD)); // Turn off transmit mode
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFFFD)); // Turn off transmit mode
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFFFD)); // Turn off transmit mode
	}

}


// This function shuts down the radios specified. Forcibly turns off transmit and recieve modes
// 'radios' refers to the Radios in the slots that will be shut down.
void WarpRadio_SHDNEnable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFFF9)); // Turn off recieve and transmit modes
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | 0x00000001)); // Assert shutdown enable
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFFF9)); // Turn off recieve and transmit modes
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | 0x00000001)); // Turn off shutdown enable
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFFF9)); // Turn off recieve and transmit modes
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | 0x00000001)); // Turn off shutdown enable
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFFF9)); // Turn off recieve and transmit modes
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) | 0x00000001)); // Turn off shutdown enable
	}
}

// Takes the specified radios out of shutdown mode. The transmit and recieve modes are still disabled. 'radios' refers
// to the the Radios in the slots affected by this function. Behaves the same as the previous function.
void WarpRadio_SHDNDisable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFFFE)); //De-assert SHDN
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFFFE)); //De-assert SHDN
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFFFE)); //De-assert SHDN
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFFFE)); //De-assert SHDN
	}

}

// Reset the radio board registers that are specified in 'radios'. Goes through a set of instructions to achieve a reset of
// the radios. Behaves similar to previous function.
void WarpRadio_Reset(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFFF9)); // Turn off TxEnable and RxEnable
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | 0x00000001)); // Assert Shutdown
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | 0x00000006)); // Turn on TxEnable and RxEnable
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFFF9)); // Turn off TxEnable and RxEnable
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFFFE)); // De-assert shutdown
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFFF9)); // Turn off TxEnable and RxEnable
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | 0x00000001)); // Assert Shutdown
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | 0x00000006)); // Turn on TxEnable and RxEnable
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFFF9)); // Turn off TxEnable and RxEnable
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFFFE)); // De-assert shutdown
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFFF9)); // Turn off TxEnable and RxEnable
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | 0x00000001)); // Assert Shutdown
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | 0x00000006)); // Turn on TxEnable and RxEnable
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFFF9)); // Turn off TxEnable and RxEnable
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFFFE)); // De-assert shutdown
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFFF9)); // Turn off TxEnable and RxEnable
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) | 0x00000001)); // Assert Shutdown
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) | 0x00000006)); // Turn on TxEnable and RxEnable
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFFF9)); // Turn off TxEnable and RxEnable
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFFFE)); // De-assert shutdown
	}

}

// Enable RxHP software control. In this situation the RxHPEnable and Disable functions control the RxHP pin
void WarpRadio_RxHp_Soft_Control_Enable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | 0x00000010)); // 162 Turn on transmit mode, and antsw[0]
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | 0x00000010)); // Turn on transmit mode, and antsw[0]
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | 0x00000010)); // Turn on transmit mode, and antsw[0]
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) | 0x00000010)); // Turn on transmit mode, and antsw[0]
	}

}

// Disable RxHP software control. In this situation the RxHP pin is controlled by the RxHP external port on the radio_controller
void WarpRadio_RxHp_Soft_Control_Disable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFFEF)); // 162 Turn on transmit mode, and antsw[0]
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFFEF)); // Turn on transmit mode, and antsw[0]
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFFEF)); // Turn on transmit mode, and antsw[0]
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFFEF)); // Turn on transmit mode, and antsw[0]
	}

}


// Enable the RXHP bit in the 'radios' specified.
// Behaves similar to previous functions.
void WarpRadio_RxHpEnable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) | 0x00000008));
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) | 0x00000008));
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) | 0x00000008));
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) | 0x00000008));
	}

}

// Disable the RXHP bit in the 'radios' specified.
// Behaves similar to previous functions.
void WarpRadio_RxHpDisable(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFFFFFF7));
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFFFFFF7));
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFFFFFF7));
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFFFFFF7));
	}

}

// Function used to shift the center frequency on the Radio within the 2.4GHz band.
// 'freqset' defines which frequency to shift to.
//		1: 2412MHz
//		2: 2417MHz
//		3: 2422MHz
//		4: 2427MHz
//		5: 2432MHz
//		6: 2437MHz
//		7: 2442MHz
//		8: 2447MHz
//		9: 2452MHz
//		10: 2457MHz
//		11: 2462MHz
//		12: 2467MHz
//		13: 2472MHz
//		14: 2484MHz
// 'radios' defines which radios are affected by this function call.
// Returns INVALID_FREQ if given frequency set is not valid.
int WarpRadio_SetCenterFreq2GHz(unsigned int* baseaddr, char freqset, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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

		transmit((volatile)baseaddr, reg3);			// Transmit the new register 3 value
		transmit((volatile)baseaddr, reg4);			// Transmit the new register 4 value

		reg3 = reg3>>4;						// Bit shift the register values to the right and remove the register number from the
		reg4 = reg4>>4;						// value.

		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {	// Check if the Slave is in use

			reg5 = REG_RAD1_BAND_SELECT & mask2g;					// Pick up local copy of the register and set the band to 2.4Ghz

			transRadio((volatile)baseaddr, 0x0001, ((reg5<<4)+0x0005));		// Transmit new register 5 value and add the register number as last 4 bits

			REG_RAD1_BAND_SELECT = (short)reg5;						// Set local copies of registers to new values.
			REG_RAD1_INTEGER_DIVIDER_RATIO = (short)reg3;
			REG_RAD1_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {	// Check if the Slave is in use

			reg5 = REG_RAD2_BAND_SELECT & mask2g;					// Pick up local copy of the register and set the band to 2.4Ghz

			transRadio((volatile)baseaddr, 0x0002, ((reg5<<4)+0x0005));		// Transmit new register 5 value and add the register number as last 4 bits

			REG_RAD2_BAND_SELECT = (short)reg5;						// Set local copies of registers to new values.
			REG_RAD2_INTEGER_DIVIDER_RATIO = (short)reg3;
			REG_RAD2_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {	// Check if the Slave is in use

			reg5 = REG_RAD3_BAND_SELECT & mask2g;					// Pick up local copy of the register and set the band to 2.4Ghz

			transRadio((volatile)baseaddr, 0x0004, ((reg5<<4)+0x0005));		// Transmit new register 5 value and add the register number as last 4 bits

			REG_RAD3_BAND_SELECT = (short)reg5;						// Set local copies of registers to new values.
			REG_RAD3_INTEGER_DIVIDER_RATIO = (short)reg3;
			REG_RAD3_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {	// Check if the Slave is in use

			reg5 = REG_RAD4_BAND_SELECT & mask2g;					// Pick up local copy of the register and set the band to 2.4Ghz

			transRadio((volatile)baseaddr, 0x0008, ((reg5<<4)+0x0005));		// Transmit new register 5 value and add the register number as last 4 bits

			REG_RAD4_BAND_SELECT = (short)reg5;						// Set local copies of registers to new values.
			REG_RAD4_INTEGER_DIVIDER_RATIO = (short)reg3;
			REG_RAD4_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
		}
	}

	return retval;		// Return either the new freqency that has been set or return -1 to indicate that the frequency set given was invalid
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
int WarpRadio_SetCenterFreq5GHz(unsigned int* baseaddr, char freqset, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

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

		transmit((volatile)baseaddr, reg3);			// Transmit register 3 value
		transmit((volatile)baseaddr, reg4);			// Transmit register 4 value

		reg3 = reg3>>4;
		reg4 = reg4>>4;

		if (band5 == 1) {									// Check if the freqency is in the lower 5GHz band
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD1_BAND_SELECT | mask5gl1;							// Set the band in register 5 to 5GHz
				reg5 = reg5 & mask5gl2;											// Set the band range in the register 5 to the lower 5GHz band

				transRadio((volatile)baseaddr, 0x0001, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio((volatile)baseaddr, 0x0001, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio((volatile)baseaddr, 0x0001, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD1_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD1_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD1_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD2_BAND_SELECT | mask5gl1;							// Set the band in register 5 to 5GHz
				reg5 = reg5 & mask5gl2;											// Set the band range in the register 5 to the lower 5GHz band

				transRadio((volatile)baseaddr, 0x0002, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio((volatile)baseaddr, 0x0002, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio((volatile)baseaddr, 0x0002, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD2_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD2_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD2_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD3_BAND_SELECT | mask5gl1;							// Set the band in register 5 to 5GHz
				reg5 = reg5 & mask5gl2;											// Set the band range in the register 5 to the lower 5GHz band

				transRadio((volatile)baseaddr, 0x0004, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio((volatile)baseaddr, 0x0004, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio((volatile)baseaddr, 0x0004, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD3_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD3_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD3_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD4_BAND_SELECT | mask5gl1;							// Set the band in register 5 to 5GHz
				reg5 = reg5 & mask5gl2;											// Set the band range in the register 5 to the lower 5GHz band

				transRadio((volatile)baseaddr, 0x0008, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio((volatile)baseaddr, 0x0008, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio((volatile)baseaddr, 0x0008, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD4_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD4_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD4_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
		}

		if (band5 == 2) {									// Check if the freqency is in the upper 5GHz band
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD1_BAND_SELECT | mask5gh;							// Set the band in register 5 to 5GHz and upper 5GHz band

				transRadio((volatile)baseaddr, 0x0001, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio((volatile)baseaddr, 0x0001, (((reg5 | 0x0080)<<4)+0x0002));	// Start auto band switch to the new value.
				transRadio((volatile)baseaddr, 0x0001, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD1_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD1_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD1_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD2_BAND_SELECT | mask5gh;							// Set the band in register 5 to 5GHz and upper 5GHz band

				transRadio((volatile)baseaddr, 0x0002, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio((volatile)baseaddr, 0x0002, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio((volatile)baseaddr, 0x0002, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD2_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD2_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD2_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD3_BAND_SELECT | mask5gh;							// Set the band in register 5 to 5GHz and upper 5GHz band

				transRadio((volatile)baseaddr, 0x0004, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio((volatile)baseaddr, 0x0004, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio((volatile)baseaddr, 0x0004, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD3_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD3_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD3_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {	// Check if the Slave is in use

				reg5 = REG_RAD4_BAND_SELECT | mask5gh;							// Set the band in register 5 to 5GHz and upper 5GHz band

				transRadio((volatile)baseaddr, 0x0008, ((reg5<<4)+0x0005));				// Set the register 5 value
				transRadio((volatile)baseaddr, 0x0008, (((reg5 | 0x0080)<<4)+0x0005));	// Start auto band switch to the new value.
				transRadio((volatile)baseaddr, 0x0008, ((reg5<<4)+0x0005));				// Restore the value of register 5

				REG_RAD4_BAND_SELECT = (short)reg5;								// Store new values to the local copies
				REG_RAD4_INTEGER_DIVIDER_RATIO = (short)reg3;
				REG_RAD4_FRACTIONAL_DIVIDER_RATIO = (short)reg4;
			}
		}
	}
	return retval;		// Return either the new freqency that has been set or return -1 to indicate that the frequency set given was invalid
}

// Put the radio into transmit calibration mode. 'radios' refers to the radios that will be put into
// calibration. Forcibly removed from receive calibration mode.
void WarpRadio_TxCalibration(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned int calreg = 0x04026;					// Set the bit in register 6 to enable TX calibration mode

	transmit((volatile)baseaddr, calreg);						// Transmit the new value

	calreg = calreg>>4;								// Bit shift to the right to remove register number

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		REG_RAD1_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		REG_RAD2_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		REG_RAD3_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		REG_RAD4_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
}

// Put the radio into receive calibration mode. 'radios' refers to the radios that will be put into
// calibration. Forcibly removed from receive calibration mode.
void WarpRadio_RxCalibration(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned calreg = 0x1C016;					// Set the bit in register 6 to enable RX calibration mode
												// and set the Gain control bits to 34db

	transmit((volatile)baseaddr, calreg);					// Transmit the new value

	calreg = calreg>>4;							// Bit shift to the right to remove register number

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		REG_RAD1_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		REG_RAD2_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		REG_RAD3_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		REG_RAD4_CALIBRATION = (short)calreg;		// Depending on if the radio is used, store the value to the local copies
	}
}

// Takes the specified radios out of transmit and recieve calibration mode. 'radios' refers the Radios in the
// slots that will be affected. This function works exactly the same way as the function above.
void WarpRadio_NoCalibration(unsigned int* baseaddr, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned calreg = 0x1C006;

	transmit((volatile)baseaddr, calreg);

	calreg = calreg>>4;

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		REG_RAD1_CALIBRATION = (short)calreg;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		REG_RAD2_CALIBRATION = (short)calreg;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		REG_RAD3_CALIBRATION = (short)calreg;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
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
char WarpRadio_TxCalGain(unsigned int* baseaddr, char gain, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned int mask = 0x0002;							// Mask to check if in transmit calibration mode.

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		if ((REG_RAD1_CALIBRATION & mask) == 0x0) {		// If the transmit calibration bit is 0 then return NOT_IN_CALIBRATION
			return NOT_IN_CALIBRATION;
		}
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		if ((REG_RAD2_CALIBRATION & mask) == 0x0) {		// If the transmit calibration bit is 0 then return NOT_IN_CALIBRATION
			return NOT_IN_CALIBRATION;
		}
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		if ((REG_RAD3_CALIBRATION & mask) == 0x0) {		// If the transmit calibration bit is 0 then return NOT_IN_CALIBRATION
			return NOT_IN_CALIBRATION;
		}
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
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

	transmit((volatile)baseaddr, calreg);					// Transmit the value for the Calibration Register and store the values in the local
												// copies.
	calreg = calreg>>4;

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		REG_RAD1_CALIBRATION = (short)calreg;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		REG_RAD2_CALIBRATION = (short)calreg;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		REG_RAD3_CALIBRATION = (short)calreg;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		REG_RAD4_CALIBRATION = (short)calreg;
	}

	return WARP_SUCCESS;
}

// Enable or disable the Rx baseband section of the reciever. Mode = 0 disables the value while mode = 1
// enables the value. Returns INVALID_MODE if the mode is invalid. Returns WARP_SUCCESS if successfully manage
// to change the value.
char WarpRadio_TxCalRxEnable(unsigned int* baseaddr, char mode, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

		unsigned int modeon = 0x0040;
		unsigned int modeoff = 0xFFBF;

		if (mode == 0) {
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
				unsigned int reg2 = REG_RAD1_STANDBY & modeoff;			// Set the required bit to 0

				transRadio((volatile)baseaddr, 0x0001, ((reg2<<4)+0x0002));		// Transmit the value and store to the local copy

				REG_RAD1_STANDBY = (short)reg2;
			}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
				unsigned int reg2 = REG_RAD2_STANDBY & modeoff;

				transRadio((volatile)baseaddr, 0x0002, ((reg2<<4)+0x0002));

				REG_RAD2_STANDBY = (short)reg2;
			}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
				unsigned int reg2 = REG_RAD3_STANDBY & modeoff;

				transRadio((volatile)baseaddr, 0x0004, ((reg2<<4)+0x0002));

				REG_RAD3_STANDBY = (short)reg2;
			}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
				unsigned int reg2 = REG_RAD4_STANDBY & modeoff;

				transRadio((volatile)baseaddr, 0x0008, ((reg2<<4)+0x0002));

				REG_RAD4_STANDBY = (short)reg2;
			}
		}
		else if (mode == 1) {
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
				unsigned int reg2 = REG_RAD1_STANDBY | modeon;			// Set the required bit to 1.

				transRadio((volatile)baseaddr, 0x0001, ((reg2<<4)+0x0002));		// Transmit the value and store to the local copy

				REG_RAD1_STANDBY = (short)reg2;
			}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
				unsigned int reg2 = REG_RAD2_STANDBY | modeon;

				//transRadio((volatile)baseaddr, 0x0002, ((reg2<<4)+0x0002));
				transmit((volatile)baseaddr, ((reg2<<4)|0x0002));
				REG_RAD2_STANDBY = (short)reg2;
			}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
				unsigned int reg2 = REG_RAD3_STANDBY | modeon;

				transRadio((volatile)baseaddr, 0x0004, ((reg2<<4)+0x0002));

				REG_RAD3_STANDBY = (short)reg2;
			}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
				unsigned int reg2 = REG_RAD4_STANDBY | modeon;

				transRadio((volatile)baseaddr, 0x0008, ((reg2<<4)+0x0002));

				REG_RAD4_STANDBY = (short)reg2;
			}
		}
		else {
			return INVALID_MODE;
		}
	return WARP_SUCCESS;
}

// Function enables or disables the MIMO mode for the specified 'radios'. 'mode' = 0 turns off MIMO mode while 'mode' = 1
// enables the MIMO mode. Returns INVALID_MODE if mode is wrong or returns WARP_SUCCESS if successful.
char WarpRadio_SetMimoMode(unsigned int* baseaddr, char mode, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned int modeon = 0x2000;
	unsigned int modeoff = 0xDFFF;

	if (mode == 0) {												// Check for disabling the MIMO mode

		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
			unsigned int reg5 = REG_RAD1_BAND_SELECT & modeoff;		// Disable the mode in Register 5 and transmit to radio

			transRadio((volatile)baseaddr, 0x0001, ((reg5<<4)+0x0005));

			unsigned int reg2 = REG_RAD1_STANDBY & modeoff;			// Disable the mode in Register 2 and transmit to radio

			transRadio((volatile)baseaddr, 0x0001, ((reg2<<4)+0x0002));

			REG_RAD1_BAND_SELECT = (short)reg5;						// Store changes to the local copies
			REG_RAD1_STANDBY = (short)reg2;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
			unsigned int reg5 = REG_RAD2_BAND_SELECT & modeoff;

			transRadio((volatile)baseaddr, 0x0002, ((reg5<<4)+0x0005));

			unsigned int reg2 = REG_RAD2_STANDBY & modeoff;

			transRadio((volatile)baseaddr, 0x0002, ((reg2<<4)+0x0002));

			REG_RAD2_BAND_SELECT = (short)reg5;
			REG_RAD2_STANDBY = (short)reg2;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
			unsigned int reg5 = REG_RAD3_BAND_SELECT & modeoff;

			transRadio((volatile)baseaddr, 0x0004, ((reg5<<4)+0x0005));

			unsigned int reg2 = REG_RAD3_STANDBY & modeoff;

			transRadio((volatile)baseaddr, 0x0004, ((reg2<<4)+0x0002));

			REG_RAD3_BAND_SELECT = (short)reg5;
			REG_RAD3_STANDBY = (short)reg2;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
			unsigned int reg5 = REG_RAD4_BAND_SELECT & modeoff;

			transRadio((volatile)baseaddr, 0x0008, ((reg5<<4)+0x0005));

			unsigned int reg2 = REG_RAD4_STANDBY & modeoff;

			transRadio((volatile)baseaddr, 0x0008, ((reg2<<4)+0x0002));

			REG_RAD4_BAND_SELECT = (short)reg5;
			REG_RAD4_STANDBY = (short)reg2;
		}

	}
	else if (mode == 1) {												// Check for enabling the MIMO mode

			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
			unsigned int reg5 = REG_RAD1_BAND_SELECT | modeon;			// Enable the mode in Register 5 and transmit to radio

			transRadio((volatile)baseaddr, 0x0001, ((reg5<<4)+0x0005));

			unsigned int reg2 = REG_RAD1_STANDBY | modeon;				// Enable the mode in Register 2 and transmit to radio

			transRadio((volatile)baseaddr, 0x0001, ((reg2<<4)+0x0002));

			REG_RAD1_BAND_SELECT = (short)reg5;							// Store changes to the local copies
			REG_RAD1_STANDBY = (short)reg2;
		}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
			unsigned int reg5 = REG_RAD2_BAND_SELECT | modeon;

			transRadio((volatile)baseaddr, 0x0002, ((reg5<<4)+0x0005));

			unsigned int reg2 = REG_RAD2_STANDBY | modeon;

			transRadio((volatile)baseaddr, 0x0002, ((reg2<<4)+0x0002));

			REG_RAD2_BAND_SELECT = (short)reg5;
			REG_RAD2_STANDBY = (short)reg2;
		}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
			unsigned int reg5 = REG_RAD3_BAND_SELECT | modeon;

			transRadio((volatile)baseaddr, 0x0004, ((reg5<<4)+0x0005));

			unsigned int reg2 = REG_RAD3_STANDBY | modeon;

			transRadio((volatile)baseaddr, 0x0004, ((reg2<<4)+0x0002));

			REG_RAD3_BAND_SELECT = (short)reg5;
			REG_RAD3_STANDBY = (short)reg2;
		}
			if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
			unsigned int reg5 = REG_RAD4_BAND_SELECT | modeon;

			transRadio((volatile)baseaddr, 0x0008, ((reg5<<4)+0x0005));

			unsigned int reg2 = REG_RAD4_STANDBY | modeon;

			transRadio((volatile)baseaddr, 0x0008, ((reg2<<4)+0x0002));

			REG_RAD4_BAND_SELECT = (short)reg5;
			REG_RAD4_STANDBY = (short)reg2;
		}


	}
	else {
		return INVALID_MODE;			// Return INVALID_MODE if the mode is neither 0 nor 1.
	}


	return WARP_SUCCESS;					// Return WARP_SUCCESS if mode is right and correctly switched.

}

// This function is to enable or disable the RSSI High Bandwidth for the 'radios' specified.
// 'mode'=0 disables the state and 'mode'=1 enables it. Function behaves the same as the above function.
char WarpRadio_RssiHighBandwidth(unsigned int* baseaddr, char mode, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	unsigned int modeon = 0x0800;
	unsigned int modeoff = 0xF7FF;

	if (mode == 0) {
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
			unsigned int reg7 = REG_RAD1_LOWPASS_FILTER & modeoff;

			transRadio((volatile)baseaddr, 0x0001, ((reg7<<4)+0x0007));

			REG_RAD1_LOWPASS_FILTER = (short)reg7;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
			unsigned int reg7 = REG_RAD2_LOWPASS_FILTER & modeoff;

			transRadio((volatile)baseaddr, 0x0002, ((reg7<<4)+0x0007));

			REG_RAD2_LOWPASS_FILTER = (short)reg7;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
			unsigned int reg7 = REG_RAD3_LOWPASS_FILTER & modeoff;

			transRadio((volatile)baseaddr, 0x0004, ((reg7<<4)+0x0007));

			REG_RAD3_LOWPASS_FILTER = (short)reg7;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
			unsigned int reg7 = REG_RAD4_LOWPASS_FILTER & modeoff;

			transRadio((volatile)baseaddr, 0x0008, ((reg7<<4)+0x0007));

			REG_RAD4_LOWPASS_FILTER = (short)reg7;
		}
	}
	else if (mode == 1) {
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
			unsigned int reg7 = REG_RAD1_LOWPASS_FILTER | modeon;

			transRadio((volatile)baseaddr, 0x0001, ((reg7<<4)+0x0007));

			REG_RAD1_LOWPASS_FILTER = (short)reg7;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
			unsigned int reg7 = REG_RAD2_LOWPASS_FILTER | modeon;

			transRadio((volatile)baseaddr, 0x0002, ((reg7<<4)+0x0007));

			REG_RAD2_LOWPASS_FILTER = (short)reg7;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
			unsigned int reg7 = REG_RAD3_LOWPASS_FILTER | modeon;

			transRadio((volatile)baseaddr, 0x0004, ((reg7<<4)+0x0007));

			REG_RAD3_LOWPASS_FILTER = (short)reg7;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
			unsigned int reg7 = REG_RAD4_LOWPASS_FILTER | modeon;

			transRadio((volatile)baseaddr, 0x0008, ((reg7<<4)+0x0007));

			REG_RAD4_LOWPASS_FILTER = (short)reg7;
		}
	}
	else {
		return INVALID_MODE;
	}
	return WARP_SUCCESS;
}

// Set the Transmit Low Pass Filter Corner Frequency. This is the Coarse adjustment for the frequency and affects
// the 'radios' specified.
// 'value':
//		00: undefined
//		01: 12MHz (nominal mode)
//		10: 18MHz (turbo mode 1)
//		11: 24MHz (turbo mode 2)
void WarpRadio_TxLpfCornFreqCoarseAdj(unsigned int* baseaddr, char value, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x0003;						// Pick the last 2 bits of the value provided.
	value = value << 5;							// Shift the bits to the right location.
	int mask = 0xFF9F;							// Mask to empty the value currently in the register.

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg7 = REG_RAD1_LOWPASS_FILTER & mask;		// Empty the two bits
		reg7 = reg7 + value;									// Put the new value in
		transRadio((volatile)baseaddr, 0x0001, ((reg7<<4)+0x0007));		// Transmit the new value

		REG_RAD1_LOWPASS_FILTER = (short)reg7;					// Store to the local copies
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg7 = REG_RAD2_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio((volatile)baseaddr, 0x0002, ((reg7<<4)+0x0007));

		REG_RAD2_LOWPASS_FILTER = (short)reg7;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg7 = REG_RAD3_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio((volatile)baseaddr, 0x0004, ((reg7<<4)+0x0007));

		REG_RAD3_LOWPASS_FILTER = (short)reg7;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg7 = REG_RAD4_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio((volatile)baseaddr, 0x0008, ((reg7<<4)+0x0007));

		REG_RAD4_LOWPASS_FILTER = (short)reg7;
	}

}

// Set the Recieve Lowpass Filter Corner Frequency. This is the Coarse adjustment and affects only the 'radios' specified
// 'value':
//		00: 7.5MHz
//		01: 9.5MHz (nominal mode)
//		10: 14MHz (turbo mode 1)
//		11: 18MHz (turbo mode 2)
// Function behaves the same as the same as the previous function.
void WarpRadio_RxLpfCornFreqCoarseAdj(unsigned int* baseaddr, char value, unsigned char radios) {
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x0003;
	value = value << 3;
	int mask = 0xFFE7;

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg7 = REG_RAD1_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio((volatile)baseaddr, 0x0001, ((reg7<<4)+0x0007));

		REG_RAD1_LOWPASS_FILTER = (short)reg7;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg7 = REG_RAD2_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio((volatile)baseaddr, 0x0002, ((reg7<<4)+0x0007));

		REG_RAD2_LOWPASS_FILTER = (short)reg7;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg7 = REG_RAD3_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio((volatile)baseaddr, 0x0004, ((reg7<<4)+0x0007));

		REG_RAD3_LOWPASS_FILTER = (short)reg7;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg7 = REG_RAD4_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio((volatile)baseaddr, 0x0008, ((reg7<<4)+0x0007));

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
// Function behaves the same as the same as the previous function.

char WarpRadio_RxLpfCornFreqFineAdj(unsigned int* baseaddr, char value, unsigned char radios) {
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x0007;
	int mask = 0xFFF8;

	if (value == 5 || value == 6 || value == 7) {				// Make sure the the value is not out of the specified range.
		return OUT_OF_RANGE;
	}

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg7 = REG_RAD1_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio((volatile)baseaddr, 0x0001, ((reg7<<4)+0x0007));

		REG_RAD1_LOWPASS_FILTER = (short)reg7;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg7 = REG_RAD2_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio((volatile)baseaddr, 0x0002, ((reg7<<4)+0x0007));

		REG_RAD2_LOWPASS_FILTER = (short)reg7;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg7 = REG_RAD3_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio((volatile)baseaddr, 0x0004, ((reg7<<4)+0x0007));

		REG_RAD3_LOWPASS_FILTER = (short)reg7;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg7 = REG_RAD4_LOWPASS_FILTER & mask;
		reg7 = reg7 + value;
		transRadio((volatile)baseaddr, 0x0008, ((reg7<<4)+0x0007));

		REG_RAD4_LOWPASS_FILTER = (short)reg7;
	}
	return WARP_SUCCESS;
}

// Set the Recieve Highpass Filter Corner Frequency when RXHP=0. Affected Slots are defined in 'radios'
// 'value':	0:100Hz
//			1:30kHz
// Function behaves the same as the above function.
void WarpRadio_RxHighPassCornerFreq(unsigned int* baseaddr, char value, unsigned char radios) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x0001;
	value = value << 2;
	int mask = 0xFFFB;

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg8 = REG_RAD1_RX_CONTROL & mask;
		reg8 = reg8 + value;
		transRadio((volatile)baseaddr, 0x0001, ((reg8<<4)+0x0008));

		REG_RAD1_RX_CONTROL = (short)reg8;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg8 = REG_RAD2_RX_CONTROL & mask;
		reg8 = reg8 + value;
		transRadio((volatile)baseaddr, 0x0002, ((reg8<<4)+0x0008));

		REG_RAD2_RX_CONTROL = (short)reg8;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg8 = REG_RAD3_RX_CONTROL & mask;
		reg8 = reg8 + value;
		transRadio((volatile)baseaddr, 0x0004, ((reg8<<4)+0x0008));

		REG_RAD3_RX_CONTROL = (short)reg8;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg8 = REG_RAD4_RX_CONTROL & mask;
		reg8 = reg8 + value;
		transRadio((volatile)baseaddr, 0x0008, ((reg8<<4)+0x0008));

		REG_RAD4_RX_CONTROL = (short)reg8;
	}
}

// Enable or disable Recieve VGA Gain Programming serially. Affects 'radios'
// 'mode' 0: Recieve VGA Gain programmed with external digital inputs.
//		  1: Receive VGA Gain programmed with serial data bits in RxGain Register
// Returns INVALID_MODE if the mode is an invalid input.
// Function behaves similar to above function.
char WarpRadio_SerialRxGain(unsigned int* baseaddr, short mode, unsigned char radios) {

	if (mode == 0 | mode == 1) {
		RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

		mode = mode & 0x0001;
		mode = mode << 12;
		int mask = 0xEFFF;

		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
			unsigned int reg8 = REG_RAD1_RX_CONTROL & mask;
			reg8 = reg8 + mode;
			transRadio((volatile)baseaddr, 0x0001, ((reg8<<4)+0x0008));

			REG_RAD1_RX_CONTROL = (short)reg8;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
			unsigned int reg8 = REG_RAD2_RX_CONTROL & mask;
			reg8 = reg8 + mode;
			transRadio((volatile)baseaddr, 0x0002, ((reg8<<4)+0x0008));

			REG_RAD2_RX_CONTROL = (short)reg8;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
			unsigned int reg8 = REG_RAD3_RX_CONTROL & mask;
			reg8 = reg8 + mode;
			transRadio((volatile)baseaddr, 0x0004, ((reg8<<4)+0x0008));

			REG_RAD3_RX_CONTROL = (short)reg8;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
			unsigned int reg8 = REG_RAD4_RX_CONTROL & mask;
			reg8 = reg8 + mode;
			transRadio((volatile)baseaddr, 0x0008, ((reg8<<4)+0x0008));

			REG_RAD4_RX_CONTROL = (short)reg8;
		}
	}
	else {
		return INVALID_MODE;
	}

	return WARP_SUCCESS;
}


// Enable or disable Transmit VGA Gain Programming Serially. Affects 'radios'
// 'mode' 0: Transmit VGA Gain programmed with external digital inputs.
//		  1: Transmit VGA Gain programmed with serial data bits in TxGain Register
// Returns INVALID_MODE if the mode is an invalid input.
// Function behaves similar to above function.
char WarpRadio_SerialTxGain(unsigned int* baseaddr, short mode, unsigned char radios) {

	if (mode == 0 | mode == 1) {
		RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

		mode = mode & 0x0001;
		mode = mode << 10;
		int mask = 0xFBFF;

		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
			unsigned int reg9 = REG_RAD1_TX_LINEARITY & mask;
			reg9 = reg9 + mode;
			transRadio((volatile)baseaddr, 0x0001, ((reg9<<4)+0x0009));

			REG_RAD1_TX_LINEARITY = (short)reg9;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
			unsigned int reg9 = REG_RAD2_TX_LINEARITY & mask;
			reg9 = reg9 + mode;
			transRadio((volatile)baseaddr, 0x0002, ((reg9<<4)+0x0009));

			REG_RAD2_TX_LINEARITY = (short)reg9;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
			unsigned int reg9 = REG_RAD3_TX_LINEARITY & mask;
			reg9 = reg9 + mode;
			transRadio((volatile)baseaddr, 0x0004, ((reg9<<4)+0x0009));

			REG_RAD3_TX_LINEARITY = (short)reg9;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
			unsigned int reg9 = REG_RAD4_TX_LINEARITY & mask;
			reg9 = reg9 + mode;
			transRadio((volatile)baseaddr, 0x0008, ((reg9<<4)+0x0009));

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
// Function behaves the same as the same as the previous function.
void WarpRadio_BaseBandTxGain(unsigned int* baseaddr, char value, unsigned char radios) {
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x0003;
	int mask = 0xFFFC;

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg9 = REG_RAD1_TX_LINEARITY & mask;
		reg9 = reg9 + value;
		transRadio((volatile)baseaddr, 0x0001, ((reg9<<4)+0x0009));

		REG_RAD1_TX_LINEARITY = (short)reg9;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg9 = REG_RAD2_TX_LINEARITY & mask;
		reg9 = reg9 + value;
		transRadio((volatile)baseaddr, 0x0002, ((reg9<<4)+0x0009));

		REG_RAD2_TX_LINEARITY = (short)reg9;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg9 = REG_RAD3_TX_LINEARITY & mask;
		reg9 = reg9 + value;
		transRadio((volatile)baseaddr, 0x0004, ((reg9<<4)+0x0009));

		REG_RAD3_TX_LINEARITY = (short)reg9;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg9 = REG_RAD4_TX_LINEARITY & mask;
		reg9 = reg9 + value;
		transRadio((volatile)baseaddr, 0x0008, ((reg9<<4)+0x0009));

		REG_RAD4_TX_LINEARITY = (short)reg9;
	}
}

// This function combined with RxVGAGainControl adjusts the total recieve gain. The 2 bits of this function map to
// B7:B6. 00 is the lowest possible gain. Function behaves the same as the previous function.
void WarpRadio_RxLNAGainControl(unsigned int* baseaddr, char value, unsigned char radios) {
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x0003;
	value = value << 5;
	int mask = 0xFF9F;

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg11 = REG_RAD1_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio((volatile)baseaddr, 0x0001, ((reg11<<4)+0x000B));

		REG_RAD1_RX_GAIN = (short)reg11;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg11 = REG_RAD2_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio((volatile)baseaddr, 0x0002, ((reg11<<4)+0x000B));

		REG_RAD2_RX_GAIN = (short)reg11;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg11 = REG_RAD3_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio((volatile)baseaddr, 0x0004, ((reg11<<4)+0x000B));

		REG_RAD3_RX_GAIN = (short)reg11;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg11 = REG_RAD4_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio((volatile)baseaddr, 0x0008, ((reg11<<4)+0x000B));

		REG_RAD4_RX_GAIN = (short)reg11;
	}

}

// This function combined with RxLNAGainControl adjusts the total recieve gain. The 5 bits of this function map to
// B5:B1. 00000 is the lowest possible gain. Function behaves the same as the previous function.
void WarpRadio_RxVGAGainControl(unsigned int* baseaddr, char value, unsigned char radios) {
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x001F;
	int mask = 0xFFE0;

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg11 = REG_RAD1_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio((volatile)baseaddr, 0x0001, ((reg11<<4)+0x000B));

		REG_RAD1_RX_GAIN = (short)reg11;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg11 = REG_RAD2_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio((volatile)baseaddr, 0x0002, ((reg11<<4)+0x000B));

		REG_RAD2_RX_GAIN = (short)reg11;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg11 = REG_RAD3_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio((volatile)baseaddr, 0x0004, ((reg11<<4)+0x000B));

		REG_RAD3_RX_GAIN = (short)reg11;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg11 = REG_RAD4_RX_GAIN & mask;
		reg11 = reg11 + value;
		transRadio((volatile)baseaddr, 0x0008, ((reg11<<4)+0x000B));

		REG_RAD4_RX_GAIN = (short)reg11;
	}

}

// This function adjusts the total transmit gain. The 6 bits of this function map to
// B6:B1. 000000 is the lowest possible gain. Function behaves the same as the previous function.
void WarpRadio_TxVGAGainControl(unsigned int* baseaddr, char value, unsigned char radios) {
	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radios));			// Select Radios affected by this function

	value = value & 0x003F;
	int mask = 0xFFC0;

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		unsigned int reg12 = REG_RAD1_TX_VGA_GAIN & mask;
		reg12 = reg12 + value;
		transRadio((volatile)baseaddr, 0x0001, ((reg12<<4)+0x000C));

		REG_RAD1_TX_VGA_GAIN = (short)reg12;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		unsigned int reg12 = REG_RAD2_TX_VGA_GAIN & mask;
		reg12 = reg12 + value;
		transRadio((volatile)baseaddr, 0x0002, ((reg12<<4)+0x000C));

		REG_RAD2_TX_VGA_GAIN = (short)reg12;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		unsigned int reg12 = REG_RAD3_TX_VGA_GAIN & mask;
		reg12 = reg12 + value;
		transRadio((volatile)baseaddr, 0x0004, ((reg12<<4)+0x000C));

		REG_RAD3_TX_VGA_GAIN = (short)reg12;
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		unsigned int reg12 = REG_RAD4_TX_VGA_GAIN & mask;
		reg12 = reg12 + value;
		transRadio((volatile)baseaddr, 0x0008, ((reg12<<4)+0x000C));

		REG_RAD4_TX_VGA_GAIN = (short)reg12;
	}

}

// Returns the RSSI ADC data of the radio specified. Can return value for only one of the radios at one time.
short WarpRadio_RSSIData(unsigned int* baseaddr, unsigned char radio) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radio));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & RAD_RSSI_ADC_D) >> 22);
	}
	else if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & RAD_RSSI_ADC_D) >> 22);
	}
	else if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & RAD_RSSI_ADC_D) >> 22);
	}
	else if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & RAD_RSSI_ADC_D) >> 22);
	}
	else {
		return 0;
	}

}


// Returns the DIPSW values of the radio specified. Can return value for only one of the radios at one time.
char WarpRadio_DIPSW(unsigned int* baseaddr, unsigned char radio) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radio));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & RAD_DIPSW) >> 15);
	}
	else if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & RAD_DIPSW) >> 15);
	}
	else if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & RAD_DIPSW) >> 15);
	}
	else if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & RAD_DIPSW) >> 15);
	}
	else {
		return 0;
	}

}


// Returns the ADC_OTR values of the radio specified. Can return value for only one of the radios at one time.
char WarpRadio_ADC_OutOfRange(unsigned int* baseaddr, unsigned char radio) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radio));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & (RAD_ADC_RX_OTRA | RAD_ADC_RX_OTRB)) >> 11);
	}
	else if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & (RAD_ADC_RX_OTRA | RAD_ADC_RX_OTRB)) >> 11);
	}
	else if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & (RAD_ADC_RX_OTRA | RAD_ADC_RX_OTRB)) >> 11);
	}
	else if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & (RAD_ADC_RX_OTRA | RAD_ADC_RX_OTRB)) >> 11);
	}
	else {
		return 0;
	}


}

// Returns the RSSI_ADC_OTR values of the radio specified. Can return value for only one of the radios at one time.
char WarpRadio_RSSI_OutOfRange(unsigned int* baseaddr, unsigned char radio) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASK & radio));			// Select Radios affected by this function

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD1MASK) > 0) {		// Check to make sure if Radio 1 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & RAD_RSSI_ADC_OTR) >> 19);
	}
	else if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD2MASK) > 0) {		// Check to make sure if Radio 2 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & RAD_RSSI_ADC_OTR) >> 19);
	}
	else if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD3MASK) > 0) {		// Check to make sure if Radio 3 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & RAD_RSSI_ADC_OTR) >> 19);
	}
	else if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & RAD4MASK) > 0) {		// Check to make sure if Radio 4 is being used
		return ((RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & RAD_RSSI_ADC_OTR) >> 19);
	}
	else {
		return 0;
	}


}


/*************************** DAC Library ****************************/


/*********Static Copies of Registers in AD9775******/

// Local copies of all the registers in the DAC. Are updated everytime a register value in the DAC is
// changed.

// DAC 1
unsigned char REG_DAC1_REGISTER_0 = 0x00;
unsigned char REG_DAC1_REGISTER_1 = 0x04;
unsigned char REG_DAC1_REGISTER_2 = 0x00;
unsigned char REG_DAC1_REGISTER_3 = 0x00;
unsigned char REG_DAC1_REGISTER_4 = 0x00;
unsigned char REG_DAC1_REGISTER_5 = 0x00;
unsigned char REG_DAC1_REGISTER_6 = 0x00;
unsigned char REG_DAC1_REGISTER_7 = 0x00;
unsigned char REG_DAC1_REGISTER_8 = 0x00;
unsigned char REG_DAC1_REGISTER_9 = 0x00;
unsigned char REG_DAC1_REGISTER_A = 0x00;
unsigned char REG_DAC1_REGISTER_B = 0x00;
unsigned char REG_DAC1_REGISTER_C = 0x00;
unsigned char REG_DAC1_REGISTER_D = 0x00;

// DAC 2
unsigned char REG_DAC2_REGISTER_0 = 0x00;
unsigned char REG_DAC2_REGISTER_1 = 0x04;
unsigned char REG_DAC2_REGISTER_2 = 0x00;
unsigned char REG_DAC2_REGISTER_3 = 0x00;
unsigned char REG_DAC2_REGISTER_4 = 0x00;
unsigned char REG_DAC2_REGISTER_5 = 0x00;
unsigned char REG_DAC2_REGISTER_6 = 0x00;
unsigned char REG_DAC2_REGISTER_7 = 0x00;
unsigned char REG_DAC2_REGISTER_8 = 0x00;
unsigned char REG_DAC2_REGISTER_9 = 0x00;
unsigned char REG_DAC2_REGISTER_A = 0x00;
unsigned char REG_DAC2_REGISTER_B = 0x00;
unsigned char REG_DAC2_REGISTER_C = 0x00;
unsigned char REG_DAC2_REGISTER_D = 0x00;

// DAC 3
unsigned char REG_DAC3_REGISTER_0 = 0x00;
unsigned char REG_DAC3_REGISTER_1 = 0x04;
unsigned char REG_DAC3_REGISTER_2 = 0x00;
unsigned char REG_DAC3_REGISTER_3 = 0x00;
unsigned char REG_DAC3_REGISTER_4 = 0x00;
unsigned char REG_DAC3_REGISTER_5 = 0x00;
unsigned char REG_DAC3_REGISTER_6 = 0x00;
unsigned char REG_DAC3_REGISTER_7 = 0x00;
unsigned char REG_DAC3_REGISTER_8 = 0x00;
unsigned char REG_DAC3_REGISTER_9 = 0x00;
unsigned char REG_DAC3_REGISTER_A = 0x00;
unsigned char REG_DAC3_REGISTER_B = 0x00;
unsigned char REG_DAC3_REGISTER_C = 0x00;
unsigned char REG_DAC3_REGISTER_D = 0x00;

// DAC 4
unsigned char REG_DAC4_REGISTER_0 = 0x00;
unsigned char REG_DAC4_REGISTER_1 = 0x04;
unsigned char REG_DAC4_REGISTER_2 = 0x00;
unsigned char REG_DAC4_REGISTER_3 = 0x00;
unsigned char REG_DAC4_REGISTER_4 = 0x00;
unsigned char REG_DAC4_REGISTER_5 = 0x00;
unsigned char REG_DAC4_REGISTER_6 = 0x00;
unsigned char REG_DAC4_REGISTER_7 = 0x00;
unsigned char REG_DAC4_REGISTER_8 = 0x00;
unsigned char REG_DAC4_REGISTER_9 = 0x00;
unsigned char REG_DAC4_REGISTER_A = 0x00;
unsigned char REG_DAC4_REGISTER_B = 0x00;
unsigned char REG_DAC4_REGISTER_C = 0x00;
unsigned char REG_DAC4_REGISTER_D = 0x00;

/******************* Masks **************************/

#define DAC1MASK 0x0010
#define DAC2MASK 0x0020
#define DAC3MASK 0x0040
#define DAC4MASK 0x0080
#define SLAVEMASKDAC 0x00F0

/******************** Functions *********************/


// The value that is required as an input is transmitted to the registers. The first 8 bits define the register for which
// the value needs to be set and the last 8 bits are the value that needs to be set in the register.
void transmitdac(unsigned int* baseaddr, int val) {

	RADIO_CONTROLLER_mWriteSlaveReg7((volatile)baseaddr, val);

	RADIO_CONTROLLER_mWriteSlaveReg4((volatile)baseaddr, 0x3510);

	while(RADIO_CONTROLLER_mReadSlaveReg4((volatile)baseaddr) == 0x3510) {
	}

}

// Initialize the SPI controller for DAC functions. This must be called before any DAC functions are called.
// In order to use dacs after using DACs call the corresponding functions in WarpRadio.
// Initializes the Control and Divider Registers to their required values.
void WarpDac_InitializeSPI(unsigned int* baseaddr) {

	RADIO_CONTROLLER_mWriteSlaveReg4((volatile)baseaddr, 0x3410);			// Set the value of the Control Register to 0x00003410.

	RADIO_CONTROLLER_mWriteSlaveReg5((volatile)baseaddr, 0x00000001);		// Set the value for the Divider Register to 0x00000001.
}


// This function initializes the selected DACs. Some register values need to be changed from the default
// and those changes are applied in this function. 'dacs' is the value that is applied to the Slave Select Register.
// This function must be called at the start of the program and needs to be called only once.
void WarpDac_InitializeDAC(unsigned int* baseaddr, unsigned char dacs) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASKDAC & dacs));		// Select the dacs that need to be affected

	transmitdac((volatile)baseaddr, 0x0004);					// Transmit a value of 0x04 for Register 0 for DAC to use only 1 refernce register

	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC1MASK) > 0) {		// Store local copies for the DACs that are affected by this function call
		REG_DAC1_REGISTER_0 = (char)0x04;
		RADIO_CONTROLLER_mWriteSlaveReg0((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg0((volatile)baseaddr) & 0xFFDFFFFF));	// Set TX_DAC_RESET to 0
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC2MASK) > 0) {
		REG_DAC2_REGISTER_0 = (char)0x04;
		RADIO_CONTROLLER_mWriteSlaveReg1((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg1((volatile)baseaddr) & 0xFFDFFFFF));	// Set TX_DAC_RESET to 0
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC3MASK) > 0) {
		REG_DAC3_REGISTER_0 = (char)0x04;
		RADIO_CONTROLLER_mWriteSlaveReg2((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg2((volatile)baseaddr) & 0xFFDFFFFF));	// Set TX_DAC_RESET to 0
	}
	if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC4MASK) > 0) {
		REG_DAC4_REGISTER_0 = (char)0x04;
		RADIO_CONTROLLER_mWriteSlaveReg3((volatile)baseaddr, (RADIO_CONTROLLER_mReadSlaveReg3((volatile)baseaddr) & 0xFFDFFFFF));	// Set TX_DAC_RESET to 0
	}

}

// This function resets the DAC and restores the default values to the registers. 'dacs' refers the DACs in the slots
// that will be affected by this call. Initializes the DACs once they have been reset.
void WarpDac_Reset(unsigned int* baseaddr, unsigned char dacs) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASKDAC & dacs));		// Select the dacs that need to be affected

	transmitdac((volatile)baseaddr, 0x0020);					// Enable the reset bit

	transmitdac((volatile)baseaddr, 0x0000);					// Disable the reset bit

	WarpDac_InitializeDAC(baseaddr, dacs);			// Initlialize the DAC to the required values.

}

// This function puts the DAC to sleep or takes it out of sleep mode. 'mode'=0 keeps it out of sleep mode while 'mode=1
// puts it in sleep mode. The DACs that are affected are specified in 'dacs'.
int WarpDac_Sleep(unsigned int* baseaddr, char mode, unsigned char dacs) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASKDAC & dacs));		// Select the dacs that need to be affected

	if (mode == 1) {									// Check if DACs need to put to sleep.

		transmitdac((volatile)baseaddr, 0x0014);					// Transmit the sleep bit = 1 for the required DACs

		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC1MASK) > 0) {
			REG_DAC1_REGISTER_0 = (char)0x14;			// Store to the local copies for the DACs affected.
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC2MASK) > 0) {
			REG_DAC2_REGISTER_0 = (char)0x14;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC3MASK) > 0) {
			REG_DAC3_REGISTER_0 = (char)0x14;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC4MASK) > 0) {
			REG_DAC4_REGISTER_0 = (char)0x14;
		}

	}
	else if (mode == 0) {

		transmitdac((volatile)baseaddr, 0x0004);					// Remove the DACs specified from sleep mode.

		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC1MASK) > 0) {
			REG_DAC1_REGISTER_0 = (char)0x04;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC2MASK) > 0) {
			REG_DAC2_REGISTER_0 = (char)0x04;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC3MASK) > 0) {
			REG_DAC3_REGISTER_0 = (char)0x04;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC4MASK) > 0) {
			REG_DAC4_REGISTER_0 = (char)0x04;
		}
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
int WarpDac_FineGainAdj(unsigned int* baseaddr, char chan, unsigned char value, unsigned char dacs) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASKDAC & dacs));			// Select the dacs that need to be affected

	value = value & 0x00FF;								// Use only the last 8 bits of the value

	if (chan == ICHAN) {								// If called on I channel send the values to register 5

		transmitdac((volatile)baseaddr, (0x0500 + value));

		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC1MASK) > 0) {
			REG_DAC1_REGISTER_5 = (char)value;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC2MASK) > 0) {
			REG_DAC2_REGISTER_5 = (char)value;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC3MASK) > 0) {
			REG_DAC3_REGISTER_5 = (char)value;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC4MASK) > 0) {
			REG_DAC4_REGISTER_5 = (char)value;
		}
	}
	else if (chan == QCHAN) {							// If called on Q channel send the values to register 9

		transmitdac((volatile)baseaddr, (0x0900 + value));

		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC1MASK) > 0) {
			REG_DAC1_REGISTER_9 = (char)value;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC2MASK) > 0) {
			REG_DAC2_REGISTER_9 = (char)value;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC3MASK) > 0) {
			REG_DAC3_REGISTER_9 = (char)value;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC4MASK) > 0) {
			REG_DAC4_REGISTER_9 = (char)value;
		}
	}
	else {
		return INVALID_MODE;
	}
	return WARP_SUCCESS;
}

// Adjust the Coarse Gain on the I and Q channels of the DAC. 'chan' = ICHAN changes the I channel coarse gain while
// 'chan' = QCHAN affects the coarse gain of the Q channel. The value is 4 bits wide and goes to the registers as
// required by the channel setting. 'dacs' refer to the DACs that are being affected by this function.
// This function behaves similar to the previous function.
int WarpDac_CoarseGainAdj(unsigned int* baseaddr, char chan, unsigned char value, unsigned char dacs) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASKDAC & dacs));		// Select the dacs that need to be affected

	value = value & 0x000F;							// Use only last 4 bits

	if (chan == ICHAN) {

		transmitdac((volatile)baseaddr, (0x0600 + value));

		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC1MASK) > 0) {
			REG_DAC1_REGISTER_6 = (char)value;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC2MASK) > 0) {
			REG_DAC2_REGISTER_6 = (char)value;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC3MASK) > 0) {
			REG_DAC3_REGISTER_6 = (char)value;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC4MASK) > 0) {
			REG_DAC4_REGISTER_6 = (char)value;
		}
	}
	else if (chan == QCHAN) {

		transmitdac((volatile)baseaddr, (0x0A00 + value));

		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC1MASK) > 0) {
			REG_DAC1_REGISTER_A = (char)value;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC2MASK) > 0) {
			REG_DAC2_REGISTER_A = (char)value;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC3MASK) > 0) {
			REG_DAC3_REGISTER_A = (char)value;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC4MASK) > 0) {
			REG_DAC4_REGISTER_A = (char)value;
		}
	}
	else {
		return INVALID_MODE;
	}
	return WARP_SUCCESS;
}

// Adjust the DC Offset on the I and Q channels of the DAC. 'chan' = ICHAN changes the I channel DC offset while
// 'chan' = QCHAN affects the DC offset of the Q channel. The value can be a maximum of 1023 and minimum of -1024
// and goes to the registers as required by the channel setting. 'dacs' refer to the DACs that are being
// affected by this function.
int WarpDac_OffsetAdj(unsigned int* baseaddr, char chan, short value, unsigned char dacs) {

	RADIO_CONTROLLER_mWriteSlaveReg6((volatile)baseaddr, (SLAVEMASKDAC & dacs));		// Select the dacs that need to be affected

//	value = value & 0x03FF;
//	short reg7 = ((value & 0x03FC) >> 2);
//	short reg8 = (value & 0x0003);
//	if ((value & 0x8000) > 0) {
//		reg8 = reg8 + 0x0080;
//	}

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

		transmitdac((volatile)baseaddr, (0x0700 + reg7));		// if I channel then store the first register to Register 7
		transmitdac((volatile)baseaddr, (0x0800 + reg8));		// and the second register to Register 8

		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC1MASK) > 0) {
			REG_DAC1_REGISTER_7 = (char)reg7;
			REG_DAC1_REGISTER_8 = (char)reg8;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC2MASK) > 0) {
			REG_DAC2_REGISTER_7 = (char)reg7;
			REG_DAC2_REGISTER_8 = (char)reg8;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC3MASK) > 0) {
			REG_DAC3_REGISTER_7 = (char)reg7;
			REG_DAC3_REGISTER_8 = (char)reg8;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC4MASK) > 0) {
			REG_DAC4_REGISTER_7 = (char)reg7;
			REG_DAC4_REGISTER_8 = (char)reg8;
		}
	}
	else if (chan == QCHAN) {

		transmitdac((volatile)baseaddr, (0x0B00 + reg7));		// if I channel then store the first register to Register B
		transmitdac((volatile)baseaddr, (0x0C00 + reg8));		// and the second register to Register C

		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC1MASK) > 0) {
			REG_DAC1_REGISTER_B = (char)reg7;
			REG_DAC1_REGISTER_C = (char)reg8;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC2MASK) > 0) {
			REG_DAC2_REGISTER_B = (char)reg7;
			REG_DAC2_REGISTER_C = (char)reg8;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC3MASK) > 0) {
			REG_DAC3_REGISTER_B = (char)reg7;
			REG_DAC3_REGISTER_C = (char)reg8;
		}
		if((RADIO_CONTROLLER_mReadSlaveReg6((volatile)baseaddr) & DAC4MASK) > 0) {
			REG_DAC4_REGISTER_B = (char)reg7;
			REG_DAC1_REGISTER_C = (char)reg8;
		}
	}
	else {
		return INVALID_MODE;
	}
	return WARP_SUCCESS;

}
