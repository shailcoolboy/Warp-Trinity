/* Copyright (c) 2006 Rice University */
/* All Rights Reserved */
/* This code is covered by the Rice-WARP license */
/* See http://warp.rice.edu/license/ for details */


//////////////////////////////////////////////////////////////////////////////
// Filename:          C:\EDK_User_Repository\WARP\drivers\EEPROM_v1_00_a\src\EEPROM_l.c
// Version:           1.00.a
// Description:       EEPROM Driver Source File
// Date:              July 28, 2006
//////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *******************************/

#include "EEPROM_l.h"
#include "xparameters.h"
#include <stdlib.h>

/****************************WARP LIBRARIES**************************/

// Initialize the EEPROM master for communication. Required before any communication 
// can be made on the 1wire bus.  Performs a master reset, and must be done before any
// communication can happen on the 1-wire bus.
// Assumes a EEPROM_select call has already been made.  Defaults to the FPGA board.
// Sets the clock divisor based on the host bus speed (usually 40 or 80MHz)
// baseaddr is the base address of the EEPROM device.
// CLK_DIV_RATIO defined in EEPROM_l.h determines which clock division should be made

char WarpEEPROM_Initialize(unsigned int* baseaddr)
{
   //Xuint8 CMD_REG; 
   Xuint8 CMD_REG, EEPROM_select;
   
   // Save current EEPROM selected.
   EEPROM_select = (EEPROM_mReadReg((volatile)baseaddr, 0x0) & 0x70);

   // For selecting the appropriate EEPROM
   CMD_REG = EEPROM_mReadReg((volatile)baseaddr, 0x0);
   EEPROM_mWriteReg((volatile)baseaddr, 0x0, (CMD_REG & 0x8F) + EEPROM_select);   
      
   switch(CLK_DIV_RATIO)
   {
      case(1) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0x8); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x88); // Enable clock
         break;
      }
      case(2) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0x2); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x82); // Enable clock
         break;
      }
      case(3) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0x5); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x85); // Enable clock
         break;
      }
      case(4) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0x3); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x83); // Enable clock
         break;
      }
      case(5) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0xC); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x8C); // Enable clock
         break;
      }
      case(6) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0x6); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x86); // Enable clock
         break;
      }
      case(7) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0x9); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x89); // Enable clock
         break;
      }
      case(8) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0x7); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x87); // Enable clock
         break;
      }
      case(9) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x10); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x90); // Enable clock
         break;
      }
      case(10) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0xA); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x8A); // Enable clock
         break;
      }
      case(11) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0xD); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x8D); // Enable clock
         break;
      }
      case(12) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0xB); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x8B); // Enable clock
         break;
      }
      case(13) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x14); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x94); // Enable clock
         break;
      }
      case(14) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0xE); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x8E); // Enable clock
         break;
      }
      case(15) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x11); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x91); // Enable clock
         break;
      }
      case(16) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET,  0xF); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x8F); // Enable clock
         break;
      }
      case(17) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x18); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x98); // Enable clock
         break;
      }
      case(18) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x12); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x92); // Enable clock
         break;
      }
      case(19) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x15); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x95); // Enable clock
         break;
      }
      case(20) : 
      {
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x13); // Set divisor ratio
         EEPROM_mWriteReg((volatile)baseaddr, CLKDIV_REG_OFFSET, 0x93); // Enable clock
         break;
      }
      default :
      {
         print("\r\nNo or invalid clock speed specified.\r\n");
      }
   }
   
   // Detect EEPROM on 1-wire bus and ready for a command
   Xuint8 check;
   check = WarpEEPROM_Detect(baseaddr); // Detect device on 1-wire line
   
   if(check == NO_DEVICE)                  // Quit w/ message if no device found
   {
      print("\r\nNo device found on the line.\r\n");
      return NO_DEVICE;
   }
   return SUCCESS;
}
   
