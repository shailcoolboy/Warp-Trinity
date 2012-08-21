/*
 *  interruptTester.c
 *  
 *	This source describes the proper way to handle multiple interrupts with a PowerPC.
 *	The code assumes a properly configured base system containing an opb_timer,
 *	opb_gpio push buttons, a RS232 opb_uartlite, and finally and opb_intc interrupt
 * 	controller.
 *
 *	The code will periodically start a timer. By default, this timer will expire every
 *	6 seconds. Before the timer expires, the user can depress push buttons and see confirmation
 * 	of those events on a terminal connected to the board via the RS232 serial port.
 *	Upon the expiration of the timer, the "timer_a_int_handler" ISR is called by the
 * 	interrupt controller driver.
 *
 *	In this ISR, the program will block for three seconds. This effectively simulates a
 * 	long operation. During this time, users will not be able to trigger interrupts with
 * 	push buttons.
 *
 *  When the ISR returns, push buttons become operational again. Pressing the left button
 *	will disable the periodic timer at the interrupt controller level (i.e. the timer
 *	itself is still generating interrupt signals). Pressing the right button will re-enable
 * 	the interrupts, returning the system to its normal state.
 *
 *  Created by Chris Hunter on 1/24/07.
 *
 */


#include "xparameters.h"
#include "xtmrctr.h"
#include "xintc.h"
#include "xgpio.h"
#include "xexception_l.h"


// Driver instances
static XGpio myGpio;
static XTmrCtr myTimer;
static XIntc myIntc;


// Push Button ISR: function is called upon the depression of ANY of the 4
// buttons. Which button is determined within the ISR.
void pb_int_handler(void *baseaddr_p) {
	Xuint32 dsr;
	XStatus stat;
	char lock;
	
	//DSR contains the information of which button was depressed, so we can switch
	//on its value.
	dsr = XGpio_mGetDataReg(XPAR_PUSH_BUTTONS_4BIT_BASEADDR, 2);
	switch(dsr) {
		
		case 0x01:
			xil_printf("Middle\r\n");
			break;
			
		case 0x02:
			xil_printf("Right: Enabling Timer interrupts\r\n");
			XIntc_Enable(&myIntc, XPAR_OPB_INTC_0_OPB_TIMER_0_INTERRUPT_INTR);
			
			break;
			
		case 0x08:
			xil_printf("Up\r\n");
			break;
			
		case 0x04:
			xil_printf("Left: Disabling Timer interrupts\r\n");
			XIntc_Disable(&myIntc, XPAR_OPB_INTC_0_OPB_TIMER_0_INTERRUPT_INTR);
			break;
			
		default : {
		}
					
	}
	//Clear the interrupt both in the Gpio instance as well as the interrupt controller
	XGpio_InterruptClear(&myGpio, 0x3);
	XIntc_Acknowledge(&myIntc,XPAR_OPB_INTC_0_PUSH_BUTTONS_4BIT_IP2INTC_IRPT_INTR);
}

// Timer ISR: function is called upon the expiration of either of two timers in a 
// single instance of the opb_timer peripheral. For the purposes of this demonstration,
// we are only using timer 0.
void timer_a_int_handler(void *CallBackRef, Xuint8 TmrCtrNumber) {

		if (TmrCtrNumber==0) {
			xil_printf("In timer interrupt handler... waiting for 3 seconds\r\n");
			usleep(3000000);
			xil_printf("Leaving timer interrupt handler ...\r\n");
		}
	//Clear the interrupt
	XIntc_Acknowledge(&myIntc,XPAR_OPB_INTC_0_OPB_TIMER_0_INTERRUPT_INTR);
	}
	
// Main: this is the function that is executed at the start of the program.	
int main(){
	
	/*There are three phases of set-up to get interrupts to work:
		1) Device initialization and configuration
		2) Interrupt controller initialization and configuration
		3) PowerPC exception initialization
	*/

	
	//********************** 1. Device initialization and configuration *************************
	xil_printf("Setting up peripherals...\r\n");
	
	//Initialize and configuring the timer
	XTmrCtr_Initialize(&myTimer, XPAR_OPB_TIMER_0_DEVICE_ID);
	XTmrCtr_SelfTest(&myTimer, 0);
	XTmrCtr_SetOptions(&myTimer,(Xuint8)0,XTC_INT_MODE_OPTION | XTC_DOWN_COUNT_OPTION | XTC_AUTO_RELOAD_OPTION);
	XTmrCtr_SetHandler(&myTimer,(XTmrCtr_Handler)timer_a_int_handler,NULL); 
	
	//Initialize and configure the push buttons
	XGpio_Initialize(&myGpio, XPAR_PUSH_BUTTONS_4BIT_DEVICE_ID);
	XGpio_mSetDataDirection(XPAR_PUSH_BUTTONS_4BIT_BASEADDR, 1, 0x3);
	XGpio_InterruptEnable(&myGpio, XGPIO_IR_CH1_MASK);
	XGpio_InterruptGlobalEnable(&myGpio);
	//*******************************************************************************************

	
	
	//*************** 2. Interrupt controller initialization and configuration ******************
	xil_printf("Setting up interrupt controller...\r\n");
	XIntc_Initialize(&myIntc, XPAR_OPB_INTC_0_DEVICE_ID);
	
	//Attach the ISRs to the interrupt controller driver.
	//NOTE: The timer is weird. You have to attach "XTmrCtr_InterruptHandler," which is nested
	//deep within the timer driver. It in turn calls the callback you provide during the
	//configuration above.
	XIntc_Connect(&myIntc, XPAR_OPB_INTC_0_PUSH_BUTTONS_4BIT_IP2INTC_IRPT_INTR,
                           (XInterruptHandler)pb_int_handler,
                           &myGpio);
	XIntc_Connect(&myIntc, XPAR_OPB_INTC_0_OPB_TIMER_0_INTERRUPT_INTR,
                           (XInterruptHandler)XTmrCtr_InterruptHandler,
                           &myTimer);									
									
	XIntc_Start(&myIntc, XIN_REAL_MODE);
	XIntc_Enable(&myIntc, XPAR_OPB_INTC_0_PUSH_BUTTONS_4BIT_IP2INTC_IRPT_INTR);
	XIntc_Enable(&myIntc, XPAR_OPB_INTC_0_OPB_TIMER_0_INTERRUPT_INTR);
	//*******************************************************************************************



	//************************ 3. PowerPC exception initialization ******************************
	xil_printf("Setting up exceptions...\r\n");		
    XExc_Init();
    XExc_RegisterHandler(XEXC_ID_NON_CRITICAL_INT,
                        (XExceptionHandler)XIntc_InterruptHandler,
                         &myIntc);
    XExc_mEnableExceptions(XEXC_NON_CRITICAL);
	//*******************************************************************************************

	
	//Set the timer to expire every 6 seconds
	XTmrCtr_SetResetValue(&myTimer, (Xuint8)0, 6 * 50000000);
	XTmrCtr_Start(&myTimer, (Xuint8)0);
	
	
	xil_printf("Entering loop...\r\n");
	while(1){
	}
	
}



