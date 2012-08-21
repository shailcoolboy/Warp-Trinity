#include <string.h>
#include "ascii_characters.h"
#include "warp_userioboard_util.h"
#include "xparameters.h"

#include "xsysace.h"

int main()
{
	xil_printf("Starting User IO Board CF Test v00.5\r\n");

	int i, status;

	//Initialize the LCD for slot 1 (i.e. don't flip the image) and non-inverted colors
	warp_userioboard_lcd_init(1, 0);

	usleep(5000000);

	while(1)
	{
		status = warp_userio_lcd_displayCFimage("bar00.rgb");
		status |= warp_userio_lcd_displayCFimage("bar01.rgb");
		status |= warp_userio_lcd_displayCFimage("bar02.rgb");
		status |= warp_userio_lcd_displayCFimage("bar03.rgb");
		status |= warp_userio_lcd_displayCFimage("bar04.rgb");
		status |= warp_userio_lcd_displayCFimage("bar05.rgb");
		status |= warp_userio_lcd_displayCFimage("bar06.rgb");
		status |= warp_userio_lcd_displayCFimage("bar07.rgb");
		status |= warp_userio_lcd_displayCFimage("bar08.rgb");
		status |= warp_userio_lcd_displayCFimage("bar09.rgb");
		status |= warp_userio_lcd_displayCFimage("bar10.rgb");
		status |= warp_userio_lcd_displayCFimage("bar11.rgb");
		status |= warp_userio_lcd_displayCFimage("bar12.rgb");
		status |= warp_userio_lcd_displayCFimage("bar13.rgb");
		status |= warp_userio_lcd_displayCFimage("bar14.rgb");
		status |= warp_userio_lcd_displayCFimage("bar15.rgb");

		if(status != 0)
		{
			xil_printf("Error!\r\n");
			break;
		}
	}
	
	return 0;
}
