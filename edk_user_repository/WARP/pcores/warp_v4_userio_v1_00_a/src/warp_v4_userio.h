/*****************************************************************************
* Filename:          /home/sgupta/edkwork/hex_disp_ise/custom_periph/MyProcessorIPLib/drivers/warp_v4_userio_v1_00_a/src/warp_v4_userio.h
* Version:           1.00.a
* Description:       warp_v4_userio Driver Header File
* Date:              Mon Oct  5 10:19:41 2009 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef WARP_V4_USERIO_H
#define WARP_V4_USERIO_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 * -- SLV_REG1 : user logic slave module register 1
 * -- SLV_REG2 : user logic slave module register 2
 * -- SLV_REG3 : user logic slave module register 3
 * -- SLV_REG4 : user logic slave module register 4
 */
#define WARP_V4_USERIO_USER_SLV_SPACE_OFFSET (0x00000000)
#define WARP_V4_USERIO_SLV_REG0_OFFSET (WARP_V4_USERIO_USER_SLV_SPACE_OFFSET + 0x00000000)
#define WARP_V4_USERIO_SLV_REG1_OFFSET (WARP_V4_USERIO_USER_SLV_SPACE_OFFSET + 0x00000004)
#define WARP_V4_USERIO_SLV_REG2_OFFSET (WARP_V4_USERIO_USER_SLV_SPACE_OFFSET + 0x00000008)
#define WARP_V4_USERIO_SLV_REG3_OFFSET (WARP_V4_USERIO_USER_SLV_SPACE_OFFSET + 0x0000000C)
#define WARP_V4_USERIO_SLV_REG4_OFFSET (WARP_V4_USERIO_USER_SLV_SPACE_OFFSET + 0x00000010)


