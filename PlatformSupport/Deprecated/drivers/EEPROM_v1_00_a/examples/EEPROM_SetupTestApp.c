//Copyright (c) 2006 Rice University
//All Rights Reserved
//This code is covered by the Rice-WARP license
//See http://warp.rice.edu/license/ for details

////////////////////////////////////////////////////
// EEPROM Setup
// Written by: Austin J. Bratton  1.[903].278.7621
// Created:      July 27, 2006
// Last update:  July 27, 2006
////////////////////////////////////////////////////

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include "xuartlite_l.h"
#include "xgpio.h"
#include "xgpio_l.h"
#include "xparameters.h"
#include "EEPROM.h"
#include "EEPROM_l.h"

Xuint32 BaseAddress = XPAR_EEPROM_0_BASEADDR; 

void InitialSetup(char choice);
void CurrentSettings();

// Dialog to set up
void InitialSetup(char choice)
{
      Xuint8 version, memory[8], i, j, MSB, LSB, MAC[6], serial;
   
      WarpEEPROM_ReadMem((unsigned int*)BaseAddress, 0, 0, memory);  // Get first page w/ device type

      print("\r\n\r\nWelcome to the WARP EEPROM Initial Setup\r\n\r\n");

//      print("Please enter the number of the device using this EEPROM\r\n");
//      print("    0:   FPGA Board\r\n");
//      print("    1:   Radio Board\r\n");
//      choice = XUartLite_RecvByte(STDIN_BASEADDRESS); // Don't use this variable again.
//      switch(choice){
//         case('0') : memory[0] = 0x01; break;
//         case('1') : memory[0] = 0x02; break;
//         default : print("\r\nInvalid choice. Exiting...\r\n"); return; break;
//      }
      if(choice == 0)
      {
         memory[0] = 0x01;
         print("\r\nFPGA BOARD SETUP\r\n");
      }
      else if(choice < 5)
      {
         memory[0] = 0x02;
         xil_printf("\r\nRADIO BOARD %d SETUP\r\n",choice);
      }
      else
      {
         print("\r\nInvalid choice. Exiting...\r\n"); return;
      }
      
      print("\r\nPlease Enter the Version Number (1-7): ");
      version = XUartLite_RecvByte(STDIN_BASEADDRESS);
      version = version - 48;                         // Convert ascii to decimal
      xil_printf("%x\r\n",version);
      if((version < 8) && (version > 0))              // Ensure range of 1-7
         memory[0] = (memory[0] & 0x1F) + (version << 5); // Store version at 3 MSB of first byte 
      else {
         print("\r\nInvalid choice. Exiting...\r\n"); 
         return;
      }
      
      print("\r\nPlease Enter the Revision Number (0-7): ");
      version = XUartLite_RecvByte(STDIN_BASEADDRESS);
      version = version - 48;                         // Convert ascii to decimal
      xil_printf("%x\r\n", version);
      if(version < 8)                                 // Ensure range of 0-7
         memory[1] = (memory[1] & 0x1F) + (version << 5); // Store revision at 3 MSB of 2nd byte
      else {
         print("\r\nInvalid choice. Exiting...\r\n"); 
         return;
      }
      
      WarpEEPROM_WriteMem((unsigned int*)BaseAddress, 0, 0, memory);
      
      print("\r\nPlease press any key to begin entering the 2-byte WARP serial number, ");
      print("\r\n    (or 'p' to pass): \r\n");
      j = XUartLite_RecvByte(STDIN_BASEADDRESS);
      if((j != 'p') && (j != 'P')) {
         print("\r\nPlease enter the address in hex, MSByte first: ");
         for(i=0;i<2;i++) {
            MSB = XUartLite_RecvByte(STDIN_BASEADDRESS);
            xil_printf("%c",MSB);   // echo character to screen
            LSB = XUartLite_RecvByte(STDIN_BASEADDRESS);
            xil_printf("%c ",LSB);  // echo character to screen
            serial = WarpEEPROM_ascii2hexbyte(MSB,LSB); // Combine ascii characters into hex byte
            WarpEEPROM_ControlByteWrite((unsigned int*)BaseAddress, ((1-i) + 5), serial); // Write value to mem
         }
      }
      
      if(choice > 0) {
         print("\r\n\r\nThank you.  Returning to main...\r\n");
         CurrentSettings();
         return;
      }
      
      //////////////////////////////////////////////////////////////////////////////////////////////////
      // ENTERING MAC ADDRESSES
      // FPGA Board
      print("\r\n\r\nPress any key to begin entering a MAC address for the FPGA Board.\r\n");
      print("    press 'p' to pass or press 'c' to clear current address.\r\n");
      choice = XUartLite_RecvByte(STDIN_BASEADDRESS);
      
      if((choice != 'p') && (choice != 'P') && (choice != 'c') && (choice != 'C')) {
         
         WarpEEPROM_ReadMACAddress((unsigned int*)BaseAddress, 0, MAC); // Retrieve current MAC
         
         print("\r\nPlease enter the address in hex, MSByte first: ");
         for(i=0;i<6;i++) {
            MSB = XUartLite_RecvByte(STDIN_BASEADDRESS);
            xil_printf("%c",MSB);   // echo character to screen
            LSB = XUartLite_RecvByte(STDIN_BASEADDRESS);
            xil_printf("%c ",LSB);  // echo character to screen
            MAC[5-i] = WarpEEPROM_ascii2hexbyte(MSB,LSB); // Combine ascii characters into hex byte
         }
         
         WarpEEPROM_WriteMACAddress((unsigned int*)BaseAddress, 0, MAC); // Write address back to mem
      }
      else if((choice == 'c') || (choice == 'C')) {
         WarpEEPROM_ReadMem((unsigned int*)BaseAddress, 0, 0, memory);
         memory[1] = memory[1] & 0xFE;
         WarpEEPROM_WriteMem((unsigned int*)BaseAddress, 0, 0, memory);
      }
      
      // INTERATE THROUGH RADIO BOARDS
      for(j=1;j<5;j++) {
         xil_printf("\r\n\r\nPress any key to begin entering a MAC address for Radio Board %d.\r\n",j);
         print("     press 'p' to pass or press 'c' to clear current address.\r\n");
         choice = XUartLite_RecvByte(STDIN_BASEADDRESS);
         
         if((choice != 'p') && (choice != 'P') && (choice != 'c') && (choice != 'C'))
         {  
            WarpEEPROM_ReadMACAddress((unsigned int*)BaseAddress, j, MAC); // Retrieve current MAC
            
            print("\r\nPlease enter the address in hex, MSByte first: ");
            for(i=0;i<6;i++) {
               MSB = XUartLite_RecvByte(STDIN_BASEADDRESS);
               xil_printf("%c",MSB); // echo character to screen
               LSB = XUartLite_RecvByte(STDIN_BASEADDRESS);
               xil_printf("%c ",LSB); // echo character to screen
               MAC[5-i] = WarpEEPROM_ascii2hexbyte(MSB,LSB); // Combine ascii characters into hex byte
            }
            
            WarpEEPROM_WriteMACAddress((unsigned int*)BaseAddress, j, MAC); // Write address back to mem
         }
         else if((choice == 'c') || (choice == 'C')) 
         {
            WarpEEPROM_ReadMem((unsigned int*)BaseAddress, 0, 0, memory);
            memory[1] = memory[1] & ~(1 << j);
            WarpEEPROM_WriteMem((unsigned int*)BaseAddress, 0, 0, memory);
         }
      }
      
      CurrentSettings();
      
}

