/* Version v16 */

#include "warp_fpga_board.h"
#include "xparameters.h"
#include "xstatus.h"
#include "errno.h"
#include "xpseudo_asm_gcc.h"
#include "stddef.h"
#include "stdio.h"
#include "string.h"
#include "xuartlite.h"
#include "xuartlite_l.h"
#include "xgpio.h"
#include "warpmac.h"
#include "ofdm_txrx_mimo_regMacros.h"
#include "ofdm_agc_mimo_regMacros.h"
#include "warp_timer_regMacros.h"
#include "radio_controller_basic.h"
#include "radio_controller_ext.h"
#include "radio_controller_adv.h"
#include "warp_userio.h"
#include "warpphy.h"
#include "warpnet.h"

#include "xlltemac.h"
#include "xllfifo_hw.h"
#include "xdmacentral.h"
#include "xdmacentral_l.h"

#include "xtime_l.h"

#define WARPMAC_SAFE_GOODHDR 0

#define TEMAC_DEVICE_ID		XPAR_LLTEMAC_0_DEVICE_ID
#define FIFO_DEVICE_ID		XPAR_LLFIFO_0_DEVICE_ID

#ifdef WARP_FPGA_BOARD_V1_2

#define ENET_LINK_SPEED		100

#elif defined WARP_FPGA_BOARD_V2_2

#include "warp_v4_userio.h"

#define USERIO_BASEADDR XPAR_WARP_V4_USERIO_ALL_BASEADDR
#define ENET_LINK_SPEED		100

#endif

//Instantiates the Maccontrol control structure
Maccontrol controlStruct;

extern unsigned int activeRadios_Tx;

//Instantiates the general-purpose input-output peripheral driver
static XGpio GPIO_UserIO;

//Instantiates the UART driver instance
static XUartLite UartLite;

static XDmaCentral DmaCentralInst;
static XDmaCentral_Config *DMAConfigPtr;

XLlTemac TemacInstance;
XLlTemac_Config *MacCfgPtr;
u32 EMAC_FIFO_BaseAddr;

//Points to a user-provided Macframe where parsed header information will be copied to
Macframe* rxPacket;

//Global variable for tracking active LED outputs
unsigned int LEDHEX_Outputs;
unsigned int ledStates;
unsigned int leftHex;
unsigned int rightHex;

//"Low" LED states
unsigned int ledStatesLow[2];
unsigned char ledStatesIndexLow;
//"High" LED states
unsigned int ledStatesHigh[2];
unsigned char ledStatesIndexHigh;
//Dip-switch state
unsigned char dipswState;
//Debug GPIO state
unsigned char debugGPIO;

//Global variable to track SISO vs. MIMO mode
unsigned char warpmac_TxMultiplexingMode;

unsigned char pktGen_allow;
unsigned int dummyPacketInterval;
unsigned char startPktGeneration;
unsigned int dummyPacketLength;

//These the addresses pointed to by these variables are set by the
//user via the callback registration functions

void (*usr_upbutton) ();
void (*usr_leftbutton) ();
void (*usr_middlebutton) ();
void (*usr_rightbutton) ();
void (*usr_badHeaderCallback) ();
int (*usr_goodHeaderCallback) ();
void (*usr_timerCallback) ();
void (*usr_dataFromNetworkLayer) ();
void (*usr_mgmtPkt) ();
void (*usr_uartRecvCallback) ();

//Null handler, for callbacks the user doesn't re-assign
void nullCallback(void* param){};
int nullCallback_i(void* param){};

