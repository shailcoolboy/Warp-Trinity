//////////////////////////////////////////////////////////////////////////////
//
// ***************************************************************************
// **                                                                       **
// ** Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.            **
// **                                                                       **
// ** You may copy and modify these files for your own internal use solely  **
// ** with Xilinx programmable logic devices and Xilinx EDK system or       **
// ** create IP modules solely for Xilinx programmable logic devices and    **
// ** Xilinx EDK system. No rights are granted to distribute any files      **
// ** unless they are distributed in Xilinx programmable logic devices.     **
// **                                                                       **
// ***************************************************************************
//
//////////////////////////////////////////////////////////////////////////////
// Filename:          C:\edk_user_repository\MyProcessorIPLib\drivers\mgt_fifo1_v1_00_a\src\mgt_fifo1.h
// Version:           1.00.a
// Description:       mgt_fifo1 Driver Header File
// Date:              Tue Jul 05 10:18:48 2005 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////

#ifndef mgt_fifo1_H
#define mgt_fifo1_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLAVE_REG0 : user logic slave module register 0
 * -- SLAVE_REG1 : user logic slave module register 1
 */
#define mgt_fifo1_USER_SLAVE_SPACE_OFFSET (0x00000000)
#define mgt_fifo1_SLAVE_REG0_OFFSET (mgt_fifo1_USER_SLAVE_SPACE_OFFSET + 0x00000000)
#define mgt_fifo1_SLAVE_REG1_OFFSET (mgt_fifo1_USER_SLAVE_SPACE_OFFSET + 0x00000004)

/**
 * IPIF Reset Mask
 * -- IPIF_RESET       : software reset
 */
#define IPIF_RESET (0x0000000A)

/**
 * IPIF Read Packet FIFO Register/Data Space Offsets
 * -- RDFIFO_RST   : read packet fifo reset register
 * -- RDFIFO_MIR   : read packet fifo module identification register
 * -- RDFIFO_SR    : read packet fifo status register
 * -- RDFIFO_DATA  : read packet fifo data
 */
#define mgt_fifo1_IPIF_RDFIFO_REG_SPACE_OFFSET (0x00000100)
#define mgt_fifo1_RDFIFO_RST_OFFSET (mgt_fifo1_IPIF_RDFIFO_REG_SPACE_OFFSET + 0x00000000)
#define mgt_fifo1_RDFIFO_MIR_OFFSET (mgt_fifo1_IPIF_RDFIFO_REG_SPACE_OFFSET + 0x00000000)
#define mgt_fifo1_RDFIFO_SR_OFFSET (mgt_fifo1_IPIF_RDFIFO_REG_SPACE_OFFSET + 0x00000004)
#define mgt_fifo1_IPIF_RDFIFO_DATA_SPACE_OFFSET (0x00000200)
#define mgt_fifo1_RDFIFO_DATA_OFFSET (mgt_fifo1_IPIF_RDFIFO_DATA_SPACE_OFFSET + 0x00000000)

/**
 * IPIF Read Packet FIFO Masks
 * -- RDFIFO_EMPTY_MASK : read packet fifo empty condition
 * -- RDFIFO_AE_MASK    : read packet fifo almost empty condition
 * -- RDFIFO_DL_MASK    : read packet fifo deadlock condition
 * -- RDFIFO_SCL_MASK   : read packet fifo occupancy scaling enabled
 * -- RDFIFO_WIDTH_MASK : read packet fifo encoded data port width
 * -- RDFIFO_OCC_MASK   : read packet fifo occupancy
 */
#define RDFIFO_EMPTY_MASK (0x80000000UL)
#define RDFIFO_AE_MASK (0x40000000UL)
#define RDFIFO_DL_MASK (0x20000000UL)
#define RDFIFO_SCL_MASK (0x10000000UL)
#define RDFIFO_WIDTH_MASK (0x0E000000UL)
#define RDFIFO_OCC_MASK (0x01FFFFFFUL)

/**
 * IPIF Write Packet FIFO Register/Data Space Offsets
 * -- WRFIFO_RST   : write packet fifo reset register
 * -- WRFIFO_MIR   : write packet fifo module identification register
 * -- WRFIFO_SR    : write packet fifo status register
 * -- WRFIFO_DATA  : write packet fifo data
 */
#define mgt_fifo1_IPIF_WRFIFO_REG_SPACE_OFFSET (0x00000300)
#define mgt_fifo1_WRFIFO_RST_OFFSET (mgt_fifo1_IPIF_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define mgt_fifo1_WRFIFO_MIR_OFFSET (mgt_fifo1_IPIF_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define mgt_fifo1_WRFIFO_SR_OFFSET (mgt_fifo1_IPIF_WRFIFO_REG_SPACE_OFFSET + 0x00000004)
#define mgt_fifo1_IPIF_WRFIFO_DATA_SPACE_OFFSET (0x00000400)
#define mgt_fifo1_WRFIFO_DATA_OFFSET (mgt_fifo1_IPIF_WRFIFO_DATA_SPACE_OFFSET + 0x00000000)

/**
 * IPIF Write Packet FIFO Masks
 * -- WRFIFO_FULL_MASK  : write packet fifo full condition
 * -- WRFIFO_AF_MASK    : write packet fifo almost full condition
 * -- WRFIFO_DL_MASK    : write packet fifo deadlock condition
 * -- WRFIFO_SCL_MASK   : write packet fifo vacancy scaling enabled
 * -- WRFIFO_WIDTH_MASK : write packet fifo encoded data port width
 * -- WRFIFO_VAC_MASK   : write packet fifo vacancy
 */
