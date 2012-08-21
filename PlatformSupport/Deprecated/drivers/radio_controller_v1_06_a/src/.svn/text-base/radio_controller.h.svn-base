/* Copyright (c) 2006 Rice University */
/* All Rights Reserved */
/* This code is covered by the Rice-WARP license */
/* See http://warp.rice.edu/license/ for details */

//////////////////////////////////////////////////////////////////////////////
// Filename:          drivers/radio_controller_v1_05_a/src/radio_controller.h
// Version:           1.05.a
// Description:       radio_controller Driver Header File
//////////////////////////////////////////////////////////////////////////////

#ifndef RADIO_CONTROLLER_H
#define RADIO_CONTROLLER_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 */
#define RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET (0x00000000)
#define RADIO_CONTROLLER_SLAVE_REG0_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000000)
#define RADIO_CONTROLLER_SLAVE_REG1_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000004)
#define RADIO_CONTROLLER_SLAVE_REG2_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000008)
#define RADIO_CONTROLLER_SLAVE_REG3_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x0000000C)
#define RADIO_CONTROLLER_SLAVE_REG4_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000010)
#define RADIO_CONTROLLER_SLAVE_REG5_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000014)
#define RADIO_CONTROLLER_SLAVE_REG6_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000018)
#define RADIO_CONTROLLER_SLAVE_REG7_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x0000001C)
#define RADIO_CONTROLLER_SLAVE_REG8_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000020)
#define RADIO_CONTROLLER_SLAVE_REG9_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000024)
#define RADIO_CONTROLLER_SLAVE_REG10_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000028)
#define RADIO_CONTROLLER_SLAVE_REG11_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x0000002C)
#define RADIO_CONTROLLER_SLAVE_REG12_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000030)
#define RADIO_CONTROLLER_SLAVE_REG13_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000034)
#define RADIO_CONTROLLER_SLAVE_REG14_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000038)
#define RADIO_CONTROLLER_SLAVE_REG15_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x0000003C)

/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a RADIO_CONTROLLER register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the RADIO_CONTROLLER device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void RADIO_CONTROLLER_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define RADIO_CONTROLLER_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a RADIO_CONTROLLER register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the RADIO_CONTROLLER device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 RADIO_CONTROLLER_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define RADIO_CONTROLLER_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read value to/from RADIO_CONTROLLER user logic slave registers.
 *
 * @param   BaseAddress is the base address of the RADIO_CONTROLLER device.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 RADIO_CONTROLLER_mReadSlaveRegn(Xuint32 BaseAddress)
 *
 */
#define RADIO_CONTROLLER_mWriteSlaveReg0(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG0_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg1(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG1_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg2(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG2_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg3(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG3_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg4(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG4_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg5(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG5_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg6(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG6_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg7(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG7_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg8(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG8_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg9(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG9_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg10(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG10_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg11(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG11_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg12(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG12_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg13(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG13_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg14(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG14_OFFSET), (Xuint32)(Value))
#define RADIO_CONTROLLER_mWriteSlaveReg15(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG15_OFFSET), (Xuint32)(Value))

#define RADIO_CONTROLLER_mReadSlaveReg0(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG0_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg1(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG1_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg2(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG2_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg3(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG3_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg4(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG4_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg5(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG5_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg6(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG6_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg7(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG7_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg8(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG8_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg9(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG9_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg10(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG10_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg11(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG11_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg12(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG12_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg13(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG13_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg14(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG14_OFFSET))
#define RADIO_CONTROLLER_mReadSlaveReg15(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG15_OFFSET))

/************************** Function Prototypes ****************************/


/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the RADIO_CONTROLLER instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus RADIO_CONTROLLER_SelfTest(void * baseaddr_p);


/************************* WARP Libraries **********************************/

/************ Radio Library *************/

#define RADIO1_ADDR 0x0001
#define RADIO2_ADDR 0x0002
#define RADIO3_ADDR 0x0004
#define RADIO4_ADDR 0x0008

#define WARP_SUCCESS 0
#define NOT_IN_CALIBRATION -2
#define INVALID_GAIN -1
#define INVALID_FREQ -1
#define INVALID_MODE -1
#define OUT_OF_RANGE -2