///@brief Initializes the framework and all hardware peripherals.
///
///This function sets reasonable default values for many of the parameters of the MAC, configures
///interrupts and exceptions, configures Ethernet, and finally initializes the custom peripherals
///such as the radio controller, the PHY, the packet detector, and the automatic gain control block.
void warpmac_init() {
	
	xil_printf("Initializing WARPMAC v16.1:\r\n");
	
	XStatus Status;

	//Initialize global variables
	startPktGeneration = 0;
	dummyPacketLength = 1470;
	debugGPIO = 0;
	LEDHEX_Outputs = 0;
	ledStates = 0;
	leftHex = 0;
	rightHex = 0;
	ledStatesLow[0] = 1;
	ledStatesLow[1] = 2;
	ledStatesIndexLow = 0;
	ledStatesHigh[0] = 4;
	ledStatesHigh[1] = 8;
	ledStatesIndexHigh = 0;
	warpmac_TxMultiplexingMode = 0;
	
	//Assign a null handler to all the callbacks; the user will override these after initialization
	usr_upbutton = nullCallback;
	usr_leftbutton = nullCallback;
	usr_middlebutton = nullCallback;
	usr_rightbutton = nullCallback;
	usr_badHeaderCallback = nullCallback;
	usr_goodHeaderCallback = nullCallback_i;
	usr_timerCallback = nullCallback;
	usr_dataFromNetworkLayer = nullCallback;
	usr_mgmtPkt = nullCallback;
	usr_uartRecvCallback = nullCallback;
	
	//Initialize the PHY
	warpphy_init();

	/*********************MAC Parameters*************************/
	//Sensible defaults; user can override
	controlStruct.maxReSend = 4;
	controlStruct.currentCW = 0;
	controlStruct.maxCW = 5;

	controlStruct.pktBuf_phyRx = 0;
	controlStruct.pktBuf_emacRx = 1;
	controlStruct.dummyPacketMode = 0;
	
	warpphy_setBuffs(controlStruct.pktBuf_emacRx, controlStruct.pktBuf_phyRx);
	/************************************************************/

	/************************UART*****************************/
	XUartLite_Initialize(&UartLite, XPAR_UARTLITE_0_DEVICE_ID);
	/************************************************************/

	/**************************DMA*******************************/
	//Lookup the DMA configuration information
	DMAConfigPtr = XDmaCentral_LookupConfig(DMA_CTRL_DEVICE_ID);
	
	//Initialize the config struct
	Status = XDmaCentral_CfgInitialize(&DmaCentralInst, DMAConfigPtr, DMAConfigPtr->BaseAddress);
	if (Status != XST_SUCCESS){
		xil_printf("DMA CfgInitialize failed!\r\n");
		return;
	}
	
	//Disable Interrupts
	XDmaCentral_InterruptEnableSet(&DmaCentralInst, 0);
	/************************************************************/
	
	/*******************Ethernet**********************************/
	xil_printf("\tInitializing TEMAC...");
	MacCfgPtr = XLlTemac_LookupConfig(TEMAC_DEVICE_ID);
	Status = XLlTemac_CfgInitialize(&TemacInstance, MacCfgPtr, MacCfgPtr->BaseAddress);
	if (Status != XST_SUCCESS)
		xil_printf("EMAC init error\r\n");
	
	if (!XLlTemac_IsFifo(&TemacInstance))
		xil_printf("EMAC hw config incorrect\r\n");
	
	EMAC_FIFO_BaseAddr = MacCfgPtr->LLDevBaseAddress;
	
	Status  = XLlTemac_ClearOptions(&TemacInstance, XTE_LENTYPE_ERR_OPTION | XTE_FLOW_CONTROL_OPTION | XTE_FCS_STRIP_OPTION);// | XTE_MULTICAST_OPTION);
	Status |= XLlTemac_SetOptions(&TemacInstance, XTE_PROMISC_OPTION | XTE_MULTICAST_OPTION | XTE_BROADCAST_OPTION | XTE_RECEIVER_ENABLE_OPTION | XTE_TRANSMITTER_ENABLE_OPTION); //| XTE_JUMBO_OPTION
	if (Status != XST_SUCCESS)
		xil_printf("Error setting EMAC options\r\n, code %d", Status);
	
	// Make sure the TEMAC is ready
	Status = XLlTemac_ReadReg(TemacInstance.Config.BaseAddress, XTE_RDY_OFFSET);
	while ((Status & XTE_RDY_HARD_ACS_RDY_MASK) == 0)
	{
		Status = XLlTemac_ReadReg(TemacInstance.Config.BaseAddress, XTE_RDY_OFFSET);
	}
	
    XLlTemac_SetOperatingSpeed(&TemacInstance, ENET_LINK_SPEED);
    usleep(1 * 10000);
	
	XLlTemac_Start(&TemacInstance);
	xil_printf("complete!\r\n");
	/************************************************************/

#ifdef WARP_FPGA_BOARD_V1_2
	/************************USER IO*****************************/
	//Initialize the UserIO GPIO core
	Status = XGpio_Initialize(&GPIO_UserIO, XPAR_USER_IO_DEVICE_ID);
	
	//We use both channels in the GPIO core- one for inputs, one for outputs
	XGpio_SetDataDirection(&GPIO_UserIO, USERIO_CHAN_INPUTS, USERIO_MASK_INPUTS);
	XGpio_SetDataDirection(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, 0);
	
	//Make sure the LEDs are all off by default
	XGpio_DiscreteClear(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, USERIO_MASK_OUTPUTS);
	/************************************************************/
	
#elif defined WARP_FPGA_BOARD_V2_2
	/************************USER IO*****************************/
	WarpV4_UserIO_NumberMode_LeftHex(USERIO_BASEADDR);
	WarpV4_UserIO_NumberMode_MiddleHex(USERIO_BASEADDR);
	WarpV4_UserIO_NumberMode_RightHex(USERIO_BASEADDR);
	/************************************************************/
#endif

	/************************************************************/
	
	//Set the default Tx power to maximum
	warpphy_setTxPower(0x3F);
	
	//Manually call the UserIO ISR once to store the initial value of the buttons/switches
	//This is especially important for applications where the value of the DIP switch means something at boot
	userIO_handler((void *)&GPIO_UserIO);
	
	//Set the backoff timer to pause during medium-busy events
	// The user can either disable this with a similar call (using mode=TIMER_MODE_NOCARRIERSENSE)
	// or set the carrier sense threshold so high it that it will never see "busy"
	warp_timer_setMode(BACKOFF_TIMER, TIMER_MODE_CARRIERSENSE); 
	
	//In this design, we dedicate 1 of the 8 timers int the warp_timer core to polling user IO
	//like the uart and push buttons. The rate of this poll is controlled by USERIO_POLLRATE.
	warp_timer_setTimer(USERIO_TIMER, 0, USERIO_POLLRATE); 
	warp_timer_setMode(USERIO_TIMER, TIMER_MODE_NOCARRIERSENSE);
	warp_timer_start(USERIO_TIMER);
	
	return;
}

///@brief Top-level polling function
///
///This function polls each peripheral in the design (PHY, timer and Ethernet)
///User applications should call this function frequently
inline void warpmac_pollPeripherals() {
	//This function polls the three main peripherals: the PHY, timer and EMAC
	warpmac_pollPhy();
	warpmac_pollTimer();
	warpmac_pollDataSource();
	
	return;
}

///@brief Polls the OFDM PHY
///
///Function checks the status of the PHY receiver
inline void warpmac_pollPhy() {
	
	unsigned int status = mimo_ofdmRx_getPktStatus();
	
	if(status & PHYRXSTATUS_HEADER & PHYRXSTATUS_GOOD) phyRx_goodHeader_handler();
	else if(status & PHYRXSTATUS_BAD) phyRx_badHeader_handler(); //Either bad header or bad payload
	else if(status & PHYRXSTATUS_PAYLOAD & PHYRXSTATUS_GOOD)
	{
		//This should never happen (good payload with no good header); reset if it does
		warpphy_clearRxPktStatus();
		xil_printf("warpmac_pollPhy Error: good pkt but no good hdr!\r\n");
	}
	
	return;
}

