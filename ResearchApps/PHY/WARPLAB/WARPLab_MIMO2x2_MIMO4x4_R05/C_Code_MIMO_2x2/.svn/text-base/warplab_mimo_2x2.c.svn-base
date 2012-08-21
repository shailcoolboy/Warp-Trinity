#include "xstatus.h"
#include <net/xilnet_config.h>
#include <net/xilsock.h>
#include "xemaclite.h"
#include "xemaclite_l.h"
#include <stdlib.h>
#include <string.h>
#include "xgpio_l.h"
#include "xgpio.h"
#include <string.h>
#include "math.h"
#include "radio_controller_basic.h"
#include "radio_controller_ext.h"
#include "radio_controller_adv.h"
#include "warplab_regmacros.h"
#include "warplab_defines.h"
#include "warp_userio.h"
#include "EEPROM.h"
#include "xparameters.h"

#define BUFSIZE 2000

#define DEBUG_LVL 0

unsigned int sendPtr32[(BUFSIZE+3)/4];
unsigned char * const sendBuffer = (unsigned char *) sendPtr32;
unsigned int receivePtr32[(BUFSIZE+3)/4];
unsigned char * const receiveBuffer = (unsigned char *) receivePtr32;
unsigned int myPort;

int sock;	// UDP socket
struct sockaddr_in addr;
int alen = 0;
char node;

unsigned int ReadWrite;
unsigned char Radios_WirelessChan;
unsigned char Radios_Tx_LPF_Corn_Freq;
unsigned char Radios_Rx_LPF_Corn_Freq;
//unsigned char Radio1_TxGain_BB, Radio1_TxGain_RF, Radio1_RxGain_BB, Radio1_RxGain_RF;
unsigned char Radio2_TxGain_BB, Radio2_TxGain_RF, Radio2_RxGain_BB, Radio2_RxGain_RF;
unsigned char Radio3_TxGain_BB, Radio3_TxGain_RF, Radio3_RxGain_BB, Radio3_RxGain_RF;
//unsigned char Radio4_TxGain_BB, Radio4_TxGain_RF, Radio4_RxGain_BB, Radio4_RxGain_RF;

unsigned int radios = RADIO2_ADDR | RADIO3_ADDR;
//unsigned int radio1 = RADIO1_ADDR;
unsigned int radio2 = RADIO2_ADDR;
unsigned int radio3 = RADIO3_ADDR;
//unsigned int radio4 = RADIO4_ADDR;

unsigned int AgcIsDoneAddr;
unsigned int MGC_AGC_Sel_Variable = 0; // By default MGC is selected

//Instantiates the general-purpose input-output peripheral driver
static XGpio GPIO_UserIO;

//Instantiates Ethernet MAC lite
static XEmacLite EmacLiteInstance;   /* Instance of the EmacLite */
static XEmacLite_Config *EmacLiteConfigPtr;

//----------------------------------
// Functions
void sendACK(unsigned int packetNo, unsigned int commandToACK);
unsigned char sevenSegmentMap(unsigned char x);
//int CalibrateTxDCO(unsigned int radioSelection); Old Tx DCO calibration code
int warpphy_applyTxDCOCorrection(unsigned int radioSelection);
void warplab_mimo_4x4_AGC_Reset();
void warplab_mimo_4x4_AGC_MasterReset();
void warplab_mimo_4x4_AGC_Start();
void warplab_mimo_4x4_AGC_Initialize(int noise_estimate);
void warplab_mimo_4x4_AGC_setNoiseEstimate(int noise_estimate);
unsigned int warplab_mimo_4x4_AGC_GetGains(void);
void warplab_mimo_4x4_AGC_SetTarget(unsigned int target);
void warplab_mimo_4x4_AGC_SetDCO(unsigned int AGCstate);
// In WARPLab there is no decimation filter in the AGC, there is a downsampling only, so in WARPLab a function equivalent to
// ofdm_AGC_FiltSel is not needed

void init_net() {
	int i, Status;
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

	/*************************Ethernet***************************/
	if(DEBUG_LVL > 1) 	xil_printf("	Initializing Ethernet...");
	//Initialize the EMAC config struct
	EmacLiteConfigPtr = XEmacLite_LookupConfig(XPAR_EMACLITE_0_DEVICE_ID);
	if (EmacLiteConfigPtr == NULL){
		xil_printf("EMAClite LookupConfig failed!\r\n");
		return;
	}

	Status = XEmacLite_CfgInitialize(&EmacLiteInstance, EmacLiteConfigPtr, EmacLiteConfigPtr->BaseAddress);
	if (Status != XST_SUCCESS){
		xil_printf("EMAClite CfgInitialize failed!\r\n");
		return;
	}

	XEmacLite_SetMacAddress(&EmacLiteInstance, mb_hw_addr);

	XEmacLite_FlushReceive(&EmacLiteInstance);
	xil_printf("complete!\r\n");
	/************************************************************/

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
		if(n==9999)
		{
		//if(DEBUG_LVL > 1) if(n==9999) xil_printf("Got magic sync packet at top level!\r\n");
		//if(DEBUG_LVL > 1) xil_printf("Got magic sync packet at top level!\r\n");
		//xil_printf("GotS\r\n");
		return 0;
		}
	}
	xil_printf("NoSync\r\n");
	return 1;
}

