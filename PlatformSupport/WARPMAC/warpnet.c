/* version 16.00 */
#include "warpnet.h"
#include "warpmac.h"
#include "warpphy.h"
#include "string.h"
#include "xparameters.h"

unsigned char arpTemplate[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x17, 0xf2, 0xc6, 0x5f, 0x30, 0x08, 0x06, 0x00, 0x01, 0x08, 0x00, 0x06, 0x04, 0x00, 0x01, 0x00, 0x17, 0xf2, 0xc6, 0x5f, 0x30, 0xC0, 0xA8, 0xFE, 0xFE, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xA8, 0xFE, 0xFE};
Netconfig configStruct;

void warpnet_setMacAddr(void* macAddr){
	memcpy((void *)&configStruct.macAddr, macAddr, 6);
}

void warpnet_sendGratuitousArp(char myID){
	unsigned int i;
	
	//copy this node's wired MAC address into the source field of the arpTemplate
	memcpy(&arpTemplate[6],&configStruct.macAddr,6);
	memcpy(&arpTemplate[22],&configStruct.macAddr,6);
	
	arpTemplate[28]=192;
	arpTemplate[29]=168;
	arpTemplate[30]=1;
	arpTemplate[31]=200+myID;
	
	arpTemplate[38]=arpTemplate[28];
	arpTemplate[39]=arpTemplate[29];
	arpTemplate[40]=arpTemplate[30];
	arpTemplate[41]=arpTemplate[31];
	
	//This is a hack to get DMA to play nice with the packet we have created.
	void* bufferAddr = (void *)warpphy_getBuffAddr(0);
	memcpy((void *)bufferAddr,(void *)&arpTemplate[0],sizeof(arpTemplate));
	
	for(i=0;i<ARPREPEAT;i++){
		warpmac_prepPktToNetwork(bufferAddr, sizeof(arpTemplate));
		warpmac_startPktToNetwork(sizeof(arpTemplate));
		usleep(10);
	}
}