///@brief  Handler for the timer peripheral.
///
///The timer  handler gets called when a hardware timer set by the
///user expires. The user's callback is called upon the completion of this event
inline void warpmac_pollTimer() {
	
	
	unsigned int timerStatus;
	
	timerStatus = warp_timer_getStatuses();
	
	
	//We check the status of each of the timers, and call necessary callbacks
	// The ifdef's below keep this funciton from wasiting time checking unused timers
	// You can enable polling timers invididually by modifying warpmac.h
#ifdef POLL_TIMER0
	if((timerStatus & TIMER0_MASK & TIMER_STATUS_DONE_MASK) != 0){
		warp_timer_resetDone(0);
		usr_timerCallback(0);
	}
#endif
#ifdef POLL_TIMER1
	if((timerStatus & TIMER1_MASK & TIMER_STATUS_DONE_MASK) != 0){
		warp_timer_resetDone(1);
		usr_timerCallback(1);
	}
#endif
#ifdef POLL_TIMER2
	if((timerStatus & TIMER2_MASK & TIMER_STATUS_DONE_MASK) != 0){
		warp_timer_resetDone(2);
		usr_timerCallback(2);
	}
#endif
#ifdef POLL_TIMER3
	if((timerStatus & TIMER3_MASK & TIMER_STATUS_DONE_MASK) != 0){
		warp_timer_resetDone(3);
		usr_timerCallback(3);
	}
#endif
#ifdef POLL_TIMER4
	if((timerStatus & TIMER4_MASK & TIMER_STATUS_DONE_MASK) != 0){
		warp_timer_resetDone(4);
		usr_timerCallback(4);
	}
#endif
#ifdef POLL_TIMER5
	if((timerStatus & TIMER5_MASK & TIMER_STATUS_DONE_MASK) != 0){
		warp_timer_resetDone(5);
		usr_timerCallback(5);
	}
#endif
	
	//Timer 6 is dedicated for polling User I/O
	if((timerStatus & TIMER6_MASK & TIMER_STATUS_DONE_MASK) != 0){
		warp_timer_resetDone(USERIO_TIMER);
		
		//Call the UART callback
		warpmac_uartRecvHandler(&UartLite);
		
		//Call the user I/O callback (buttons, switches, etc.)
		userIO_handler(&GPIO_UserIO);
		
		//Reset and restart the user I/O polling timer
		warp_timer_setTimer(USERIO_TIMER, 0, USERIO_POLLRATE);
		warp_timer_setMode(USERIO_TIMER, TIMER_MODE_NOCARRIERSENSE);
		warp_timer_start(USERIO_TIMER);
	}
	
	//Timer 7 is dedicated to dummy packet generation
	if((timerStatus & TIMER7_MASK & TIMER_STATUS_DONE_MASK) != 0){
		warp_timer_resetDone(PKTGEN_TIMER);
		//warpmac_incrementLEDLow();
		pktGen_allow = 1;
	
		warp_timer_setTimer(PKTGEN_TIMER, 0, dummyPacketInterval*TIMERCLK_CYCLES_PER_USEC); 
		warp_timer_setMode(PKTGEN_TIMER, TIMER_MODE_NOCARRIERSENSE);
		warp_timer_start(PKTGEN_TIMER);
	}

	return;
}

///@brief Polls the Ethernet
///
///Function checks the status of the ping and pong Emac buffers
///and calls the effective-ISR when either is filled.
inline void warpmac_pollDataSource() {
	
	//If the user code has disabled new data (probably becuase they're still working on the previous packet)
	// return immediately without actually polling anything. This allows the TEAMC and LLFIFO to buffer
	// incoming packets, dropping them at the wire if too many arrive before the user is ready
	if( controlStruct.enableDataFromNetwork == 0 )
		return;
	
	//If we're in dummyPacket mode, and it's time to generate a new packet, 
	// call the user callback immediately, as if a packet had been received over the wire into pktBuf_emacRx
	if(controlStruct.dummyPacketMode && startPktGeneration && pktGen_allow)
	{
		pktGen_allow = 0;
//				xil_printf("dummy\r\n");
		usr_dataFromNetworkLayer(dummyPacketLength, warpphy_getBuffAddr(controlStruct.pktBuf_emacRx)+NUM_HEADER_BYTES);
	}
	
	//warpmac_setDebugGPIO(0x1);

	//Two ways to check if there are packets in the LLFIFO:
	// 1) Read the ISR register for XLLF_INT_RC_MASK (receive complete)
	// 2) Read the RDFO register for a count of received packets in the FIFO
	//Option 2 works well in testing
	//if(XIo_In32(EMAC_FIFO_BaseAddr+XLLF_ISR_OFFSET) & XLLF_INT_RC_MASK)
	if(XIo_In32(EMAC_FIFO_BaseAddr+XLLF_RDFO_OFFSET) > 0)
	{
		//FIXME: add LLFIFO and TEMAC error handling

		//Clear the LLFIFO status bits
		XIo_Out32(EMAC_FIFO_BaseAddr+XLLF_ISR_OFFSET, 0x0FFFFFFF);
		
		//warpmac_setDebugGPIO(0x3);

		//Call the ethernet packet handler
		emacRx_handler();
	}
	//warpmac_setDebugGPIO(0x0);

	return;
}

///@brief "Good Header" handler for the PHY layer.
///
///This function is the handler for the RX physical layer peripheral.
///This function is only called if the packet header has no bit errors
///(i.e., the packet header passes CRCs in the PHY). This handler will
///be asserted *before* the packet is fully received. This function assumes
///the user's callback will poll the PHY to determine if the packet is eventually
///good or bad
void phyRx_goodHeader_handler() {	

	
	unsigned int numPayloadBytes;
	int length;
	
	int i;
	
//	warpmac_setDebugGPIO(0xF);
	
	//Copy the received packet's header into the rxPacket struct
	memcpy((unsigned char *)(&(rxPacket->header)), (unsigned char *)warpphy_getBuffAddr(controlStruct.pktBuf_phyRx), (size_t)NUM_HEADER_BYTES);
	
	//Strip the header and checksum from the total number of bytes reported to user code
	if(rxPacket->header.length == NUM_HEADER_BYTES) {
		//Header-only packet (like an ACK) has 0 payload bytes
		rxPacket->header.length = 0;
	}
	else {
		//Other packets have payload bytes; subtract off header and 4-byte payload checksum lengths and (if coded) tail bytes
		rxPacket->header.length = (rxPacket->header.length) - NUM_HEADER_BYTES - NUM_PAYLOAD_CRC_BYTES - NUM_PAYLOAD_TAIL_BYTES;
	}
	
	//If the Rx packet is too big, ignore the payload
	// This should never happen; the Tx code will never send a pkt bigger than Ethernet MTU
	if(rxPacket->header.length>MY_XEM_MAX_FRAME_SIZE) {
		rxPacket->header.length = 0;
	}
	
	//Pass the received packet to the user handler
	if(~usr_goodHeaderCallback(rxPacket)){
		warpphy_clearRxPktStatus();
	}
#if WARPMAC_SAFE_GOODHDR
	//Poll PHY to insure ISR does not quit too early
	//User code probably does this too, but it is required to
	unsigned char state = PHYRXSTATUS_INCOMPLETE;
	while(state == PHYRXSTATUS_INCOMPLETE)
	{
		//Blocks until the PHY reports the received packet as either good or bad
		state = mimo_ofdmRx_getPayloadStatus();
	}
	
	//Clears every interrupt output of the PHY
	warpphy_clearRxPktStatus();
#endif
	
//		warpmac_setDebugGPIO(0x0,0xF);
	
//warpmac_setDebugGPIO(0x0);	
	
	return;
}