void CurrentSettings()
{
   Xuint8 memory[8], version, revision, valid, MAC[6], i;
   Xuint16 serial;
   
   WarpEEPROM_ReadMem((unsigned int*)BaseAddress, 0, 0, memory);
   version = (memory[0] & 0xE0) >> 5; // Find version number
   revision = (memory[1] & 0xE0) >> 5; // Find revision number
   valid = memory[1] & 0x1F;
   print("\r\n\r\n\r\n");
   switch(memory[0] & 0x1F) {
      // Case 1: The board is an FPGA board.
      case(1) : {
         xil_printf("\r\n\r\nWARP FPGA Board Ver. %d.%d\r\n", version,revision);
              print("\r\n  Device                          MAC Address\r\n");
         if((valid & 0x01) != 0)
         {
            WarpEEPROM_ReadMACAddress((unsigned int*)BaseAddress, 0, MAC);  
            xil_printf("\r\nFPGA Board                     %x %x %x %x %x %x\r\n",MAC[5],MAC[4],MAC[3],MAC[2],MAC[1],MAC[0]);
         }
         else
            print("\r\nFPGA Board                    NO VALID MAC ADDRESS\r\n");
         
         if((valid & 0x02) != 0)
         {
            WarpEEPROM_ReadMACAddress((unsigned int*)BaseAddress, 1, MAC);
            xil_printf("\r\nRadio Board 1                  %x %x %x %x %x %x\r\n",MAC[5],MAC[4],MAC[3],MAC[2],MAC[1],MAC[0]);
         }
         else
            print("\r\nRadio Board 1                 NO VALID MAC ADDRESS\r\n");
         
         if((valid & 0x04) != 0)
         {
            WarpEEPROM_ReadMACAddress((unsigned int*)BaseAddress, 2, MAC);
            xil_printf("\r\nRadio Board 2                  %x %x %x %x %x %x\r\n",MAC[5],MAC[4],MAC[3],MAC[2],MAC[1],MAC[0]);
         }
         else
            print("\r\nRadio Board 2                 NO VALID MAC ADDRESS\r\n");
         
         if((valid & 0x08) != 0)
         {
            WarpEEPROM_ReadMACAddress((unsigned int*)BaseAddress, 3, MAC);
            xil_printf("\r\nRadio Board 3                  %x %x %x %x %x %x\r\n",MAC[5],MAC[4],MAC[3],MAC[2],MAC[1],MAC[0]);
         }
         else
            print("\r\nRadio Board 3                 NO VALID MAC ADDRESS\r\n");
         
         if((valid & 0x10) != 0)
         {
            WarpEEPROM_ReadMACAddress((unsigned int*)BaseAddress, 4, MAC);
            xil_printf("\r\nRadio Board 4                  %x %x %x %x %x %x\r\n",MAC[5],MAC[4],MAC[3],MAC[2],MAC[1],MAC[0]);
         }
         else
            print("\r\nRadio Board 4                 NO VALID MAC ADDRESS\r\n");
         break;
      }
      case(2) : {
         xil_printf("\r\n\r\nWARP Radio Board Ver. %d.%d\r\n", version,revision); break;
      }
      default : {
         print("\r\n\r\nNo valid device code given by EEPROM. Please run intial setup.\r\n");
      }
      
      
   } // end switch
   
   serial = WarpEEPROM_ReadWARPSerial((unsigned int*)BaseAddress);
   xil_printf("\r\n\r\nSerial Number (WARP):                %x %x\r\n", (char)((serial & 0xFF00) >> 8), (char)(serial & 0xFF));
   
   WarpEEPROM_ReadDSSerial((unsigned int*)BaseAddress, memory);
       print("\r\nSerial Number (DS):             ");
   for(i=1;i<7;i++)
      xil_printf(" %x",memory[7-i]);
   print("\r\n\r\n\r\nPress any key to return to main...\r\n\r\n");
   XUartLite_RecvByte(STDIN_BASEADDRESS);
   

}