int main() {

	int bytesReceived;
	int bytesSend;
	int command;
	int packetNo;
	unsigned int rxArg0;
	char done = 0;
	unsigned int i,j,k, n;
	unsigned char sevenSeg0;
	unsigned char sevenSeg1 = 0x1;
	int agctarget = -14;
  	int agcnoiseEst = -95;
	unsigned int agc_dco_state;
	unsigned int LEDHEX_Outputs = 0;

/*** START User I/O Setup ***/
	//Initialize the driver instance for the GPIO core attached to the FPGA board's user I/O (swithces, LEDs, etc)
	XGpio_Initialize(&GPIO_UserIO, XPAR_USER_IO_DEVICE_ID);

	//We use both channels in the GPIO core- one for inputs, one for outputs
	//A '1' in a bit position in the third argument marks the bit as an input
	XGpio_SetDataDirection(&GPIO_UserIO, USERIO_CHAN_INPUTS, USERIO_MASK_INPUTS);
	XGpio_SetDataDirection(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, 0);

	//Make sure the LEDs are all off by default
	XGpio_DiscreteClear(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, USERIO_MASK_OUTPUTS);
/*** END User I/O Setup ***/

	//Read the 4-bit DIP switch, and use its value as this node's ID
	node = USERIO_MAP_DIPSW(XGpio_DiscreteRead(&GPIO_UserIO, USERIO_CHAN_INPUTS) & USERIO_MASK_INPUTS);

	//Display the node's ID + 1 (to match the IP address) on the right hex display
	LEDHEX_Outputs = (
		USERIO_MAP_LEDS(0) |
		USERIO_MAP_DISPR(sevenSegmentMap(node+1)) |
		USERIO_MAP_DISPL(sevenSeg1)
	);
	XGpio_DiscreteSet(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, LEDHEX_Outputs);

	//Initialize the xilnet stack & default sockets
	init_net();
	init_socket();

	//Initialize the radio transceivers
	WarpRadio_v1_Reset((unsigned int*)XPAR_RADIO_CONTROLLER_0_BASEADDR, 2);
	WarpRadio_v1_SetCenterFreq2GHz(11, radios);
	WarpRadio_v1_SoftwareTxGainControl(1, radios);
	//By default, MGC (Manual Gain Control) is enabled. AGC is not enabled by default
	WarpRadio_v1_SoftwareRxGainControl(1, radios);
	WarpRadio_v1_RxHpSoftControlEnable(radios);
	//Set Rx bandwidth to nominal mode
	Radios_Tx_LPF_Corn_Freq = 1;
	WarpRadio_v1_RxLpfCornFreqCoarseAdj(Radios_Tx_LPF_Corn_Freq, radios); 
	//Set Tx bandwidth to nominal mode
	Radios_Rx_LPF_Corn_Freq = 1;
	WarpRadio_v1_TxLpfCornFreqCoarseAdj(Radios_Rx_LPF_Corn_Freq, radios);

	//Apply the stored TX DC offset correction values for each radio
	warpphy_applyTxDCOCalibration(RADIO2_ADDR);
	warpphy_applyTxDCOCalibration(RADIO3_ADDR);
//	CalibrateTxDCO(RADIO2_ADDR); Old Tx DCO calibration code
//	CalibrateTxDCO(RADIO3_ADDR); Old Tx DCO calibration code

	while(done == 0) {

		if(DEBUG_LVL > 2) xil_printf("|");

		bytesReceived = xilsock_recvfrom(sock, receiveBuffer, BUFSIZE, (struct sockaddr *)&addr, &alen);	// Wait to receive data

		if (bytesReceived > 0) {	// Check for valid packet

			packetNo = receivePtr32[0];
			command = receivePtr32[1];
			rxArg0  = receivePtr32[2];

			//Rotate the single active bit
			sevenSeg1 = ( ((sevenSeg1<<1)&0x7E) | ((sevenSeg1>>5)&0x7E) );

			//Update the hex displays to show the new values
			LEDHEX_Outputs = (
				USERIO_MAP_LEDS(0) |
				USERIO_MAP_DISPR(sevenSegmentMap(node+1)) |
				USERIO_MAP_DISPL(sevenSeg1)
			);
			XGpio_DiscreteSet(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, LEDHEX_Outputs);

			if(DEBUG_LVL > 2) xil_printf("=============\r\nPacket Received\r\n  Length: %d\r\n  Packet No.: %d\r\n  Command No: %d\r\n", bytesReceived, packetNo, command);

			switch(command) {			// Decode on incoming command

				case INITIALIZE:
					//if(DEBUG_LVL > 1) xil_printf("Initializing Node...");
					warplab_mimo_2x2_WriteReg_TxDelay(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					warplab_mimo_2x2_WriteReg_StartCapture(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					warplab_mimo_2x2_WriteReg_TxLength(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, (unsigned int)16383);
					warplab_mimo_2x2_WriteReg_TransMode(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					warplab_mimo_2x2_WriteReg_RADIO2TXBUFF_TXEN(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					warplab_mimo_2x2_WriteReg_RADIO3TXBUFF_TXEN(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					warplab_mimo_2x2_WriteReg_RADIO2RXBUFF_RXEN(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					warplab_mimo_2x2_WriteReg_RADIO3RXBUFF_RXEN(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					warplab_mimo_2x2_WriteReg_DebugRx2Buffers(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					warplab_mimo_2x2_WriteReg_DebugRx3Buffers(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
					warplab_mimo_4x4_AGC_WriteReg_RADIO1_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR,0);	// No radio on slot 1
					warplab_mimo_4x4_AGC_WriteReg_RADIO2_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR,0);
					warplab_mimo_4x4_AGC_WriteReg_RADIO3_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR,0);
					warplab_mimo_4x4_AGC_WriteReg_RADIO4_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR,0);	// No radio on slot 2
					warplab_mimo_4x4_AGC_WriteReg_AGC_TRIGGER_DELAY(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR,(unsigned int)50);
					warplab_mimo_2x2_WriteReg_MGC_AGC_SEL(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);// Select MGC by default
					warplab_mimo_4x4_AGC_WriteReg_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0);
					MGC_AGC_Sel_Variable = 0;

					sendACK(packetNo, command);
				break;

				case TX_DELAY:
					ReadWrite = (unsigned int)receivePtr32[2];
					if(0 == ReadWrite)
					{
						sendPtr32[0] = packetNo + 1;
						sendPtr32[1] = ACK;
						sendPtr32[2] = command;

						sendPtr32[3] = warplab_mimo_2x2_ReadReg_TxDelay(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR);

						if(DEBUG_LVL > 2) xil_printf("Read capt offset of %d\r\n", (unsigned int)receivePtr32[3]);
						xilsock_sendto(sock, sendBuffer, 16, (struct sockaddr *)&addr, alen);
					}
					if(1 == ReadWrite)
					{
						//If the user requests a TX_DELAY that's too big, write the maximum instead
						warplab_mimo_2x2_WriteReg_TxDelay(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, (unsigned int)receivePtr32[3] > 16383 ? 16383 : (unsigned int)receivePtr32[3]);
						if(DEBUG_LVL > 2) xil_printf("Set capt offset to %d\r\n", (unsigned int)receivePtr32[3]);
						sendACK(packetNo, command);
					}
				break;

				case TX_LENGTH:
					ReadWrite = (unsigned int)receivePtr32[2];
					if(0 == ReadWrite)
					{
						sendPtr32[0] = packetNo + 1;
						sendPtr32[1] = ACK;
						sendPtr32[2] = command;

						sendPtr32[3] = warplab_mimo_2x2_ReadReg_TxLength(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR);

						if(DEBUG_LVL > 2) xil_printf("Read TxLength of %d\r\n", (unsigned int)receivePtr32[3]);
						xilsock_sendto(sock, sendBuffer, 16, (struct sockaddr *)&addr, alen);
					}
					if(1 == ReadWrite)
					{
						//If the user requests a TX_LENGTH that's too big, write the maximum instead
						warplab_mimo_2x2_WriteReg_TxLength(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, (unsigned int)receivePtr32[3] > 16383 ? 16383 : (unsigned int)receivePtr32[3]);
						if(DEBUG_LVL > 2) xil_printf("Set TxLength to %d\r\n", (unsigned int)receivePtr32[3]);
						sendACK(packetNo, command);
					}
				break;

				case TX_MODE:
					ReadWrite = (unsigned int)receivePtr32[2];
					if(0 == ReadWrite)
					{
						sendPtr32[0] = packetNo + 1;
						sendPtr32[1] = ACK;
						sendPtr32[2] = command;

						sendPtr32[3] = warplab_mimo_2x2_ReadReg_TransMode(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR);

						xilsock_sendto(sock, sendBuffer, 16, (struct sockaddr *)&addr, alen);
					}
					if(1 == ReadWrite)
					{
						warplab_mimo_2x2_WriteReg_TransMode(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, (unsigned int)receivePtr32[3]);
						sendACK(packetNo, command);
					}
				break;

				case RX2BUFFERS_DEBUG:
				   ReadWrite = (unsigned int)receivePtr32[2];
					if(0 == ReadWrite)
					{
						sendPtr32[0] = packetNo + 1;
						sendPtr32[1] = ACK;
						sendPtr32[2] = command;

						sendPtr32[3] = warplab_mimo_2x2_ReadReg_DebugRx2Buffers(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR);

						xilsock_sendto(sock, sendBuffer, 16, (struct sockaddr *)&addr, alen);
					}
					if(1 == ReadWrite)
					{
						warplab_mimo_2x2_WriteReg_DebugRx2Buffers(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, (unsigned int)receivePtr32[3]);
						sendACK(packetNo, command);
					}
				break;

				case RX3BUFFERS_DEBUG:
					ReadWrite = (unsigned int)receivePtr32[2];
					if(0 == ReadWrite)
					{
						sendPtr32[0] = packetNo + 1;
						sendPtr32[1] = ACK;
						sendPtr32[2] = command;

						sendPtr32[3] = warplab_mimo_2x2_ReadReg_DebugRx3Buffers(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR);

						xilsock_sendto(sock, sendBuffer, 16, (struct sockaddr *)&addr, alen);
					}
					if(1 == ReadWrite)
					{
						warplab_mimo_2x2_WriteReg_DebugRx3Buffers(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, (unsigned int)receivePtr32[3]);
						sendACK(packetNo, command);
					}
				break;

				case MGC_AGC_SEL:
					//ReadWrite = (unsigned int)receivePtr32[2];
					MGC_AGC_Sel_Variable = (unsigned int)receivePtr32[2];
					//if(0 == ReadWrite)
					//{
					//	sendPtr32[0] = packetNo + 1;
					//	sendPtr32[1] = ACK;
					//	sendPtr32[2] = command;

					//	sendPtr32[3] = warplab_mimo_4x4_ReadReg_MGC_AGC_SEL(XPAR_WARPLAB_MIMO_4X4_OPBW_0_BASEADDR);

					//	xilsock_sendto(sock, sendBuffer, 16, (struct sockaddr *)&addr, alen);
					//}
					//if(1 == ReadWrite)
					//{
						warplab_mimo_2x2_WriteReg_MGC_AGC_SEL(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, MGC_AGC_Sel_Variable);

						if(0 == MGC_AGC_Sel_Variable)
						{
							warplab_mimo_4x4_AGC_WriteReg_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0);
							//Set Radios for Manual Gain Control (MGC)
							WarpRadio_v1_SoftwareRxGainControl(1, radios);
							WarpRadio_v1_RxHpSoftControlEnable(radios);
						}
						if(1 == MGC_AGC_Sel_Variable)
						{
							//Set Radios for Automatic Gain Control (AGC)
							WarpRadio_v1_SoftwareRxGainControl(0, radios); // RxGains will be controlled by the AGC (AGC Change)
							WarpRadio_v1_RxHpSoftControlDisable(radios); // RxHp will be controlled by the AGC (AGC Change)
							WarpRadio_v1_RxHighPassCornerFreq(0, radios); // Will set the corner frequency when RxHp is 0? (AGC Change)
							//xil_printf("agctargetINIT = %d\r\n",agctarget);
							//Set Rx bandwidth; 19MHz
							WarpRadio_v1_RxLpfCornFreqCoarseAdj(1, radios); // (AGC Change)

							// Initialize the AGC
							warplab_mimo_4x4_AGC_Initialize(agcnoiseEst);
							warplab_mimo_4x4_AGC_setNoiseEstimate(agcnoiseEst);
							// ofdm_AGC_FiltSel(0); No decimation option in WARPLab AGC
							warplab_mimo_4x4_AGC_SetDCO(0);
							warplab_mimo_4x4_AGC_SetTarget(agctarget);
							warplab_mimo_4x4_AGC_Reset();
						}

						sendACK(packetNo, command);
					//}
				break;

				case CARRIER_CHANNEL:
					Radios_WirelessChan = ((unsigned int)receivePtr32[2]);
					WarpRadio_v1_SetCenterFreq2GHz(Radios_WirelessChan, radios);
					sendACK(packetNo, command);
				break;
				
				case TX_LPF_CORN_FREQ:
					Radios_Tx_LPF_Corn_Freq = ((unsigned int)receivePtr32[2]);
					//xil_printf("Radios_Tx_LPF_Corn_Freq = %d\r\n",Radios_Tx_LPF_Corn_Freq);
					WarpRadio_v1_TxLpfCornFreqCoarseAdj(Radios_Tx_LPF_Corn_Freq, radios);
					sendACK(packetNo, command);
				break;
				
				case RX_LPF_CORN_FREQ:
					Radios_Rx_LPF_Corn_Freq = ((unsigned int)receivePtr32[2]);
					//xil_printf("Radios_Rx_LPF_Corn_Freq = %d\r\n",Radios_Rx_LPF_Corn_Freq);
					WarpRadio_v1_RxLpfCornFreqCoarseAdj(Radios_Rx_LPF_Corn_Freq, radios);
					sendACK(packetNo, command);
				break;

				case RADIO2_TXGAINS:
					//Extract the radio gain config options from the received Ethernet packet
					Radio2_TxGain_BB = (((unsigned int)receivePtr32[2])>>16)&0x3;
					Radio2_TxGain_RF = ((unsigned int)receivePtr32[2])&0x3F;
					WarpRadio_v1_BaseBandTxGain(Radio2_TxGain_BB, radio2);
					WarpRadio_v1_TxVGAGainControl(Radio2_TxGain_RF, radio2);
					sendACK(packetNo, command);
				break;

				case RADIO2_RXGAINS:
					//Extract the radio gain config options from the received Ethernet packet
					Radio2_RxGain_RF = (((unsigned int)receivePtr32[2])>>16)&0x3;
					Radio2_RxGain_BB = ((unsigned int)receivePtr32[2])&0x3F;
					WarpRadio_v1_RxLNAGainControl(Radio2_RxGain_RF, radio2);
					WarpRadio_v1_RxVGAGainControl(Radio2_RxGain_BB, radio2);
					sendACK(packetNo, command);
				break;

				case RADIO3_TXGAINS:
					//Extract the radio gain config options from the received Ethernet packet
					Radio3_TxGain_BB = (((unsigned int)receivePtr32[2])>>16)&0x3;
					Radio3_TxGain_RF = ((unsigned int)receivePtr32[2])&0x3F;
					WarpRadio_v1_BaseBandTxGain(Radio3_TxGain_BB, radio3);
					WarpRadio_v1_TxVGAGainControl(Radio3_TxGain_RF, radio3);
					sendACK(packetNo, command);
				break;

				case RADIO3_RXGAINS:
					//Extract the radio gain config options from the received Ethernet packet
					Radio3_RxGain_RF = (((unsigned int)receivePtr32[2])>>16)&0x3;
					Radio3_RxGain_BB = ((unsigned int)receivePtr32[2])&0x3F;
					WarpRadio_v1_RxLNAGainControl(Radio3_RxGain_RF, radio3);
					WarpRadio_v1_RxVGAGainControl(Radio3_RxGain_BB, radio3);
					sendACK(packetNo, command);
				break;

				case RADIO2_TXEN:
					/***************** Setup the radio board ************/

					WarpRadio_v1_BaseBandTxGain(Radio2_TxGain_BB, radio2);
					WarpRadio_v1_TxVGAGainControl(Radio2_TxGain_RF, radio2);
					
					//Enable the transmitter
					WarpRadio_v1_TxEnable(radio2);
					/***************** END Setup the radio board ************/

					if(DEBUG_LVL > 1) xil_printf("Radio 2 Tx Enabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO3_TXEN:
					/***************** Setup the radio board ************/

					WarpRadio_v1_BaseBandTxGain(Radio3_TxGain_BB, radio3);
					WarpRadio_v1_TxVGAGainControl(Radio3_TxGain_RF, radio3);
					
					//Enable the transmitter
					WarpRadio_v1_TxEnable(radio3);
					/***************** END Setup the radio board ************/

					if(DEBUG_LVL > 1) xil_printf("Radio 3 Tx Enabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO2_TXDIS:
					WarpRadio_v1_TxRxDisable(radio2);
					//if(DEBUG_LVL > 1) xil_printf("Radio 2 Tx Disabled\r\n");
					if(DEBUG_LVL > 1) xil_printf("Radio 2 Tx Disabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO3_TXDIS:
					WarpRadio_v1_TxRxDisable(radio3);
					//if(DEBUG_LVL > 1) xil_printf("Radio 3 Tx Disabled\r\n");
					if(DEBUG_LVL > 1) xil_printf("Radio 3 Tx Disabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO2_RXEN:
					
					/***************** Setup the radio board ************/
					if(0 == MGC_AGC_Sel_Variable)
					{
						// Disable the Rx HP filter
						// Only needed in Manual Gain Control (MGC) Mode
						// In Automatic Gain Control (AGC) Mode, the RxHp
						// is controlled by the AGC core
						WarpRadio_v1_RxHpDisable(radio2);
					}

					usleep(10);

					//Enable the receiver
					WarpRadio_v1_RxEnable(radio2);

					if(1 == MGC_AGC_Sel_Variable)
					{
						//Enable this radio's AGC if user has set AGC Mode
						warplab_mimo_4x4_AGC_WriteReg_RADIO2_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR,1);
					}

					/***************** END Setup the radio board ************/

					//if(DEBUG_LVL > 1) xil_printf("Radio 2 Rx Enabled\r\n");
					if(DEBUG_LVL > 1) xil_printf("Radio 2 Rx Enabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO3_RXEN:
					
					/***************** Setup the radio board ************/
					if(0 == MGC_AGC_Sel_Variable)
					{
						// Disable the Rx HP filter
						// Only needed in Manual Gain Control (MGC) Mode
						// In Automatic Gain Control (AGC) Mode, the RxHp
						// is controlled by the AGC core
						WarpRadio_v1_RxHpDisable(radio3);
					}

					usleep(10);

					//Enable the receiver
					WarpRadio_v1_RxEnable(radio3);

					if(1 == MGC_AGC_Sel_Variable)
					{
						//Enable this radio's AGC if user has set AGC Mode
						warplab_mimo_4x4_AGC_WriteReg_RADIO3_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR,1);
					}

					/***************** END Setup the radio board ************/

					//if(DEBUG_LVL > 1) xil_printf("Radio 3 Rx Enabled\r\n");
					if(DEBUG_LVL > 1) xil_printf("Radio 3 Rx Enabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO2_RXDIS:
					WarpRadio_v1_TxRxDisable(radio2);

					if(0 == MGC_AGC_Sel_Variable)
					{
						//Enable the Rx HP filter
						// Only needed in Manual Gain Control (MGC) Mode
						// In Automatic Gain Control (AGC) Mode, the RxHp
						// is controlled by the AGC core
						WarpRadio_v1_RxHpEnable(radio2);
					}

					if(1 == MGC_AGC_Sel_Variable)
					{
						//Disable this radio's AGC if user has set AGC Mode
						warplab_mimo_4x4_AGC_WriteReg_RADIO2_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR,0);
					}

					//if(DEBUG_LVL > 1) xil_printf("Radio 2 Rx Disabled\r\n");
					if(DEBUG_LVL > 1) xil_printf("Radio 2 Rx Disabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO3_RXDIS:
					WarpRadio_v1_TxRxDisable(radio3);

					if(0 == MGC_AGC_Sel_Variable)
					{
						//Enable the Rx HP filter
						// Only needed in Manual Gain Control (MGC) Mode
						// In Automatic Gain Control (AGC) Mode, the RxHp
						// is controlled by the AGC core
						WarpRadio_v1_RxHpEnable(radio3);
					}

					if(1 == MGC_AGC_Sel_Variable)
					{
						//Disable this radio's AGC if user has set AGC Mode
						warplab_mimo_4x4_AGC_WriteReg_RADIO3_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR,0);
					}

					//if(DEBUG_LVL > 1) xil_printf("Radio 3 Rx Disabled\r\n");
					if(DEBUG_LVL > 1) xil_printf("Radio 3 Rx Disabled\r\n");
					sendACK(packetNo, command);
				break;

				case RADIO2_TXDATA:
					//if(DEBUG_LVL > 1) xil_printf("Got some data for Radio 2 Tx (offset: %x)\r\n",rxArg0);
					//if(DEBUG_LVL > 1) xil_printf("Sample bytes: %x %x %x %x\r\n", *(unsigned int *)(receivePtr32 + 3), *(unsigned int *)(receivePtr32 + 4), *(unsigned int *)(receivePtr32 + 5), *(unsigned int *)(receivePtr32 + 6));

					//if(DEBUG_LVL > 1) xil_printf("Got some data for Radio 2 Tx (offset: %x)\r\n",rxArg0);

					//if(DEBUG_LVL > 1) xil_printf("Got some data for Radio 2 Tx (offset: %x)\r\n",rxArg0);
					/*
					memcpy
					(
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMWO_TxBuff_Radio2_OFFSET + 4*rxArg0),\
						(unsigned int *)(receivePtr32 + 3),\
						(bytesReceived-12)
					);
					*/
					memcpy
					(
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_PLBW_0_MEMMAP_TXBUFF_RADIO2 + 4*rxArg0),\
						(unsigned int *)(receivePtr32 + 3),\
						(bytesReceived-12)
					);
					sendACK(packetNo, command);
				break;

				case RADIO3_TXDATA:
					//if(DEBUG_LVL > 1) xil_printf("Got some data for Radio 3 Tx (offset: %x)\r\n",rxArg0);
					//if(DEBUG_LVL > 1) xil_printf("Sample bytes: %x %x %x %x\r\n", *(unsigned int *)(receivePtr32 + 3), *(unsigned int *)(receivePtr32 + 4), *(unsigned int *)(receivePtr32 + 5), *(unsigned int *)(receivePtr32 + 6));

					//if(DEBUG_LVL > 1) xil_printf("Got some data for Radio 3 Tx (offset: %x)\r\n",rxArg0);

					//if(DEBUG_LVL > 1) xil_printf("Got some data for Radio 3 Tx (offset: %x)\r\n",rxArg0);
					/*
					memcpy
					(
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMWO_TxBuff_Radio3_OFFSET + 4*rxArg0),\
						(unsigned int *)(receivePtr32 + 3),\
						(bytesReceived-12)
					);
					*/
					memcpy
					(
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_PLBW_0_MEMMAP_TXBUFF_RADIO3 + 4*rxArg0),\
						(unsigned int *)(receivePtr32 + 3),\
						(bytesReceived-12)
					);
					sendACK(packetNo, command);
				break;

				case RADIO2_RXDATA:
					//while(warplab_mimo_2x2_ReadReg_CaptureDone(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR) == 0) {}

					/*
					memcpy
					(
						(unsigned int *)(sendPtr32 + 4), \
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RxBuff_Radio2_OFFSET + 4*rxArg0),\
						1024
					);
					*/
					memcpy
					(
						(unsigned int *)(sendPtr32 + 4), \
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_PLBW_0_MEMMAP_RXBUFF_RADIO2 + 4*rxArg0),\
						1024
					);

					//if(DEBUG_LVL > 1) xil_printf("Read Rx data (offset: %x)\r\n",rxArg0);
					//if(DEBUG_LVL > 1) xil_printf("Copied 1024 bytes from %x\r\n",(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RxBuff_Radio2_OFFSET + rxArg0));

					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;
					sendPtr32[3] = rxArg0;
					xilsock_sendto(sock, sendBuffer, 16+1024, (struct sockaddr *)&addr, alen);
				break;

				case RADIO3_RXDATA:
					//while(warplab_mimo_2x2_ReadReg_CaptureDone(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR) == 0) {}

					/*
					memcpy
					(
						(unsigned int *)(sendPtr32 + 4), \
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RxBuff_Radio3_OFFSET + 4*rxArg0),\
						1024
					);
					*/
					memcpy
					(
						(unsigned int *)(sendPtr32 + 4), \
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_PLBW_0_MEMMAP_RXBUFF_RADIO3 + 4*rxArg0),\
						1024
					);


					//if(DEBUG_LVL > 1) xil_printf("Read Rx data (offset: %x)\r\n",rxArg0);
					//if(DEBUG_LVL > 1) xil_printf("Copied 1024 bytes from %x\r\n",(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RxBuff_Radio3_OFFSET + rxArg0));

					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;
					sendPtr32[3] = rxArg0;
					xilsock_sendto(sock, sendBuffer, 16+1024, (struct sockaddr *)&addr, alen);
				break;

				case RADIO2_RSSIDATA:
					//while(warplab_mimo_2x2_ReadReg_CaptureDone(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR) == 0) {}

					/*
					memcpy
					(
						(unsigned int *)(sendPtr32 + 4), \
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RSSIBuff_Radio2_OFFSET + 4*rxArg0),\
						1024
					);
					*/
					memcpy
					(
						(unsigned int *)(sendPtr32 + 4), \
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_PLBW_0_MEMMAP_RSSIBUFF_RADIO2 + 4*rxArg0),\
						1024
					);


					//if(DEBUG_LVL > 1) xil_printf("Read RSSI data (offset: %x)\r\n",rxArg0);
					//if(DEBUG_LVL > 1) xil_printf("Copied 1024 bytes from %x\r\n",(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RSSIBuff_Radio2_OFFSET + 4*rxArg0));

					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;
					sendPtr32[3] = rxArg0;
					xilsock_sendto(sock, sendBuffer, 16+1024, (struct sockaddr *)&addr, alen);
				break;

				case RADIO3_RSSIDATA:
					//while(warplab_mimo_2x2_ReadReg_CaptureDone(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR) == 0) {}

					/*
					memcpy
					(
						(unsigned int *)(sendPtr32 + 4), \
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RSSIBuff_Radio3_OFFSET + 4*rxArg0),\
						1024
					);
					*/
					memcpy
					(
						(unsigned int *)(sendPtr32 + 4), \
						(unsigned int *)(XPAR_WARPLAB_MIMO_2X2_PLBW_0_MEMMAP_RSSIBUFF_RADIO3 + 4*rxArg0),\
						1024
					);


					//if(DEBUG_LVL > 1) xil_printf("Read RSSI data (offset: %x)\r\n",rxArg0);
					//if(DEBUG_LVL > 1) xil_printf("Copied 1024 bytes from %x\r\n",(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR + warplab_mimo_2x2_SMRO_RSSIBuff_Radio3_OFFSET + 4*rxArg0));

					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;
					sendPtr32[3] = rxArg0;
					xilsock_sendto(sock, sendBuffer, 16+1024, (struct sockaddr *)&addr, alen);
				break;

				case RADIO2TXBUFF_TXEN:
					warplab_mimo_2x2_WriteReg_RADIO2TXBUFF_TXEN(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 1);

					sendACK(packetNo, command);
				break;

				case RADIO3TXBUFF_TXEN:
					warplab_mimo_2x2_WriteReg_RADIO3TXBUFF_TXEN(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 1);

					sendACK(packetNo, command);
				break;

				case RADIO2TXBUFF_TXDIS:
					warplab_mimo_2x2_WriteReg_RADIO2TXBUFF_TXEN(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);

					sendACK(packetNo, command);
				break;

				case RADIO3TXBUFF_TXDIS:
					warplab_mimo_2x2_WriteReg_RADIO3TXBUFF_TXEN(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);

					sendACK(packetNo, command);
				break;

				case RADIO2RXBUFF_RXEN:
					warplab_mimo_2x2_WriteReg_RADIO2RXBUFF_RXEN(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 1);

					sendACK(packetNo, command);
				break;

				case RADIO3RXBUFF_RXEN:
					warplab_mimo_2x2_WriteReg_RADIO3RXBUFF_RXEN(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 1);

					sendACK(packetNo, command);
				break;

				case RADIO2RXBUFF_RXDIS:
					warplab_mimo_2x2_WriteReg_RADIO2RXBUFF_RXEN(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);

					sendACK(packetNo, command);
				break;

				case RADIO3RXBUFF_RXDIS:
					warplab_mimo_2x2_WriteReg_RADIO3RXBUFF_RXEN(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);

					sendACK(packetNo, command);
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

				case RX_DONEREADING:
					//warplab_mimo_2x2_WriteReg_DoneReading(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 1);
					//warplab_mimo_2x2_WriteReg_DoneReading(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);

					sendACK(packetNo, command);
				break;

				case RX_START:
					//if(DEBUG_LVL > 1) xil_printf("Starting Rx\r\n");
					//if(DEBUG_LVL > 1) xil_printf("Starting Rx\r\n");
					sendACK(packetNo, command);

					if(waitForSync() == 0)
					{
						warplab_mimo_2x2_WriteReg_StartCapture(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 1);
						warplab_mimo_4x4_AGC_Start();
						warplab_mimo_2x2_WriteReg_StartCapture(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);

						//if(DEBUG_LVL > 1) xil_printf("Capture started\r\n");
					}
					else
						if(DEBUG_LVL > 1) xil_printf("No MAGIC_SYNC received; canceling Rx Capture\r\n");
				break;

				case TX_START:
					//if(DEBUG_LVL > 1) xil_printf("Starting Tx\r\n");
					if(DEBUG_LVL > 1) xil_printf("Starting Tx\r\n");
					sendACK(packetNo, command);

					if(waitForSync() == 0)
					{
						warplab_mimo_2x2_WriteReg_StartTx(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 1);
						warplab_mimo_2x2_WriteReg_StartTx(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);
						//if(DEBUG_LVL > 1) xil_printf("Transmit started\r\n");
					}
					else
						if(DEBUG_LVL > 1) xil_printf("No MAGIC_SYNC received; canceling Tx\r\n");
				break;

				case TX_STOP:
					sendACK(packetNo, command);

					warplab_mimo_2x2_WriteReg_StopTx(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 1);
					warplab_mimo_2x2_WriteReg_StopTx(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, 0);

				break;

				case READ_AGC_DONE_ADDR:
					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;

					sendPtr32[3] = warplab_mimo_2x2_ReadReg_AGCDoneAddr(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR);

					xilsock_sendto(sock, sendBuffer, 16, (struct sockaddr *)&addr, alen);
				break;

				case READ_RADIO2AGCDONERSSI:
					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;

					sendPtr32[3] = warplab_mimo_2x2_ReadReg_Radio2AGCDoneRSSI(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR);

					xilsock_sendto(sock, sendBuffer, 16, (struct sockaddr *)&addr, alen);
				break;

				case READ_RADIO3AGCDONERSSI:
					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;

					sendPtr32[3] = warplab_mimo_2x2_ReadReg_Radio3AGCDoneRSSI(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR);

					xilsock_sendto(sock, sendBuffer, 16, (struct sockaddr *)&addr, alen);
				break;

				case AGC_RESET:
					warplab_mimo_4x4_AGC_Reset();
					sendACK(packetNo, command);
				break;

				case READ_AGC_GAINS:
					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;

					sendPtr32[3] = warplab_mimo_4x4_AGC_GetGains();

					xilsock_sendto(sock, sendBuffer, 16, (struct sockaddr *)&addr, alen);
				break;

				case SET_AGC_TARGET_dBm:
					agctarget = (int)receivePtr32[2];
					warplab_mimo_4x4_AGC_SetTarget(agctarget);
					xil_printf("agctarget = %d\r\n",agctarget);
					sendACK(packetNo, command);
				break;

				case SET_AGC_DCO_EN_DIS:
					agc_dco_state = (unsigned int)receivePtr32[2];
					warplab_mimo_4x4_AGC_SetDCO(agc_dco_state);
					warplab_mimo_2x2_WriteReg_DCO_EN_SEL(XPAR_WARPLAB_MIMO_2X2_OPBW_0_BASEADDR, agc_dco_state);
					xil_printf("agc_dco_state = %d\r\n",agc_dco_state);
					sendACK(packetNo, command);
				break;

				case SET_AGC_NOISEEST_dBm:
					agcnoiseEst = (int)receivePtr32[2];
					warplab_mimo_4x4_AGC_setNoiseEstimate(agcnoiseEst);
					xil_printf("agctarget = %d\r\n",agctarget);
					sendACK(packetNo, command);
				break;

				case SET_AGC_THRESHOLDS:
					warplab_mimo_4x4_AGC_WriteReg_Thresholds(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, (unsigned int)receivePtr32[2]);
					sendACK(packetNo, command);
				break;

				case SET_AGC_TRIG_DELAY:
					warplab_mimo_4x4_AGC_WriteReg_AGC_TRIGGER_DELAY(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, (unsigned int)receivePtr32[2]);
					sendACK(packetNo, command);
				break;

				case READ_AGC_THRESHOLDS:
					sendPtr32[0] = packetNo + 1;
					sendPtr32[1] = ACK;
					sendPtr32[2] = command;

					sendPtr32[3] = warplab_mimo_4x4_AGC_ReadReg_Thresholds(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR);

					xilsock_sendto(sock, sendBuffer, 16, (struct sockaddr *)&addr, alen);
				break;

				case CLOSE:
					if(DEBUG_LVL > 1) xil_printf("Closing sockets.\r\n");
					sendACK(packetNo, command);
					done = 1;

				break;

				case TX_TEST:
					if(DEBUG_LVL > 1) xil_printf("Starting Tx Test\r\n");
					sendACK(packetNo, command);

				break;

				default:
					if(DEBUG_LVL > 1) xil_printf("Received command (%d) is not recognized. Please retry transmission.\r\n", command);

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

// Commented out old TxDCP Calibration code see new code below
//int CalibrateTxDCO(unsigned int radioSelection)
//{
//	int eepromStatus = 0;
//	short calReadback = 0;
//	signed short best_I, best_Q;
//	unsigned char radioNum;

//	 //Radio selection will be 0x11111111, 0x22222222, 0x44444444 or 0x88888888
//	 // corresponding to radios in slots 1, 2, 3 or 4
//	 // We need the slot number to initialize the EEPROM
//	 radioNum = (radioSelection & 0xF) == 1 ? 1 : ( (radioSelection & 0xF) == 2 ? 2 : ( (radioSelection & 0xF) == 4 ? 3 : 4 ) );
//
//	 //Select the EEPROM on the current radio board
//	 eepromStatus = WarpEEPROM_EEPROMSelect((unsigned int*)XPAR_EEPROM_CONTROLLER_MEM0_BASEADDR, radioNum);
//
//	 if(eepromStatus != 0)
//	 {
//	 xil_printf("TxDCO: EEPROM error\r\n");
//	 return -1;
//	 }
//
//	 //Initialize the EEPROM controller
//	 eepromStatus = WarpEEPROM_Initialize((unsigned int*)XPAR_EEPROM_CONTROLLER_MEM0_BASEADDR);
//
//	 if(eepromStatus != 0)
//	 {
//	 	xil_printf("TxDCO: EEPROM error\r\n");
//	 	return -1;
//	 }
//
//	 //Read the Tx DCO values
//	 calReadback = WarpEEPROM_ReadRadioCal((unsigned int*)XPAR_EEPROM_CONTROLLER_MEM0_BASEADDR, 2, 1);
//
//	 //Scale the stored values
//	 best_I = (signed short)(((signed char)(calReadback & 0xFF))<<1);
//	 best_Q = (signed short)(((signed char)((calReadback>>8) & 0xFF))<<1);
//
//	 xil_printf("TxDCO: Applied values to radio %d - I: %d\tQ: %d\r\n", radioNum, best_I, best_Q);
//
//	 //Finally, write the Tx DCO values to the DAC
//	 WarpRadio_v1_DACOffsetAdj(ICHAN, best_I, radioSelection);
//	 WarpRadio_v1_DACOffsetAdj(QCHAN, best_Q, radioSelection);
//
//	return 0;
//
//}

#define XPAR_EEPROM_CONTROLLER_BASEADDR XPAR_EEPROM_CONTROLLER_MEM0_BASEADDR
//New TxDCO calibration code
int warpphy_applyTxDCOCalibration(unsigned int radioSelection)
{
	int eepromStatus = 0;
	short calReadback = 0;
	signed short best_I, best_Q;
	unsigned char radioNum;
	Xuint8 memory[8], version, revision, valid, MAC[6], i;
	Xuint16 serial;

	//Radio selection will be 0x11111111, 0x22222222, 0x44444444 or 0x88888888
	// corresponding to radios in slots 1, 2, 3 or 4
	// We need the slot number to initialize the EEPROM
	radioNum = (radioSelection & 0xF) == 1 ? 1 : ( (radioSelection & 0xF) == 2 ? 2 : ( (radioSelection & 0xF) == 4 ? 3 : 4 ) );
	xil_printf("Applying TxDCO correction for radio %d\r\n", radioNum);

	//Mimic the radio test code, in hopes of a more stable EEPROM read...
	//Choose the EEPROM on the selected radio board; second arg is [0,1,2,3,4] for [FPGA, radio1, radio2, radio3, radio4]
	eepromStatus = WarpEEPROM_EEPROMSelect((unsigned int *)XPAR_EEPROM_CONTROLLER_BASEADDR, 0);
	if(eepromStatus != 0)
	{
		xil_printf("EEPROM Select Failed!\r\n");
		return;
	}

	//Initialize the EEPROM controller
	eepromStatus = WarpEEPROM_Initialize((unsigned int *)XPAR_EEPROM_CONTROLLER_BASEADDR);
	if(eepromStatus != 0)
	{
		xil_printf("EEPROM Init Returned %x\r\n", eepromStatus);
		xil_printf("EEPROM Init Failed!\r\n");
	return;
	}

	//Select the EEPROM on the current radio board
	eepromStatus = WarpEEPROM_EEPROMSelect((unsigned int*)XPAR_EEPROM_CONTROLLER_BASEADDR, radioNum);

	if(eepromStatus != 0)
	{
		xil_printf("TxDCO: EEPROM error\r\n");
		return -1;
	}

	//Read the first page from the EERPOM
	WarpEEPROM_ReadMem((unsigned int*)XPAR_EEPROM_CONTROLLER_BASEADDR, 0, 0, memory);
	version = (memory[0] & 0xE0) >> 5;
	revision = (memory[1] & 0xE0) >> 5;
	valid = memory[1] & 0x1F;

	xil_printf("\r\n\r\nEEPROM Values for Radio Board in Slot %d\r\n", radioNum);

	xil_printf("    WARP Radio Board Version %d.%d\r\n", version, revision);

	serial = WarpEEPROM_ReadWARPSerial((unsigned int*)XPAR_EEPROM_CONTROLLER_BASEADDR);

	xil_printf("    Serial Number (WARP): WR-a-%05d\r\n", serial);

	WarpEEPROM_ReadDSSerial((unsigned int*)XPAR_EEPROM_CONTROLLER_BASEADDR, memory);
	print("    EEPROM Hard-wired Serial Number: ");
	for(i=1;i<7;i++)
		xil_printf(" %x",memory[7-i]);
	xil_printf("\r\n\r\n");
	//Read the Tx DCO values
	calReadback = WarpEEPROM_ReadRadioCal((unsigned int*)XPAR_EEPROM_CONTROLLER_BASEADDR, 2, 1);

	//Scale the stored values
	best_I = (signed short)(((signed char)(calReadback & 0xFF))<<1);
	best_Q = (signed short)(((signed char)((calReadback>>8) & 0xFF))<<1);

	xil_printf("TxDCO: Applied values to radio %d - I: %d\tQ: %d\r\n", radioNum, best_I, best_Q);

	//Finally, write the Tx DCO values to the DAC
	WarpRadio_v1_DACOffsetAdj(ICHAN, best_I, radioSelection);
	WarpRadio_v1_DACOffsetAdj(QCHAN, best_Q, radioSelection);

	return 0;
}


void warplab_mimo_4x4_AGC_Reset()
{
	// Cycle the agc's software reset port

	warplab_mimo_4x4_AGC_WriteReg_SRESET_IN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 1);
	usleep(10);
	warplab_mimo_4x4_AGC_WriteReg_SRESET_IN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0);
	usleep(100);

	return;
}

void warplab_mimo_4x4_AGC_MasterReset()
{
	// Cycle the master reset register in the AGC and enable it

	warplab_mimo_4x4_AGC_WriteReg_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0);
	usleep(10);
	warplab_mimo_4x4_AGC_WriteReg_MRESET_IN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0);
	usleep(10);
	warplab_mimo_4x4_AGC_WriteReg_MRESET_IN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 1);
	usleep(10);
	warplab_mimo_4x4_AGC_WriteReg_MRESET_IN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0);
	usleep(10);
	warplab_mimo_4x4_AGC_WriteReg_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 1);

	return;
}