///@brief "Bad Header" handler for the PHY layer.
///
///This function is the handler for the RX physical layer peripheral.
///This function is only called if the packet fails CRC. The received
///packet is passed to the user's callback, and the PHY is reset.
inline void phyRx_badHeader_handler() {
	//Bad packets, by definition, have no payload bytes which can be trusted
	// The user handler is called with no arguments, since there is no real packet data to process
	// If the header happend to be good but the payload bad, the user should use the good header
	// interrupt to process the header
	usr_badHeaderCallback();
	
	//Clear the good/bad packet interrupts in the PHY to re-enable packet reception
	warpphy_clearRxPktStatus();
	
	return;
}

///@brief Handles a received Ethernet frame
///
///This funciton handles a single received Ethernet frame
///The calling function is responsible for first checking that a frame is ready to be received
void emacRx_handler() {
//xil_printf("emacRx handler\r\n");
	unsigned short RxPktLength, RxPktEtherType;
	int skipDataCallback = 0;
	int mgmtFrame = 0;
	void* pktBufPtr;
	warpnetEthernetPktHeader* thePkt;

	pktBufPtr = (void *)warpphy_getBuffAddr(controlStruct.pktBuf_emacRx)+NUM_HEADER_BYTES;

	//Wait for the DMA to be idle
	warpmac_waitForDMA();

	//Set DMA to non-increment source, increment dest addresses
	XDmaCentral_SetControl(&DmaCentralInst, XDMC_DMACR_DEST_INCR_MASK);

	//Read the Rx packet length; the packet must be read from the FIFO immediately after this read
	RxPktLength = XIo_In32(EMAC_FIFO_BaseAddr+XLLF_RLF_OFFSET);

	//warpmac_setDebugGPIO(0x7);
	//Transfer the Ethernet frame from the FIFO to the PHY buffer
	XDmaCentral_Transfer(&DmaCentralInst,
						(u8 *)(EMAC_FIFO_BaseAddr+XLLF_RDFD_OFFSET),
						(u8 *)pktBufPtr,
						RxPktLength);

	//Extract the EtherType field to determine if this is a management packet
	thePkt = (warpnetEthernetPktHeader*)(pktBufPtr);
	RxPktEtherType = thePkt->ethType;
	
#ifdef WARPNET_ETHTYPE_SVR2NODE
	if (RxPktEtherType == WARPNET_ETHTYPE_SVR2NODE) {
		//The packet is a WARPnet packet
		mgmtFrame = 1;
		skipDataCallback = 1;
	}
#endif
#ifdef WARPNET_ETHTYPE_NODE2SVR
	if (RxPktEtherType == WARPNET_ETHTYPE_NODE2SVR) {
		//The packet is a WARPnet packet from another node destined to the server; ignore it
		mgmtFrame = 0;
		skipDataCallback = 1;
	}
#endif
	
	if(mgmtFrame)
	{
		//Wait until the DMA transfer is done by checking the Status register
		warpmac_waitForDMA();
		
		usr_mgmtPkt(RxPktLength, pktBufPtr);
	}
	else if( (skipDataCallback == 0) && (controlStruct.dummyPacketMode == 0))
	{
		//printBytes((unsigned char *)pktBufPtr, 24);

		//This call does *not* wait for the DMA to finish, since the FIFO/DMA will be much faster than an OFDM PHY Tx
		//warpmac_setDebugGPIO(0xF);
//		xil_printf("Not dummy\r\n");
//		xil_printf("Not dummy\r\n");
		usr_dataFromNetworkLayer(RxPktLength, pktBufPtr);
	}

	return;
}

inline void warpmac_waitForDMA()
{

	int RegValue;

	//Wait until the DMA transfer is done by checking the Status register
	do {RegValue = XDmaCentral_GetStatus(&DmaCentralInst);}
	while ((RegValue & XDMC_DMASR_BUSY_MASK) == XDMC_DMASR_BUSY_MASK);

	return;
}

///@brief This function stops the timer.
///
///Additionally it will return the amount of time remaining before expiration.
///@return Number of clock cycles remaining before expiration.
inline void warpmac_clearTimer(unsigned char theTimer) {
	warp_timer_pause(theTimer);
	warp_timer_resetDone(theTimer);
	
	return;
}

///@brief This function starts the timer in either a CSMA or non-CSMA mode.
///@param theTimer ID of the hardware timer (in [0,7]) to start
///@param mode TIMER_MODE_CARRIERSENSE if automatic carrier-sense pausing is desired. TIMER_MODE_NOCARRIERSENSE if received energy
///is to be ignored.
inline void warpmac_startTimer(unsigned char theTimer, unsigned char mode) {
	warp_timer_setMode(theTimer, mode);
	warp_timer_start(theTimer);
}

///@brief Function is responsible for high-level MAC timing
///
///This function is used by user code, and in turn calls the other timer functions.
///It is capable of initiating either a deterministic timeout, or a random backoff.
///@param type TIMEOUT_TIMER for deterministic countdown, BACKOFF_TIMER for random exponential
void warpmac_setTimer(int type) {
	unsigned int setTime, numSlots;
	int myRandNum;
	int retval;
	
	switch(type) {
		case TIMEOUT_TIMER:
			
			//User a 1-cycle slot, so the numSlots argument is equal to the number of clock cycles
			warp_timer_setTimer(TIMEOUT_TIMER, 0, controlStruct.timeout);
			warp_timer_setMode(TIMEOUT_TIMER, TIMER_MODE_NOCARRIERSENSE); 
			warp_timer_start(TIMEOUT_TIMER);
			return;
			break;
		case BACKOFF_TIMER:
			
			myRandNum = randNum(controlStruct.currentCW);
			numSlots = myRandNum;
			
			if(controlStruct.currentCW < controlStruct.maxCW){
				controlStruct.currentCW = controlStruct.currentCW + 1;
			}
			
			warp_timer_setTimer(BACKOFF_TIMER, controlStruct.slotTime, numSlots);
			warp_timer_start(BACKOFF_TIMER);
			
			return;
			break;
		default:
			//Invalid timer ID; do nothing
			return;
			break;
	}
}