#define RAD_SHDN_MASK 0x00000001
#define RAD_TXEN_MASK 0x00000002
#define RAD_RXEN_MASK 0x00000004
#define RAD_RXHP_MASK 0x00000008
#define RAD_SOFT_RXHP_MASK 0x00000010
#define RAD_LD_MASK 0x00000010
#define RAD_24PA_MASK 0x00000020
#define RAD_5PA_MASK 0x00000040
#define RAD_ANTSW1_MASK 0x00000080
#define RAD_ANTSW2_MASK 0x00000100
#define RAD_ADC_RX_DCS 0x00000200
#define RAD_LED1_MASK 0x00000400
#define RAD_ADC_RX_DFS 0x00000400
#define RAD_LED2_MASK 0x00000800
#define RAD_ADC_RX_OTRA 0x00000800
#define RAD_LED3_MASK 0x00001000
#define RAD_ADC_RX_OTRB 0x00001000
#define RAD_ADC_RX_PWDNA 0x00002000
#define RAD_ADC_RX_PWDNB 0x00004000
#define RAD_RSSI_ADC_SLEEP 0x00008000
#define RAD_DIPSW 0x00078000
#define RAD_RSSI_ADC_OTR 0x00080000
#define RAD_TX_DAC_PLL_LOCK 0x00100000
#define RAD_TX_DAC_RESET 0x00200000
#define RAD_RSSI_ADC_D 0xFFC00000

// RADIO 1
unsigned short REG_RAD1_REGISTER_0;
unsigned short REG_RAD1_REGISTER_1;
unsigned short REG_RAD1_STANDBY;
unsigned short REG_RAD1_INTEGER_DIVIDER_RATIO;
unsigned short REG_RAD1_FRACTIONAL_DIVIDER_RATIO;
unsigned short REG_RAD1_BAND_SELECT;
unsigned short REG_RAD1_CALIBRATION;
unsigned short REG_RAD1_LOWPASS_FILTER;
unsigned short REG_RAD1_RX_CONTROL;
unsigned short REG_RAD1_TX_LINEARITY;
unsigned short REG_RAD1_PA_BIAS_DAC;
unsigned short REG_RAD1_RX_GAIN;
unsigned short REG_RAD1_TX_VGA_GAIN;

// RADIO 2
unsigned short REG_RAD2_REGISTER_0;
unsigned short REG_RAD2_REGISTER_1;
unsigned short REG_RAD2_STANDBY;
unsigned short REG_RAD2_INTEGER_DIVIDER_RATIO;
unsigned short REG_RAD2_FRACTIONAL_DIVIDER_RATIO;
unsigned short REG_RAD2_BAND_SELECT;
unsigned short REG_RAD2_CALIBRATION;
unsigned short REG_RAD2_LOWPASS_FILTER;
unsigned short REG_RAD2_RX_CONTROL;
unsigned short REG_RAD2_TX_LINEARITY;
unsigned short REG_RAD2_PA_BIAS_DAC;
unsigned short REG_RAD2_RX_GAIN;
unsigned short REG_RAD2_TX_VGA_GAIN;

// RADIO 3
unsigned short REG_RAD3_REGISTER_0;
unsigned short REG_RAD3_REGISTER_1;
unsigned short REG_RAD3_STANDBY;
unsigned short REG_RAD3_INTEGER_DIVIDER_RATIO;
unsigned short REG_RAD3_FRACTIONAL_DIVIDER_RATIO;
unsigned short REG_RAD3_BAND_SELECT;
unsigned short REG_RAD3_CALIBRATION;
unsigned short REG_RAD3_LOWPASS_FILTER;
unsigned short REG_RAD3_RX_CONTROL;
unsigned short REG_RAD3_TX_LINEARITY;
unsigned short REG_RAD3_PA_BIAS_DAC;
unsigned short REG_RAD3_RX_GAIN;
unsigned short REG_RAD3_TX_VGA_GAIN;

// RADIO 4
unsigned short REG_RAD4_REGISTER_0;
unsigned short REG_RAD4_REGISTER_1;
unsigned short REG_RAD4_STANDBY;
unsigned short REG_RAD4_INTEGER_DIVIDER_RATIO;
unsigned short REG_RAD4_FRACTIONAL_DIVIDER_RATIO;
unsigned short REG_RAD4_BAND_SELECT;
unsigned short REG_RAD4_CALIBRATION;
unsigned short REG_RAD4_LOWPASS_FILTER;
unsigned short REG_RAD4_RX_CONTROL;
unsigned short REG_RAD4_TX_LINEARITY;
unsigned short REG_RAD4_PA_BIAS_DAC;
unsigned short REG_RAD4_RX_GAIN;
unsigned short REG_RAD4_TX_VGA_GAIN;


