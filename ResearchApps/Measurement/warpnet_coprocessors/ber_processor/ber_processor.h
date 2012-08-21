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

///Structure contains PHY header
typedef struct {
	unsigned char fullRate;
	unsigned char codeRate;
	unsigned short int length;
	unsigned short int srcAddr;
	unsigned short int destAddr;
	unsigned short int relAddr;
	unsigned char pktType;
	unsigned char reserved1;
	unsigned short seqNum;
	unsigned char reserved2;
	unsigned char reserved4;
	unsigned char reserved5;
	unsigned char reserved6;
	unsigned char reserved7;
	unsigned char reserved8;
	unsigned char reserved9;
	unsigned short int checksum;
	unsigned char headerTail;
} phyHeader;

typedef struct {
	unsigned char structID;
	unsigned char nodeID;
	unsigned short sequenceNumber;
	unsigned char nodeID_tx;
	unsigned char nodeID_rx;
	unsigned short mac_seqNum;
	unsigned int bits_rx;
	unsigned int bits_errors;
} warpnetObserveBER;

#define STRUCTID_OBSERVE_BER				0x24
#define STRUCTID_OBSERVE_BER_REQ			0x25

#define WARPNET_ETHTYPE_NODE2SVR 0x9191
#define WARPNET_ETHTYPE_NODE2BER 0x9494

//Compile-time limits on numbers of nodes and controllers
#define MAX_NUMWARPNODES 4
#define MAX_NODETXTRIES 32
#define NODETX_TRYDELAY 65000

//Maximum size of network buffers
#define MAX_ETHPKTSIZE 1550

void ProcessWARPnodeMessage(u_char *args, const struct pcap_pkthdr *header, const u_char *packet);
int CalculateBER(void *bufA, void *bufB, int length, warpnetObserveBER *berResult);
void SendStructToServer(void *theStruct);
int SetupPCAP();
