/* Copyright (c) 2006 Rice University */
/* All Rights Reserved */
/* This code is covered by the Rice-WARP license */
/* See http://warp.rice.edu/license/ for details */


//////////////////////////////////////////////////////////////////////////////
// Filename:          C:\EDK_User_Repository\WARP\drivers\EEPROM_v1_00_a\src\EEPROM_l.h
// Version:           1.00.a
// Description:       EEPROM Driver Header File
// Date:              July 28, 2006
//////////////////////////////////////////////////////////////////////////////

#ifndef EEPROM_L_H
#define EEPROM_L_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 */
#define EEPROM_USER_SLAVE_SPACE_OFFSET (0x00000000)

/**
 * IPIF Reset/Mir Space Register Offsets
 * -- RST : software reset register
 * -- MIR : module identification register
 */
#define EEPROM_IPIF_RST_SPACE_OFFSET (0x00000100)
#define EEPROM_RST_OFFSET (EEPROM_IPIF_RST_SPACE_OFFSET + 0x00000000)
#define EEPROM_MIR_OFFSET (EEPROM_IPIF_RST_SPACE_OFFSET + 0x00000000)

/**
 * IPIF Reset/Mir Masks
 * -- IPIF_MAVN_MASK   : module major version number
 * -- IPIF_MIVN_MASK   : module minor version number
 * -- IPIF_MIVL_MASK   : module minor version letter
 * -- IPIF_BID_MASK    : module block id
 * -- IPIF_BTP_MASK    : module block type
 * -- IPIF_RESET       : software reset
 */
#define IPIF_MAVN_MASK (0xF0000000UL)
#define IPIF_MIVN_MASK (0x0FE00000UL)
#define IPIF_MIVL_MASK (0x001F0000UL)
#define IPIF_BID_MASK (0x0000FF00UL)
#define IPIF_BTP_MASK (0x000000FFUL)
#define IPIF_RESET (0x0000000A)

/**
 * IPIF Interrupt Controller Space Offsets
 * -- INTR_DISR  : device (ipif) interrupt status register
 * -- INTR_DIPR  : device (ipif) interrupt pending register
 * -- INTR_DIER  : device (ipif) interrupt enable register
 * -- INTR_DIIR  : device (ipif) interrupt id (priority encoder) register
 * -- INTR_DGIER : device (ipif) global interrupt enable register
 * -- INTR_ISR   : ip (user logic) interrupt status register
 * -- INTR_IER   : ip (user logic) interrupt enable register
 */
#define EEPROM_IPIF_INTR_SPACE_OFFSET (0x00000200)
#define EEPROM_INTR_DISR_OFFSET (EEPROM_IPIF_INTR_SPACE_OFFSET + 0x00000000)
#define EEPROM_INTR_DIPR_OFFSET (EEPROM_IPIF_INTR_SPACE_OFFSET + 0x00000004)
#define EEPROM_INTR_DIER_OFFSET (EEPROM_IPIF_INTR_SPACE_OFFSET + 0x00000008)
#define EEPROM_INTR_DIIR_OFFSET (EEPROM_IPIF_INTR_SPACE_OFFSET + 0x00000018)
#define EEPROM_INTR_DGIER_OFFSET (EEPROM_IPIF_INTR_SPACE_OFFSET + 0x0000001C)
#define EEPROM_INTR_ISR_OFFSET (EEPROM_IPIF_INTR_SPACE_OFFSET + 0x00000020)
#define EEPROM_INTR_IER_OFFSET (EEPROM_IPIF_INTR_SPACE_OFFSET + 0x00000028)

/**
 * IPIF Interrupt Controller Masks
 * -- INTR_TERR_MASK : transaction error
 * -- INTR_DPTO_MASK : data phase time-out
 * -- INTR_IPIR_MASK : ip interrupt requeset
 * -- INTR_DMA0_MASK : dma channel 0 interrupt request
 * -- INTR_DMA1_MASK : dma channel 1 interrupt request
 * -- INTR_RFDL_MASK : read packet fifo deadlock interrupt request
 * -- INTR_WFDL_MASK : write packet fifo deadlock interrupt request
 * -- INTR_IID_MASK  : interrupt id
 * -- INTR_GIE_MASK  : global interrupt enable
 * -- INTR_NOPEND    : the DIPR has no pending interrupts
 */