// Send a Reset out on the 1-wire device and wait for a presence detect.  
// Assumes previous initialization
// baseaddr is the base address of the EEPROM device
// Returns SUCCESS if device found
// Else returns FAILURE
char WarpEEPROM_Detect(unsigned int* baseaddr)
{
   Xuint8 datareg;
   
   // Send reset pulse on 1-wire
   datareg = EEPROM_mReadReg((volatile)baseaddr, COMMAND_REG_OFFSET);
   EEPROM_mWriteReg((volatile)baseaddr, COMMAND_REG_OFFSET, (datareg & 0xFE)+ 0x01);
   
   // Wait for presence detect window
   while((EEPROM_mReadReg((volatile)baseaddr, INTERRUPT_REG_OFFSET) & 0x01) == 0)
   {
   }
   
   // If device a device was found on 1-Wire, return SUCCESS, else FAILURE
   if((EEPROM_mReadReg((volatile)baseaddr, INTERRUPT_REG_OFFSET) & 0x02) == 0)
      return SUCCESS;
   else
      return NO_DEVICE;
}

// Writes a byte to the transmit buffer
// Waits until Tx buffer/shift registers are empty before writing.
// Waits until Rx buffer is full to continue. This is indicative of
// completion of the sending.
// Assumes previous Initialization and Detect
// baseaddr is the base address of the EEPROM device
// data is the byte to be written
void WarpEEPROM_WriteByte(unsigned int* baseaddr, char data)
{
   // Wait until Tx buffer/shift register are empty
   while((EEPROM_mReadReg((volatile)baseaddr, INTERRUPT_REG_OFFSET) & 0x3C) != 0xC)
   {
      EEPROM_mReadReg((volatile)baseaddr, TXRXBUFFER_OFFSET); 
   }
   
   // Write to the Tx buffer
   EEPROM_mWriteReg((volatile)baseaddr, TXRXBUFFER_OFFSET, data);
   
   // Wait until Rx buffer is full -- indicates all has sent
   while((EEPROM_mReadReg((volatile)baseaddr, INTERRUPT_REG_OFFSET) & 0x10) == 0)
   {
   }
}

// Reads a data byte from the EEPROM
// Assumes the EEPROM is ready to trasmit based on other commands.
// Also assumes no other information is needing to be read.
// Returns a byte.  Default value is FF.
// baseaddr is the base address of the EEPROM device
char WarpEEPROM_ReadByte(unsigned int* baseaddr)
{
   Xuint8 data;
   // Wait until Rx buffer/shift registers are clear.
   while((EEPROM_mReadReg((volatile)baseaddr, INTERRUPT_REG_OFFSET) & 0x30) != 0)
   {
      EEPROM_mReadReg((volatile)baseaddr, TXRXBUFFER_OFFSET);   
   }   
   
   // Write to EEPROM to retrieve byte
   WarpEEPROM_WriteByte(baseaddr, 0xFF);
      
   // Wait until Rx buffer is full
   while((EEPROM_mReadReg((volatile)baseaddr, INTERRUPT_REG_OFFSET) & 0x10) == 0)
   {
   }
   
   // Read and return byte
   data = EEPROM_mReadReg((volatile)baseaddr, TXRXBUFFER_OFFSET);
   
   return data;
}

// Given a 64 bit ROM from an EEPROM, checks to see that the family code
// and serial number flies with the CRC.
// Returns SUCCESS if no error, otherwise FAILURE
char WarpEEPROM_VerifyROM(unsigned char *Serial)
{
    // Initialize registers
    Xboolean   reg0 = 0,
               reg1 = 0,
               reg2 = 0,
               reg3 = 0,
               reg4 = 0,
               reg5 = 0,
               reg6 = 0,
               reg7 = 0,
               reg8 = 0,
               reg8old = 0;
           
   Xuint8 i,bitsel,j, nextbit;
    
   for(i=0; i<8 ; i++)
   {
      for(bitsel=0; bitsel<8 ; bitsel++)
      {         
         // Mask and shift to choose next bit
         nextbit = (Xboolean)((Serial[i] & (1 << bitsel)) >> bitsel); 
         
         // Shift Algorithm to check CRC
         // Polynomial = X^8 + X^5 + X^4 + 1
         reg8old = reg8;       
         reg8 = reg7;
         reg7 = reg6;
         reg6 = reg5 ^ (nextbit ^ reg8old);
         reg5 = reg4 ^ (nextbit ^ reg8old);
         reg4 = reg3;
         reg3 = reg2;
         reg2 = reg1;
         reg1 = reg8old ^ nextbit;     
      }
   }
   
   // If all registers are = 0, then the information was received correctly.
   if((reg1==0)&&(reg2==0)&&(reg3==0)&&(reg4==0)&&(reg5==0)&&(reg6==0)&&(reg7==0)&&(reg8==0))
      return SUCCESS;
   else 
      return FAILURE;      
}

