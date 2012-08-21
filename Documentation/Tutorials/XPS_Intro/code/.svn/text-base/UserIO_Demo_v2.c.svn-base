#include "warp_v4_userio.h"
#include "xparameters.h"

int main(void)
{
	unsigned char ledDisp = 0;
	
	// Set the hex displays to number mode (see FPGA Board v2.2 User Guide)
	WarpV4_UserIO_NumberMode_All(XPAR_WARP_V4_USERIO_ALL_BASEADDR);

	while(1)
	{
		xil_printf("Displaying: %x\r\n", ledDisp);

		// Show the number on the three hex displays and on the LEDs
		WarpV4_UserIO_WriteNumber_LeftHex(XPAR_WARP_V4_USERIO_ALL_BASEADDR, ledDisp, 0);
		WarpV4_UserIO_WriteNumber_MiddleHex(XPAR_WARP_V4_USERIO_ALL_BASEADDR, ledDisp, 0);
		WarpV4_UserIO_WriteNumber_RightHex(XPAR_WARP_V4_USERIO_ALL_BASEADDR, ledDisp, 0);
		WarpV4_UserIO_Leds(XPAR_WARP_V4_USERIO_ALL_BASEADDR, ledDisp);

		usleep(600000);

		//Cycle the displays through [0x0,0xF]
		if(ledDisp == 15)
			ledDisp = 0;
		else
			ledDisp++;
	}
	
	return 0;

}
