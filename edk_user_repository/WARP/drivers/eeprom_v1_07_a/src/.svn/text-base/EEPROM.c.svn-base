/* Copyright (c) 2006 Rice University */
/* All Rights Reserved */
/* This code is covered by the Rice-WARP license */
/* See http://warp.rice.edu/license/ for details */


//////////////////////////////////////////////////////////////////////////////
// Filename:          C:\EDK_User_Repository\WARP\drivers\EEPROM_v1_00_a\src\EEPROM.c
// Version:           1.00.a
// Description:       EEPROM Driver Source File
// Date:              July 28, 2006 
//////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *******************************/

#include "EEPROM.h"
#include "xparameters.h"
#include <stdlib.h>

/****************************WARP LIBRARIES**************************/

// Choose the EEPROM to be affected by subsequent reads/writes
// EEPROM_select selects the appropriate EEPROM to drive
// Defaults to FPGA Board
//   0: FPGA Board  1: Radio1  2: Radio2  3: Radio3  4: Radio4
// Returns SUCCESS if clock set correctly
// Returns FAILURE otherwise  
char WarpEEPROM_EEPROMSelect(unsigned int* baseaddr, char EEPROM_select)
{
   if(EEPROM_select > 4)
      return FAILURE;
   
   Xuint8 CMD_REG;
   
   CMD_REG = EEPROM_mReadReg((volatile)baseaddr, 0x0);

   EEPROM_mWriteReg((volatile)baseaddr, 0x0, (CMD_REG & 0x8F) + (EEPROM_select << 4));
   
   return SUCCESS;
}

// This function checks to see if a valid calibration value is stored on the EEPROM
// and returns the value if so.
// baseaddr is the base address of the EEPROM device
// RxNTx specifies whether the values are the Rx or Tx values. 1 indicates Rx
// val_select selects which value to write
//   1: DC offset    2: Gain IQ     3: Phase IQ
// Returns a short where the most significant byte is the Q-value and 
// the least significant byte is the I-value.
// Returns 0 if there is no valid data or if the function is called on an EEPROM 
// located on and FPGA board
short WarpEEPROM_ReadRadioCal(unsigned int* baseaddr, char RxNTx, char val_select)
{
   Xuint8 memory[8];
   Xuint16 calval;
   
   // Ensure use of Radio EEPROM
   if(WarpEEPROM_GetDeviceType(baseaddr) != 0x02)
      return FAILURE;
   
   // Get current page from memory.
   WarpEEPROM_ReadMem(baseaddr, 0, RxNTx, memory); 
   
   
   if((memory[1] & (1 << val_select)) != 0) // Is the desired calibration value, valid?
   {
      calval = (memory[val_select*2+1] << 8) + memory[val_select*2]; // If so, return the value
   }
   else
      calval = 0; // If not, return 0
      
   return calval;
}

// This function writes a calibration value to the EEPROM
// baseaddr is the base address of the EEPROM device
// RxNTx specifies whether the values are the Rx or Tx values. 1 indicates Rx
// val_select selects which value to write
//   1: DC offset    2: Gain IQ     3: Phase IQ
// I_val is the I-component to be stored
// Q_val is the Q-component to be stored
char WarpEEPROM_WriteRadioCal(unsigned int* baseaddr, char RxNTx, char val_select, char I_val, char Q_val)
{
   Xuint8 memory[8], success;
   
   // Ensure use of Radio EEPROM
   if(WarpEEPROM_GetDeviceType(baseaddr) != 0x02)
      return FAILURE;
   
   // Get current page and sector from memory
   WarpEEPROM_ReadMem(baseaddr, 0, RxNTx, memory);
   
   
   // Store the I and Q values
   memory[val_select*2] = I_val;
   memory[val_select*2+1] = Q_val;
   
   // Set the valid bit to 1
   if((memory[1] & (1 << val_select)) == 0)
      memory[1] = memory[1] + (1 << val_select);
      
   // Store the new value back to memory.
   success = WarpEEPROM_WriteMem(baseaddr, 0, RxNTx, memory);

   if(success == 0)
      return SUCCESS;
   else 
      return FAILURE;
}