// This function verifies that the 16bit-CRC produced by the EEPROM
// jives with the information sent over the 1-wire bus during
// Read/Write Scratchpad commands.
// array is the 13-byte (11 + 2-byte CRC) or 14-byte (12 + 2-byte CRC) 
// array of information
// The function expects that the last 2 bytes of the array will be the 
// complement of the CRC sent over the 1-wire bus (that is the actual CRC).
// RNW: 0 - if checking a write command, 1 -- if checking a read command
// Returns SUCCESS if no error, otherwise FAILURE
char WarpEEPROM_VerifyScratchpad(unsigned char *array, unsigned char RNW)
{
    // Initialize registers
    Xboolean   reg1     = 0,
               reg2     = 0,
               reg3     = 0,
               reg4     = 0,
               reg5     = 0,
               reg6     = 0,
               reg7     = 0,
               reg8     = 0,
               reg9     = 0,
               reg10    = 0,
               reg11    = 0,
               reg12    = 0,
               reg13    = 0,
               reg14    = 0,
               reg15    = 0,
               reg16    = 0,
               reg16old = 0;
           
   Xuint8 i,bitsel,j, nextbit;
   
   
   for(i=0; i < (13 + RNW) ; i++)
   {
      for(bitsel=0; bitsel<8 ; bitsel++)
      {         
         // Mask and shift to choose next bit
         nextbit = (Xboolean)((array[i] & (1 << bitsel)) >> bitsel); 
         
         // Shift Algorithm to check CRC
         // Polynomial = X^16 + X^15 + X^2 + 1
         reg16old = reg16;       
         reg16 = reg15 ^ (nextbit ^ reg16old);
         reg15 = reg14;
         reg14 = reg13;
         reg13 = reg12;
         reg12 = reg11;
         reg11 = reg10;
         reg10 = reg9;
         reg9 = reg8;
         reg8 = reg7;
         reg7 = reg6;
         reg6 = reg5; 
         reg5 = reg4;
         reg4 = reg3;
         reg3 = reg2 ^ (nextbit ^ reg16old);
         reg2 = reg1;
         reg1 = reg16old ^ nextbit;     
      }
   }
   
   // If all registers are = 0, then the information was received correctly.
   if((reg1==0)&&(reg2==0)&&(reg3==0)&&(reg4==0)&&(reg5==0)&&(reg6==0)&&(reg7==0)&&(reg8==0)&&(reg9==0)&&(reg10==0)&&(reg11==0)&&(reg12==0)&&(reg13==0)&&(reg14==0)&&(reg15==0)&&(reg16==0))
      return SUCCESS;
   else 
      return FAILURE;      
}

// Given an array of information and addressing information, this function writes
// the given information to the memory of the EEPROM.  
// baseaddr is the base address of the EEPROM device
// page must be 0-3, and refers to memory pages on the device
// sector must be 0-3, and refers to the appropriate sector on the device
// array must be an 8 byte array
char WarpEEPROM_WriteScratch(unsigned int* baseaddr, char page, char sector, unsigned char *array)
{
   
   // Check to see that user gave valid location
   
   if((page > 3))// || (page < 0))
   {
      print("\r\nInvalid Page Number\r\n");
      return;
   }
   else if((sector > 3))// || (sector < 0))
   {
      print("\r\nInvalid Sector Number\r\n");
      return FAILURE;
   }

   ///////////////////////////////////////////////////////////////////////////////
   // INITIALIZATION SEQUENCE
   Xuint8 check, mem_address;
   
   WarpEEPROM_Initialize(baseaddr); // Set Clock

   WarpEEPROM_WriteByte(baseaddr, 0xCC); // Bypass ROM access

   ///////////////////////////////////////////////////////////////////////////////
   // COPY ARRAY TO SCRATCHPAD
   // Produce Array for Verifying Scratchpad Write
   Xuint8 verify[13];
   
   // Send Write Scratchpad command
   WarpEEPROM_WriteByte(baseaddr, 0x0F);
   verify[0] = 0x0F;
   
   
   // Set memory address TA1 based on page and sector.
   mem_address = ((page & 0x03) << 5) + ((sector & 0x03) << 3);
   WarpEEPROM_WriteByte(baseaddr,mem_address);
   verify[1] = mem_address;
   
   // Second byte is always zero   
   WarpEEPROM_WriteByte(baseaddr,0x0);
   verify[2] = 0;
   

   // Send 8 data bytes of array to scratchpad
   Xuint8 i;
   for(i=0;i<8;i++)
   {
      WarpEEPROM_WriteByte(baseaddr,array[i]);
      verify[i + 3] = array[i];
   }   
   
   // Receive 2 bytes of inverted CRC-16 
   // Receive CRC 1st byte
   Xuint8 CRC_n;
   CRC_n = WarpEEPROM_ReadByte(baseaddr);
   verify[11] = ~CRC_n;
   
   // Receive CRC 2nd byte
   CRC_n = WarpEEPROM_ReadByte(baseaddr);
   verify[12] = ~CRC_n;
   
   check = WarpEEPROM_VerifyScratchpad(verify, 0);
   //xil_printf("\r\n\r\nWriteSuccess (0)    : %x\r\n", check);
   if(check == 0)
      return SUCCESS;
   else 
      return FAILURE;
}

