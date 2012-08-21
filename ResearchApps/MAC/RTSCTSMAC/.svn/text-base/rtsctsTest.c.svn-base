// Testing functions for rtsctsMac
// 7/1/08
// Keith Wilhelm



#include "xparameters.h"
#include "warpphy.h"



///array of test variables
unsigned int tvar[16] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};



///print an address
void printAddr(unsigned char * addr) {
	xil_printf("\r\n%02x %02x %02x %02x %02x %02x",
		addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
}


///show the contents of the RX packet buffer
void printRXbuf() {

	unsigned short i = 0;
	#define rxbyte(x) *(unsigned char *)(warpphy_getBuffAddr(0) + 24 + i + x)
	xil_printf("\n");
	for(i=0; i < 0x80; i += 0x10) {
		xil_printf("\r\n%04x  %02x %02x %02x %02x %02x %02x %02x %02x "
		" %02x %02x %02x %02x %02x %02x %02x %02x", i, 
		rxbyte(0), rxbyte(1), rxbyte(2), rxbyte(3),
		rxbyte(4), rxbyte(5), rxbyte(6), rxbyte(7),
		rxbyte(8), rxbyte(9), rxbyte(10), rxbyte(11),
		rxbyte(12), rxbyte(13), rxbyte(14), rxbyte(15));
	}
	#undef rxbyte

}


///show RF and baseband gains assigned to antennas A and B by the AGC
void printRXGains() {
	unsigned int g = ofdm_AGC_GetGains();
	xil_printf("\r\n%d: A_BB=%d,A_RF=%d,B_BB=%d,B_RF=%d",
		g, (g >> 2) & 31, g & 3, (g >> 10) & 31, (g >> 8) & 3);
}


///print the test variables
void printTvars() {
	unsigned char i;
	xil_printf("\r\n");
	for(i = 0; i < 16; i++)
		xil_printf("%d ", tvar[i]);
}


///interrupt service routine for testing warp_timer
void timerTest_isr() {
	tvar[15] = warp_timer_getInterrupts();
}


///tests for warp_timer
void timerTest() {
	volatile int i = 0;
	warpmac_setTimerCallback((void *)timerTest_isr);
	for(i=0; i<4; i++) {
		warp_timer_setVal(i,50000);
		warp_timer_start(i);
		tvar[0] = warp_timer_timeLeft(i);
		tvar[1] = warp_timer_timeLeft(i);
		tvar[2] = warp_timer_getStatus(i);
		warp_timer_pause(i);
		tvar[3] = warp_timer_timeLeft(i);
		tvar[4] = warp_timer_timeLeft(i);
		tvar[5] = warp_timer_getStatus(i);
		warp_timer_resume(i);
		tvar[6] = warp_timer_timeLeft(i);
		tvar[7] = warp_timer_timeLeft(i);
		tvar[8] = warp_timer_getStatus(i);
		warp_timer_stop(i);
		tvar[9] = warp_timer_timeLeft(i);
		tvar[10] = warp_timer_timeLeft(i);
		tvar[11] = warp_timer_getStatus(i);
		warp_timer_start(i);
		while(warp_timer_isActive(i)) tvar[12]++;
		tvar[13] = warp_timer_timeLeft(i);
		tvar[14] = warp_timer_getStatus(i);
		printTvars();
	}
	for(i=0; i<4; i++) {
		warp_timer_setVal(i,20000);
		warp_timer_start(i);
		tvar[0] = warp_timer_isExpired(i);
		tvar[1] = warp_timer_isActive(i);
		tvar[2] = warp_timer_isPaused(i);
		warp_timer_pause(i);
		tvar[3] = warp_timer_isExpired(i);
		tvar[4] = warp_timer_isActive(i);
		tvar[5] = warp_timer_isPaused(i);
		warp_timer_resume(i);
		tvar[6] = warp_timer_isExpired(i);
		tvar[7] = warp_timer_isActive(i);
		tvar[8] = warp_timer_isPaused(i);
		warp_timer_stop(i);
		tvar[9] = warp_timer_isExpired(i);
		tvar[10] = warp_timer_isActive(i);
		tvar[11] = warp_timer_isPaused(i);
		warp_timer_start(i);
		while(warp_timer_isActive(i));
		tvar[12] = warp_timer_isExpired(i);
		tvar[13] = warp_timer_isActive(i);
		tvar[14] = warp_timer_isPaused(i);
		printTvars();
	}
	for(i=0; i<4; i++) {
		warp_timer_setVal(i,20000);
		warp_timer_start(i);
		tvar[0] = warp_timer_getStatuses();
		warp_timer_pause(i);
		tvar[1] = warp_timer_getStatuses();
		warp_timer_resume(i);
		tvar[2] = warp_timer_getStatuses();
		warp_timer_stop(i);
		tvar[3] = warp_timer_getStatuses();
		warp_timer_start(i);
		while(warp_timer_isActive(i));
		tvar[4] = warp_timer_getStatuses();
		printTvars();
	}
	while(i != 0);	// do not return
}
