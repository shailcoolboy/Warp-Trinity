// Copyright (c) 2006 Rice University
// All Rights Reserved
// This code is covered by the Rice-WARP license
// See http://warp.rice.edu/license/ for details

/**
 * \file radio_prototypes.h
 * \brief Header file containing macros and defines for all radio controller drivers.
 *
 * @version 1.09
 * @author Siddharth Gupta
 *
 * This header file contains all the macros responsible for writing to the
 * radio controller hardware registers. It also has the external definitions
 * of the local copies of the radio registers.
 */


#ifndef RADIO_PROTOTYPES_H
#define RADIO_PROTOTYPES_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/*
 * User Logic Slave Space Offsets
 * -- SLAVE_REG0 : user logic slave module register 0
 * -- SLAVE_REG1 : user logic slave module register 1
 * -- SLAVE_REG2 : user logic slave module register 2
 * -- SLAVE_REG3 : user logic slave module register 3
 * -- SLAVE_REG4 : user logic slave module register 4
 * -- SLAVE_REG5 : user logic slave module register 5
 * -- SLAVE_REG6 : user logic slave module register 6
 * -- SLAVE_REG7 : user logic slave module register 7
 * -- SLAVE_REG8 : user logic slave module register 8
 * -- SLAVE_REG9 : user logic slave module register 9
 * -- SLAVE_REG10 : user logic slave module register 10
 * -- SLAVE_REG11 : user logic slave module register 11
 * -- SLAVE_REG12 : user logic slave module register 12
 * -- SLAVE_REG13 : user logic slave module register 13
 * -- SLAVE_REG14 : user logic slave module register 14
 * -- SLAVE_REG15 : user logic slave module register 15
 * -- SLAVE_REG16 : user logic slave module register 16
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
#define RADIO_CONTROLLER_SLAVE_REG16_OFFSET (RADIO_CONTROLLER_USER_SLAVE_SPACE_OFFSET + 0x00000040)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/*
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
 * @note
 * C-style signature:
 * 	void RADIO_CONTROLLER_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define RADIO_CONTROLLER_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/*
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
 * @note
 * C-style signature:
 * 	Xuint32 RADIO_CONTROLLER_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define RADIO_CONTROLLER_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/*
 *
 * Write/Read value to/from RADIO_CONTROLLER user logic slave registers.
 *
 * @param   BaseAddress is the base address of the RADIO_CONTROLLER device.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
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
#define RADIO_CONTROLLER_mWriteSlaveReg16(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG16_OFFSET), (Xuint32)(Value))

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
#define RADIO_CONTROLLER_mReadSlaveReg16(BaseAddress) \
 	XIo_In32((BaseAddress) + (RADIO_CONTROLLER_SLAVE_REG16_OFFSET))

/********************** Radio Controller Definitions ***********************/

/// Use to apply any function to radio in slot 1 ('radios' input).
#define RADIO1_ADDR 0x11111111
/// Use to apply any function to radio in slot 2 ('radios' input).
#define RADIO2_ADDR 0x22222222
/// Use to apply any function to radio in slot 3 ('radios' input).
#define RADIO3_ADDR 0x44444444
/// Use to apply any function to radio in slot 4 ('radios' input).
#define RADIO4_ADDR 0x88888888

#define RAD1MASK 0x0001
#define RAD2MASK 0x0002
#define RAD3MASK 0x0004
#define RAD4MASK 0x0008
#define SLAVEMASK 0x000F
#define SLVREGRDMSK 0x002063EF
#define DAC1MASK 0x0010
#define DAC2MASK 0x0020
#define DAC3MASK 0x0040
#define DAC4MASK 0x0080
#define SLAVEMASKDAC 0x00F0

/// Return value from a function if successful completion.
#define WARP_SUCCESS 0
#define NOT_IN_CALIBRATION -2
/// Return value from a function if input gain value invalid.
#define INVALID_GAIN -1
/// Return value from a function if input frequency invalid.
#define INVALID_FREQ -1
/// Return value from a function if input mode invalid.
#define INVALID_MODE -1
/// Return value from a function if value given is out of range.
#define OUT_OF_RANGE -2
/// Use if function applies to I channel of DAC.
#define ICHAN 1
/// Use if function applies to Q channel of DAC.
#define QCHAN 2

/*-- Masks for all slave register bit locations --*/