// Initialize the spi controller to the configurations required for Radios. Before any readio functions are called
// this function must be called to initilize the spi. If dac functions need to be used in the middle call the WarpDac_InitializeSPI
// to set up the controller to transmit DAC values. One can switch between the DAC and the radios as long the respective
// InitializeSPI functions are called before use.
// Sets the MAX2829 control register and divider register.
// Does not have a return value
void WarpRadio_InitializeSPI(unsigned int* baseaddr);

// This function initializes the selected radios. Some register values need to be changed from the default
// and those changes are applied in this function. 'radios' is the value that is applied to the Slave Select Register.
// This function must be called at the start of the program and needs to be called only once.
void WarpRadio_InitializeRadio(unsigned int* baseaddr, unsigned char radios);

// Enables the recieve mode in the radio board. On calling this function the transmit mode is forcibly turned off.
// Also makes sure that the amplifiers are off. 'radios' refers to the Radios in the slots that will have their recieve
// mode turned on.
void WarpRadio_RxEnable(unsigned int* baseaddr, unsigned char radios);

// Disables the receive mode in the radios specified. 'radios' refers to the Radios in the slots whose recieve mode will be turned
// off.
void WarpRadio_RxDisable(unsigned int* baseaddr, unsigned char radios);

// Enables the transmit enable mode on the Radios specified. Also turns on the 2.4Ghz amplifier currently.
// Forcibly turns off the recieve enable mode. 'radios' refers to the Radios in the slots whose transmit mode is turned on.
void WarpRadio_TxEnable(unsigned int* baseaddr, unsigned char radios);

// Disables the transmit mode on the Radios specified. Both amplifiers are also turned off.
// 'radios' refers to the Radios in the slots whose transmit mode is turned off.
void WarpRadio_TxDisable(unsigned int* baseaddr, unsigned char radios);

// Turns on a radio's 2.4GHz power amplifier
void WarpRadio_24AmpEnable(unsigned int* baseaddr, unsigned char radios);

// Turns off a radio's 2.4GHz power amplifier
void WarpRadio_24AmpDisable(unsigned int* baseaddr, unsigned char radios);

// Turns on a radio's 5GHz power amplifier
void WarpRadio_5AmpEnable(unsigned int* baseaddr, unsigned char radios);

// Turns off a radio's 5GHz power amplifier
void WarpRadio_5AmpDisable(unsigned int* baseaddr, unsigned char radios);


// This function shuts down the radios specified. Forcibly turns off transmit and recieve modes as well as shuts down
// amplifiers. 'radios' refers to the Radios in the slots that will be shut down.
void WarpRadio_SHDNEnable(unsigned int* baseaddr, unsigned char radios);

// Takes the specified radios out of shutdown mode. The transmit and recieve modes are still disabled. 'radios' refers
// to the the Radios in the slots affected by this function. Behaves the same as the previous function.
void WarpRadio_SHDNDisable(unsigned int* baseaddr, unsigned char radios);

// Reset the radio board registers that are specified in 'radios'. Goes through a set of instructions to achieve a reset of
// the radios. Behaves similar to previous function.
void WarpRadio_Reset(unsigned int* baseaddr, unsigned char radios);

// Enable RxHP software control. In this situation the RxHPEnable and Disable functions control the RxHP pin
void WarpRadio_RxHp_Soft_Control_Enable(unsigned int* baseaddr, unsigned char radios);

// Disable RxHP software control. In this situation the RxHP pin is controlled by the RxHP external port on the radio_controller
void WarpRadio_RxHp_Soft_Control_Disable(unsigned int* baseaddr, unsigned char radios);

// Enable the RXHP bit in the 'radios' specified.
// Behaves similar to previous functions.
void WarpRadio_RxHpEnable(unsigned int* baseaddr, unsigned char radios);

// Disable the RXHP bit in the 'radios' specified.
// Behaves similar to previous functions.
void WarpRadio_RxHpDisable(unsigned int* baseaddr, unsigned char radios);

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
int WarpRadio_SetCenterFreq2GHz(unsigned int* baseaddr, char freqset, unsigned char radios);

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
int WarpRadio_SetCenterFreq5GHz(unsigned int* baseaddr, char freqset, unsigned char radios);

// Put the radio into transmit calibration mode. 'radios' refers to the radios that will be put into
// calibration. Forcibly removed from receive calibration mode.
void WarpRadio_TxCalibration(unsigned int* baseaddr, unsigned char radios);

