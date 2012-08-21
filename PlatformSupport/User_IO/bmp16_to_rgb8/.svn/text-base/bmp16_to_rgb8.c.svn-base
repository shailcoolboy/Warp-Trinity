/* This program converts a 128x128 16-bit color BMP image to a 128x128 8-bit RGB array of pixel values
 * suitable for use on the WARP User I/O Board's LCD screen. It produces two output formats; for both formats
 * the pixles are re-arranged into 256 64-pixel blocks to accomodate the User I/O board controller's
 * character map pixel ordering.
 * 
 * See http://warp.rice.edu/trac/wiki/HardwareUsersGuides/UserIOBoard_v1.0/LCD for details
 * 
 * Output formats:
 * RGB: a binary file with exactly 128*128 1-byte pixel values (16KB); each pixel is stored as [RRRGGGBB]
 * C Header: a header file with  one variable (unsigned char imgArray[16384] defined)
 * 
 * This program has been tested on Mac OS X 10.5.4. It should work on any Unix-ish OS.
 * 
 * This code is not thoroughly tested, nor is it guaranteed error-free or even safe. Use it at your own risk.
 * 
 * This code is available under the Rice WARP license. See http://warp.rice.edu/license for details.
*/

#include <stdio.h>

#define BMP16_NUM_HEADER_BYTES 54

#define PIXCONV_RED_5b_TO_3b(c) ( (c>>12)&0x7 )
#define PIXCONV_GREEN_5b_TO_3b(c) ( (c>>7)&0x7 )
#define PIXCONV_BLUE_5b_TO_2b(c) ( (c>>3)&0x3 )

#define PIXCONV_16b_TO_8b(c) ( 0xFF & ( (PIXCONV_RED_5b_TO_3b(c)<<5) | (PIXCONV_GREEN_5b_TO_3b(c)<<2) | PIXCONV_BLUE_5b_TO_2b(c) ))

void print_usage(char* progName);

int main(int argc, char * argv[])
{
	int i, j, k, m, n;

	FILE *fp_in, *fp_outBin, *fp_outHeader;
	size_t bytesRead, bytesWritten;

	unsigned char outputHeader;
	
	unsigned char img_header[BMP16_NUM_HEADER_BYTES];
	
	unsigned short img_orig[128*128];
	unsigned char img_rgb8[128*128];

	//Check the command line arguments
	if(argc < 3 | argc > 4)
	{
		printf("Bad input arguments!\n");
		print_usage(argv[0]);
		return -1;
	}

	if(argc == 3)
	{
		//User specified an input file and output RGB file; don't print the C header file
		fp_in = fopen(argv[1], "r+b");
		fp_outBin = fopen(argv[2], "w+b");
		outputHeader = 0;
	}

	if(argc == 4)
	{
		//User specified an input file, output RGB file and output C header file
		fp_in = fopen(argv[1], "r+b");
		fp_outBin = fopen(argv[2], "w+b");
		fp_outHeader = fopen(argv[3], "w+");
		outputHeader = 1;
	}

	bytesRead = fread(&img_header, 1, BMP16_NUM_HEADER_BYTES, fp_in);
	if(bytesRead != BMP16_NUM_HEADER_BYTES)
	{
		printf("Error! - not enough bytes for the header\n");
		return -1;
	}

	bytesRead = fread(&img_orig, sizeof(short), 128*128, fp_in);
	if(bytesRead != (128*128))
	{
		printf("Error! - not enough bytes of image data (read %d)\n", bytesRead);
		return -1;
	}

	fclose(fp_in);

	//Now img_orig is a 128x128 array of 16-bit pixel values
	//We need an array of 16x16 64-pixel blocks, with each pixel occuping 1 byte
	//This is probably a really inefficient way to implement this re-ordering
	// but for 16K entries on a fast PC, who cares?
	m = 0;
	for(i=15; i>=0; i--)//Count down, since BMP files are stored last-line-first
	{
		for(j=0; j<16; j++)
		{
			for(k=7; k>=0; k--)//Count down, since BMP files are stored last-line-first
			{
				for(n=0; n<8; n++)
				{
					img_rgb8[m++] = (unsigned char)PIXCONV_16b_TO_8b(img_orig[i*1024 + j*8 + k*128 + n]);
				}
			}
		}
	}

	if(outputHeader)
	{
		fprintf(fp_outHeader, "/***START imgArray ***/\nunsigned char imgArray[16384] = {");

		for(i=0; i<16384; i++)
		{
			fprintf(fp_outHeader, "0x%x", img_rgb8[i]);
			if(i < 16383) fprintf(fp_outHeader, ",");
			if(i!=0 & i%128==0) fprintf(fp_outHeader, "\n");
		}
		fprintf(fp_outHeader, "};\n/***END imgArray ***/\n");

		fclose(fp_outHeader);
	}

	bytesWritten = fwrite(&img_rgb8, 1, 128*128, fp_outBin);
	fclose(fp_outBin);

	if(bytesWritten != (128*128))
	{
		printf("Error! - not enough bytes of image data written (wrote %d)\n", bytesWritten);
		return -1;
	}

	//Return successfully
	return 0;
}

void print_usage(char* progName)
{
	printf("Usage: %s inputBitmap.bmp outputBinary.rgb <outputHeader.h>\n", progName);
}