// This function writes a 6-byte MAC address into a 6-byte array addressed by a pointer.
// baseaddr is the base address of the EEPROM device
// dev_select specifies which device's MAC address to read
//    0: FPGA Board   1: Radio1   2: Radio2   3: Radio3   4: Radio4
// *MAC is a pointer to a 6-byte array
// Returns all 1's if there is no valid MAC address
// NOTE: The Addresses have been mapped on the EEPROM so as to fit on only 1 data page
void WarpEEPROM_ReadMACAddress(unsigned int* baseaddr, char dev_select, char *MAC)
{
   Xuint8 memory[8], i;
   
   // Ensure use of FPGA EEPROM
   if(WarpEEPROM_GetDeviceType(baseaddr) != 0x01)
      {
        for(i = 0; i < 6; i++)
            MAC[i] = 0xff;
         return;
      }
   
   // Get the valid register
   WarpEEPROM_ReadMem(baseaddr, 0, 0, memory);
   
   // If there is no valid MAC address stored, return all 1's as the address
   if((memory[1] & (1 << dev_select)) == 0) 
   {
      for(i = 0; i < 6; i++)
         MAC[i] = 0xff;
      return;
   }
   
   switch(dev_select)   // Choose which device's MAC address is being stored.
   {
      case(0) :         // FPGA BOARD
      {
         for(i = 0; i < 6; i++)
            MAC[i] = memory[i+2];   // Write bytes to MAC 
            
         break;
      }
      case(1) :         // Radio 1
      {         
         WarpEEPROM_ReadMem(baseaddr, 0, 1, memory); // Get Pg0Sec1
         for(i = 0; i < 6; i++)     
            MAC[i] = memory[i];   // Write bytes to MAC
            
         break;
      }
      case(2) :         // Radio 2
      {
         WarpEEPROM_ReadMem(baseaddr, 0, 1, memory); // Get Pg0Sec1
         for(i = 0; i < 2; i++)
            MAC[i] = memory[i+6];   // Write bytes to MAC
         
         WarpEEPROM_ReadMem(baseaddr, 0, 2, memory); // Get Pg0Sec2
         for(i = 0; i < 4; i++)
            MAC[i+2] = memory[i];   // Write bytes to MAC
         
         break;
      }
      case(3) :         // Radio 3
      {
         WarpEEPROM_ReadMem(baseaddr, 0, 2, memory); // Get Pg0Sec2
         for(i = 0; i < 4; i++)
            MAC[i] = memory[i+4];   // Write bytes to MAC
         
         WarpEEPROM_ReadMem(baseaddr, 0, 3, memory); // Get Pg0Sec3
         for(i = 0; i < 2; i++)
            MAC[i+4] = memory[i];        // Write byte to MAC
         
         break;
      }
      case(4) :         // Radio 4
      {
         WarpEEPROM_ReadMem(baseaddr, 0, 3, memory); // Get Pg0Sec3
         for(i = 0; i < 6; i++)
            MAC[i] = memory[i+2];   // Write bytes to MAC
         
         break;
      }
      default :   // Invalid address return all 1's
      {
         for(i = 0; i < 6; i++)
            MAC[i] = 0xff;
      }
   }
}

// This function writes a 6-byte MAC address into the EEPROM.
// baseaddr is the base address of the EEPROM device
// dev_select specifies which device's MAC address to read
//    0: FPGA Board   1: Radio1   2: Radio2   3: Radio3   4: Radio4
// *MAC is a pointer to a 6-byte array containing the address
// Returns SUCCESS if all goes well, FAILURE otherwise
char WarpEEPROM_WriteMACAddress(unsigned int* baseaddr, char dev_select, char *MAC)
{
   Xuint8 memory[8], i, success;
   
   // Ensure use of the FPGA EEPROM
   if(WarpEEPROM_GetDeviceType(baseaddr) != 0x01)
      return FAILURE;
   
   switch(dev_select)      // Choose which device's MAC address to write
   {
      case(0) :            // FPGA BOARD
      {
         WarpEEPROM_ReadMem(baseaddr, 0, 0, memory);             
         for(i = 0; i < 6; i++)
            memory[i+2] = MAC[i];            // Write bytes to memory sector 
         memory[1] = (memory[1] & 0xFE) + 1; // Set valid flag
         
         success = WarpEEPROM_WriteMem(baseaddr, 0 , 0, memory); // Write sector back to mem
         
         if(success == 0)
            return SUCCESS;
         else 
            return FAILURE;
         break;
      }
      case(1) :            // Radio 1
      {  
         WarpEEPROM_ReadMem(baseaddr, 0, 1, memory); // Get Pg0Sec1
         for(i = 0; i < 6; i++)     
            memory[i] = MAC[i];   // Write bytes to memory sector
         
         success = WarpEEPROM_WriteMem(baseaddr, 0, 1, memory); // Write sector back to mem
         
         break;
      }
      case(2) :            // Radio 2
      {
         WarpEEPROM_ReadMem(baseaddr, 0, 1, memory); // Get Pg0Sec1
         for(i = 0; i < 2; i++)
            memory[i+6] = MAC[i];   // Write bytes to memory sector
            
         success = WarpEEPROM_WriteMem(baseaddr, 0, 1, memory); // Write the sector back to mem
         
         WarpEEPROM_ReadMem(baseaddr, 0, 2, memory); // Get Pg0Sec2
         for(i = 0; i < 4; i++)
            memory[i] = MAC[i+2];   // Write bytes to memory sector
            
         success = success + WarpEEPROM_WriteMem(baseaddr, 0, 2, memory); // Write sector back to mem
         
         break;
      }
      case(3) :            // Radio 3
      {
         WarpEEPROM_ReadMem(baseaddr, 0, 2, memory); // Get Pg0Sec2
         for(i = 0; i < 4; i++)
            memory[i+4] = MAC[i];   // Write bytes to memory sector
         
         success = WarpEEPROM_WriteMem(baseaddr, 0, 2, memory); // Write sector back to mem
         
         WarpEEPROM_ReadMem(baseaddr, 0, 3, memory); // Get Pg0Sec3
         for(i = 0; i < 2; i++)
            memory[i] = MAC[i+4];        // Write byte to memory sector
         
         success = success + WarpEEPROM_WriteMem(baseaddr, 0, 3, memory); // Write sector back to mem
         
         break;
      }
      case(4) :            // Radio 4
      {
         WarpEEPROM_ReadMem(baseaddr, 0, 3, memory); // Get Pg0Sec3
         for(i = 0; i < 6; i++)
            memory[i+2] = MAC[i];   // Write bytes to memory sector
         
         success = WarpEEPROM_WriteMem(baseaddr, 0, 3, memory); // Write sector back to mem
         
         break;
      }
      default :   // Invalid address return all 1's
      {
         for(i = 0; i < 6; i++)
            MAC[i] = 0xFF;
      }
   }
   
   if(success == 0)
   {
      WarpEEPROM_ReadMem(baseaddr, 0, 0, memory); // Get Pg0Sec0
      
      // Set the appropriate valid bit
      if((memory[1] & (1 << dev_select)) == 0)
         memory[01] = memory[1] + (1 << dev_select);
         
      success = WarpEEPROM_WriteMem(baseaddr, 0, 0, memory);
      
      if(success == 0)
         return SUCCESS;
      else
         return FAILURE;
   }
   else 
      return FAILURE;
}