#define INTR_TERR_MASK (0x00000001UL)
#define INTR_DPTO_MASK (0x00000002UL)
#define INTR_IPIR_MASK (0x00000004UL)
#define INTR_DMA0_MASK (0x00000008UL)
#define INTR_DMA1_MASK (0x00000010UL)
#define INTR_RFDL_MASK (0x00000020UL)
#define INTR_WFDL_MASK (0x00000040UL)
#define INTR_IID_MASK (0x000000FFUL)
#define INTR_GIE_MASK (0x80000000UL)
#define INTR_NOPEND (0x80)

/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a EEPROM register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the EEPROM device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void EEPROM_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define EEPROM_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a EEPROM register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the EEPROM device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 EEPROM_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define EEPROM_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Reset EEPROM via software.
 *
 * @param   BaseAddress is the base address of the EEPROM device.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void EEPROM_mReset(Xuint32 BaseAddress)
 *
 */
#define EEPROM_mReset(BaseAddress) \
 	XIo_Out32((BaseAddress)+(EEPROM_RST_OFFSET), IPIF_RESET)

/**
 *
 * Read module identification information from EEPROM device.
 *
 * @param   BaseAddress is the base address of the EEPROM device.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 EEPROM_mReadMIR(Xuint32 BaseAddress)
 *
 */
#define EEPROM_mReadMIR(BaseAddress) \
 	XIo_In32((BaseAddress)+(EEPROM_MIR_OFFSET))

/************************** Function Prototypes ****************************/


/**
 *
 * Enable all possible interrupts from EEPROM device.
 *
 * @param   baseaddr_p is the base address of the EEPROM device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void EEPROM_EnableInterrupt(void * baseaddr_p);

/**
 *
 * Example interrupt controller handler.
 *
 * @param   baseaddr_p is the base address of the EEPROM device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void EEPROM_Intr_DefaultHandler(void * baseaddr_p);

/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the EEPROM instance to be worked on.
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
XStatus EEPROM_SelfTest(void * baseaddr_p);

/**************************WARP LIBRARIES******************************************/

#define COMMAND_REG_OFFSET          0x00
#define TXRXBUFFER_OFFSET           0x04
#define INTERRUPT_REG_OFFSET        0x08
#define ENABLE_INTERRUPT_REG_OFFSET 0x0C
#define CLKDIV_REG_OFFSET           0x10
#define CONTROL_REG_OFFSET          0x14

#define SUCCESS                     0x00
#define FAILURE                     0xff
#define NO_DEVICE                   0xfe
#define ABORT                       0xfa


// OPB_CLOCK defines which clock division should be made to drive the 1-wire bus
//  A value of 17 or 18 is suggested, to generate pulses on the one-wire interface
///  that are in-spec.
#define OPB_CLOCK 18  // Default for 40 MHz OPB-clock

// Initialize the EEPROM master for communication. Required before any communication
// can be made on the 1wire bus.  Must be done after a master reset.
// Sets the clock divisor based on the input.
// baseaddr is the base address of the EEPROM device.
// Returns SUCCESS if clock set correctly
// Returns FAILURE otherwise
char WarpEEPROM_Initialize(unsigned int* baseaddr);

// Send a Reset out on the 1-wire device and wait for a presence detect.
// Returns SUCCESS if device found
// Else returns FAILURE
char WarpEEPROM_Detect(unsigned int* baseaddr);

// Writes a byte to the transmit buffer
// Waits until buffer is empty before returning.
void WarpEEPROM_WriteByte(unsigned int* baseaddr, char data);

// Reads a data byte from the EEPROM
// The EEPROM must be ready to trasmit based on
// other commands.  Default value is FF.
char WarpEEPROM_ReadByte(unsigned int* baseaddr);

// Given a 64 bit ROM from an EEPROM, checks to see that the family code
// and serial number flies with the CRC.
// Serial is the 64 bit ROM information.
// Returns SUCCESS if no error, otherwise FAILURE
char WarpEEPROM_VerifyROM(unsigned char *Serial);

// This function verifies that the 16bit-CRC produced by the EEPROM
// jives with the information sent over the 1-wire bus during
// Read/Write Scratchpad commands.
// array is the 13-byte (11 + 2-byte CRC) or 14-byte (12 + 2-byte CRC)
// array of information
// RNW: 0 - if checking a write command, 1 -- if checking a read command
// Returns SUCCESS if no error, otherwise FAILURE
char WarpEEPROM_VerifyScratchpad(unsigned char *array, unsigned char RNW);

// Given an array of information and addressing information, this function writes
// the given information to the scratchpad of the EEPROM.  This must be done
// before information can be written to memory.
// baseaddr is the base address of the EEPROM device
// page must be 1-4, and refers to memory pages on the device
// sector must be 1-4, and refers to the appropriate sector on the device
// array must be an 8 byte array
char WarpEEPROM_WriteScratch(unsigned int* baseaddr, char page, char sector, unsigned char *array);