/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a WARP_V4_USERIO register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the WARP_V4_USERIO device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void WARP_V4_USERIO_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define WARP_V4_USERIO_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a WARP_V4_USERIO register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the WARP_V4_USERIO device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 WARP_V4_USERIO_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define WARP_V4_USERIO_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from WARP_V4_USERIO user logic slave registers.
 *
 * @param   BaseAddress is the base address of the WARP_V4_USERIO device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void WARP_V4_USERIO_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 WARP_V4_USERIO_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define WARP_V4_USERIO_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (WARP_V4_USERIO_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define WARP_V4_USERIO_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (WARP_V4_USERIO_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define WARP_V4_USERIO_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (WARP_V4_USERIO_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define WARP_V4_USERIO_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (WARP_V4_USERIO_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))
#define WARP_V4_USERIO_mWriteSlaveReg4(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (WARP_V4_USERIO_SLV_REG4_OFFSET) + (RegOffset), (Xuint32)(Value))

#define WARP_V4_USERIO_mReadSlaveReg0(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (WARP_V4_USERIO_SLV_REG0_OFFSET) + (RegOffset))
#define WARP_V4_USERIO_mReadSlaveReg1(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (WARP_V4_USERIO_SLV_REG1_OFFSET) + (RegOffset))
#define WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (WARP_V4_USERIO_SLV_REG2_OFFSET) + (RegOffset))
#define WARP_V4_USERIO_mReadSlaveReg3(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (WARP_V4_USERIO_SLV_REG3_OFFSET) + (RegOffset))
#define WARP_V4_USERIO_mReadSlaveReg4(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (WARP_V4_USERIO_SLV_REG4_OFFSET) + (RegOffset))


/* Register descriptions
 * SlaveReg0 - Output register: 8 LSB bits output to the LEDs
 * SlaveReg1 - Input register: 4 LSB are pushbuttons and 4 above that are dip switches
 * SlaveReg2 - Hex displays in number mode. When in number mode
 			   the bits in this register are mapped to numbers on the displays
 * SlaveReg3 - Hex displays in raw mode. When in raw mode, the bits are directly
 			   output to the hex displays
 * SlaveReg4 - Control register: Setup parameters for hex display control
 
 Refer to http://warp.rice.edu/trac/wiki/HardwareUsersGuides/FPGABoard_v2.2/UserIO for details.
*/

#define LEFTHEX_OFFSET_NUM 16
#define MIDHEX_OFFSET_NUM 8
#define RIGHTHEX_OFFSET_NUM 0

#define LEFTHEX_OFFSET_RAW 24
#define MIDHEX_OFFSET_RAW 16
#define RIGHTHEX_OFFSET_RAW 8
#define IOEX_LEDS_OFFSET_RAW 0

#define LEDMASK 0x000000FF
#define PBMASK 0x0000000F
#define DIPMASK 0x000000F0

//Bit masks for user inputs (buttons & switches)
#define USERIO_MASK_DIPSW	0xF0
#define USERIO_MASK_PB		0x0F
#define USERIO_MASK_PBC		0x01
#define USERIO_MASK_PBR		0x02
#define USERIO_MASK_PBL		0x04
#define USERIO_MASK_PBU		0x08


#define LED_OFFSET 0
#define PB_OFFSET 0
#define DIP_OFFSET 4

#define LEFTHEX_NUM_MODE 0x00000004
#define MIDHEX_NUM_MODE 0x00000002
#define RIGHTHEX_NUM_MODE 0x00000001

#define LEFTHEX_NUM_VAL 0x001F0000
#define MIDHEX_NUM_VAL 0x00001F00
#define RIGHTHEX_NUM_VAL 0x0000001F

#define HEX_OFF_ON 0x00000020


#define WarpV4_UserIO_Leds(BaseAddress, Value) \
	WARP_V4_USERIO_mWriteSlaveReg0(BaseAddress, 0, (Value & LEDMASK))
#define WarpV4_UserIO_PushB(BaseAddress) \
	((WARP_V4_USERIO_mReadSlaveReg1(BaseAddress, 0) & PBMASK) >> PB_OFFSET)
#define WarpV4_UserIO_DipSw(BaseAddress) \
	((WARP_V4_USERIO_mReadSlaveReg1(BaseAddress, 0) & DIPMASK) >> DIP_OFFSET)
	
#define WarpV4_UserIO_NumberMode_All(BaseAddress) \
	WARP_V4_USERIO_mWriteSlaveReg4(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg4(BaseAddress, 0) | (LEFTHEX_NUM_MODE | MIDHEX_NUM_MODE | RIGHTHEX_NUM_MODE)))
#define WarpV4_UserIO_NumberMode_LeftHex(BaseAddress) \
	WARP_V4_USERIO_mWriteSlaveReg4(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg4(BaseAddress, 0) | LEFTHEX_NUM_MODE))
#define WarpV4_UserIO_NumberMode_MiddleHex(BaseAddress) \
	WARP_V4_USERIO_mWriteSlaveReg4(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg4(BaseAddress, 0) | MIDHEX_NUM_MODE))
#define WarpV4_UserIO_NumberMode_RightHex(BaseAddress) \
	WARP_V4_USERIO_mWriteSlaveReg4(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg4(BaseAddress, 0) | RIGHTHEX_NUM_MODE))

#define WarpV4_UserIO_WriteNumber_LeftHex(BaseAddress, NumberTW, DecimalPoint) \
	WARP_V4_USERIO_mWriteSlaveReg2(BaseAddress, 0, (((WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, 0) & ~LEFTHEX_NUM_VAL) | ((NumberTW & 0x0000000F) << LEFTHEX_OFFSET_NUM)) | ((DecimalPoint & 0x00000001) << (LEFTHEX_OFFSET_NUM+4))))
#define WarpV4_UserIO_WriteNumber_MiddleHex(BaseAddress, NumberTW, DecimalPoint) \
	WARP_V4_USERIO_mWriteSlaveReg2(BaseAddress, 0, (((WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, 0) & ~MIDHEX_NUM_VAL) | ((NumberTW & 0x0000000F) << MIDHEX_OFFSET_NUM)) | ((DecimalPoint & 0x00000001) << (MIDHEX_OFFSET_NUM+4))))