// This will read the current value in the scratchpad.
// Returns the two memory location bytes and the E/S byte necessary 
// to copy the scratchpad to memory.
// baseaddr is the base address of the EEPROM device
// auth_code is a 11-byte array where the 3-byte authcode followed by the 8-byte
// scratchpad value sent from the EEPROM will be stored
char WarpEEPROM_ReadScratch(unsigned int* baseaddr, unsigned char* auth_code)
{
   ///////////////////////////////////////////////////////////////////////////////
   // INITIALIZATION SEQUENCE
   Xuint8 check, mem_address;
   
   WarpEEPROM_Initialize(baseaddr); // Set Clock

   WarpEEPROM_WriteByte(baseaddr, 0xCC); // Bypass ROM access
   
   ///////////////////////////////////////////////////////////////////////////////
   // READ SCRATCHPAD
   
   // Make array for checking CRC-16 value
   Xuint8 verify[14];
   
   // Send Read Scratchpad Command
   WarpEEPROM_WriteByte(baseaddr, 0xAA);
   verify[0] = 0xAA;
   
   // Get data bytes from EEPROM
   Xuint8 i, data;
   for(i = 0; i < 11; i++)
   {
      data = WarpEEPROM_ReadByte(baseaddr);
      auth_code[i] = data;
      verify[i+1]  = data;
   }
   
   // Receive 2 bytes of inverted CRC-16
   // Receive CRC 1st byte
   Xuint8 CRC_n;
   CRC_n = WarpEEPROM_ReadByte(baseaddr);
   verify[12] = ~CRC_n;
   
   // Receive CRC 2nd byte
   CRC_n = WarpEEPROM_ReadByte(baseaddr);
   verify[13] = ~CRC_n;
   
   check = WarpEEPROM_VerifyScratchpad(verify, 1);
   //xil_printf("Read Success (0)    : %x\r\n", check);
   if(check == 0)
      return SUCCESS;
   else 
      return FAILURE;
}

// After the information in the scratchpad has been verified via CRC check, the
// scratchpad read, and the authorization code returned, this command will copy 
// the scratchpad into the flash memory specified.
// baseaddr is the base address of the EEPROM device
// auth_code a 3 byte array containing the 2-byte memory location and
// 1-byte E/S regsiter value returned during a ReadScratch command.
// Returns SUCCESS if no error, otherwise FAILURE
char WarpEEPROM_Scratch2Mem(unsigned int* baseaddr, unsigned char* auth_code)
{
   ///////////////////////////////////////////////////////////////////////////////
   // INITIALIZATION SEQUENCE
   Xuint8 check;
   
   WarpEEPROM_Initialize(baseaddr); // Set Clock

   WarpEEPROM_WriteByte(baseaddr, 0xCC); // Bypass ROM access
   
   ///////////////////////////////////////////////////////////////////////////////
   // COPY SCRATCHPAD TO MEMORY
   
   // Give Copy Scratchpad Command
   WarpEEPROM_WriteByte(baseaddr, 0x55);
   
   // Write authorization bytes to EEPROM
   Xuint8 i;
   for(i = 0; i < 3; i++)
   {
      WarpEEPROM_WriteByte(baseaddr, auth_code[i]);
   }
   
   usleep(12500); // 12.5ms for data transfer
   
   check = WarpEEPROM_ReadByte(baseaddr);
   //xil_printf("AA for success      : %x\r\n", check);
   
   if(check == 0xAA)
      return SUCCESS;
   else
      return FAILURE;
}

