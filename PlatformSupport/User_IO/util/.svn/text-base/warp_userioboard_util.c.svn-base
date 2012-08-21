/*! \file warp_userioboard_util.c
 \brief Provides high-level functions for using the various interfaces on the WARP User I/O Board. This file and its header file should be included in your EDK software project to help drive the User I/O board. The low-level register access functions used here are provided by the User I/O Board controller's driver.
*/

#include "warp_userioboard_util.h"
#include "ascii_characters.h"
#include "xparameters.h"

//Only include SystemACE CF and xil_fatfs headers if the xps_sysace hardware and xil_fatfs library is included in the project
#ifdef XPAR_SYSACE_0_DEVICE_ID
#ifdef XILFATFS_MAXFILES
#include "xsysace.h"
#include "sysace_stdio.h"
#endif
#endif

///@brief Initializes the LCD screen
///
///@param slotNumber Integer in [1,2,3,4] indicating which daughtercard slot holds the User I/O Board
///@param invertColors Selects standard or inverse color map; use 0 by default
void warp_userioboard_lcd_init(unsigned char slotNumber, unsigned char invertColors)
{
	//Reset the LCD via its dedicated digital reset pin, mapped through the controller
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_RESETLCD, 1);
	usleep(10);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_RESETLCD, 0);
	usleep(10);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_RESETLCD, 1);

	//Write the default values to every register, as specified in the From Register masks in Sysgen
	// (these defaults aren't honored in hardware, so we write them here)
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_BACKGROUNDCOLOR, 0);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_CHARACTERSSELECT, 0); 
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_COLSET, 0x175);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_CONFIGLOCATION, 0);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_DIVIDERSELECT, 0);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_FIRSTEND, 131);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_FIRSTSTART, 0);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_RAMWRITE, 0x15C);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_RESET, 0);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_RESETLCD, 1);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_ROWSET, 0x115);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_SECONDEND, 131);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_SECONDSTART, 0);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_SEND, 0);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_TOTALCMDTRANSFER, 10);

	//Reset and initialize the LCD and SPI controller state machines
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_RESET, 1);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_TOTALCMDTRANSFER, 50); //Number of commands in RAM by default
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_SEND, 0);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_RESET, 0);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_ROWSET, LCDCMD_CASET);
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_COLSET, LCDCMD_PASET);


/* The LCD controller command buffer contains the correct initialization commands for a board in slot 1 with non-inverted colors
 * These commands will be sent when this function asserts LCD_SEND below
 * If you want to customize the initialization sequence, use a different slot or invert the colors, you'll need the code below
 * Change INCLUDE_LCD_INIT_CODE to 1 in the header file, then customize the initial values for the array below
 * If you change the total number of commands (50 by default), be sure to update the value written to LCD_TOTALCMDTRANSFER above
*/
#if INCLUDE_LCD_INIT_CODE
	//Define the command buffer
	unsigned short cmds[50];

	//Populate the command buffer with the required at-boot setup command sequence
	cmds[0] = LCDCMD_DISCTL;
	cmds[1] = 0x03;
	cmds[2] = 32;
	cmds[3] = 12;
	cmds[4] = 0x00;
	cmds[5] = LCDCMD_COMSCN;
	cmds[6] = 0x01;
	cmds[7] = LCDCMD_OSCON;
	cmds[8] = LCDCMD_SLPOUT;
	cmds[9] = LCDCMD_VOLCTR;
	cmds[10] = 25;
	cmds[11] = 0x03;
	cmds[12] = LCDCMD_PWRCTR;
	cmds[13] = 0x0f;
	cmds[14] = invertColors ? LCDCMD_NOP : LCDCMD_DISINV;
	cmds[15] = LCDCMD_DATCTL;
	cmds[16] = (slotNumber <= 2) ? 0x05 : 0x06; //Slots 3/4: rotate the screen orientation 180 degrees
	cmds[17] = 0;
	cmds[18] = 0x01;
	cmds[19] = 0x00;
	cmds[20] = LCDCMD_RGBSET8;
	cmds[21] = 0;
	cmds[22] = 2;
	cmds[23] = 4;
	cmds[24] = 6;
	cmds[25] = 8;
	cmds[26] = 10;
	cmds[27] = 12;
	cmds[28] = 15;
	cmds[29] = 0;
	cmds[30] = 2;
	cmds[31] = 4;
	cmds[32] = 6;
	cmds[33] = 8;
	cmds[34] = 10;
	cmds[35] = 12;
	cmds[36] = 15;
	cmds[37] = 0;
	cmds[38] = 4;
	cmds[39] = 9;
	cmds[40] = 15;
	cmds[41] = LCDCMD_NOP;
	cmds[42] = LCDCMD_PASET;
	cmds[43] = 2;
	cmds[44] = 130;
	cmds[45] = LCDCMD_CASET;
	cmds[46] = 2;
	cmds[47] = 130;
	cmds[48] = LCDCMD_DISON;
	cmds[49] = LCDCMD_RAMWR;

	//Copy the command buffer to the board controller
	memcpy((void *)LCD_COMMAND_BUFFER, (void *)(&cmds), 50*sizeof(short));
