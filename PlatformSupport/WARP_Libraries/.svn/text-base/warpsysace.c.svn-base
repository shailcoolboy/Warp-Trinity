/* Copyright (c) 2006 Rice University */ 
/* All Rights Reserved */ 
/* This code is covered by the Rice-WARP license */ 
/* See http://warp.rice.edu/license/ for details */ 


#include "warpsysace.h"
#include <stdio.h>
#include <stdlib.h>
#include "xparameters.h"
#include "xsysace_l.h"
#include "xsysace.h"
#include <string.h>
#include "warplib.h"
#include "sysace_stdio.h"




/**************************************************************************/


#define LSIZE 2048

#ifdef XPAR_XSYSACE_NUM_INSTANCES
XSysAce SA;
#endif

/**************************************************************************/

// This is a system for appending log files. The size of each log can be set by modifying LSIZE
// It creates log files as well as has a master log name file to keep track of the current file
// being appended

#ifdef XPAR_XSYSACE_NUM_INSTANCES
int WarpSysace_appendLog(char *buffer) {

	if (strlen(buffer) > LSIZE) {
		return -1;
	}
	else {

		// Define some constants and determine if the current-name-log-file exists

		char fname[20];

		char filedata[LSIZE]="";

		void *openfile = sysace_fopen("FNAMELOG.TXT", "r");

		int filedatasize = sysace_fread(NULL, 1, 20, openfile);

		// print("Size established\r\n");

		// putnum(filedatasize);

		// print("\r\n");

		sysace_fclose(openfile);

		if (filedatasize <= 0) { // create the logname file if it doesn't exist

			void *openfile2 = sysace_fopen("FNAMELOG.TXT", "w");

			strcat(fname, "LOG0000.TXT"); // if it doesn't exist we assume we're starting at the first log file

			sysace_fwrite(fname, 1, strlen(fname), openfile2);

			// puts(fname);

			// sysace_fclose(openfile2);

			// print("Main log file created\r\n");

		}
		else { // otherwise, open the namelog file since it exists, and get the current log file to be modified

			void *openfile3 = sysace_fopen("FNAMELOG.TXT", "r");

			sysace_fread(fname, 1, 20, openfile3);

			sysace_fclose(openfile3);

			// print("Main log file read\r\n");

		}

		// the next step is to read in the amount of data as well as our string size
		// to determine whether to append this file or create a new one

		// puts(fname);

		void *datafile = sysace_fopen(fname, "r");

		// putnum(datafile);

		int amtdata = sysace_fread(filedata, 1, LSIZE, datafile); // get the amount of data in the current log file

		sysace_fclose(datafile);

		// print("Size of data in log file is:");

		// putnum(amtdata);

		// print("\r\n");

		if ((amtdata + strlen(buffer)) <= LSIZE) { // if there is enough space, we simply append the log file by
												   // concatination and overwriting
			void *datafile2 = sysace_fopen(fname, "w");

			// putnum(datafile2);

			strcat(filedata, buffer);

			//puts(filedata);

			sysace_fwrite(filedata, 1, strlen(filedata), datafile2);

			sysace_fclose(datafile2);

			// print("Data written\r\n");

		}
		else { // otherwise we go through a series of nested if/else statements to determine the new file
			   // name to be created. It's obvius that it can be compressed into a simple recursive call
			   // but this should hopefully make it easier to understand. We use our int-to-char and char-to-int
			   // functions to draw from the current log-file name to determine which digits to increment.
			int curr3=WarpLib_ctoi(fname[6]);
			if(curr3<9)	{
				curr3=curr3+1;
				fname[6]=WarpLib_itoc(curr3);
			}
			else {
				curr3=0;
				fname[6]=WarpLib_itoc(curr3);
				int curr2=WarpLib_ctoi(fname[5]);
				if(curr2<9)	{
					curr2=curr2+1;
					fname[5]=WarpLib_itoc(curr2);
				}
				else {
					curr2=0;
					fname[5]=WarpLib_itoc(curr2);
					int curr1=WarpLib_ctoi(fname[4]);
					if(curr1<9)	{
						curr1=curr1+1;
						fname[4]=WarpLib_itoc(curr1);
					}
					else {
						curr1=0;
						fname[4]=WarpLib_itoc(curr1);
						int curr0=WarpLib_ctoi(fname[3]);
						if(curr0<9) {
							curr0=curr0+1;
							fname[3]=WarpLib_itoc(curr0);
						}
						else {
							print("\r\n\r\nError: Out of Range\r\n\r\n");
						}
					}
				}
			}

			// puts(fname);

			// now that the new file name has been determined, we create it and write the new data into it

			void *newdatafile = sysace_fopen(fname, "w");
			// puts(buffer);
			sysace_fwrite(buffer, 1, strlen(buffer), newdatafile);
			sysace_fclose(newdatafile);

			// we now update the file-name-log with the new file-name

			void *mainfile = sysace_fopen("FNAMELOG.TXT", "w");
			sysace_fwrite(fname, 1, strlen(fname), mainfile);
			sysace_fclose(mainfile);

			// print("Data written to new file");


		}

		return 0;
	}


}
#endif