// This function reads from a specified memory location in the 1024-bit memory.
// Returns an 8-byte sector of the EEPROM. 
// baseaddr is the base address of the EEPROM device
// page must be 0-3, and refers to memory pages on the device
// sector must be 0-3, and refers to the appropriate sector on the device
// array must be an 8 byte array
// Returns SUCCESS if no error, otherwise FAILURE
char WarpEEPROM_ReadMem(unsigned int* baseaddr, char page, char sector, unsigned char *memory)
{
   // Check to see that user gave valid location
   if((page > 3)) //  || (page < 0))
   {
      print("Invalid Page Number");
      return FAILURE;
   }
   else if((sector > 3)) //  || (sector < 0))
   {
      print("Invalid Sector Number");
      return FAILURE;
   }
   
   ///////////////////////////////////////////////////////////////////////////////
   // INITIALIZATION SEQUENCE
   Xuint8 check, mem_address;
   
   WarpEEPROM_Initialize(baseaddr); // Set Clock

   WarpEEPROM_WriteByte(baseaddr, 0xCC); // Bypass ROM access
   
   ///////////////////////////////////////////////////////////////////////////////
   // READ FROM MEMORY
         
   // Send Read Memory command
   WarpEEPROM_WriteByte(baseaddr, 0xF0);

   
   // Set memory address TA1 based on page and sector.
   mem_address = ((page & 0x03) << 5) + ((sector & 0x03) << 3);
   WarpEEPROM_WriteByte(baseaddr,mem_address);

   // Second byte is always zero
   WarpEEPROM_WriteByte(baseaddr,0x0);

   // Receive 8 data bytes from memory
   Xuint8 i;
   for(i=0;i<8;i++)
   {
      memory[i] = WarpEEPROM_ReadByte(baseaddr);
   }   
   return SUCCESS;
}

// Writes a given 8-byte array to a designated location in memory.
// Essentially a wrapper of the WriteScratch, ReadScratch and Scratch2Mem functions
// baseaddr is the base address of the EEPROM device
// page must be 0-3, and refers to memory pages on the device
// sector must be 0-3, and refers to the appropriate sector on the device
// array must be an 8 byte array
char WarpEEPROM_WriteMem(unsigned int* baseaddr, char page, char sector, unsigned char *array)
{
   Xuint8 array2[11], check; 
   
   check = WarpEEPROM_WriteScratch(baseaddr, page, sector, array);
   if(check != 0)
      return FAILURE;
   check = WarpEEPROM_ReadScratch(baseaddr, array2);
   if(check != 0)
      return FAILURE;
   check = WarpEEPROM_Scratch2Mem(baseaddr, array2);
   if(check != 0)
      return FAILURE;
   
   return SUCCESS;
}

// Reads and outputs the values stored in the 5 protection bytes, the factory byte, and the 
// two user bytes.
void WarpEEPROM_ReadControlBytes(unsigned int* baseaddr, char *control_regs)
{
   ///////////////////////////////////////////////////////////////////////////////
   // INITIALIZATION SEQUENCE
   Xuint8 check, mem_address;
   
   WarpEEPROM_Initialize(baseaddr); // Set Clock
   
   WarpEEPROM_WriteByte(baseaddr, 0xCC); // Bypass ROM access
   
   ///////////////////////////////////////////////////////////////////////////////
   // READ FROM MEMORY
         
   // Send Read Memory command
   WarpEEPROM_WriteByte(baseaddr, 0xF0);
   
   // Set memory address TA1 based on page and sector.
   mem_address = 0x80;
   WarpEEPROM_WriteByte(baseaddr,mem_address);

   // Second byte is always zero
   WarpEEPROM_WriteByte(baseaddr,0x0);

   // Receive 8 data bytes from memory
   Xuint8 i;
   for(i=0;i<8;i++)
   {
      control_regs[i] = WarpEEPROM_ReadByte(baseaddr);
   }   
   //xil_printf("\r\nProtection Control Byte Page 0:     %x", control_regs[0]);
   //xil_printf("\r\nProtection Control Byte Page 1:     %x", control_regs[1]);
   //xil_printf("\r\nProtection Control Byte Page 2:     %x", control_regs[2]);
   //xil_printf("\r\nProtection Control Byte Page 3:     %x", control_regs[3]);
   //xil_printf("\r\nCopy Protection Byte:               %x", control_regs[4]);
   //xil_printf("\r\nFactory Byte:                       %x", control_regs[5]);
   //xil_printf("\r\nUser Byte:                          %x", control_regs[6]);
   //xil_printf("\r\nUser Byte:                          %x\r\n", control_regs[7]);
    
}