void DEBUG()
{
   Xuint8 memory[8],i,j,k;
   
   print("\r\n\r\n\r\nENTERING DEBUG\r\n");
   
   for(i=0;i<4;i++){
      for(j=0;j<4;j++) {
         WarpEEPROM_ReadMem((unsigned int*)BaseAddress, i, j, memory);
         xil_printf("\r\n\r\nPage%dSec%d: \r\n",i,j);
         for(k=0;k<8;k++)
            xil_printf("            %x\r\n",memory[k]);
      }
   }
   
   WarpEEPROM_ReadControlBytes((unsigned int*)BaseAddress, memory);
   xil_printf("\r\n\r\nProtection Control Byte Page 0:     %x", memory[0]);
   xil_printf("\r\nProtection Control Byte Page 1:     %x", memory[1]);
   xil_printf("\r\nProtection Control Byte Page 2:     %x", memory[2]);
   xil_printf("\r\nProtection Control Byte Page 3:     %x", memory[3]);
   xil_printf("\r\nCopy Protection Byte:               %x", memory[4]);
   xil_printf("\r\nFactory Byte:                       %x", memory[5]);
   xil_printf("\r\nUser Byte:                          %x", memory[6]);
   xil_printf("\r\nUser Byte:                          %x\r\n", memory[7]);
}