#ifdef XPAR_XSYSACE_NUM_INSTANCES
void WarpSysace_reconfigure(unsigned int baseaddr, unsigned int newaddr) 
{

	// the last value in the XSysAce_mSetCfgAddr function call denotes the configuration
	// program to load as set in iMPACT. In the iMPACT setup tutorial, we set the bitstream
	// program to reconfigure the FPGA as configuration address 0, and this system as configuration
	// address 0 so that we may switch back. The iMPACT system allows for up to 8 reconfiguration
	// bitstreams (represented by 0-7).

	SA.BaseAddress = baseaddr;

	XSysAce_mSetControlReg(baseaddr, 0x0);
	XSysAce_mSetCfgAddr(baseaddr, newaddr);
	XSysAce_mOrControlReg(baseaddr, 0x0008);
	XSysAce_ResetCfg(&SA);
	//putnum(XSysAce_mGetControlReg(baseaddr)); // for debug
	XSysAce_mOrControlReg(baseaddr, XSA_CR_CFGSTART_MASK);
	XSysAce_Unlock(&SA);

}
#endif

#ifdef XPAR_XSYSACE_NUM_INSTANCES
void WarpSysace_GetLock(unsigned int baseaddr)
{

SA.BaseAddress = baseaddr;
	int a;
	XStatus stat;

	// Initialize the SysACE
		stat = XSysAce_Initialize(&SA, 0);

		do {
			// Get a lock on the SysACE. Need it for reading and writing to flash.
			stat = XSysAce_Lock(&SA, XFALSE);

			for(a = 0; a < 1000; a++) {
			}

	} while(stat == XST_DEVICE_BUSY);

}
#endif


#ifdef XPAR_XSYSACE_NUM_INSTANCES
short WarpSysace_IChanDcOffset(unsigned int radio) {

	sysace_chdir("a:\\CAL");

	short ival;
	char name[20]="";

	switch(radio) {

		case(0x0001) : {
			strcat(name, "RAD1CAL.TXT");
			break;
		}
		case(0x0002) : {
			strcat(name, "RAD2CAL.TXT");
			break;
		}
		case(0x0004) : {
			strcat(name, "RAD3CAL.TXT");
			break;
		}
		case(0x0008) : {
			strcat(name, "RAD4CAL.TXT");
			break;
		}
		default : {
			return -2000;
		}
	}

	void *calfile = sysace_fopen(name, "r");

	sysace_fread(&ival, 1, 2, calfile);

	sysace_fclose(calfile);

	return ival;

}
#endif


#ifdef XPAR_XSYSACE_NUM_INSTANCES
short WarpSysace_QChanDcOffset(unsigned int radio) {

	sysace_chdir("a:\\CAL");

	short qval;
	char name[20]="";

	switch(radio) {

		case(0x0001) : {
			strcat(name, "RAD1CAL.TXT");
			break;
		}
		case(0x0002) : {
			strcat(name, "RAD2CAL.TXT");
			break;
		}
		case(0x0004) : {
			strcat(name, "RAD3CAL.TXT");
			break;
		}
		case(0x0008) : {
			strcat(name, "RAD4CAL.TXT");
			break;
		}
		default : {
			return -2000;
		}
	}

	void *cal2file = sysace_fopen(name, "r");

	sysace_fread(NULL, 1, 2, cal2file);

	sysace_fread(&qval, 1, 2, cal2file);

	sysace_fclose(cal2file);

	return qval;

}
#endif


#ifdef XPAR_XSYSACE_NUM_INSTANCES
short WarpSysace_UpdateDcOffset(short ival, short qval, unsigned int radio) {

	sysace_mkdir("a:\\CAL");

	sysace_chdir("a:\\CAL");

	char name[20]="";

	switch(radio) {

		case(0x0001) : {
			strcat(name, "RAD1CAL.TXT");
			break;
		}
		case(0x0002) : {
			strcat(name, "RAD2CAL.TXT");
			break;
		}
		case(0x0004) : {
			strcat(name, "RAD3CAL.TXT");
			break;
		}
		case(0x0008) : {
			strcat(name, "RAD4CAL.TXT");
			break;
		}
		default : {
			return -2000;
		}
	}

	void *calfile = sysace_fopen(name, "r");

	char filedatasize = sysace_fread(NULL, 1, 1000, calfile);

	sysace_fclose(calfile);

	if (filedatasize <= 0) {

		void *writefile = sysace_fopen(name, "w");

		sysace_fwrite(&ival, 1, 2, writefile);

		sysace_fwrite(&qval, 1, 2, writefile);

		sysace_fclose(writefile);

	}
	else {
		char val[100];

		void *cal2file = sysace_fopen(name, "r");

		sysace_fread(NULL, 1, 4, cal2file);

		sysace_fread(&val, 1, 100, cal2file);

		sysace_fclose(cal2file);

		void *write2file = sysace_fopen(name, "w");

		sysace_fwrite(&ival, 1, 2, write2file);

		sysace_fwrite(&qval, 1, 2, write2file);

		sysace_fwrite(&val, 1, filedatasize, write2file);

		sysace_fclose(write2file);

	}

}
#endif



