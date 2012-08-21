#include "xparameters.h"
#include "xstatus.h"
#include <net/xilnet_config.h>
#include <net/xilsock.h>
#include <xemac_l.h>
#include <stdlib.h>
#include <string.h>
#include "xgpio_l.h"
#include "xgpio.h"
#include <string.h>
#include "math.h"
#include "radio_controller_basic.h"
#include "radio_controller_ext.h"
#include "radio_controller_adv.h"
#include "warplab_mimo_2x2.h"
#include "EEPROM.h"

#define BUFSIZE 2000

unsigned int sendPtr32[(BUFSIZE+3)/4];
unsigned char * const sendBuffer = (unsigned char *) sendPtr32;
unsigned int receivePtr32[(BUFSIZE+3)/4];
unsigned char * const receiveBuffer = (unsigned char *) receivePtr32;
unsigned int myPort;

int sock;	// UDP socket
struct sockaddr_in addr;
int alen = 0;
char node;

unsigned char Radio2_TxGain_BB, Radio2_TxGain_RF, Radio2_RxGain_BB, Radio2_RxGain_RF, Radio3_TxGain_BB, Radio3_TxGain_RF, Radio3_RxGain_BB, Radio3_RxGain_RF,Radio2_RF_Channel, Radio2_WirelessChan;

unsigned int radios = RADIO2_ADDR | RADIO3_ADDR;
unsigned int radio1 = RADIO1_ADDR;
unsigned int radio2 = RADIO2_ADDR;
unsigned int radio3 = RADIO3_ADDR;

#define DEBUG_LVL 1

// Command definitions
#define ACK 1
#define NOACK 2
#define INITIALIZE 100

//Individual radio commands start at 1000
//#define RADIO1_TXEN 1001
#define RADIO2_TXEN 1002
#define RADIO3_TXEN 1003
//#define RADIO1_TXDIS 1005
#define RADIO2_TXDIS 1006
#define RADIO3_TXDIS 1007

//#define RADIO1_RXEN 1009
#define RADIO2_RXEN 1010
#define RADIO3_RXEN 1011
//#define RADIO1_RXDIS 1011
#define RADIO2_RXDIS 1012
#define RADIO3_RXDIS 1013

//#define RADIO1_TXDATA 1101
#define RADIO2_TXDATA 1102
#define RADIO3_TXDATA 1103

//#define RADIO1_RXDATA 1105
#define RADIO2_RXDATA 1106
#define RADIO3_RXDATA 1107

//#define RADIO1_RSSIDATA 1109
#define RADIO2_RSSIDATA 1110
#define RADIO3_RSSIDATA 1111

//PHY Proto Engine commands start at 2000
#define TX_START 2000
#define RX_START 2001
#define RX_DONEREADING 2002
#define RX_DONECHECK 2003
#define TX_STOP 2004

//Misc
#define TX_TEST 6000
#define SET_OPTIONS 6010

#define CLOSE 99999


//----------------------------------
// Functions
void sendACK(unsigned int packetNo, unsigned int commandToACK);
unsigned char sevenSegmentMap(unsigned char x);
void CalibrateTxDCO();

void init_net() {
	int i;
	print("Starting Up!!\n\r");

	Xuint8 ip[16];
	Xuint8 myHwAddr[6];

	mb_hw_addr[0] = 0;
	mb_hw_addr[1] = 1;
	mb_hw_addr[2] = 2;
	mb_hw_addr[3] = 3;
	mb_hw_addr[4] = 4;
	mb_hw_addr[5] = node+1;

	mb_ip_addr[0] = 10;
	mb_ip_addr[1] = 0;
	mb_ip_addr[2] = 0;
	mb_ip_addr[3] = node+1;

	//Define the "magic" SYNC IP address
	magicSync_ip_addr[0] = 10;
	magicSync_ip_addr[1] = 0;
	magicSync_ip_addr[2] = 0;
	magicSync_ip_addr[3] = 244;

	myPort = 9000 + node;

	// Initialize Ethernet hardware table (eth.c)
	xilnet_eth_init_hw_addr_tbl();

	// Set the IP address  (ip.c)
	// xilnet_ip_init(ip);

	// Initialize the MAC OPB base address (MAC driver in net/mac.c)
	xilnet_mac_init(XPAR_ETHERNET_MAC_BASEADDR);
	// xemac_l.h
	if(DEBUG_LVL > 1) xil_printf("Reseting PHY\n\r");
	XEmac_mPhyReset(XPAR_ETHERNET_MAC_BASEADDR);
	// Set the MAC physical Ethernet address in the MAC driver (xemac_l.h)
	XEmac_mSetMacAddress(XPAR_ETHERNET_MAC_BASEADDR, mb_hw_addr);
	// Enable MAC (xemac_l.h)
	XEmac_mEnable(XPAR_ETHERNET_MAC_BASEADDR);
	// Print IP address
	if(DEBUG_LVL > 0) xil_printf("IP Address: %d.%d.%d.%d \n\r", mb_ip_addr[0], mb_ip_addr[1],mb_ip_addr[2],mb_ip_addr[3]);
}