// Retrieves the type of board.  Returns a char.
// Return values: 0x01 -- FPGA Board
//                0x02 -- Radio Board                
char WarpEEPROM_GetDeviceType(unsigned int* baseaddr)
{
   Xuint8 memory[8];
   WarpEEPROM_ReadMem(baseaddr, 0, 0, memory);
   return memory[0] & 0x1F;
}

// A utility function for taking ascii input and turning it into a hex number
char WarpEEPROM_ascii2hex(unsigned char ascii)
{
   if((ascii < 48) || ((ascii > 57) && (ascii < 65)) || ((ascii > 70) && (ascii < 97)) || (ascii > 102))
      return 0x00; // return 0 if bad input.  less harmful than other options
   else if(ascii <= 57)
      return (char)(ascii - 48);
   else if(ascii <= 70)
      return (char)(ascii - 55);
   else 
      return (char)(ascii - 87);
}

// A utility function for taking two sequential keyboard inputs and
// returning a single hex byte.  Used for hex input from keyboard
char WarpEEPROM_ascii2hexbyte(unsigned char MSB, unsigned char LSB)
{
   Xuint8 MSBx,LSBx, byte;
   
   MSBx = WarpEEPROM_ascii2hex(MSB); 
   LSBx = WarpEEPROM_ascii2hex(LSB);

   return (char)((MSBx << 4) + LSBx);
}
   

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

