/*! \file warpnet.h
\brief Header file for the WARPMAC Framework.

@version 16.00
@author Chris Hunter and Patrick Murphy

This header file contains the macros, function prototypes, and typedefs required for WARPMAC.
*/

#ifndef WARPNET_H
#define WARPNET_H

#define ARPREPEAT 5
#define WARPNET_ETHTYPE_SVR2NODE		0x9090
#define WARPNET_ETHTYPE_NODE2SVR		0x9191
#define WARPNET_ETHTYPE_ARBTRAFFIC		0x9292
#define WARPNET_ETHTYPE_NODE2COPROC		0x9393
#define WARPNET_ETHTYPE_NODE2BER		0x9494

//Index of OFDM PHY pkt buffer used for sending WARPnet Ethernet packets
#define WARPNET_SVR2NODE_PKTBUFFINDEX	0

#define WARPNET_NODE2COPROC_PKTBUFFINDEX	30

#define WARPNET_NODE2SVR_PKTBUFFINDEX	31



#define TXPACKET			0xFF


#define STRUCTID_CONTROL 					0x13
#define STRUCTID_CONTROL_ACK				0x14
#define STRUCTID_OBSERVE_REQUEST_NORELAY	0x15
#define STRUCTID_OBSERVE_REQUEST_RELAY		0x19
#define	STRUCTID_OBSERVE					0x16
#define STRUCTID_COMMAND					0x17	
#define	STRUCTID_COMMAND_ACK				0x18
#define STRUCTID_RTOBSERVE_REQUEST			0x1A
#define STRUCTID_RTOBSERVE					0x1B
#define STRUCTID_CONCAT						0x1C
#define STRUCTID_RXPHYDUMP					0x1E
/*******Patrick's**********/
#define STRUCTID_CFO						0x20
#define STRUCTID_PHYCTRL					0x22
#define STRUCTID_PHYCTRL_ACK				0x23
#define STRUCTID_OBSERVE_BER				0x24
#define STRUCTID_OBSERVE_BER_REQ			0x25
#define STRUCTID_OBSERVE_PER				0x26
#define STRUCTID_OBSERVE_PER_REQ			0x27
#define STRUCTID_OBSERVE_COOPBER			0x28
#define STRUCTID_OBSERVE_COOPBER_REQ		0x29
#define STRUCTID_RAWPKT						0x30

#define STRUCTID_OBSERVE_PER_MULTIRATE		0x32
#define STRUCTID_OBSERVE_PER_MULTIRATE_REQ	0x33

#define STRUCTID_RXSTATUS					0x34
#define STRUCTID_RXSTATUS_REQ				0x35

/*************************/

#define COMMANDID_STARTTRIAL			0x40
#define COMMANDID_STOPTRIAL				0x41
#define COMMANDID_RELAYSTATE			0x42
	#define COMMANDPARAM_OFF			0x43
	#define COMMANDPARAM_AF				0x44
	#define COMMANDPARAM_DF				0x45
	#define COMMANDPARAM_ALTERNATING	0x49
#define COMMANDID_PKTGEN				0x46
	#define COMMANDPARAM_ENABLE			0x47
	#define COMMANDPARAM_DISABLE		0x48
#define COMMANDID_RESET_PER				0x50
#define COMMANDID_ENABLE_BER_TESTING    0x51
#define COMMANDID_DISABLE_BER_TESTING    0x52

typedef struct {
	unsigned char controllerID;
	unsigned char controllerGrp;
	unsigned char access;
	unsigned char reserved0;
} warpnetControllerGroup;

typedef struct {
	unsigned char macAddr[6];
} Netconfig;

//Struct representing raw Ethernet header + packet contents
typedef struct {
	//Standard 14-byte Ethernet header (dest/src MAC addresses + EtherType)
	unsigned char dstAddr[6];
	unsigned char srcAddr[6];
	unsigned short ethType;
	//total number of bytes in pkt, including this header
	unsigned short pktLength;
	//number of warpnet structs that follow
	unsigned char numStructs;
	//Sequence number to match packets to ACKs
	unsigned char seqNum;
} warpnetEthernetPktHeader;