#define WarpV4_UserIO_WriteNumber_RightHex(BaseAddress, NumberTW, DecimalPoint) \
	WARP_V4_USERIO_mWriteSlaveReg2(BaseAddress, 0, (((WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, 0) & ~RIGHTHEX_NUM_VAL) | ((NumberTW & 0x0000000F) << RIGHTHEX_OFFSET_NUM)) | ((DecimalPoint & 0x00000001) << (RIGHTHEX_OFFSET_NUM+4))))

#define WarpV4_UserIO_ReadNumber_LeftHex(BaseAddress) \
	((WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, 0) & LEFTHEX_NUM_VAL) >> LEFTHEX_OFFSET_NUM)
#define WarpV4_UserIO_ReadNumber_MiddleHex(BaseAddress) \
	((WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, 0) & MIDHEX_NUM_VAL) >> MIDHEX_OFFSET_NUM)
#define WarpV4_UserIO_ReadNumber_RightHex(BaseAddress) \
	((WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, 0) & RIGHTHEX_NUM_VAL) >> RIGHTHEX_OFFSET_NUM)

#define WarpV4_UserIO_LeftHex_Off(BaseAddress) \
	WARP_V4_USERIO_mWriteSlaveReg2(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, 0) | (HEX_OFF_ON << LEFTHEX_OFFSET_NUM)))
#define WarpV4_UserIO_MiddleHex_Off(BaseAddress) \
	WARP_V4_USERIO_mWriteSlaveReg2(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, 0) | (HEX_OFF_ON << MIDHEX_OFFSET_NUM)))
#define WarpV4_UserIO_RightHex_Off(BaseAddress) \
	WARP_V4_USERIO_mWriteSlaveReg2(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, 0) | (HEX_OFF_ON << RIGHTHEX_OFFSET_NUM)))

#define WarpV4_UserIO_LeftHex_On(BaseAddress) \
	WARP_V4_USERIO_mWriteSlaveReg2(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, 0) & ~(HEX_OFF_ON << LEFTHEX_OFFSET_NUM)))
#define WarpV4_UserIO_MiddleHex_On(BaseAddress) \
	WARP_V4_USERIO_mWriteSlaveReg2(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, 0) & ~(HEX_OFF_ON << MIDHEX_OFFSET_NUM)))
#define WarpV4_UserIO_RightHex_On(BaseAddress) \
	WARP_V4_USERIO_mWriteSlaveReg2(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg2(BaseAddress, 0) & ~(HEX_OFF_ON << RIGHTHEX_OFFSET_NUM)))

#define WarpV4_UserIO_Write_ExtraLeds(BaseAddress, Value) \
	WARP_V4_USERIO_mWriteSlaveReg3(BaseAddress, 0, ((WARP_V4_USERIO_mReadSlaveReg3(BaseAddress, 0) & ~(LEDMASK << IOEX_LEDS_OFFSET_RAW)) | ((Value & LEDMASK) << IOEX_LEDS_OFFSET_RAW)))
#define WarpV4_UserIO_WriteRaw_LeftHex(BaseAddress, Value) \
	WARP_V4_USERIO_mWriteSlaveReg3(BaseAddress, 0, ((WARP_V4_USERIO_mReadSlaveReg3(BaseAddress, 0) & ~(LEDMASK << LEFTHEX_OFFSET_RAW)) | ((Value & LEDMASK) << LEFTHEX_OFFSET_RAW)))
#define WarpV4_UserIO_WriteRaw_MiddleHex(BaseAddress, Value) \
	WARP_V4_USERIO_mWriteSlaveReg3(BaseAddress, 0, ((WARP_V4_USERIO_mReadSlaveReg3(BaseAddress, 0) & ~(LEDMASK << MIDHEX_OFFSET_RAW)) | ((Value & LEDMASK) << MIDHEX_OFFSET_RAW)))