// This will read the current value in the scratchpad.
// Returns the two memory location bytes and the E/S byte necessary
// to copy the scratchpad to memory.
// baseaddr is the base address of the EEPROM device
// auth_code is a 3-byte array where the 3-bytes returned from the
// EEPROM will be stored
char WarpEEPROM_ReadScratch(unsigned int* baseaddr, unsigned char* auth_code);

// After the information in the scratchpad has been verified via CRC check, the
// scratchpad read, and the authorization code returned, this command will copy
// the scratchpad into the flash memory specified.
// baseaddr is the base address of the EEPROM device
// auth_code a 3 byte array containing the 2-byte memory location and
// 1-byte E/S regsiter value returned during a ReadScratch command.
// Returns SUCCESS if no error, otherwise FAILURE
char WarpEEPROM_Scratch2Mem(unsigned int* baseaddr, unsigned char* auth_code);

// This function reads from a specified memory location in the 1024-bit memory.
// Returns an 8-byte sector of the EEPROM.
// baseaddr is the base address of the EEPROM device
// page must be 0-3, and refers to memory pages on the device
// sector must be 0-3, and refers to the appropriate sector on the device
// array must be an 8 byte array
// Returns SUCCESS if no error, otherwise FAILURE
char WarpEEPROM_ReadMem(unsigned int* baseaddr, char page, char sector, unsigned char *array);

// Writes a given 8-byte array to a designated location in memory.
// Essentially a wrapper of the WriteScratch, ReadScratch and Scratch2Mem functions
// baseaddr is the base address of the EEPROM device
// page must be 0-3, and refers to memory pages on the device
// sector must be 0-3, and refers to the appropriate sector on the device
// array must be an 8 byte array
char WarpEEPROM_WriteMem(unsigned int* baseaddr, char page, char sector, unsigned char *array);

// Reads and outputs the values stored in the 5 protection bytes, the factory byte, and the
// two user bytes.
void WarpEEPROM_ReadControlBytes(unsigned int* baseaddr, char* control_regs); //, char* control_regs);

// Retrieves the type of board
char WarpEEPROM_GetDeviceType(unsigned int* baseaddr);

// A utility function for taking ascii input and turning it into a hex number
char WarpEEPROM_ascii2hex(unsigned char ascii);

// A utility function for taking two sequential keyboard inputs and
// returning a single hex byte.  Used for hex input from keyboard
char WarpEEPROM_ascii2hexbyte(unsigned char MSB, unsigned char LSB);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*************************************************************************************************************//
//*************************************************************************************************************//
//*************************************************************************************************************//
// THE FOLLOWING FUNCTION CAN BE USED TO WRITE TO THE WRITE PROTECTION BYTES AND THE TWO USER BYTES            //
//             SOME WRITES CAN NEVER BE CHANGED.  EVER.  USE AT YOUR OWN RISK.                                 //
//*************************************************************************************************************//
//*************************************************************************************************************//
//*************************************************************************************************************//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//***********************************************************************************************************
//***********************************************************************************************************
//**WARNING**: Writing to any of the protection bytes is **IRREVERSIBLE**!
//             Both the write protect and EPROM mode commands write protect the
//             register to which they are written.
//***********************************************************************************************************
//***********************************************************************************************************
//
// Writes to one of the five protection bytes (if not already copy protected) or
// to one of the User Bytes (if not copy protected).
// baseaddr is the base address of the EEPROM device
// ByteSelect:
//                0: Protection Control Byte Page 0
//                1: Protection Control Byte Page 1
//                2: Protection Control Byte Page 2
//                3: Protection Control Byte Page 3
//                4: Copy Protection Byte
//                5: User Byte #1
//                6: User Byte #2
//
char WarpEEPROM_ControlByteWrite(unsigned int* baseaddr, char ByteSelect, char value2store);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*************************************************************************************************************//
//*************************************************************************************************************//
//*************************************************************************************************************//
// THE ABOVE FUNCTION CAN BE USED TO WRITE TO THE WRITE PROTECTION BYTES AND THE TWO USER BYTES                //
//             SOME WRITES CAN NEVER BE CHANGED.  EVER.  USE AT YOUR OWN RISK.                                 //
//*************************************************************************************************************//
//*************************************************************************************************************//
//*************************************************************************************************************//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#endif // EEPROM_L_H