// Returns the the 2-byte serial number assigned by Rice WARP
short WarpEEPROM_ReadWARPSerial(unsigned int* baseaddr)
{
   Xuint8 memory[8];
   Xuint16 serial;
   WarpEEPROM_ReadControlBytes(baseaddr, memory); // Store control bytes to memory
   serial = (memory[7] << 8) + memory[6];          // Make short out of two bytes
   return serial;
}

// Get Serial number from a EEPROM device.  Assumes it is the only device on the bus.
// Assumes previous initialization.
// baseaddr is the base address of the EEPROM device
// edits a memory array containing the 1 byte family code, 6 byte serial
// serial number and 1 byte CRC value
char WarpEEPROM_ReadDSSerial(unsigned int* baseaddr, unsigned char *Serial)
{
   Xuint8 check;
   
   // Intialize the EEPROM
   WarpEEPROM_Initialize(baseaddr);
   
   // Send Serial# Command (0x33) to the EEPROM
   WarpEEPROM_WriteByte(baseaddr, 0x33);
   
   // Iterate through 8 bytes of returning data and
   // Store the data to array Serial   
   Xuint8 count;
   for(count=0; count<8; count++)
   { 
      Serial[count] = WarpEEPROM_ReadByte(baseaddr);
   }
   
   return WarpEEPROM_VerifyROM(Serial); // Return the CRC check result
}

// This function reads from a specified memory location in the 1024-bit memory.
// Returns an 8-byte sector of the EEPROM. 
// baseaddr is the base address of the EEPROM device
// page must be 1-3, and refers to memory pages on the device
// sector must be 1-3, and refers to the appropriate sector on the device
// array must be an 8 byte array
// Returns SUCCESS if no error, otherwise FAILURE
char WarpEEPROM_ReadUserMem(unsigned int* baseaddr, char page, char sector, unsigned char *array)
{
   if((page > 3) || (page < 1))                // Verify valid page #
   {
      print("\r\nInvalid Page Number\r\n");
      return FAILURE;
   }
   else if((sector > 3) || (sector < 1))        // Verify valid sector #
   {
      print("\r\nInvalid Sector Number\r\n");
      return FAILURE;
   }
   
   Xuint8 check, i;
   
   check = WarpEEPROM_ReadMem(baseaddr, page, sector, array); // Store memory sector to array
   
   for(i = 0; i < 8; i++)
      xil_printf("\r\nByte[%d] :   %x", i,array[i]);
   
   if(check == 0)
      return SUCCESS;
   else
      return FAILURE;
}

// Writes a given 8-byte array to a designated location in memory.
// Essentially a wrapper of the WriteScratch, ReadScratch and Scratch2Mem functions
// baseaddr is the base address of the EEPROM device
// page must be 1-3, and refers to memory pages on the device
// sector must be 1-3, and refers to the appropriate sector on the device
// array must be an 8 byte array
char WarpEEPROM_WriteUserMem(unsigned int* baseaddr, char page, char sector, unsigned char *array)
{
   if((page > 3) || (page < 1))                 // Verify valid page #
   {
      print("\r\nInvalid Page Number\r\n");
      return FAILURE;
   }
   else if((sector > 3) || (sector < 1))        // Verify valid sector #
   {
      print("\r\nInvalid Sector Number\r\n");
      return FAILURE;
   }
   
   Xuint8 check, i;
   
   check = WarpEEPROM_WriteMem(baseaddr, page, sector, array); // Write array to memory sector
   if(check == 0)
      return SUCCESS;
   else
      return FAILURE;
}
