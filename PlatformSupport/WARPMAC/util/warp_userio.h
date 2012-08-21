/**********************************************************************
* This file provides macros and constants for interfacing with
* the LEDs, buttons and switches on the WARP FPGA Board v1.2
*
* The constants here assume a hardware platform (MHS) built using
*  Xilinx EDK 10.1.03 (or later)
*  Base System Builder
*  WARP FPGA Board v1.2 XBD svn rev 1444 (or later)
**********************************************************************/

#ifndef USERIO_H
#define USERIO_H

#include "warp_fpga_board.h"

#ifdef WARP_FPGA_BOARD_V1_2
/********************************************************/
/************* WARP FPGA Board v1.2 macros **************/
/********************************************************/

#define USERIO_MAP_DIPSW(x) ( (unsigned int)( (x & USERIO_MASK_DIPSW) >> USERIO_OFFSET_DIPSW) )
#define USERIO_MAP_PB(x) ( (unsigned int)( (x & USERIO_MASK_PB) >> USERIO_OFFSET_PB) )


#define USERIO_MAP_LEDS(x) ( (unsigned int)(USERIO_MASK_LEDS & ((unsigned int)x << USERIO_OFFSET_LEDS)) )

#define USERIO_CHAN_INPUTS	1
#define USERIO_CHAN_OUTPUTS	2

//Bit masks for user inputs (buttons & switches)
#define USERIO_MASK_DIPSW	0x3C000
#define USERIO_MASK_PB		0x03C00
#define USERIO_MASK_PBC		0x00400
#define USERIO_MASK_PBR		0x00800
#define USERIO_MASK_PBL		0x01000
#define USERIO_MASK_PBU		0x02000
#define USERIO_MASK_INPUTS	(USERIO_MASK_DIPSW | USERIO_MASK_PB)

//Offsets for user inputs
#define USERIO_OFFSET_DIPSW	14
#define USERIO_OFFSET_PB	10

//Bit masks for user outputs (LEDs and 7-segment displays)
#define USERIO_MASK_DISPR	0x0003F800
#define USERIO_MASK_DISPL	0x000007F0
#define USERIO_MASK_LEDS	0x0000000F
#define USERIO_MASK_OUTPUTS	(USERIO_MASK_DISPL | USERIO_MASK_DISPR | USERIO_MASK_LEDS)

//Offsets for user outputs
#define USERIO_OFFSET_DISPR	11
#define USERIO_OFFSET_DISPL	4
#define USERIO_OFFSET_LEDS	0

#define USERIO_MAP_DISPR(x) ( (unsigned int)(USERIO_MASK_DISPR & ( (unsigned int)x << USERIO_OFFSET_DISPR)) )
#define USERIO_MAP_DISPL(x) ( (unsigned int)(USERIO_MASK_DISPL & ( (unsigned int)x << USERIO_OFFSET_DISPL)) )

#endif //ifdef WARP_FPGA_BOARD_V1_2

#endif //ifndef USERIO_H
