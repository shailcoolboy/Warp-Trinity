/* Copyright (c) 2006 Rice University */
/* All Rights Reserved */
/* This code is covered by the Rice-WARP license */
/* See http://warp.rice.edu/license/ for details */


//////////////////////////////////////////////////////////////////////////////
// Filename:          C:\EDK_User_Repository\WARP\drivers\EEPROM_v1_00_a\src\EEPROM.h
// Version:           1.00.a
// Description:       EEPROM Driver Header File
// Date:              July 28, 2006
//////////////////////////////////////////////////////////////////////////////

#ifndef EEPROM_H
#define EEPROM_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"
#include "EEPROM_l.h"

/**************************WARP LIBRARIES******************************************/


// Choose the EEPROM to be affected by subsequent reads/writes
// baseaddr is the base address of the EEPROM peripheral
// EEPROM_select selects the appropriate EEPROM to drive
//   0: FPGA Board  1: Radio1  2: Radio2  3: Radio3  4: Radio4 
// Returns SUCCESS if clock set correctly
// Returns FAILURE otherwise 
char WarpEEPROM_EEPROMSelect(unsigned int* baseaddr, char EEPROM_select);

// This function checks to see if a valid calibration value is stored on the EEPROM
// and returns the value if there is.
// baseaddr is the base address of the EEPROM peripheral
// RxNTx specifies whether the values are the Rx or Tx values. 1 indicates Rx
// val_select selects which value to write
//   1: DC offset    2: Gain IQ     3: Phase IQ
// Returns a short where the most significant byte is the Q-value and 
// the least significant byte is the I-value.
short WarpEEPROM_ReadRadioCal(unsigned int* baseaddr, char RxNTx, char val_select);

// This functions writes a calibration value to the EEPROM
// baseaddr is the base address of the EEPROM peripheral
// RxNTx specifies whether the values are the Rx or Tx values. 1 indicates Rx
// val_select selects which value to write
//   1: DC offset    2: Gain IQ     3: Phase IQ
// I_val is the I-component to be stored
// Q_val is the Q-component to be stored
// Returns SUCCESS (0x00) if all goes well, FAILURE (0xff) otherwise
char WarpEEPROM_WriteRadioCal(unsigned int* baseaddr, char RxNTx, char val_select, char I_val, char Q_val);

// This function writes a 6-byte MAC address into a 6-byte array addressed by a pointer.
// baseaddr is the base address of the EEPROM peripheral
// dev_select specifies which device's MAC address to read
//    0: FPGA Board   1: Radio1   2: Radio2   3: Radio3   4: Radio4
// *MAC is a pointer to a 6-byte array
void WarpEEPROM_ReadMACAddress(unsigned int* baseaddr, char dev_select, char *MAC);

// This function writes a 6-byte MAC address into the EEPROM.
// baseaddr is the base address of the EEPROM peripheral
// dev_select specifies which device's MAC address to read
//    0: FPGA Board   1: Radio1   2: Radio2   3: Radio3   4: Radio4
// *MAC is a pointer to a 6-byte array containing the address
// Returns SUCCESS (0x00) if all goes well, FAILURE (0xff) otherwise
char WarpEEPROM_WriteMACAddress(unsigned int* baseaddr, char dev_select, char *MAC);

// Returns the the 2-byte serial number assigned by Rice WARP
// baseaddr is the base address of the EEPROM peripheral
short WarpEEPROM_ReadWARPSerial(unsigned int* baseaddr);

// Get Serial number from a EEPROM device.  Assumes it is the only device on the bus.
// baseaddr is the base address of the EEPROM peripheral
// returns a memory array containing the 1 byte family code, 6 byte serial
// serial number and 1 byte CRC value
// *Serial is a pointer to an 8-byte array
// Returns SUCCESS (0x00) if all goes well, FAILURE (0xff) otherwise
char WarpEEPROM_ReadDSSerial(unsigned int* baseaddr, unsigned char *Serial);

// This function reads from a specified memory location in the 1024-bit memory.
// Returns an 8-byte sector of the EEPROM. 
// baseaddr is the base address of the EEPROM peripheral
// page must be 1-3, and refers to memory pages on the device
// sector must be 1-3, and refers to the appropriate sector on the device
// *array is a pointer to an 8-byte array
// Returns SUCCESS (0x00) if all goes well, FAILURE (0xff) otherwise
char WarpEEPROM_ReadUserMem(unsigned int* baseaddr, char page, char sector, unsigned char *array);

// Writes a given 8-byte array to a designated location in memory.
// Essentially a wrapper of the WriteScratch, ReadScratch and Scratch2Mem functions
// baseaddr is the base address of the EEPROM peripheral
// page must be 1-3, and refers to memory pages on the device
// sector must be 1-3, and refers to the appropriate sector on the device
// *array is a pointer to an 8-byte array
// Returns SUCCESS (0x00) if all goes well, FAILURE (0xff) otherwise
char WarpEEPROM_WriteUserMem(unsigned int* baseaddr, char page, char sector, unsigned char *array);

#endif // EEPROM_L_H