void warplab_mimo_4x4_AGC_Start()
{
	// Cycle the agc's packet in port
	warplab_mimo_4x4_AGC_WriteReg_PACKET_IN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 1);
	usleep(10);
	warplab_mimo_4x4_AGC_WriteReg_PACKET_IN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0);
	usleep(100);

	return;
}

void warplab_mimo_4x4_AGC_Initialize(int noise_estimate)
{
	int g_bbset = 0;

	// First set all standard parameters

	// Turn off both resets and the master enable
	warplab_mimo_4x4_AGC_WriteReg_AGC_EN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0);
	warplab_mimo_4x4_AGC_WriteReg_SRESET_IN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0);
	warplab_mimo_4x4_AGC_WriteReg_MRESET_IN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0);

	// An adjustment parameter
	warplab_mimo_4x4_AGC_WriteReg_ADJ(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 8);

	// Timing for the DC-offset correction
	warplab_mimo_4x4_AGC_WriteReg_DCO_Timing(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0x12001000);

	// Initial baseband gain setting
	warplab_mimo_4x4_AGC_WriteReg_GBB_init(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 52);

	// RF gain AGCstate thresholds
	warplab_mimo_4x4_AGC_WriteReg_Thresholds(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR,0xD5CBA6);

	// Overall AGC timing
	warplab_mimo_4x4_AGC_WriteReg_Timing(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0x9A962A28);//0x826E3C0A;

	// vIQ and RSSI average lengths
	warplab_mimo_4x4_AGC_WriteReg_AVG_LEN(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0x10F); //103

	// Disable DCO, disable DCO subtraction
	warplab_mimo_4x4_AGC_WriteReg_Bits(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, 0x0);

	// Compute and set the initial g_BB gain value from the noise estimate
	// The initial g_bb sets noise to -19 db, assuming 32 db RF gain

	g_bbset = -19 - 32 - noise_estimate;
	warplab_mimo_4x4_AGC_WriteReg_GBB_init(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, g_bbset);

	// Perform a master reset
	warplab_mimo_4x4_AGC_MasterReset();

	// Agc is now reset and enabled, ready to go!
	return;
}

