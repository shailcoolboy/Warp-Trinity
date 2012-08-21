/* Copyright (c) 2006 Rice University */ 
/* All Rights Reserved */ 
/* This code is covered by the Rice-WARP license */ 
/* See http://warp.rice.edu/license/ for details */ 


#include "warplib.h"
#include <stdlib.h>
#include "xparameters.h"

#include <string.h>


// a test function to make sure the library is being called correctly.

void WarpLib_test(void)
{
	print("This is a test function for the new TAP Library that we are developing. 1337.");
}

// a basic int to character converter

char WarpLib_itoc(int x)
{
	char c = (char)(x+48);
	return c;
}

// a basic character to int converter

int WarpLib_ctoi(char c)
{
	int x = (int)(c-48);
	return x;
}

// 7 segment display mapper. Takes in desired char-type of a char or number
// and gives out its corresponding 7-segment display code


int WarpLib_segmap(char x) 
{

	switch(x){

	case('0') : return 0x007E;
	case('1') : return 0x0030;
	case('2') : return 0x006D;
	case('3') : return 0x0079;
	case('4') : return 0x0033;
	case('5') : return 0x005B;
	case('6') : return 0x005F;
	case('7') : return 0x0070;
	case('8') : return 0x007F;
	case('9') : return 0x007B;

	case('A') : return 0x0077;
	case('a') : return 0x0077;
	case('B') : return 0x007F;
	case('b') : return 0x007F;
	case('C') : return 0x004E;
	case('c') : return 0x004E;
	case('D') : return 0x007E;
	case('d') : return 0x007E;
	case('E') : return 0x004F;
	case('e') : return 0x004F;
	case('F') : return 0x0047;
	case('f') : return 0x0047;
	default : return 0x0001;
	}

}


