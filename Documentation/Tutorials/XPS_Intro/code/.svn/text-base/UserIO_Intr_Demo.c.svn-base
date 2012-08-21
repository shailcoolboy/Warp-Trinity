#include "xgpio.h"
#include "xexception_l.h"
#include "xintc.h"
#include "warp_userio.h"
#include "xparameters.h"

//Shortcuts for constants in xparameters.h
#define INTC_DEVICE_ID		XPAR_XPS_INTC_0_DEVICE_ID
#define USERIO_DEVICE_ID 	XPAR_USER_IO_DEVICE_ID
#define USERIO_IRPT_ID		XPAR_XPS_INTC_0_USER_IO_IP2INTC_IRPT_INTR

//Instances of the GPIO and Intc drivers
static XGpio GPIO_UserIO;
static XIntc Intc;

//Global variable for tracking active LED outputs
static unsigned int LED_Outputs = 0;

//Function prototypes
unsigned char sevenSegmentMap(unsigned char x);
void UserIO_InterruptHandler(void *InstancePtr);
void callback_button_center();
void callback_button_right();
void callback_button_left();
void callback_button_up();
void callback_dipsw(unsigned char dipsw_state);

int main(void)
{
    XStatus Status;
	unsigned char ledDisp = 0;
	
	//Initialize the UserIO GPIO core
	Status = XGpio_Initialize(&GPIO_UserIO, USERIO_DEVICE_ID);

	//We use both channels in the GPIO core- one for inputs, one for outputs
	XGpio_SetDataDirection(&GPIO_UserIO, USERIO_CHAN_INPUTS, USERIO_MASK_INPUTS);
	XGpio_SetDataDirection(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, 0);

	//Make sure the LEDs are all off by default
	XGpio_DiscreteClear(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, USERIO_MASK_OUTPUTS);

/****** START Interrupt Setup ********/

	//Initailize the interrupt controller
	Status = XIntc_Initialize(&Intc, INTC_DEVICE_ID);
	if(Status) xil_printf("Intc Setup Error!\r\n");

	//Assign the UserIO ISR; there is a single ISR for any GPIO interrupt event
	XIntc_Connect(&Intc, USERIO_IRPT_ID, (XInterruptHandler)UserIO_InterruptHandler, &GPIO_UserIO);

	//Configure & enable the GPIO interrupt output
	// The interrupt is only enabled for the GPIO input channel
    XGpio_InterruptEnable(&GPIO_UserIO, USERIO_CHAN_INPUTS);
    XGpio_InterruptGlobalEnable(&GPIO_UserIO);

	//Enable the UserIO interrupt in the interrupt controller
    XIntc_Enable(&Intc, USERIO_IRPT_ID);
	
	//Configure & enable the PPC interrupt input
	XExc_Init();
	XExc_RegisterHandler(XEXC_ID_NON_CRITICAL_INT, (XExceptionHandler)XIntc_InterruptHandler, &Intc);
	XExc_mEnableExceptions(XEXC_NON_CRITICAL);

	//Finally start the interrupt controller
	XIntc_Start(&Intc, XIN_REAL_MODE);

/****** END Interrupt Setup ********/

	//Manually call the UserIO ISR once to store the initial value of the buttons/switches
	// This is especially important for applications where the value of the DIP switch means something at boot
	UserIO_InterruptHandler((void *)&GPIO_UserIO);

	while(1)
	{
		xil_printf("Displaying: %x\r\n", ledDisp);

		//Update the global variable we use to track which LED/segments are currently lit
		// The xps_gpio core doesn't allow outputs to be read from code, so we have to track this internally
		LED_Outputs = (USERIO_MAP_LEDS(ledDisp) | USERIO_MAP_DISPR(ledDisp) | USERIO_MAP_DISPL(ledDisp));
		
		//Set the LEDs & hex displays
		XGpio_DiscreteSet(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, LED_Outputs);

		usleep(600000);

		//Cycle the displays through [0x0,0xF]
		if(ledDisp == 15)
			ledDisp = 0;
		else
			ledDisp++;
	}
	
	return 0;

}

//Interrupt service routine for the single GPIO interrupt
// This function decodes which input caused the interrupt and calls the appropriate callback
void UserIO_InterruptHandler(void *InstancePtr)
{
	xil_printf("UserIO ISR!");

	static unsigned int previousAssertedInputs;
	unsigned int assertedInputs;
	unsigned int newAssertedInputs;
	
	//Re-interpret the generic input pointer as a GPIO driver instance
    XGpio *GpioPtr = (XGpio *)InstancePtr;

	//Disable the GPIO core's interrupt output
    XGpio_InterruptDisable(GpioPtr, USERIO_CHAN_INPUTS);

	//Read the GPIO inputs; each 1 is a currently-asserted input bit
	assertedInputs = XGpio_DiscreteRead(&GPIO_UserIO, USERIO_CHAN_INPUTS) & USERIO_MASK_INPUTS;

	//XOR the current active bits with the previously active bits
	newAssertedInputs = assertedInputs ^ previousAssertedInputs;
	previousAssertedInputs = assertedInputs;

	//Check whether push buttons or DIP switch triggered the interrupt
	// We assume a user callback per button, and another for the DIP switch
	if(newAssertedInputs & USERIO_MASK_PBC) callback_button_center();
	if(newAssertedInputs & USERIO_MASK_PBR) callback_button_right();
	if(newAssertedInputs & USERIO_MASK_PBL) callback_button_left();
	if(newAssertedInputs & USERIO_MASK_PBU) callback_button_up();
	if(newAssertedInputs & USERIO_MASK_DIPSW) callback_dipsw( USERIO_MAP_DIPSW(assertedInputs) );

	//Clear, acknowledge and re-enable the GPIO interrupt output
	XGpio_InterruptClear(GpioPtr, USERIO_CHAN_INPUTS);
	XIntc_Acknowledge(&Intc, USERIO_IRPT_ID);
	XGpio_InterruptEnable(GpioPtr, USERIO_CHAN_INPUTS);
	
	return;
}

//Place holders for user-code callbacks
void callback_button_center()
{
	xil_printf("PB Center!\r\n");
	return;
}

void callback_button_right()
{
	xil_printf("PB Right!\r\n");
	return;
}

void callback_button_left()
{
	xil_printf("PB Left!\r\n");
	return;
}

void callback_button_up()
{
	xil_printf("PB Up!\r\n");
	return;
}

void callback_dipsw(unsigned char dipsw_state)
{
	xil_printf("DIP SW: 0x%04x\r\n", dipsw_state);
	return;
}

unsigned char sevenSegmentMap(unsigned char x)
{
	switch(x)
	{
		case(0x0) : return 0x007E;
		case(0x1) : return 0x0030;
		case(0x2) : return 0x006D;
		case(0x3) : return 0x0079;
		case(0x4) : return 0x0033;
		case(0x5) : return 0x005B;
		case(0x6) : return 0x005F;
		case(0x7) : return 0x0070;
		case(0x8) : return 0x007F;
		case(0x9) : return 0x007B;

		case(0xA) : return 0x0077;
		case(0xB) : return 0x007F;
		case(0xC) : return 0x004E;
		case(0xD) : return 0x007E;
		case(0xE) : return 0x004F;
		case(0xF) : return 0x0047;
		default : return 0x0000;
	}
}