void warplab_mimo_4x4_AGC_setNoiseEstimate(int noise_estimate)
{
	int g_bbset;

	g_bbset = -19 - 32 - noise_estimate;

	warplab_mimo_4x4_AGC_WriteReg_GBB_init(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, g_bbset);

	return;
}

unsigned int warplab_mimo_4x4_AGC_GetGains(void)
{
	unsigned int gBB_A, gRF_A, gBB_B, gRF_B, gBB_C, gRF_C, gBB_D, gRF_D, gains;

	// Get the gains from the registers
	gBB_A = warplab_mimo_4x4_AGC_ReadReg_GBB_A(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR);
	gRF_A = warplab_mimo_4x4_AGC_ReadReg_GRF_A(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR);

	gBB_B = warplab_mimo_4x4_AGC_ReadReg_GBB_B(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR);
	gRF_B = warplab_mimo_4x4_AGC_ReadReg_GRF_B(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR);

	gBB_C = warplab_mimo_4x4_AGC_ReadReg_GBB_C(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR);
	gRF_C = warplab_mimo_4x4_AGC_ReadReg_GRF_C(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR);

	gBB_D = warplab_mimo_4x4_AGC_ReadReg_GBB_D(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR);
	gRF_D = warplab_mimo_4x4_AGC_ReadReg_GRF_D(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR);

	// First concatenate the two radios together, into the gRF register
	// 2 lowest bits are RF, 5 higher bits are BB, last bit is unused
	// Multiply by 2^2, shift gBB right by 2 bits

	gRF_A = gRF_A + (gBB_A * 4);
	gRF_B = gRF_B + (gBB_B * 4);
	gRF_C = gRF_C + (gBB_C * 4);
	gRF_D = gRF_D + (gBB_D * 4);

	// Multiply by 2^8 shift gRF right by 8 bits

	gains = gRF_A + (gRF_B * 256) + (gRF_C * 65536) + (gRF_D * 16777216);

	return gains;
}

void warplab_mimo_4x4_AGC_SetTarget(unsigned int target)
{
	warplab_mimo_4x4_AGC_WriteReg_T_dB(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, target);
	return;
}

void warplab_mimo_4x4_AGC_SetDCO(unsigned int AGCstate)
{
// Enables DCO and DCO subtraction (correction scheme and butterworth hipass are active)

	unsigned int bits;

	bits = warplab_mimo_4x4_AGC_ReadReg_Bits(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR);

	if(AGCstate)
		bits = bits | 0x6;
	else
		bits = bits & 0x1;

	warplab_mimo_4x4_AGC_WriteReg_Bits(XPAR_WARPLAB_MIMO_4X4_AGC_PLBW_0_BASEADDR, bits);

	return;
}