#define RAD_SHDN_MASK				0x0000000F
#define RAD_SHDN_CON_MASK			0x000000F0
#define RAD_TXEN_MASK				0x00000F00
#define RAD_TXEN_CON_MASK			0x0000F000
#define RAD_RXEN_MASK				0x000F0000
#define RAD_RXEN_CON_MASK			0x00F00000
#define RAD_RXHP_MASK				0x0F000000
#define RAD_RXHP_CON_MASK			0xF0000000
#define RAD_24PA_MASK				0x0000000F
#define RAD_5PA_MASK				0x000000F0
#define RAD_LD_MASK					0x00000F00
#define RAD_ANTSW_MASK				0x000F0000
#define RAD_TX_DAC_RESET_MASK		0x00F00000
#define RAD_ADC_RX_DCS_MASK			0x0F000000
#define RAD_ADC_RX_DFS_MASK			0xF0000000
#define RAD_ADC_RX_OTRA_MASK		0x0000000F
#define RAD_ADC_RX_OTRB_MASK		0x000000F0
#define RAD_ADC_RX_PWDNA_MASK		0x00000F00
#define RAD_ADC_RX_PWDNB_MASK		0x0000F000
#define RAD_RSSI_ADC_SLEEP_MASK		0x000F0000
#define RAD_RSSI_ADC_OTR_MASK		0x00F00000
#define RAD_RSSI_ADC_HIZ_MASK		0x0F000000
#define RAD_RSSI_ADC_CLAMP_MASK		0xF0000000
#define RAD_DIPSW_L_MASK			0x00003C00
#define RAD_DIPSW_H_MASK			0x3C000000
#define RAD_TX_DAC_PLL_LOCK_MASK	0x80008000
#define RAD_RSSI_ADC_D_L_MASK		0x000003FF
#define RAD_RSSI_ADC_D_H_MASK		0x03FF0000

/*-- Local copies of radio registers --*/

// RADIO 1
extern unsigned short REG_RAD1_REGISTER_0;
extern unsigned short REG_RAD1_REGISTER_1;
extern unsigned short REG_RAD1_STANDBY;
extern unsigned short REG_RAD1_INTEGER_DIVIDER_RATIO;
extern unsigned short REG_RAD1_FRACTIONAL_DIVIDER_RATIO;
extern unsigned short REG_RAD1_BAND_SELECT;
extern unsigned short REG_RAD1_CALIBRATION;
extern unsigned short REG_RAD1_LOWPASS_FILTER;
extern unsigned short REG_RAD1_RX_CONTROL;
extern unsigned short REG_RAD1_TX_LINEARITY;
extern unsigned short REG_RAD1_PA_BIAS_DAC;
extern unsigned short REG_RAD1_RX_GAIN;
extern unsigned short REG_RAD1_TX_VGA_GAIN;

// RADIO 2
extern unsigned short REG_RAD2_REGISTER_0;
extern unsigned short REG_RAD2_REGISTER_1;
extern unsigned short REG_RAD2_STANDBY;
extern unsigned short REG_RAD2_INTEGER_DIVIDER_RATIO;
extern unsigned short REG_RAD2_FRACTIONAL_DIVIDER_RATIO;
extern unsigned short REG_RAD2_BAND_SELECT;
extern unsigned short REG_RAD2_CALIBRATION;
extern unsigned short REG_RAD2_LOWPASS_FILTER;
extern unsigned short REG_RAD2_RX_CONTROL;
extern unsigned short REG_RAD2_TX_LINEARITY;
extern unsigned short REG_RAD2_PA_BIAS_DAC;
extern unsigned short REG_RAD2_RX_GAIN;
extern unsigned short REG_RAD2_TX_VGA_GAIN;

// RADIO 3
extern unsigned short REG_RAD3_REGISTER_0;
extern unsigned short REG_RAD3_REGISTER_1;
extern unsigned short REG_RAD3_STANDBY;
extern unsigned short REG_RAD3_INTEGER_DIVIDER_RATIO;
extern unsigned short REG_RAD3_FRACTIONAL_DIVIDER_RATIO;
extern unsigned short REG_RAD3_BAND_SELECT;
extern unsigned short REG_RAD3_CALIBRATION;
extern unsigned short REG_RAD3_LOWPASS_FILTER;
extern unsigned short REG_RAD3_RX_CONTROL;
extern unsigned short REG_RAD3_TX_LINEARITY;
extern unsigned short REG_RAD3_PA_BIAS_DAC;
extern unsigned short REG_RAD3_RX_GAIN;
extern unsigned short REG_RAD3_TX_VGA_GAIN;

// RADIO 4
extern unsigned short REG_RAD4_REGISTER_0;
extern unsigned short REG_RAD4_REGISTER_1;
extern unsigned short REG_RAD4_STANDBY;
extern unsigned short REG_RAD4_INTEGER_DIVIDER_RATIO;
extern unsigned short REG_RAD4_FRACTIONAL_DIVIDER_RATIO;
extern unsigned short REG_RAD4_BAND_SELECT;
extern unsigned short REG_RAD4_CALIBRATION;
extern unsigned short REG_RAD4_LOWPASS_FILTER;
extern unsigned short REG_RAD4_RX_CONTROL;
extern unsigned short REG_RAD4_TX_LINEARITY;
extern unsigned short REG_RAD4_PA_BIAS_DAC;
extern unsigned short REG_RAD4_RX_GAIN;
extern unsigned short REG_RAD4_TX_VGA_GAIN;

unsigned int* radio_controller_baseaddr;

extern unsigned int clkRatio;

void transmit(int val);

void transRadio(int ssval, unsigned int val);

void transmitdac(int val);

#endif
