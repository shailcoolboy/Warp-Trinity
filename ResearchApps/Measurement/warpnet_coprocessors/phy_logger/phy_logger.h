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
	unsigned char controllerID;
	unsigned char controllerGrp;
	unsigned char access;
	unsigned char reserved0;
} warpnetControllerGroup;

typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned short numStructs;
	unsigned int trialIndex;
	unsigned char innerStructs[1500];
} warpnetConcatStruct;

typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned short sequenceNumber;
	unsigned char pktType;
	unsigned char srcNode;
	unsigned char destNode;
	unsigned char relNode;
	unsigned char phystatus;
	unsigned char macstate;
	unsigned short rssi;
	unsigned short gain;
	unsigned short timeStampHigh;
	unsigned int timeStampLow;
	unsigned int packetDetCount;
} warpnetRTObserve;

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

typedef struct {
	char structID;
	char nodeID;
	short cmdID;
} warpnetAck;

typedef struct {
	char structID;
	char nodeID;
	char cmdID;
	char cmdParam;
} warpnetCommand;

typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	
	unsigned short fileSuffix;
	
	unsigned int param0;
	unsigned int param1;
	unsigned int param2;
	unsigned int param3;
} warpnetLogParams;	

#define STRUCTID_OBSERVE_BER				0x24
#define STRUCTID_OBSERVE_BER_REQ			0x25

#define STRUCTID_COMMAND					0x17	
#define	STRUCTID_COMMAND_ACK				0x18

#define STRUCTID_RTOBSERVE		0x1B
#define STRUCTID_CONCAT			0x1C
#define STRUCTID_RXPHYDUMP		0x1E

#define STRUCTID_LOGPARAMS				0x32
#define STRUCTID_LOGPARAMS_ACK			0x33

#define WARPNET_ETHTYPE_SVR2NODE		0x9090
#define WARPNET_ETHTYPE_NODE2SVR		0x9191
#define WARPNET_ETHTYPE_NODE2COPROC		0x9393
#define WARPNET_ETHTYPE_NODE2BER		0x9494

//Rx PHY Dump magic numbers
#define RXPHYDUMP_INCLUDE_EVMPERSC		0x1
#define RXPHYDUMP_INCLUDE_EVMPERSYM		0x2
#define RXPHYDUMP_INCLUDE_CHANESTAA		0x4
#define RXPHYDUMP_INCLUDE_CHANESTBA		0x8

#define RXPHYDUMP_SIZE_EVMPERSC			(4*64)
#define RXPHYDUMP_SIZE_CHANEST			(4*64)

//EVMPERSYM should be 4*256 bytes; the PHY has storage for 256 OFDM symbol's worth of EVM
// It's set to 128 here so EVMPERSYM+EVMPERSC+CHANESTAA+CHANESTBA can all fit in one MTU
//#define RXPHYDUMP_SIZE_EVMPERSYM		(4*256)
#define RXPHYDUMP_SIZE_EVMPERSYM		(4*128)

//Compile-time limits on numbers of nodes and controllers
#define MAX_NUMWARPNODES 4

//Maximum size of network buffers
#define MAX_ETHPKTSIZE 1550

int LogRxPHYDump(warpnetRxPHYdump* ptr_rxPHYdumpStruct, FILE* logFile);
int LogRTobserve(warpnetRTObserve* ptr_rtObserve, unsigned int trialIndex, FILE* logFile);
void SendStructToServer(warpnetControllerGroup* theGroupStruct, void *theStruct);
void ProcessServerMessage(u_char *args, const struct pcap_pkthdr *header, const u_char *packet);
void pcap_pktRx_handler(u_char *args, const struct pcap_pkthdr *header, const u_char *packet);
void ProcessWARPnodeMessage(u_char *args, const struct pcap_pkthdr *header, const u_char *packet);
int SetupLogFiles();
int SetupPCAP();