///@brief Generates a uniform random value between [0,(2^(N+4) - 1)], where N is a positive integer
///
///Used internally by WARPMAC for random exponential backoffs.
///@param N Window size for draw of uniform random value.
inline unsigned int randNum(unsigned int N){
	
	return ((unsigned int)rand() >> (32-(N+5)));
	
}

///@brief Returns a value corresponding to the instantaneous channel condition {busy or idle}
///
///@return 1 if medium is idle, 0 if medium is busy
inline int warpmac_carrierSense() {
	return ofdm_txrx_mimo_ReadReg_Rx_PktDet_idleForDifs();
}


///@brief Starts a DMA transfer to the EMAC FIFO
///
///This function does *not* block until the DMA finishes, so the user app can do other things
///User code should call warpmac_startPktToNetwork() soon after calling this function
///
///@param thePkt Pointer to the packet data
///@param length Number of bytes in the packet
inline void warpmac_prepPktToNetwork(void* thePkt, unsigned int length) {

	
	#if 0	
	xil_printf("prepPktToNetwork\r\n");
	#define NUMREAD 100
	int i;
	for(i=0;i<NUMREAD;i++){
		xil_printf("0x%x, ",*((unsigned char*)thePkt+i)&0xFF);
	}
	xil_printf("\r\n");
	#endif

//	int i;
//	for(i=0;i<length;i++){
//	xil_printf("0x%x, ",*((unsigned char*)thePkt+i)&0xFF);
//	}
//	xil_printf("\r\n");

	//Wait for the DMA to be idle
	warpmac_waitForDMA();

	//Set DMA to increment src, non-increment dest addresses
	XDmaCentral_SetControl(&DmaCentralInst, XDMC_DMACR_SOURCE_INCR_MASK);

	//Transfer the packet into the LLFIFO
	XDmaCentral_Transfer(&DmaCentralInst, 
							(u8 *)(thePkt),
							(u8 *)(EMAC_FIFO_BaseAddr + XLLF_TDFD_OFFSET),
							length);
	return;
}

///@brief Starts an Ethernet packet transmission
///
///Packet must have already been transferred using warpmac_prepPktToNetwork()
///@param length Number of bytes in packet to send (must match length argument in previous warpmac_prepPktToNetwork call)
inline void warpmac_startPktToNetwork(unsigned int length) {

//xil_printf("startPktToNetwork\r\n");

	//Wait for the DMA to finish
	warpmac_waitForDMA();


	
	//Write the length to the LL_FIFO; this write initiates the TEMAC transmission
	XIo_Out32( (EMAC_FIFO_BaseAddr + XLLF_TLF_OFFSET), length);
	
	return;
}

///@brief Sets user callback function for various system events
///
///@param event ID of the event triggering the callback; one of EVENT_* values from warpmac.h
///@param handler Function pointer for user-provided callback function
void warpmac_setCallback(int event, void(*handler)()) {

	switch(event)
	{
		case EVENT_UPBUTTON:
			usr_upbutton = handler;
			break;
		case EVENT_LEFTBUTTON:
			usr_leftbutton = handler;
			break;
		case EVENT_RIGHTBUTTON:
			usr_rightbutton = handler;
			break;
		case EVENT_MIDDLEBUTTON:
			usr_middlebutton = handler;
			break;
		case EVENT_TIMER:
			usr_timerCallback = handler;
			break;
		case EVENT_DATAFROMNETWORK:
			usr_dataFromNetworkLayer = handler;
			break;
		case EVENT_MGMTPKT:
			usr_mgmtPkt = handler;
			break;
		case EVENT_PHYGOODHEADER:
			usr_goodHeaderCallback = handler;
			break;
		case EVENT_PHYBADHEADER:
			usr_badHeaderCallback = handler;
			break;
		case EVENT_UARTRX:
			usr_uartRecvCallback = handler;
			break;
		default:
			//Invalid event ID; do nothing
			break;
	}
	
	return;
}

///@brief Sets the base rate modulation order
///
///The base rate symbols (i.e. the header) must have an agreed upon rate between the transmitter
///and receiver. This function sets that rate.
///@param rate BPSK, QPSK or QAM_16
void warpmac_setBaseRate(unsigned char rate) {
	//Update the base rate modulation in the PHY; leave the four full rate modulation selections unchanged
	warpphy_set_modulation(rate, MOD_UNCHANGED, MOD_UNCHANGED, MOD_UNCHANGED, MOD_UNCHANGED);
	
	//Change these to _UNCODED if FEC is disabled
	if(rate == BPSK) warpphy_setNumBaseRateSyms(NUM_BASERATE_SYMBOLS_BPSK_CODED);
	else warpphy_setNumBaseRateSyms(NUM_BASERATE_SYMBOLS_QPSK_CODED);

	return;
}