// Put the radio into receive calibration mode. 'radios' refers to the radios that will be put into
// calibration. Forcibly removed from receive calibration mode.
void WarpRadio_RxCalibration(unsigned int* baseaddr, unsigned char radios);

// Takes the specified radios out of transmit and recieve calibration mode. 'radios' refers the Radios in the
// slots that will be affected. This function works exactly the same way as the function above.
void WarpRadio_NoCalibration(unsigned int* baseaddr, unsigned char radios);

// Sets the gain for Transmitter I/Q Calibration LO Leakage and Sideband-Detector Gain Control.
// Returns NOT_IN_CALIBRATION if any of the radios for which the gain is being set in not
// in calibration mode. Returns INVALID_GAIN if the gain set value given is not valid. Returns
// WARP_SUCCESS if value changed successfully. To be in calibration mode set
// TxCalibration.
// gain = 0 -> 8db
// gain = 1 -> 18db
// gain = 2 -> 24db
// gain = 3 -> 34db
char WarpRadio_TxCalGain(unsigned int* baseaddr, char gain, unsigned char radios);

// Enable or disable the Rx baseband section of the reciever. Mode = 0 disables the value while mode = 1
// enables the value. Returns INVALID_MODE if the mode is invalid. Returns WARP_SUCCESS if successfully manage
// to change the value.
char WarpRadio_TxCalRxEnable(unsigned int* baseaddr, char mode, unsigned char radios);

// Function enables or disables the MIMO mode for the specified 'radios'. 'mode' = 0 turns off MIMO mode while 'mode' = 1
// enables the MIMO mode. Returns INVALID_MODE if mode is wrong or returns WARP_SUCCESS if successful.
char WarpRadio_SetMimoMode(unsigned int* baseaddr, char mode, unsigned char radios);

// Enable or disable RSSI High Bandwidth. Mode:0 disables high bandwidth, Mode:1 enables
// high bandwidth. Requires baseaddress and radios for which it applies. Return INVALID_MODE if
// mode is incorrect. Returns WARP_SUCCESS if successful change.
char WarpRadio_RssiHighBandwidth(unsigned int* baseaddr, char mode, unsigned char radios);

// Set the Transmit Low Pass Filter Corner Frequency. This is the Coarse adjustment for the frequency and affects
// the 'radios' specified.
// 'value':
//		00: undefined
//		01: 12MHz (nominal mode)
//		10: 18MHz (turbo mode 1)
//		11: 24MHz (turbo mode 2)
void WarpRadio_TxLpfCornFreqCoarseAdj(unsigned int* baseaddr, char value, unsigned char radios);

// Set the Recieve Lowpass Filter Corner Frequency. This is the Coarse adjustment and affects only the 'radios' specified
// 'value':
//		00: 7.5MHz
//		01: 9.5MHz (nominal mode)
//		10: 14MHz (turbo mode 1)
//		11: 18MHz (turbo mode 2)
void WarpRadio_RxLpfCornFreqCoarseAdj(unsigned int* baseaddr, char value, unsigned char radios);

// Set the Recieve Lowpass Filter Corner Frequency. This is the Fine adjustment and affects only the 'radios' specified
// 'value':
//		000: 90%
//		001: 95%
//		010: 100%
//		011: 105%
//		100: 110%
//		101-111: not applicable
// Returns OUT_OF_RANGE if value is out of range
char WarpRadio_RxLpfCornFreqFineAdj(unsigned int* baseaddr, char value, unsigned char radios);

// Set the Recieve Highpass Filter Corner Frequency when RXHP=0. Affected Slots are defined in 'radios'
// 'value':	0:100Hz
//			1:30kHz
void WarpRadio_RxHighPassCornerFreq(unsigned int* baseaddr, char value, unsigned char radios);

// Enable or disable Recieve VGA Gain Programming serially. Affects 'radios'
// 'mode' 0: Recieve VGA Gain programmed with external digital inputs.
//		  1: Receive VGA Gain programmed with serial data bits in RxGain Register
// Returns INVALID_MODE if the mode is an invalid input.
char WarpRadio_SerialRxGain(unsigned int* baseaddr, short mode, unsigned char radios);

// Enable or disable Transmit VGA Gain Programming Serially. Affects 'radios'
// 'mode' 0: Transmit VGA Gain programmed with external digital inputs.
//		  1: Transmit VGA Gain programmed with serial data bits in TxGain Register
// Returns INVALID_MODE if the mode is an invalid input.
char WarpRadio_SerialTxGain(unsigned int* baseaddr, short mode, unsigned char radios);

