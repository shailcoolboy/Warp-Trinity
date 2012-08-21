/* Copyright (c) 2006 Rice University */ 
/* All Rights Reserved */ 
/* This code is covered by the Rice-WARP license */ 
/* See http://warp.rice.edu/license/ for details */ 


#ifndef WARPSYSACE_H
#define WARPSYSACE_H

#define INVALIDRADIO -2000

// The following library contains functions that provide specific CF
// functionality. All of these require the Xilinx FAT Library to be installed
// in MSS file. This can be done by adding the following lines of code to the
// system's MSS file.
// BEGIN LIBRARY
// PARAMETER LIBRARY_NAME = xilfatfs
// PARAMETER LIBRARY_VER = 1.00.a
// PARAMETER CONFIG_WRITE = true
// PARAMETER CONFIG_DIR_SUPPORT = true
// PARAMETER CONFIG_FAT12 = false
// PARAMETER CONFIG_MAXFILES = 5
// PARAMETER CONFIG_BUFCACHE_SIZE = 10240
// PARAMETER PROC_INSTANCE = ppc405_0
// END

// A General Append function for SysACE I/O. It takes in the
// file to which the string needs to be appended, and the string that
// needs to be appended. You must make sure to be located in
// the proper directory of the file itself using the sysace_chdir function
// detailed in the "LibXil FATFile System (FATfs)" section of http://www.xilinx.com/ise/embedded/oslibs_rm.pdf
int WarpSysace_appendLog(char *buffer);

// Reconfigures the board with the ACE file located at the newaddr location.
// baseaddr is the base address of the SystemACE.
void WarpSysace_reconfigure(unsigned int baseaddr, unsigned int newaddr);

// Get lock function. Must be called carefully! If lock already exists,
// the system may freeze up. Refer to WARP tutorial for an example
// to see proper calling techniques and the contents of function
// WarpSysace_reconfigure where the unlock is automatically called for you
// during after a switch!
void WarpSysace_GetLock(unsigned int baseaddr);



// The following functions are radio board functions used that utilize the
// sysace controller and compact flash.



// Get the I channel dc offset value for calibrating the radio board defined by 'radio'
// Returns INVALIDRADIO if the radio value given does not exist or if more than one radio value is
// given. Returns the I channel value in the normal case.
short WarpSysace_IChanDcOffset(unsigned int radio);

// Get the Q channel dc offset value for calibrating the radio board defined by 'radio'.
// Returns INVALIDRADIO if the radio value given does not exist or if more than one radio value is
// given. Returns the I channel value in the normal case.
short WarpSysace_QChanDcOffset(unsigned int radio);


short WarpSysace_UpdateDcOffset(short ival, short qval, unsigned int radio);


#endif