#endif

	//Trigger the SPI state machine; this will write LCD_TOTALCMDTRANSFER commands to the LCD controller IC
	XIo_Out32(USER_IO_BOARD_CONTROLLER_LCD_SEND, 1);

	//Done! The LCD should now be displaying the character map (the default contents of character buffer 0)
	//User code can now overwrite the character and character map buffers
	return;
}

///@brief Prints characters to the LCD display
///@param chars Pointer to array of characters to print; the first entry will be the left-most character displayed
///@param numChars Number of characters from chars to print; must be one of [4,8,12,16]; numChars + col must not exceed 16
///@param line Line number on the LCD to print the characters; must be integer in [0...15]
///@param col Column to start displayng the characters; must be one of [0,4,8,12]; numChars + col must not exceed 16
///@param charBuf Selects which character buffer in the controller to write; must be integer in [0,7]
int warp_userio_lcd_print(unsigned char* chars, unsigned char numChars, unsigned char line, unsigned char col, unsigned char charBuf)
{
	int i;
	//If any of the parameters don't make sense, return immediately
	if(
		(numChars == 0) | (numChars > (16 - col) ) | ((numChars & 0x3) > 0) | 
		(line > 15) | 
		(col > 15) | ((col & 0x3) > 0) | 
		charBuf > 7
	)
		return -1;
	
	//Use a for loop over 32-bit writes; for some reason, memcpy is useless unless you write a full 16-character line
	for(i = 0; i<numChars; i=i+4)
	{
		XIo_Out32((warp_userioboard_get_lcd_charbufaddr(charBuf) + line*16 + col + i), *(unsigned int *)(chars + i));
	}

	return 0;
}

///@brief Reads an image file from a CompactFlash card and displays it on the LCD screen; this function overwrites the chracter map and character buffer 7
///
///@param filename String giving the name of the file to read; the file should be FAT16/8.3 compatible name ("image.rgb", for example)
int warp_userio_lcd_displayCFimage(const char* filename)
{
#ifdef XPAR_SYSACE_0_DEVICE_ID
#ifdef XILFATFS_MAXFILES
	int i, status;
	void* fid;
	
	fid = sysace_fopen(filename, "r");
	
	if(fid == 0)
		return -2; //fopen failed
	
	//Read 128x128 8-bit pixel values from the CF card
	status = sysace_fread((void *)LCD_CHARMAP_BUFFER, 1, 16384, fid);
	
	if(status != 16384)
		return -3; //Didn't read enough bytes; who knows what state the character map is in now

	status = sysace_fclose(fid);
	
	if(status != 0)
		return -4; //fclose failed; the Sysace controller is likely in a really bad state at this point

	//Write [0,1...255] to character buffer 7
	//This is required so that each block in the new "character map" (the image) can be read in order
	//The character buffer is a 32-bit memory and must be written 4 bytes at a time (there are no byte-enables on this RAM)
	for(i=0; i<256; i=i+4)
	{
		//Write 4-bytes: [i i+1 i+2 i+3]
		XIo_Out32((warp_userioboard_get_lcd_charbufaddr(7)+i), ((i<<24) + ((i+1)<<16) + ((i+2)<<8) + ((i+3)<<0)));
	}

	//Switch the dipslay to character buffer 7
	warp_userioboard_set_lcd_charbuf(7);

	return 0; //Success
#endif
#endif

	//If the project doesn't have a SysaceACE controller or xil_fatfs library, fail immediately
	return -1;
}

///@brief Configures the buzzer waveform generator
///
///@param period Sets the period of the buzzer control signal, in units of bus clock cycles; interpreted as 18-bit unsigned integer in hardware
///@param dutyCycle Sets the duty cycles of the buzzer control signal; intrepreted as UFix18_18 (18-bit unsigned fraction) in hardware
void warp_userioboard_buzzer_set(unsigned int period, unsigned int dutyCycle)
{
	//Set the buzzer period, in units of bus clock cycles
	// For example, given a 50MHz bus, period=50000 would generate a 1kHz tone
	XIo_Out32(USER_IO_BOARD_CONTROLLER_BUZZER_PERIOD, (unsigned int)period);

	// dutyCycle is a UFix18_18 fraction that sets the fraction of each period the buzzer is enabled
	// The value is handed as an unsigned int here to avoid floating point code bloat
	// The user needs to provide the int corresponding to the UFix18_18 value they want
	// A value of 0.05 (13107 as an int) is a good starting point
	XIo_Out32(USER_IO_BOARD_CONTROLLER_BUZZER_DUTYCYCLE, (unsigned int)dutyCycle);

	return;
}