#define WarpV4_UserIO_WriteRaw_RightHex(BaseAddress, Value) \
	WARP_V4_USERIO_mWriteSlaveReg3(BaseAddress, 0, ((WARP_V4_USERIO_mReadSlaveReg3(BaseAddress, 0) & ~(LEDMASK << RIGHTHEX_OFFSET_RAW)) | ((Value & LEDMASK) << RIGHTHEX_OFFSET_RAW)))

#define WarpV4_UserIO_Read_ExtraLeds(BaseAddress) \
	((WARP_V4_USERIO_mReadSlaveReg3(BaseAddress, 0) >> IOEX_LEDS_OFFSET_RAW) & LEDMASK)
#define WarpV4_UserIO_ReadRaw_LeftHex(BaseAddress) \
	((WARP_V4_USERIO_mReadSlaveReg3(BaseAddress, 0) >> LEFTHEX_OFFSET_RAW) & LEDMASK)
#define WarpV4_UserIO_ReadRaw_MiddleHex(BaseAddress) \
	((WARP_V4_USERIO_mReadSlaveReg3(BaseAddress, 0) >> MIDHEX_OFFSET_RAW) & LEDMASK)
#define WarpV4_UserIO_ReadRaw_RightHex(BaseAddress) \
	((WARP_V4_USERIO_mReadSlaveReg3(BaseAddress, 0) >> RIGHTHEX_OFFSET_RAW) & LEDMASK)

#define WarpV4_UserIO_RawMode_All(BaseAddress) \
	{ \
		WarpV4_UserIO_WriteRaw_LeftHex(BaseAddress, WarpV4_UserIO_ReadRaw_LeftHex(BaseAddress)); \
		WarpV4_UserIO_WriteRaw_MiddleHex(BaseAddress, WarpV4_UserIO_ReadRaw_MiddleHex(BaseAddress)); \
		WarpV4_UserIO_WriteRaw_RightHex(BaseAddress, WarpV4_UserIO_ReadRaw_RightHex(BaseAddress)); \
		WARP_V4_USERIO_mWriteSlaveReg4(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg4(BaseAddress, 0) & ~(LEFTHEX_NUM_MODE | MIDHEX_NUM_MODE | RIGHTHEX_NUM_MODE))); \
	}
#define WarpV4_UserIO_RawMode_LeftHex(BaseAddress) \
	{ \
		WarpV4_UserIO_WriteRaw_LeftHex(BaseAddress, WarpV4_UserIO_ReadRaw_LeftHex(BaseAddress)); \
		WARP_V4_USERIO_mWriteSlaveReg4(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg4(BaseAddress, 0) & ~LEFTHEX_NUM_MODE)); \
	}
#define WarpV4_UserIO_RawMode_MiddleHex(BaseAddress) \
	{ \
		WarpV4_UserIO_WriteRaw_MiddleHex(BaseAddress, WarpV4_UserIO_ReadRaw_MiddleHex(BaseAddress)); \
		WARP_V4_USERIO_mWriteSlaveReg4(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg4(BaseAddress, 0) & ~MIDHEX_NUM_MODE)); \
	}
#define WarpV4_UserIO_RawMode_RightHex(BaseAddress) \
	{ \
		WarpV4_UserIO_WriteRaw_RightHex(BaseAddress, WarpV4_UserIO_ReadRaw_RightHex(BaseAddress)); \
		WARP_V4_USERIO_mWriteSlaveReg4(BaseAddress, 0, (WARP_V4_USERIO_mReadSlaveReg4(BaseAddress, 0) & ~RIGHTHEX_NUM_MODE)); \
	}


/************************** Function Prototypes ****************************/



#endif /** WARP_V4_USERIO_H */