char WarpEEPROM_ControlByteWrite(unsigned int* baseaddr, char ByteSelect, char value2store)
{   
   Xuint8 choice;
   if(ByteSelect < 5)
   {
      print("\r\nReturning\r\n");
      return; // Remove in order to enable writing to control bytes.
      print("\r\nSETTING THE PROTECTION REGISTERS TO WRITE PROTECT OR EPROM MODE IS\r\n");
      print("\r\n                    ***IRREVERSIBLE***\r\n");
      print("\r\nDo you wish to continue? (y)\r\n");
      choice = XUartLite_RecvByte(STDIN_BASEADDRESS);
      if(choice != 'y')
         return ABORT;
      
      print("\r\nPlease Verify the Control Byte you are Writing\r\n");
      print("      0: Protection Control Byte Page 0\r\n");      
      print("      1: Protection Control Byte Page 1\r\n");      
      print("      2: Protection Control Byte Page 2\r\n");      
      print("      3: Protection Control Byte Page 3\r\n");      
      print("      4: Copy Protection Byte\r\n");      
      print("      5: User Byte #1\r\n");      
      print("      6: User Byte #2\r\n");
      choice = XUartLite_RecvByte(STDIN_BASEADDRESS);   
      if((choice - 48) != ByteSelect)
         return ABORT;
         
      print("\r\nPlease Verify the value you are writing is %x.  (k)\r\n", value2store);
      choice = XUartLite_RecvByte(STDIN_BASEADDRESS);
      if(choice != 'k')
         return ABORT;
      
      print("\r\nSETTING THE PROTECTION REGISTERS TO 'WRITE PROTECT' OR 'EPROM MODE' IS\r\n");
      print("\r\n                    ***IRREVERSIBLE***\r\n");
      print("\r\nDo you wish to continue? (y)\r\n");
      choice = XUartLite_RecvByte(STDIN_BASEADDRESS);
      if(choice != 'y')
         return ABORT;
   }
   
   // Obtain Current Control Register Values
   Xuint8 control_regs[8], mem_address;
   WarpEEPROM_ReadControlBytes(baseaddr, control_regs); 
   mem_address = 0x80;
   switch(ByteSelect)
   {   
      case(0)  : 
      {
         control_regs[0] = value2store; break;
      }
      case(1)  : 
      {
         control_regs[1] = value2store; break;
      
      }
      case(2)  : 
      {
         control_regs[2] = value2store; break;
      
      }
      case(3)  : 
      {
         control_regs[3] = value2store; break;
      
      }
      case(4)  : 
      {
         control_regs[4] = value2store; break;
      
      }
      case(5)  : 
      {
         control_regs[6] = value2store; break;
      
      }
      case(6)  : 
      {
         control_regs[7] = value2store; break;
      
      }
      default : return; break;
   } 

      ////////////////////////////////////////////////////////////////////////////////////
      // Write Scratchpad
      Xuint8 CRC_n, check, verify[14];
      WarpEEPROM_Initialize(baseaddr);
      WarpEEPROM_WriteByte(baseaddr, 0xCC);     
      
      WarpEEPROM_WriteByte(baseaddr, 0x0F);             verify[0] = 0x0F;
      
      WarpEEPROM_WriteByte(baseaddr, mem_address);      verify[1] = mem_address;
      WarpEEPROM_WriteByte(baseaddr, 0x0);              verify[2] = 0x0;
      
      WarpEEPROM_WriteByte(baseaddr, control_regs[0]);  verify[3] = control_regs[0];
      WarpEEPROM_WriteByte(baseaddr, control_regs[1]);  verify[4] = control_regs[1];
      WarpEEPROM_WriteByte(baseaddr, control_regs[2]);  verify[5] = control_regs[2];
      WarpEEPROM_WriteByte(baseaddr, control_regs[3]);  verify[6] = control_regs[3];
      WarpEEPROM_WriteByte(baseaddr, control_regs[4]);  verify[7] = control_regs[4];
      WarpEEPROM_WriteByte(baseaddr, control_regs[5]);  verify[8] = control_regs[5];
      WarpEEPROM_WriteByte(baseaddr, control_regs[6]);  verify[9] = control_regs[6];
      WarpEEPROM_WriteByte(baseaddr, control_regs[7]); verify[10] = control_regs[7];
      
      CRC_n = WarpEEPROM_ReadByte(baseaddr); 
      verify[11] = ~CRC_n;
      CRC_n = WarpEEPROM_ReadByte(baseaddr); 
      verify[12] = ~CRC_n;
      
      check = WarpEEPROM_VerifyScratchpad(verify, 0);
      if(check != 0)
         return FAILURE;   
      
      ////////////////////////////////////////////////////////////////////////////////////
      // Read Scratchpad
      WarpEEPROM_Initialize(baseaddr);
      WarpEEPROM_WriteByte(baseaddr, 0xCC);     
      
      WarpEEPROM_WriteByte(baseaddr, 0xAA); verify[0] = 0xAA;
      
       verify[1] = WarpEEPROM_ReadByte(baseaddr);
       verify[2] = WarpEEPROM_ReadByte(baseaddr);
       verify[3] = WarpEEPROM_ReadByte(baseaddr); 
       
       verify[4] = WarpEEPROM_ReadByte(baseaddr);
       verify[5] = WarpEEPROM_ReadByte(baseaddr);
       verify[6] = WarpEEPROM_ReadByte(baseaddr);
       verify[7] = WarpEEPROM_ReadByte(baseaddr);
       verify[8] = WarpEEPROM_ReadByte(baseaddr);
       verify[9] = WarpEEPROM_ReadByte(baseaddr);
      verify[10] = WarpEEPROM_ReadByte(baseaddr);
      verify[11] = WarpEEPROM_ReadByte(baseaddr);
      
      CRC_n = WarpEEPROM_ReadByte(baseaddr); verify[12] = ~CRC_n;
      CRC_n = WarpEEPROM_ReadByte(baseaddr); verify[13] = ~CRC_n;
      
      check = WarpEEPROM_VerifyScratchpad(verify, 1);
      if(check != 0)
         return FAILURE;
      
      ////////////////////////////////////////////////////////////////////////////////////
      // Copy Scratchpad
      WarpEEPROM_Initialize(baseaddr);
      WarpEEPROM_WriteByte(baseaddr, 0xCC);     
      
      WarpEEPROM_WriteByte(baseaddr, 0x55);
      WarpEEPROM_WriteByte(baseaddr, verify[1]);
      WarpEEPROM_WriteByte(baseaddr, verify[2]);
      WarpEEPROM_WriteByte(baseaddr, verify[3]);
      usleep(12500);
      
      check = WarpEEPROM_ReadByte(baseaddr);
      if(check == 0xAA)
      {
         return SUCCESS;
      }
      else 
         return FAILURE;
}

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