// Set the Transmit Baseband Gain. Affects only the 'radios' specified.
// 'value':
//		00: max baseband gain - 5db
//		01: max baseband gain - 3db
//		10: max baseband gain - 1.5db
//		11: max baseband gain
void WarpRadio_BaseBandTxGain(unsigned int* baseaddr, char value, unsigned char radios);

// This function combined with RxVGAGainControl adjusts the total recieve gain. The 2 bits of this function map to
// B7:B6. 00 is the lowest possible gain.
void WarpRadio_RxLNAGainControl(unsigned int* baseaddr, char value, unsigned char radios);

// This function combined with RxLNAGainControl adjusts the total recieve gain. The 5 bits of this function map to
// B5:B1. 00000 is the lowest possible gain.
void WarpRadio_RxVGAGainControl(unsigned int* baseaddr, char value, unsigned char radios);

// This function adjusts the total transmit gain. The 6 bits of this function map to
// B6:B1. 000000 is the lowest possible gain.
void WarpRadio_TxVGAGainControl(unsigned int* baseaddr, char value, unsigned char radios);

// Returns the RSSI ADC data of the radio specified. Can return value for only one of the radios at one time.
short WarpRadio_RSSIData(unsigned int* baseaddr, unsigned char radio);

// Returns the DIPSW values of the radio specified. Can return value for only one of the radios at one time.
char WarpRadio_DIPSW(unsigned int* baseaddr, unsigned char radio);

// Returns the ADC_OTR values of the radio specified. Can return value for only one of the radios at one time.
char WarpRadio_ADC_OutOfRange(unsigned int* baseaddr, unsigned char radio);

// Returns the RSSI_ADC_OTR values of the radio specified. Can return value for only one of the radios at one time.
char WarpRadio_RSSI_OutOfRange(unsigned int* baseaddr, unsigned char radio);

//Sets the timing parameters for each transmission
void WarpRadio_SetTxTiming(unsigned int* baseaddr, unsigned char radios, unsigned char dly_TxEn, unsigned char dly_TxStart, unsigned char dly_GainRampEn, unsigned char dly_PowerAmpEn);

//Sets the parameters for automatic Tx gain ramping
void WarpRadio_SetTxGainTiming(unsigned int* baseaddr, unsigned char radios, unsigned char TxGainTarget, unsigned char TxGainStep, unsigned char TxGainTimeStep);

/************* DAC Library **************/

// Use the following for selecting DACs. DAC1_ADDR | DAC2_ADDR selects DACs 1 and 2 and so on.
#define DAC1_ADDR 0x0010
#define DAC2_ADDR 0x0020
#define DAC3_ADDR 0x0040
#define DAC4_ADDR 0x0080

#define WARP_SUCCESS 0
#define INVALID_MODE -1
#define ICHAN 1
#define QCHAN 2

// DAC 1
unsigned char REG_DAC1_REGISTER_0;
unsigned char REG_DAC1_REGISTER_1;
unsigned char REG_DAC1_REGISTER_2;
unsigned char REG_DAC1_REGISTER_3;
unsigned char REG_DAC1_REGISTER_4;
unsigned char REG_DAC1_REGISTER_5;
unsigned char REG_DAC1_REGISTER_6;
unsigned char REG_DAC1_REGISTER_7;
unsigned char REG_DAC1_REGISTER_8;
unsigned char REG_DAC1_REGISTER_9;
unsigned char REG_DAC1_REGISTER_A;
unsigned char REG_DAC1_REGISTER_B;
unsigned char REG_DAC1_REGISTER_C;
unsigned char REG_DAC1_REGISTER_D;

// DAC 2
unsigned char REG_DAC2_REGISTER_0;
unsigned char REG_DAC2_REGISTER_1;
unsigned char REG_DAC2_REGISTER_2;
unsigned char REG_DAC2_REGISTER_3;
unsigned char REG_DAC2_REGISTER_4;
unsigned char REG_DAC2_REGISTER_5;
unsigned char REG_DAC2_REGISTER_6;
unsigned char REG_DAC2_REGISTER_7;
unsigned char REG_DAC2_REGISTER_8;
unsigned char REG_DAC2_REGISTER_9;
unsigned char REG_DAC2_REGISTER_A;
unsigned char REG_DAC2_REGISTER_B;
unsigned char REG_DAC2_REGISTER_C;
unsigned char REG_DAC2_REGISTER_D;

