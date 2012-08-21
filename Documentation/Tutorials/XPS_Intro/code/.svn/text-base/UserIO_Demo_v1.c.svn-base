#include "xgpio.h"
#include "warp_userio_v1.h"
#include "xparameters.h"

//Shortcuts for constants in xparameters.h
#define USERIO_DEVICE_ID 	XPAR_USER_IO_DEVICE_ID

//Instances of the GPIO and Intc drivers
static XGpio GPIO_UserIO;

//Global variable for tracking active LED outputs
static unsigned int LED_Outputs = 0;

//Function prototypes
unsigned char sevenSegmentMap(unsigned char x);

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