typedef struct {
	char structID;
	char nodeID;
	short cmdID;
} warpnetAck;

typedef struct {
	char structID;
	char nodeID;
	char txPower;
	char channel;
	char modOrderHeader;
	char modOrderPayload;
	char codeRatePayload;
	char reserved;
	int pktGen_period;
	int pktGen_length;
} warpnetControl;

typedef struct {
	char structID;
	char nodeID;
	char cmdID;
	char cmdParam;
} warpnetCommand;

typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned short sourceNode;
	unsigned int numDataTx;
	unsigned int numNACKTx;
	unsigned int numDataRx;
	unsigned int numNACKRx;
	unsigned int numBadHeaderRx;
	unsigned int sumGains;
	unsigned int sumRSSI;
	unsigned int sumPacketCountRx;
	unsigned int trialDuration;
	unsigned int timeStamp;
} warpnetObserve;

typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned short sequenceNumber;
	unsigned char pktType;
	unsigned char srcNode;
	unsigned char destNode;
	unsigned char relNode;
	unsigned char state;
	unsigned char reserved;
	unsigned short rssi;
	unsigned short gain;
	unsigned short timeStampHigh;
	unsigned int timeStampLow;
} warpnetRTObserve;


/********* Patrick's structs *************/
typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned short sequenceNumber;
	unsigned int cfo_c;
	unsigned int cfo_p;
	unsigned int cfo_b;
	unsigned int txCFO;
	unsigned int pktStatus;
} warpnetCFO;

typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned short param0;
	unsigned int param1;
	unsigned int param2;
	unsigned int param3;
	unsigned int param4;
	unsigned int param5;
	unsigned int param6;
	unsigned int param7;
	unsigned int param8;
	unsigned int param9;
} warpnetPHYctrl;

typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned short sequenceNumber;
	
	unsigned char nodeID_tx;
	unsigned char nodeID_rx;
	unsigned short mac_seqNum;
	
	unsigned char mac_pktType;
	unsigned char reserved0;
	unsigned char reserved1;
	unsigned char reserved2;
	
	unsigned int bits_rx;
	unsigned int bits_errors;
} warpnetObserveBER;

typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned char reqNum;
	unsigned char reqType;
	unsigned int numPkts_tx;
	unsigned int numPkts_rx_good;
	unsigned int numPkts_rx_goodHdrBadPyld;
	unsigned int numPkts_rx_badHdr;
} warpnetObservePER;

typedef struct {
	char structID;
	char nodeID;
	char reqNum;
	char reqType;
} warpnetPERreq;

typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned short numBytes;
} warpnetRawPkt;

typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned short seqNum;
	unsigned char pktType;
	unsigned char rxStatus;
	unsigned char includedData; //bitwise OR of RXPHYDUMP_INCLUDE_*
	unsigned char reserved0;
	unsigned short rssi;
	unsigned short rxGains;
	unsigned int cfoEst_coarse;
	unsigned int cfoEst_pilots;
} warpnetRxPHYdump;

//MS DEMO
typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned char reqNum;
	unsigned char reqType;
	unsigned int numPkts_tx[4];
	unsigned int numPkts_rx_good[4];
	unsigned int numPkts_rx_goodHdrBadPyld[4];
	unsigned int numPkts_rx_badHdr;
} warpnetObservePER_multiRate;

typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned char rxStatus;
	unsigned char reserved0;
	unsigned short rssi;
	unsigned short rxGains;
} warpnetRxStatus;
/********* END Patrick's structs *************/

typedef struct {
	char structID;
	char nodeID;
	short cmdID;//NOTE: We are going to overload cmdID to be the "source" packet
} warpnetRequest;

void warpnet_setMacAddr(void* macAddr);
void warpnet_sendGratuitousArp(char myID);



#endif//ifndef WARPNET_H