// DAC 3
unsigned char REG_DAC3_REGISTER_0;
unsigned char REG_DAC3_REGISTER_1;
unsigned char REG_DAC3_REGISTER_2;
unsigned char REG_DAC3_REGISTER_3;
unsigned char REG_DAC3_REGISTER_4;
unsigned char REG_DAC3_REGISTER_5;
unsigned char REG_DAC3_REGISTER_6;
unsigned char REG_DAC3_REGISTER_7;
unsigned char REG_DAC3_REGISTER_8;
unsigned char REG_DAC3_REGISTER_9;
unsigned char REG_DAC3_REGISTER_A;
unsigned char REG_DAC3_REGISTER_B;
unsigned char REG_DAC3_REGISTER_C;
unsigned char REG_DAC3_REGISTER_D;

// DAC 4
unsigned char REG_DAC4_REGISTER_0;
unsigned char REG_DAC4_REGISTER_1;
unsigned char REG_DAC4_REGISTER_2;
unsigned char REG_DAC4_REGISTER_3;
unsigned char REG_DAC4_REGISTER_4;
unsigned char REG_DAC4_REGISTER_5;
unsigned char REG_DAC4_REGISTER_6;
unsigned char REG_DAC4_REGISTER_7;
unsigned char REG_DAC4_REGISTER_8;
unsigned char REG_DAC4_REGISTER_9;
unsigned char REG_DAC4_REGISTER_A;
unsigned char REG_DAC4_REGISTER_B;
unsigned char REG_DAC4_REGISTER_C;
unsigned char REG_DAC4_REGISTER_D;

// Initialize the SPI controller for DAC functions. This must be called before any DAC functions are called.
// In order to use radios after using DACs call the corresponding functions in WarpRadio.
// Initializes the Control and Divider Registers to their required values.
void WarpDac_InitializeSPI(unsigned int* baseaddr);

// This function initializes the selected DACs. Some register values need to be changed from the default
// and those changes are applied in this function. 'dacs' is the value that is applied to the Slave Select Register.
// This function must be called at the start of the program and needs to be called only once.
void WarpDac_InitializeDAC(unsigned int* baseaddr, unsigned char dacs);

// This function resets the DAC and restores the default values to the registers. 'dacs' refers the DACs in the slots
// that will be affected by this call. Initializes the DACs once they have been reset.
void WarpDac_Reset(unsigned int* baseaddr, unsigned char dacs);

// This function puts the DAC to sleep or takes it out of sleep mode. 'mode'=0 keeps it out of sleep mode while 'mode=1
// puts it in sleep mode. The DACs that are affected are specified in 'dacs'.
int WarpDac_Sleep(unsigned int* baseaddr, char mode, unsigned char dacs);

// Adjust the Fine Gain on the I and Q channels of the DAC. 'chan' = ICHAN changes the I channel fine gain while
// 'chan' = QCHAN affects the fine gain of the Q channel. The value is 8 bits wide and goes to the registers as
// required by the channel setting. 'dacs' refer to the DACs that are being affected by this function.
// Returns INVALID_MODE if the mode is incorrect. Returns WARP_SUCCESS if successful change.
int WarpDac_FineGainAdj(unsigned int* baseaddr, char chan, unsigned char value, unsigned char dacs);

// Adjust the Coarse Gain on the I and Q channels of the DAC. 'chan' = ICHAN changes the I channel coarse gain while
// 'chan' = QCHAN affects the coarse gain of the Q channel. The value is 4 bits wide and goes to the registers as
// required by the channel setting. 'dacs' refer to the DACs that are being affected by this function.
// Returns INVALID_MODE if the mode is incorrect. Returns WARP_SUCCESS if successful change.
int WarpDac_CoarseGainAdj(unsigned int* baseaddr, char chan, unsigned char value, unsigned char dacs);

// Adjust the DC Offset on the I and Q channels of the DAC. 'chan' = ICHAN changes the I channel DC offset while
// 'chan' = QCHAN affects the DC offset of the Q channel. The value can be a maximum of 1023 and minimum of -1024
// and goes to the registers as required by the channel setting. 'dacs' refer to the DACs that are being
// affected by this function.
// Returns INVALID_MODE if the mode is incorrect. Returns OUT_OF_RANGE is the value given
// is out of the range that can be supported. Returns WARP_SUCCESS if successful change.
int WarpDac_OffsetAdj(unsigned int* baseaddr, char chan, short value, unsigned char dacs);


#endif // RADIO_CONTROLLER_H