void Test()
{
   Xuint8 choice, MSB, LSB, MSBx, LSBx, byte;
   
   do{
   
   print("\r\n\r\nEnter hex number\r\n");
   
   choice = XUartLite_RecvByte(STDIN_BASEADDRESS);
   MSB = choice;
   MSBx=WarpEEPROM_ascii2hex(choice);
   xil_printf("\r\nMSB:       %x\r\n",MSBx);
   
   choice = XUartLite_RecvByte(STDIN_BASEADDRESS);
   LSB = choice;
   LSBx=WarpEEPROM_ascii2hex(choice);
   xil_printf("\r\nLSB:       %x\r\n",LSBx);
   
   byte=WarpEEPROM_ascii2hexbyte(MSB,LSB);
   xil_printf("\r\nCombined: %x\r\n",byte);
   
   }while(choice != 'q');
   
   
}

int main()
{
   XGpio_mSetDataReg(XPAR_LEDS_4BIT_BASEADDR, 1, 0x1); // turn an LED on for debugging purposes
                                                       // program DLs succesfully if LED 1 on the board
                                                       // is lit.
   Xuint8 choice, choice1, check;
   
   print("\r\n\r\nRice University WARP Board EEPROM Setup\r\n");
   
   
   
   while(1)
	{
         WarpEEPROM_Initialize((unsigned int*)BaseAddress);
         print("\r\n\r\nPlease Choose an EEPROM to Access\r\n\r\n");
         print("(0): FPGA Board\r\n");
         print("(1): Radio Board 1\r\n");
         print("(2): Radio Board 2\r\n");
         print("(3): Radio Board 3\r\n");
         print("(4): Radio Board 4\r\n");
          
         choice = XUartLite_RecvByte(STDIN_BASEADDRESS); 
      
         check = WarpEEPROM_EEPROMSelect((unsigned int*)BaseAddress, choice - 48);
         if(check != SUCCESS)
         {
            print("\r\nInvalid Selection\r\n");
            main();
         }

         print("\r\n\r\nMENU\r\n\r\n");
			print("(1): Initial Board Setup\r\n");
			print("(2): Current Settings\r\n");
         print("(3): DEBUG\r\n");
         //print("(4): Test Util. Functions\r\n");
			print("Please Enter the Number corresponding to your choice.\r\n");
         
			choice1 = XUartLite_RecvByte(STDIN_BASEADDRESS); 

			switch(choice1)
			{
				case('1') : InitialSetup(choice-48); break;
				case('2') : CurrentSettings(); break;
            case('3') : DEBUG(); break;
           // case('4') : Test(); break;
				default : print("\r\n\r\nInvalid Choice Entered\r\n\r\n"); break;
			}
	}

   return 0;
}
