// test routines for rtsctsMac

#ifndef RTSCTSTEST_H
#define RTSCTSTEST_H

extern unsigned int tvar[];

// macros for timing code
#define wtic do { warp_timer_setVal(3,800000); warp_timer_start(3); } while(0)
#define wtoc do { warp_timer_pause(3); tvar[15]=800000-warp_timer_timeLeft(3)-224; warp_timer_stop(3); } while(0)

void printAddr();
void printRXbuf();
void printRXGains();
void printTvars();
void timerTest_isr();
void timerTest();

#endif
