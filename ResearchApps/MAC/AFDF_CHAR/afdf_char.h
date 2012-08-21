/*! \file afdf_char.h
 \brief Top-level "MAC" for testing PHY performance
 
 @version 15.22
 @author Patrick Murphy
 
 Doesn't actually implement a MAC, and traffic only flows one direction. This is used for characterizing the PHY.
*/

#define RXPHYDUMP_INCLUDE_EVMPERSC		0x1
#define RXPHYDUMP_INCLUDE_EVMPERSYM		0x2
#define RXPHYDUMP_INCLUDE_CHANESTAA		0x4
#define RXPHYDUMP_INCLUDE_CHANESTBA		0x8

#define RXPHYDUMP_SIZE_EVMPERSC			256 //(4*64)
#define RXPHYDUMP_SIZE_CHANEST			256 //(4*64)

//EVMPERSYM should be 4*256 bytes; the PHY has storage for 256 OFDM symbol's worth of EVM
// It's set to 128 here so EVMPERSYM+EVMPERSC+CHANESTAA+CHANESTBA can all fit in one MTU
//#define RXPHYDUMP_SIZE_EVMPERSYM		(4*256)
#define RXPHYDUMP_SIZE_EVMPERSYM		512 //(4*128)

int phyRx_goodHeader_callback(Macframe* packet);
void phyRx_badHeader_callback();
void dataFromNetworkLayer_callback(Xuint32 length, char* payload);
void uartRecv_callback(unsigned char uartByte);
void mgmtFromNetworkLayer_callback(Xuint32 length, char* payload);

void processPHYControl(warpnetPHYctrl* phyCtrlStruct);
void processControl(warpnetControl* controlStruct);
void processCommand(warpnetCommand* commandStruct);
void Send_RxPHYdump(int sendEVMperSC, int sendEVMperSym, int sendChanEstAA, int sendChanEstBA, unsigned char pktType, unsigned short seqNum);
void setupNodeBehaviors();
void setDACinterp(unsigned int mode, unsigned int radios);

int main();