///@brief Sets the PHY Tx and Rx antenna modes
///
///@param txMode One of TX_ANTMODE_* values defined in warpphy.h
///@param rxMode One of RX_ANTMODE_* values defined in warpphy.h
int warpmac_setAntennaMode(unsigned int txMode, unsigned int rxMode)
{
	//Update the global variables, used elsewhere to calculate PHY values
	// (like numFullRate symbols) which depend on the current antenna configuration
	if( (txMode & PHYMODE_SISO) || (txMode & PHYMODE_ALAMOUTI) )
	{
		warpmac_TxMultiplexingMode = 0;
	}
	else
	{
		warpmac_TxMultiplexingMode = 1;
	}

	//Call the warpphy function to actually configure the PHY antenna mode
	warpphy_setAntennaMode(txMode, rxMode);

	return 0;
}
///@brief Loads a header into the PHY, but does not immediately transmit
///
///This function performs the conversion from the packet structure to the byte array
///but does not send the packet over the air. This is used to "preload" and ACK
///into the PHY while the data packet is still being received. This extra 
///pipelining saves on turn-around time.
///@param packet Pointer to user's Macframe
///@param buffer Packet buffer to send from
void warpmac_prepPhyForXmit(Macframe* packet, unsigned char buffer) {
	
	unsigned short origLength;
	if(packet->header.length == 0) {
		//All-header packet, like an ACK, has only base-rate symbols
		//Update the PHY packet length to consist of just the header
		origLength = 0;
		packet->header.length = NUM_HEADER_BYTES;
	}
	else {
		//Update the header's numBytes field to include the header, CRC and tail bytes
		origLength = packet->header.length;
		packet->header.length = packet->header.length + NUM_HEADER_BYTES + NUM_PAYLOAD_CRC_BYTES + NUM_PAYLOAD_TAIL_BYTES;
	}
	
	//Copy the header to the PHY packet buffer, filling exactly NUM_HEADER_BYTES bytes
	// The rest of the packet (its payload) will be copied by DMA later
	memcpy( (void *) warpphy_getBuffAddr(buffer), (void *) packet, (size_t) NUM_HEADER_BYTES);
	
	//Revert the packet payload length so the user code doesn't see the MAC/PHY tweaking
	packet->header.length = origLength;
	
	return;
}

///@brief Sends the current txBuffer's content.
///
///This function sends an existing Macframe over the air. This existing Macframe comes from the warpmac_prepPhyForXmit 
///function.
inline void warpmac_startPhyXmit(unsigned char buffer) {
	
	int txResult;
	
	//Hold the packet detecter in reset to prevent any interfering receptions
	//	ofdm_pktDetector_mimo_WriteReg_pktDet_reset(PKTDET_BASEADDR, 1);
	
	//Transmit the packet; WARPPHY disables the radio Rx, enables Tx, sends the packet, then re-enables radio Rx
	// TXBLOCK will cause this call to block until the transmission is finished
	warpphy_setBuffs(buffer, controlStruct.pktBuf_phyRx);
	controlStruct.pktBuf_phyTx = buffer;
	
	txResult = warpphy_pktTx(TXNOBLOCK);
	
	if(txResult != 0)
	{
		xil_printf("WARPMAC tried to Tx, but PHY was busy\r\n");
	}
	
	return;
}

///@brief Blocks on PHY transmission
///
///This function waits for the PHY to finish transmitting, then re-enables wireless reception and sets packet buffers back
///to their default values.
inline void warpmac_finishPhyXmit() {
	warpphy_waitForTx();
}

///@brief Tells the PHY which piece of memory to receive to
///
///Also, it updates the global struct element Maccontrol#rxBuffIndex to keep track of that information*/
inline void warpmac_setRxBuffers(Macframe* rxFrame, unsigned char phyRxBuff) {

	//Update the gloal Rx Macframe
	rxPacket = rxFrame;

	//Update the PHY Rx buffer assignment
	controlStruct.pktBuf_phyRx = phyRxBuff;
//	warpphy_setBuffs(controlStruct.pktBuf_emacRx, controlStruct.pktBuf_phyRx);
	warpphy_setBuffs(controlStruct.pktBuf_phyTx, controlStruct.pktBuf_phyRx);

	return;
}

///@brief Tells the PHY which piece of memory to send from
inline void warpmac_setPHYTxBuffer(unsigned char txBuff) {
	controlStruct.pktBuf_phyTx = txBuff;
	warpphy_setBuffs(txBuff, controlStruct.pktBuf_phyRx);
	return;
}

///@brief Tells the PHY which piece of memory to send from
inline void warpmac_setEMACRxBuffer(unsigned char emacRxBuff) {
	controlStruct.pktBuf_emacRx = emacRxBuff;
	return;
}

///@brief Decrements the remaining reSend counter for the given Macframe
///
///Also, it returns whether or not the counter has wrapped around the maximum
///number of retransmits
///@param packet Pointer to user's Macframe
///@return 0 if maximum number of retransmits has been reached, and 1 otherwise
int warpmac_decrementRemainingReSend(Macframe* packet){
	int status = 1;
	
	unsigned char remainingReSend;
	remainingReSend=(packet->header.remainingTx);
	
	if(remainingReSend>0){
		remainingReSend--;
	}
	
	else{
		status = 0;	
	}

	packet->header.remainingTx = remainingReSend;

	return status;
}

///@brief Resets the current contention window to the minimum
///
///Resets the current contention window to the minimum value. This is used
///following the reception of an ACK in order to engage a minimum CW backoff period.
void warpmac_resetCurrentCW(){
	controlStruct.currentCW = 0;
	return;
}

///@brief Sets the maximum number of resends
///
///@param c Integer maximum number of resends
inline void warpmac_setMaxResend(unsigned int c) {
	controlStruct.maxReSend = c;
}

///@brief Sets the maximum contention window.
///
///@param c Maximum contention window
inline void warpmac_setMaxCW(unsigned int c) {
	controlStruct.maxCW = c;
}

///@brief Sets the amount of time the node is willing to wait for an acknowledgement.
///
///@param time Timeout duration (in microseconds)
inline void warpmac_setTimeout(unsigned int time){
	controlStruct.timeout = time * TIMERCLK_CYCLES_PER_USEC;
}

///@brief Sets the smallest backoff window.
///
///@param time Slot time duration (in microseconds)
inline void warpmac_setSlotTime(unsigned int time){
	controlStruct.slotTime = time * TIMERCLK_CYCLES_PER_USEC;
}

///@brief Returns a value corresponding to whether or not the node is in timeout.
///
///@return 1 if in TIMEOUT_TIMER, 0 otherwise
inline int warpmac_inTimeout(){
	return (0 != (warp_timer_getStatus(TIMEOUT_TIMER) & (TIMER_STATUS_DONE_MASK | TIMER_STATUS_RUNNING_MASK)));
}

///@brief Returns a value corresponding to whether or not the node is in backoff.
///
///@return 1 if in BACKOFF_TIMER, 0 otherwise
inline int warpmac_inBackoff(){
	return (0 != (warp_timer_getStatus(BACKOFF_TIMER) & (TIMER_STATUS_DONE_MASK | TIMER_STATUS_RUNNING_MASK)));
}