void init_socket() {

	sock = xilsock_socket(AF_INET, SOCK_DGRAM, 0);	// Create UDP socket with domain Internet and UDP connection.
	if (sock == -1) {
		if(DEBUG_LVL > 0) xil_printf("Error in creating socket\r\n");
		exit(-1);
	}

	addr.sin_family = AF_INET;
	addr.sin_port = myPort;
	addr.sin_addr.s_addr = INADDR_ANY;			// Create the input socket with any incoming address. (0x00000000)

	XStatus bind = xilsock_bind(sock, (struct sockaddr *)&addr, sizeof(struct sockaddr));
	if (bind == -1) {
		if(DEBUG_LVL > 0) xil_printf("Unable to bind socket\r\n");
		exit(-1);
	}
	alen = sizeof(struct sockaddr);
	if(DEBUG_LVL > 0) xil_printf("Listening on UDP port %d.\r\n", myPort);
}

void shut_socket() {
	xilsock_close(sock);
}

int waitForSync()
{
	unsigned int i, n;

	for(i=0; i<10; i++)
	{
		n = xilnet_eth_recv_frame(receiveBuffer, BUFSIZE);
		//if(n==9999) xil_printf("Got magic sync packet at top level!\r\n");
		return 0;
	}
	return 1;
}

int main() {

	node = XGpio_mGetDataReg(XPAR_DIPSWS_4BIT_BASEADDR, 1);

	int bytesReceived;
	int bytesSend;
	int command;
	int packetNo;
	unsigned int rxArg0;
	char done = 0;
	unsigned int i,j,k, n;
	unsigned char sevenSeg0;
	unsigned char sevenSeg1 = 0x1;

	XGpio_mSetDataReg(XPAR_LED_7SEGMENT_BASEADDR, 1, sevenSegmentMap(node+1));

	init_net();

	init_socket();

	//Initialize the radio transceivers
	WarpRadio_v1_Reset((unsigned int*)XPAR_RADIO_CONTROLLER_0_BASEADDR);
	WarpRadio_v1_SetCenterFreq2GHz(11, radios);
	WarpRadio_v1_SoftwareTxGainControl(1, radios);
	WarpRadio_v1_SoftwareRxGainControl(1, radios);
	WarpRadio_v1_RxHpSoftControlEnable(radios);

	CalibrateTxDCO();
	while(done == 0) {

		//xil_printf("|");

		bytesReceived = xilsock_recvfrom(sock, receiveBuffer, BUFSIZE, (struct sockaddr *)&addr, &alen);	// Wait to receive data

		if (bytesReceived > 0) {	// Check for valid packet

			packetNo = receivePtr32[0];
			command = receivePtr32[1];
			rxArg0  = receivePtr32[2];

			sevenSeg1 = ( ((sevenSeg1<<1)&0x7E) | ((sevenSeg1>>5)&0x7E) );
			XGpio_mSetDataReg(XPAR_LED_7SEGMENT_1_BASEADDR, 1, sevenSeg1);
			//xil_printf("=============\r\nPacket Received\r\n  Length: %d\r\n  Packet No.: %d\r\n  Command No: %d\r\n", bytesReceived, packetNo, command);

			switch(command) {			// Decode on incoming command

				case INITIALIZE:
					//xil_printf("Initializing Node...");
					warplab_mimo_2x2_WriteReg_CaptOffset(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					warplab_mimo_2x2_WriteReg_DoneReading(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					warplab_mimo_2x2_WriteReg_StartCapture(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					warplab_mimo_2x2_WriteReg_TxLength(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, (unsigned int)16383);
					warplab_mimo_2x2_WriteReg_TransMode(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);

					sendACK(packetNo, command);
				break;

				case SET_OPTIONS:
					/* Options vector:
						rx[00] pktNum
						rx[01] command
						rx[02] captOffset
						rx[03] txLength
						rx[04] transMode
						rx[05] wirelessChannel
						rx[06] rx2Gain
						rx[07] tx2Gain
						rx[08] rx3Gain
						rx[09] tx3Gain
						rx[10] TxSelect
						rx[11] RxSelect
					*/

					if(DEBUG_LVL > 1) xil_printf("Setting options:\r\n");

					//Setup the PHY_Proto core
					warplab_mimo_2x2_WriteReg_CaptOffset(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, (unsigned int)receivePtr32[2]);
					warplab_mimo_2x2_WriteReg_TxLength(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, (unsigned int)receivePtr32[3]);
					warplab_mimo_2x2_WriteReg_TransMode(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, (unsigned int)receivePtr32[4]);
					warplab_mimo_2x2_WriteReg_TxSelect(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, (unsigned int)receivePtr32[10]);
					warplab_mimo_2x2_WriteReg_RxSelect(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, (unsigned int)receivePtr32[11]);


					//Extract the radio gain config options from the received Ethernet packet
					Radio2_TxGain_BB = (((unsigned int)receivePtr32[7])>>16)&0x3;
					Radio2_TxGain_RF = ((unsigned int)receivePtr32[7])&0x3F;
					Radio2_RxGain_RF = (((unsigned int)receivePtr32[6])>>16)&0x3;
					Radio2_RxGain_BB = ((unsigned int)receivePtr32[6])&0x1F;
					
					Radio3_TxGain_BB = (((unsigned int)receivePtr32[9])>>16)&0x3;
					Radio3_TxGain_RF = ((unsigned int)receivePtr32[9])&0x3F;
					Radio3_RxGain_RF = (((unsigned int)receivePtr32[8])>>16)&0x3;
					Radio3_RxGain_BB = ((unsigned int)receivePtr32[8])&0x1F;
					

					//Set Tx/Rx gains for radios #2 and #3
					WarpRadio_v1_BaseBandTxGain(Radio2_TxGain_BB, radio2);
					WarpRadio_v1_TxVGAGainControl(Radio2_TxGain_RF, radio2);
					WarpRadio_v1_RxLNAGainControl(Radio2_RxGain_RF, radio2);
					WarpRadio_v1_RxVGAGainControl(Radio2_RxGain_BB, radio2);
					
					WarpRadio_v1_BaseBandTxGain(Radio3_TxGain_BB, radio3);
					WarpRadio_v1_TxVGAGainControl(Radio3_TxGain_RF, radio3);
					WarpRadio_v1_RxLNAGainControl(Radio3_RxGain_RF, radio3);
					WarpRadio_v1_RxVGAGainControl(Radio3_RxGain_BB, radio3);

					//Set center frequency for radios #2 and #3
					Radio2_WirelessChan = ((unsigned int)receivePtr32[5]);
					WarpRadio_v1_SetCenterFreq2GHz(Radio2_WirelessChan, radios);

					sendACK(packetNo, command);

					if(DEBUG_LVL > 1) xil_printf("Capt Offset: %d, Tx Length: %d\r\n", (unsigned int)receivePtr32[2], (unsigned int)receivePtr32[3]);
					if(DEBUG_LVL > 1) xil_printf("RxGains: %x %x\r\n", Radio2_RxGain_RF, Radio2_RxGain_BB);
					if(DEBUG_LVL > 1) xil_printf("TxGains: %x %x\r\n", Radio2_TxGain_BB, Radio2_TxGain_RF);
					if(DEBUG_LVL > 1) xil_printf("Debug Mode: %d\r\n", (unsigned int)receivePtr32[6]);
				break;

				case RADIO2_TXEN:
					/***************** Setup the radio board ************/

					WarpRadio_v1_BaseBandTxGain(Radio2_TxGain_BB, radio2);
					WarpRadio_v1_TxVGAGainControl(Radio2_TxGain_RF, radio2);

					//Enable the transmitter
					WarpRadio_v1_TxEnable(radio2);
					/***************** END Setup the radio board ************/

					xil_printf("Radio 2 Tx Enabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO3_TXEN:
					/***************** Setup the radio board ************/

					WarpRadio_v1_BaseBandTxGain(Radio3_TxGain_BB, radio3);
					WarpRadio_v1_TxVGAGainControl(Radio3_TxGain_RF, radio3);

					//Enable the transmitter
					WarpRadio_v1_TxEnable(radio3);
					/***************** END Setup the radio board ************/

					xil_printf("Radio 3 Tx Enabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO2_TXDIS:
					WarpRadio_v1_TxRxDisable(radio2);
					//if(DEBUG_LVL > 1) xil_printf("Radio 2 Tx Disabled\r\n");
					//xil_printf("Radio 2 Tx Disabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO3_TXDIS:
					WarpRadio_v1_TxRxDisable(radio3);
					//if(DEBUG_LVL > 1) xil_printf("Radio 3 Tx Disabled\r\n");
					xil_printf("Radio 3 Tx Disabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO2_RXEN:
					/***************** Setup the radio board ************/
					//Disable the Rx HP filter
					WarpRadio_v1_RxHpDisable(radio2);
					usleep(10);

					//Enable the receiver
					WarpRadio_v1_RxEnable(radio2);

					/***************** END Setup the radio board ************/

					//if(DEBUG_LVL > 1) xil_printf("Radio 2 Rx Enabled\r\n");
					xil_printf("Radio 2 Rx Enabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO3_RXEN:
					/***************** Setup the radio board ************/
					//Disable the Rx HP filter
					WarpRadio_v1_RxHpDisable(radio3);
					usleep(10);

					//Enable the receiver
					WarpRadio_v1_RxEnable(radio3);

					/***************** END Setup the radio board ************/

					//if(DEBUG_LVL > 1) xil_printf("Radio 3 Rx Enabled\r\n");
					xil_printf("Radio 3 Rx Enabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO2_RXDIS:
					WarpRadio_v1_TxRxDisable(radio2);

					//Enable the Rx HP filter
					WarpRadio_v1_RxHpEnable(radio2);

					//if(DEBUG_LVL > 1) xil_printf("Radio 2 Rx Disabled\r\n");
					xil_printf("Radio 2 Rx Disabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO3_RXDIS:
					WarpRadio_v1_TxRxDisable(radio3);

					//Enable the Rx HP filter
					WarpRadio_v1_RxHpEnable(radio3);

					//if(DEBUG_LVL > 1) xil_printf("Radio 3 Rx Disabled\r\n");
					xil_printf("Radio 3 Rx Disabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO2_TXDATA:
					if(DEBUG_LVL > 1) xil_printf("Got some data for Radio 2 Tx (offset: %x)\r\n",rxArg0);
					if(DEBUG_LVL > 1) xil_printf("Sample bytes: %x %x %x %x\r\n", *(unsigned int *)(receivePtr32 + 3), *(unsigned int *)(receivePtr32 + 4), *(unsigned int *)(receivePtr32 + 5), *(unsigned int *)(receivePtr32 + 6));

					xil_printf("Got some data for Radio 2 Tx (offset: %x)\r\n",rxArg0);

					xil_printf("Got some data for Radio 2 Tx (offset: %x)\r\n",rxArg0);
					memcpy
					(
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMWO_TxBuff_Radio2_OFFSET + 4*rxArg0),\
						(unsigned int *)(receivePtr32 + 3),\
						(bytesReceived-12)
					);
					sendACK(packetNo, command);
				break;

				case RADIO3_TXDATA:
					if(DEBUG_LVL > 1) xil_printf("Got some data for Radio 3 Tx (offset: %x)\r\n",rxArg0);
					if(DEBUG_LVL > 1) xil_printf("Sample bytes: %x %x %x %x\r\n", *(unsigned int *)(receivePtr32 + 3), *(unsigned int *)(receivePtr32 + 4), *(unsigned int *)(receivePtr32 + 5), *(unsigned int *)(receivePtr32 + 6));

					xil_printf("Got some data for Radio 3 Tx (offset: %x)\r\n",rxArg0);

					xil_printf("Got some data for Radio 3 Tx (offset: %x)\r\n",rxArg0);
					memcpy
					(
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMWO_TxBuff_Radio3_OFFSET + 4*rxArg0),\
						(unsigned int *)(receivePtr32 + 3),\
						(bytesReceived-12)
					);
					sendACK(packetNo, command);
				break;

				case RADIO2_RXDATA:
					//while(warplab_mimo_2x2_ReadReg_CaptureDone(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR) == 0) {}

					memcpy
					(
						(unsigned int *)(sendPtr32 + 4), \
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RxBuff_Radio2_OFFSET + 4*rxArg0),\
						1024
					);

					//xil_printf("Read Rx data (offset: %x)\r\n",rxArg0);
					//xil_printf("Copied 1024 bytes from %x\r\n",(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RxBuff_Radio2_OFFSET + rxArg0));

					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;
					sendPtr32[3] = rxArg0;
					xilsock_sendto(sock, sendBuffer, 16+1024, (struct sockaddr *)&addr, alen);
				break;

				case RADIO3_RXDATA:
					//while(warplab_mimo_2x2_ReadReg_CaptureDone(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR) == 0) {}

					memcpy
					(
						(unsigned int *)(sendPtr32 + 4), \
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RxBuff_Radio3_OFFSET + 4*rxArg0),\
						1024
					);

					//xil_printf("Read Rx data (offset: %x)\r\n",rxArg0);
					//xil_printf("Copied 1024 bytes from %x\r\n",(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RxBuff_Radio3_OFFSET + rxArg0));

					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;
					sendPtr32[3] = rxArg0;
					xilsock_sendto(sock, sendBuffer, 16+1024, (struct sockaddr *)&addr, alen);
				break;

				case RX_DONECHECK:

					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;

					if(warplab_mimo_2x2_ReadReg_CaptureDone(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR) == 0)
						sendPtr32[3] = 0;
					else
						sendPtr32[3] = 1;

					xilsock_sendto(sock, sendBuffer, 16, (struct sockaddr *)&addr, alen);
				break;

				case RADIO2_RSSIDATA:
					//while(warplab_mimo_2x2_ReadReg_CaptureDone(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR) == 0) {}

					memcpy
					(
						(unsigned int *)(sendPtr32 + 4), \
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RSSIBuff_Radio2_OFFSET + 4*rxArg0),\
						1024
					);

					//xil_printf("Read RSSI data (offset: %x)\r\n",rxArg0);
					//xil_printf("Copied 1024 bytes from %x\r\n",(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RSSIBuff_Radio2_OFFSET + 4*rxArg0));

					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;
					sendPtr32[3] = rxArg0;
					xilsock_sendto(sock, sendBuffer, 16+1024, (struct sockaddr *)&addr, alen);
				break;

				case RADIO3_RSSIDATA:
					//while(warplab_mimo_2x2_ReadReg_CaptureDone(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR) == 0) {}

					memcpy
					(
						(unsigned int *)(sendPtr32 + 4), \
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RSSIBuff_Radio3_OFFSET + 4*rxArg0),\
						1024
					);

					//xil_printf("Read RSSI data (offset: %x)\r\n",rxArg0);
					//xil_printf("Copied 1024 bytes from %x\r\n",(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RSSIBuff_Radio3_OFFSET + 4*rxArg0));

					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;
					sendPtr32[3] = rxArg0;
					xilsock_sendto(sock, sendBuffer, 16+1024, (struct sockaddr *)&addr, alen);
				break;

				case RX_DONEREADING:
					warplab_mimo_2x2_WriteReg_DoneReading(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 1);
					warplab_mimo_2x2_WriteReg_DoneReading(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);

					sendACK(packetNo, command);
				break;

				case RX_START:
					//if(DEBUG_LVL > 1) xil_printf("Starting Rx\r\n");
					xil_printf("Starting Rx\r\n");
					sendACK(packetNo, command);

					if(waitForSync() == 0)
					{
						warplab_mimo_2x2_WriteReg_StartCapture(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 1);
						warplab_mimo_2x2_WriteReg_StartCapture(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
						//xil_printf("Capture started\r\n");
					}
					else
						xil_printf("No MAGIC_SYNC received; canceling Rx Capture\r\n");
				break;

				case TX_START:
					//if(DEBUG_LVL > 1) xil_printf("Starting Tx\r\n");
					xil_printf("Starting Tx\r\n");
					sendACK(packetNo, command);

					if(waitForSync() == 0)
					{
						warplab_mimo_2x2_WriteReg_StartTx(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 1);
						warplab_mimo_2x2_WriteReg_StartTx(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
						//xil_printf("Transmit started\r\n");
					}
					else
						xil_printf("No MAGIC_SYNC received; canceling Tx\r\n");
				break;
				
				case TX_STOP:
					sendACK(packetNo, command);
					
					warplab_mimo_2x2_WriteReg_StopTx(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 1);
					warplab_mimo_2x2_WriteReg_StopTx(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					
				break;

				case CLOSE:
					xil_printf("Closing sockets.\r\n");
					sendACK(packetNo, command);
					done = 1;

				break;


				case TX_TEST:
					xil_printf("Starting Tx Test\r\n");
					sendACK(packetNo, command);

				break;

				default:
					xil_printf("Received command (%d) is not recognized. Please retry transmission.\r\n", command);

					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = NOACK;
					bytesSend = 8;
					xilsock_sendto(sock, sendBuffer, bytesSend, (struct sockaddr *)&addr, alen);
			}
		}
	}

	shut_socket();

	return 0;
}

void sendACK(unsigned int packetNo, unsigned int commandToACK)
{
	sendPtr32[0] = packetNo + 1;
	sendPtr32[1] = ACK;
	sendPtr32[2] = commandToACK;
	xilsock_sendto(sock, sendBuffer, 12, (struct sockaddr *)&addr, alen);
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

void CalibrateTxDCO () {
        unsigned char i;
        unsigned int thisRadio;
        int eepromStatus = 0;
        short calReadback = 0;
        signed short best_I, best_Q;

        //Select which radios should be used
        // Include RADION_ADDR to enable a radio, 0 to disable it
        // This array must contain 4 elements corresponding to the 4 radios
        // Use a value of RADION_ADDR (for N=[1,2,3,4]) to enable a radio
        // Use 0 to disable a radio
        //  For example, these arrys are valid:
        //   {RADIO1_ADDR, RADIO2_ADDR, RADIO3_ADDR, RADIO4_ADDR} //Calibrate all four radios
        //   {RADIO1_ADDR, 0, 0, RADIO4_ADDR} //Calibrate radios #1 and #4
        //  But these are not:
        //   {RADIO2_ADDR, RADIO1_ADDR, 0, 0} //Out of order
        //   {RADIO1_ADDR} //Not enough elements

        unsigned int selectedRadios[4] = {0, RADIO2_ADDR, RADIO3_ADDR, 0};

        for(i=0; i<4; i++)
        {
                thisRadio = selectedRadios[i];

                //Only read values for enabled radios
                if(thisRadio > 0)
                {
                        //Select the EEPROM on the current radio board
                        eepromStatus = WarpEEPROM_EEPROMSelect((unsigned int*)XPAR_EEPROM_CONTROLLER_BASEADDR , i+1);

                        //Initialize the EEPROM controller
                        eepromStatus = WarpEEPROM_Initialize((unsigned int*)XPAR_EEPROM_CONTROLLER_BASEADDR );

                        //Read the Tx DCO values
                        calReadback = WarpEEPROM_ReadRadioCal((unsigned int*)XPAR_EEPROM_CONTROLLER_BASEADDR , 2, 0);

                        //Scale the stored values
                        best_I = (signed short)(((signed char)(calReadback & 0xFF))<<1);
                        best_Q = (signed short)(((signed char)((calReadback>>8) & 0xFF))<<1);

                        //Optional debug output; useful to check whether the values are valid
                        xil_printf("\r\nRadio #%d TxDCO - I: %d Q: %d\r\n", i, best_I, best_Q);

                        //Finally, write the Tx DCO values to the DAC
                        WarpRadio_v1_DACOffsetAdj(ICHAN, best_I, thisRadio);
                        WarpRadio_v1_DACOffsetAdj(QCHAN, best_Q, thisRadio);
                }
        }

        return;
}