#define WRFIFO_FULL_MASK (0x80000000UL)
#define WRFIFO_AF_MASK (0x40000000UL)
#define WRFIFO_DL_MASK (0x20000000UL)
#define WRFIFO_SCL_MASK (0x10000000UL)
#define WRFIFO_WIDTH_MASK (0x0E000000UL)
#define WRFIFO_VAC_MASK (0x01FFFFFFUL)

/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a mgt_fifo1 register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the mgt_fifo1 device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void mgt_fifo1_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define mgt_fifo1_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a mgt_fifo1 register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the mgt_fifo1 device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 mgt_fifo1_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define mgt_fifo1_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read value to/from mgt_fifo1 user logic slave registers.
 *
 * @param   BaseAddress is the base address of the mgt_fifo1 device.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 mgt_fifo1_mReadSlaveRegn(Xuint32 BaseAddress)
 *
 */
#define mgt_fifo1_mWriteSlaveReg0(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (mgt_fifo1_SLAVE_REG0_OFFSET), (Xuint32)(Value))
#define mgt_fifo1_mWriteSlaveReg1(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (mgt_fifo1_SLAVE_REG1_OFFSET), (Xuint32)(Value))

#define mgt_fifo1_mReadSlaveReg0(BaseAddress) \
 	XIo_In32((BaseAddress) + (mgt_fifo1_SLAVE_REG0_OFFSET))
#define mgt_fifo1_mReadSlaveReg1(BaseAddress) \
 	XIo_In32((BaseAddress) + (mgt_fifo1_SLAVE_REG1_OFFSET))

/**
 *
 * Reset read packet FIFO of mgt_fifo1 to its initial state.
 *
 * @param   BaseAddress is the base address of the mgt_fifo1 device.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void mgt_fifo1_mResetReadFIFO(Xuint32 BaseAddress)
 *
 */
#define mgt_fifo1_mResetReadFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(mgt_fifo1_RDFIFO_RST_OFFSET), IPIF_RESET)

/**
 *
 * Check status of mgt_fifo1 read packet FIFO module.
 *
 * @param   BaseAddress is the base address of the mgt_fifo1 device.
 *
 * @return  Status is the result of status checking.
 *
 * @note    None.
 *
 * C-style signature:
 * 	bool mgt_fifo1_mReadFIFOEmpty(Xuint32 BaseAddress)
 * 	Xuint32 mgt_fifo1_mReadFIFOOccupancy(Xuint32 BaseAddress)
 *
 */
#define mgt_fifo1_mReadFIFOEmpty(BaseAddress) \
 	((XIo_In32((BaseAddress)+(mgt_fifo1_RDFIFO_SR_OFFSET)) & RDFIFO_EMPTY_MASK) == RDFIFO_EMPTY_MASK)
#define mgt_fifo1_mReadFIFOOccupancy(BaseAddress) \
 	((XIo_In32((BaseAddress)+(mgt_fifo1_RDFIFO_SR_OFFSET)) & RDFIFO_OCC_MASK) == RDFIFO_OCC_MASK)

/**
 *
 * Read data from mgt_fifo1 read packet FIFO module.
 *
 * @param   BaseAddress is the base address of the mgt_fifo1 device.
 *
 * @return  Data is the data from the read packet FIFO.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 mgt_fifo1_mReadFromFIFO(Xuint32 BaseAddress)
 *
 */
#define mgt_fifo1_mReadFromFIFO(BaseAddress) \
 	XIo_In32((BaseAddress) + (mgt_fifo1_RDFIFO_DATA_OFFSET))

/**
 *
 * Reset write packet FIFO of mgt_fifo1 to its initial state.
 *
 * @param   BaseAddress is the base address of the mgt_fifo1 device.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void mgt_fifo1_mResetWriteFIFO(Xuint32 BaseAddress)
 *
 */
#define mgt_fifo1_mResetWriteFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(mgt_fifo1_WRFIFO_RST_OFFSET), IPIF_RESET)

/**
 *
 * Check status of mgt_fifo1 write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the mgt_fifo1 device.
 *
 * @return  Status is the result of status checking.
 *
 * @note    None.
 *
 * C-style signature:
 * 	bool mgt_fifo1_mWriteFIFOFull(Xuint32 BaseAddress)
 * 	Xuint32 mgt_fifo1_mWriteFIFOVacancy(Xuint32 BaseAddress)
 *
 */
#define mgt_fifo1_mWriteFIFOFull(BaseAddress) \
 	((XIo_In32((BaseAddress)+(mgt_fifo1_WRFIFO_SR_OFFSET)) & WRFIFO_FULL_MASK) == WRFIFO_FULL_MASK)
#define mgt_fifo1_mWriteFIFOVacancy(BaseAddress) \
 	((XIo_In32((BaseAddress)+(mgt_fifo1_WRFIFO_SR_OFFSET)) & WRFIFO_VAC_MASK) == WRFIFO_VAC_MASK)

/**
 *
 * Write data to mgt_fifo1 write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the mgt_fifo1 device.
 * @param   Data is the value to be written to write packet FIFO.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void mgt_fifo1_mWriteToFIFO(Xuint32 BaseAddress, Xuint32 Data)
 *
 */
#define mgt_fifo1_mWriteToFIFO(BaseAddress, Data) \
 	XIo_Out32((BaseAddress) + (mgt_fifo1_WRFIFO_DATA_OFFSET), (Xuint32)(Data))

/************************** Function Prototypes ****************************/


/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the mgt_fifo1 instance to be worked on.
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
XStatus mgt_fifo1_SelfTest(void * baseaddr_p);

#endif // mgt_fifo1_H