///@brief Enables/disables carrier sensing in the PHY packet detector
///
///@param mode 1 enables CS, 0 disables CS
inline void warpmac_setCSMA(char mode) {
	if(mode)
		ofdm_txrx_mimo_WriteReg_Rx_CSMA_setThresh(THRESH_CARRIER_SENSE);
	else
		ofdm_txrx_mimo_WriteReg_Rx_CSMA_setThresh(16380);

	return;
}

///@brief Raises a signal that is routed out to the debug header on the board
///
///@param val 4-bit input (per bit: 1=asserts output, 0=deasserts output)
///@param mask 4-bit mask of which bits to affect
inline void warpmac_setDebugGPIO(unsigned char val, unsigned char mask) {

	debugGPIO = ((debugGPIO&~mask)|(mask&val));
	XGpio_mSetDataReg(XPAR_DEBUGOUTPUTS_BASEADDR, 1, debugGPIO);
	return;
}




///@brief Enable the Ethernet
inline void warpmac_enableDataFromNetwork() {
	controlStruct.enableDataFromNetwork = 1;
	return;
}

///@brief Disables the Ethernet
inline void warpmac_disableDataFromNetwork() {
	controlStruct.enableDataFromNetwork = 0;
	return;
}


///@brief Blocks on PHY transmission and returns whether packet was good or bad
///
///This function waits for the PHY to finish receiving, then checks its status
inline char warpmac_finishPhyRecv(){
	XTime startTime,currTime;
	unsigned char state = PHYRXSTATUS_INCOMPLETE;

//The running theory is that there is a bad state somewhere in the PHY
//That keeps a goodHeader from ever turning into a goodPayload or badPayload.
//I'm adding a watchdog timer in here to look for that state and purge the PHY.
//We should also notify the experiment that there was a corrupted trial so this dataPoint
//should be redone.

	XTime_GetTime(&startTime);
		

	while(state == PHYRXSTATUS_INCOMPLETE) {
		//Blocks until the PHY reports the received packet as either good or bad
		state = mimo_ofdmRx_getPayloadStatus();

		XTime_GetTime(&currTime);
		if(((currTime>>10)-(startTime>>10))>=(234375*1)){
			return 2;
		}

	}
	return state;
}


//void warpmac_uartRecvHandler(void *CallBackRef, unsigned int EventData)
void warpmac_uartRecvHandler(void *CallBackRef)
{
	XUartLite *InstancePtr = CallBackRef;
	
	unsigned int uartIntStatus;
	unsigned char receivedByte;
	
	uartIntStatus = XUartLite_mReadReg(InstancePtr->RegBaseAddress, XUL_STATUS_REG_OFFSET);
	
	if( (uartIntStatus & (XUL_SR_RX_FIFO_FULL |	XUL_SR_RX_FIFO_VALID_DATA)) != 0)
	{
		receivedByte = XUartLite_RecvByte(InstancePtr->RegBaseAddress);
		
		//Call the user callback, passing the byte that was received
		usr_uartRecvCallback(receivedByte);
	}
	
	return;
}

//**************************//
// Dummy Packet Mode Config //
//**************************//
inline void warpmac_setDummyPacketMode(char mode) {
	if(mode){
		xil_printf("Dummy Packet Mode Enabled\r\n");
		controlStruct.dummyPacketMode = 1;
		}
	else
		{
		xil_printf("Dummy Packet Mode Disabled\r\n");
		controlStruct.dummyPacketMode = 0;
		}
	return;
}

void warpmac_startPacketGeneration(unsigned int length, unsigned int interval) {

	startPktGeneration = 1;
	dummyPacketLength = length;
	dummyPacketInterval = interval;
	
	warp_timer_setTimer(PKTGEN_TIMER, 0, dummyPacketInterval*TIMERCLK_CYCLES_PER_USEC); 
	warp_timer_setMode(PKTGEN_TIMER, TIMER_MODE_NOCARRIERSENSE);
	warp_timer_start(PKTGEN_TIMER);
	return;
}

void warpmac_stopPacketGeneration() {
	startPktGeneration = 0;
	
	warp_timer_pause(PKTGEN_TIMER);
	warp_timer_resetDone(PKTGEN_TIMER);
}

///@brief Reads the value from the user dip switches for use as node identification.
///
///@return Value currently set on dip switches of the WARP board
int warpmac_getMyId() {

	//dipswState is updated automatically by the User I/O handler
	return dipswState;
}

inline void printBytes(unsigned char* data, int length)
{
	int i;

	xil_printf("Data (hex, %d bytes):\r\n", length);

	for(i=0; i<length; i++)
		xil_printf("%02x ", data[i]);

	xil_printf("\r\n");
	return;
}


//**********START***********//
// FPGA Board Specific Code //
//**************************//
#ifdef WARP_FPGA_BOARD_V1_2
///@brief  Handler for the User I/O.
///
///This is called by the User I/O polling from one of the timers.
///The various user callbacks are executed, depending upon which button was depressed. Additionally,
///the board's dip switches also trigger this handler, though the framework does not currently call user
///code in this event. We assume that dipswitches are currently only used for beginning-of-time
///state assignments.
void userIO_handler(void *InstancePtr){
	
	static unsigned int previousAssertedInputs;
	unsigned int assertedInputs;
	unsigned int newAssertedInputs;
	
	//Re-interpret the generic input pointer as a GPIO driver instance
    XGpio *GpioPtr = (XGpio *)InstancePtr;
	
	//Disable the GPIO core's interrupt output
    //XGpio_InterruptDisable(GpioPtr, USERIO_CHAN_INPUTS);
	
	//Read the GPIO inputs; each 1 is a currently-asserted input bit
	assertedInputs = XGpio_DiscreteRead(&GPIO_UserIO, USERIO_CHAN_INPUTS) & USERIO_MASK_INPUTS;
	
	//XOR the current active bits with the previously active bits
	newAssertedInputs = (assertedInputs ^ previousAssertedInputs) & assertedInputs;
	previousAssertedInputs = assertedInputs;
	
	//Check whether push buttons or DIP switch triggered the interrupt
	// We assume a user callback per button, and another for the DIP switch
	if(newAssertedInputs & USERIO_MASK_PBC) usr_middlebutton();
	if(newAssertedInputs & USERIO_MASK_PBR) usr_rightbutton();
	if(newAssertedInputs & USERIO_MASK_PBL) usr_leftbutton();
	if(newAssertedInputs & USERIO_MASK_PBU) usr_upbutton();
	if(newAssertedInputs & USERIO_MASK_DIPSW) {
		dipswState = USERIO_MAP_DIPSW(assertedInputs); 
	}
	
	return;
}

