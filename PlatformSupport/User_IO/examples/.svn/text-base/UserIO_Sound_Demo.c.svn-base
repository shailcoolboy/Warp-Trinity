#include <string.h>
#include "ascii_characters.h"
#include "warp_userioboard_util.h"
#include "Sound_Test.h"
#include "xparameters.h"

#define CLKFREQ 50000000

#define MIDDLE_A (CLKFREQ / 440)
#define LOUD 7500

int main()
{
	xil_printf("Starting Sound v00.1\r\n");

	int i, status;
	unsigned int trackball, trackball_prev;

	unsigned char buzzer_en = 0;
	unsigned int buzzer_duty = LOUD;
	unsigned int buzzer_period = MIDDLE_A;

	warp_userioboard_buzzer_set(buzzer_period, buzzer_duty);

	//Initialize the LCD for slot 1 (i.e. don't flip the image) and non-inverted colors
	warp_userioboard_lcd_init(1, 0);

	while(1)
	{
		trackball_prev = trackball;
		//Read the trackball inputs
		trackball = warp_userioboard_get_trackball();

		switch(trackball ^ trackball_prev)
		{
			case TRACKBALL_PUSH:
				if(trackball & TRACKBALL_PUSH)
					buzzer_en = buzzer_en ^ 1;
			break;
			case TRACKBALL_UP:
				if(trackball & TRACKBALL_UP)
					buzzer_period = buzzer_period + 2500;
			break;
			case TRACKBALL_DOWN:
				if(trackball & TRACKBALL_DOWN)
					buzzer_period = buzzer_period - 2500;
			break;
			case TRACKBALL_RIGHT:
				if(trackball & TRACKBALL_RIGHT)
					buzzer_duty = buzzer_duty + 250;
			break;
			case TRACKBALL_LEFT:
				if(trackball & TRACKBALL_LEFT)
					buzzer_duty = buzzer_duty - 250;
			break;
			default:
			break;
		}

		warp_userioboard_set_buzzer_en(buzzer_en);
		warp_userioboard_buzzer_set(buzzer_period, buzzer_duty);
	}
	
	return 0;
}