///@brief Alternates the bottom two LEDs on the WARP board.
void warpmac_incrementLEDLow(){
	
	
	//Update the global variable we use to track which LED/segments are currently lit
	// The xps_gpio core doesn't allow outputs to be read from code, so we have to track this internally
	LEDHEX_Outputs = (USERIO_MAP_LEDS( (ledStatesLow[ledStatesIndexLow]|ledStatesHigh[ledStatesIndexHigh])) | USERIO_MAP_DISPR(rightHex) | USERIO_MAP_DISPL(leftHex));
	
	
	XGpio_DiscreteSet(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, LEDHEX_Outputs);
	ledStatesIndexLow = (ledStatesIndexLow+1)%2;
}


///@brief Alternates the top two LEDs on the WARP board.
void warpmac_incrementLEDHigh(){
	
	//Update the global variable we use to track which LED/segments are currently lit
	// The xps_gpio core doesn't allow outputs to be read from code, so we have to track this internally
	LEDHEX_Outputs = (USERIO_MAP_LEDS( (ledStatesLow[ledStatesIndexLow]|ledStatesHigh[ledStatesIndexHigh])) | USERIO_MAP_DISPR(rightHex) | USERIO_MAP_DISPL(leftHex));
	
	XGpio_DiscreteSet(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, LEDHEX_Outputs);
	
	ledStatesIndexHigh = (ledStatesIndexHigh+1)%2;
}

///@brief Maps character to the seven segment display
///
///@param x Input character
///@return Corresponding value that can be written to the GPIO connected to the Hex displays
unsigned char sevenSegmentMap(unsigned char x){
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

///@brief Displays the input character on the left hex display
///
///@param x Character to display
void warpmac_leftHex(unsigned char x){
	
	
	leftHex = sevenSegmentMap(x);
	
	//Update the global variable we use to track which LED/segments are currently lit
	// The xps_gpio core doesn't allow outputs to be read from code, so we have to track this internally
	LEDHEX_Outputs = (USERIO_MAP_LEDS( (ledStatesLow[ledStatesIndexLow]|ledStatesHigh[ledStatesIndexHigh])) | USERIO_MAP_DISPR(rightHex) | USERIO_MAP_DISPL(leftHex));
	
	
	XGpio_DiscreteSet(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, LEDHEX_Outputs);
	
	return;
}

///@brief Displays the input character on the right hex display
///
///@param x Character to display
void warpmac_rightHex(unsigned char x){
	
	rightHex = sevenSegmentMap(x);	
	//Update the global variable we use to track which LED/segments are currently lit
	// The xps_gpio core doesn't allow outputs to be read from code, so we have to track this internally
	LEDHEX_Outputs = (USERIO_MAP_LEDS( (ledStatesLow[ledStatesIndexLow]|ledStatesHigh[ledStatesIndexHigh])) | USERIO_MAP_DISPR(rightHex) | USERIO_MAP_DISPL(leftHex));
	XGpio_DiscreteSet(&GPIO_UserIO, USERIO_CHAN_OUTPUTS, LEDHEX_Outputs);
	return;
}

#elif defined WARP_FPGA_BOARD_V2_2
///@brief  Handler for the User I/O.
///
///This is called by the User I/O polling from one of the timers.
///The various user callbacks are executed, depending upon which button was depressed. Additionally,
///the board's dip switches also trigger this handler, though the framework does not currently call user
///code in this event. We assume that dipswitches are currently only used for beginning-of-time
///state assignments.
void userIO_handler(void *InstancePtr){
	
	static unsigned int previousAssertedInputs;
	unsigned int assertedInputs;
	unsigned int newAssertedInputs;
	
	//Read the GPIO inputs; each 1 is a currently-asserted input bit
	assertedInputs = WarpV4_UserIO_PushB(USERIO_BASEADDR) | (WarpV4_UserIO_DipSw(USERIO_BASEADDR) << 4);
	
	//XOR the current active bits with the previously active bits
	newAssertedInputs = (assertedInputs ^ previousAssertedInputs) & assertedInputs;
	previousAssertedInputs = assertedInputs;
	
	//Check whether push buttons or DIP switch triggered the interrupt
	// We assume a user callback per button, and another for the DIP switch
	if(newAssertedInputs & USERIO_MASK_PBC) usr_middlebutton();
	if(newAssertedInputs & USERIO_MASK_PBR) usr_rightbutton();
	if(newAssertedInputs & USERIO_MASK_PBL) usr_leftbutton();
	if(newAssertedInputs & USERIO_MASK_PBU) usr_upbutton();
	if(newAssertedInputs & USERIO_MASK_DIPSW) {
		dipswState = WarpV4_UserIO_DipSw(USERIO_BASEADDR);
	}
	
	return;
}

///@brief Alternates the bottom two LEDs on the WARP board.
void warpmac_incrementLEDLow(){
	
	WarpV4_UserIO_Leds(USERIO_BASEADDR, ledStatesLow[ledStatesIndexLow] | ledStatesHigh[ledStatesIndexHigh]);

	ledStatesIndexLow = (ledStatesIndexLow+1)%2;
}

///@brief Alternates the top two LEDs on the WARP board.
void warpmac_incrementLEDHigh(){
	
	WarpV4_UserIO_Leds(USERIO_BASEADDR, ledStatesLow[ledStatesIndexLow] | ledStatesHigh[ledStatesIndexHigh]);
	
	ledStatesIndexHigh = (ledStatesIndexHigh+1)%2;
}

void warpmac_leftHex(unsigned char x){
	
	WarpV4_UserIO_WriteNumber_LeftHex(USERIO_BASEADDR, x, 0);
	return;
}

void warpmac_middleHex(unsigned char x){
	
	WarpV4_UserIO_WriteNumber_MiddleHex(USERIO_BASEADDR, x, 0);
	return;
}

void warpmac_rightHex(unsigned char x){
	
	WarpV4_UserIO_WriteNumber_RightHex(USERIO_BASEADDR, x, 0);
	return;
}
#endif
//**************************//
// FPGA Board Specific Code //
//***********END************//
