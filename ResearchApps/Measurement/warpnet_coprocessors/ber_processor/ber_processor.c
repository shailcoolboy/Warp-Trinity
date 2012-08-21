#include <assert.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <stdlib.h>
#include <pcap.h>
#include "ber_processor.h"
//#include <CoreFoundation/CoreFoundation.h>
#include <sys/time.h>

//Global variables

//Lookup table of numbers of ones in binary representations of each 8-bit value
const unsigned char ones_in_chars[256] = {0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8};

//PCAP session handle (used by pcap Rx and Tx threads)
pcap_t *pcap_handle;

//Network device for PCAP (en0 = Ethernet; en5 = USB Ethernet)
char* pcap_device;

const char debug = 0;

//Number of WARP nodes
unsigned int numWARPnodes;

//WARPnet structs
warpnetObserveBER berStruct;
warpnetEthernetPktHeader txEthPktHdr;
warpnetControllerGroup groupStruct;
unsigned char txEthPktBuf[MAX_ETHPKTSIZE];
						  
//This "node's" ID (for talking to the warpnet server as if it were a node)
unsigned char myID;
unsigned short berSeq;

int phypkt_seq_nums[MAX_NUMWARPNODES];

unsigned char* pktBufs[MAX_NUMWARPNODES];

//Global sequence number incrememnted every time a packet is sent to any node
unsigned char ethPkt_seqNumTx, ethPkt_seqNumRx;

//Time structs for scheduled node updates
struct timeval currentTime;
struct timezone theTimezone;

void ProcessWARPnodeMessage(u_char *args, const struct pcap_pkthdr *header, const u_char *packet)
{
	//printf("ProcessWARPnodeMessage: Got a WARP node update\n");

	int i;
	int rv;
	
	//Packets from the WARP node must have this sturcture; indicies are bytes:
	// warpnetEthernetPktHeader struct first:
	//	0-5: Source MAC address (last nibble assumed to be nodeID)
	//	6-11: Destination MAC address
	//	12-13: Ethertype = WARPNET_ETHTYPE_NODE2BER
	//	14-15: Number of bytes in full packet, including this header
	//	16: Number of WARPNet structs in packet
	//	17: seqNum (for what?)
	// 18:... Raw wireless header and payload as Tx/Rx by the PHY

	warpnetEthernetPktHeader* ethpkt_hdr;
	unsigned char ethpkt_nodeID;
	unsigned int ethpkt_len;

	phyHeader* phypkt_hdr;
	unsigned short phypkt_seqNum;
	unsigned short phypkt_srcAddr, phypkt_dstAddr;
	unsigned short phypkt_len;
	
	char isPktFromTx;
	char isPktFromRx;
	char alreadyHavePktFromTx;
	char alreadyHavePktFromRx;

	isPktFromRx = 0;
	alreadyHavePktFromTx = 0;
	
	if( (header->len) < (sizeof(warpnetEthernetPktHeader) + sizeof(phyHeader))) {
		printf("ProcessWARPnodeMessage: pcap captured too short a packet! (%d bytes)\n", (header->len));
		return;
	}
	
	//Extract fields from the MAC/PHY header
	phypkt_hdr = (phyHeader*)(packet + sizeof(warpnetEthernetPktHeader));
	phypkt_seqNum = htons(phypkt_hdr->seqNum);
	phypkt_srcAddr = htons(phypkt_hdr->srcAddr);
	phypkt_dstAddr = htons(phypkt_hdr->destAddr);
	phypkt_len = htons(phypkt_hdr->length);

	//Intrepret the received packet's header
	ethpkt_hdr = (warpnetEthernetPktHeader*)packet;
	ethpkt_len = htons(ethpkt_hdr->pktLength);
	ethpkt_nodeID = ((ethpkt_hdr->srcAddr[5]) & 0xF);
	
	
	if( (header->len) < ethpkt_len) {
		printf("ProcessWARPnodeMessage: pcap captured too short a packet! (%d bytes captured, ethPktHdr.len claimed %d)\n", (header->len), ethpkt_len);
		return;
	}

	if( ethpkt_len < (phypkt_len + sizeof(phyHeader))) {
		printf("ProcessWARPnodeMessage: WARP Node Pkt was too short! (%d vs. %d)\n", ethpkt_len, (int)(phypkt_len + sizeof(phyHeader)));
		return;
	}
	
	if((ethpkt_nodeID >= numWARPnodes) | (phypkt_srcAddr > numWARPnodes) | (phypkt_dstAddr > numWARPnodes)) {
		printf("ProcessWARPnodeMessage: invalid nodeID or addr! nodeID=%d, dstAddr=%d, srcAddr=%d\n", ethpkt_nodeID, phypkt_dstAddr, phypkt_srcAddr);
		for(i=0; i<48; i++) {
			printf("%02x ", *((unsigned char *)(packet+i)));
		}
		printf("\n\n");

		return;
	}

	if(debug > 1) {
		printf("Got BER pkt: (PHY: Seq=%d, Src=%d, Dst=%d, Len=%d) (Eth: Len=%d, srcID=%d)\n", \
			   phypkt_seqNum, phypkt_srcAddr, phypkt_dstAddr, phypkt_len, \
			   ethpkt_len, ethpkt_nodeID);
	}
	

	//Copy this packet to the local buffers
	memcpy(pktBufs[ethpkt_nodeID], packet, (header->len));

	//Record this wireless packet's sequence number as the reporting node's most recent
	phypkt_seq_nums[ethpkt_nodeID] = (int)phypkt_seqNum;

	isPktFromTx = ( ethpkt_nodeID == phypkt_srcAddr);
	isPktFromRx = ( ethpkt_nodeID == phypkt_dstAddr);

	alreadyHavePktFromTx = ((int)phypkt_seqNum == phypkt_seq_nums[phypkt_srcAddr]);
	alreadyHavePktFromRx = ((int)phypkt_seqNum == phypkt_seq_nums[phypkt_dstAddr]);

	//Check if we have enough to run a BER calculation
	if( (isPktFromRx && alreadyHavePktFromTx) || (isPktFromTx && alreadyHavePktFromRx))
	{
//		rv = CalculateBER(pktBufs[phypkt_srcAddr]+sizeof(phyHeader)+sizeof(warpnetEthernetPktHeader), pktBufs[phypkt_dstAddr]+sizeof(phyHeader)+sizeof(warpnetEthernetPktHeader), phypkt_len, &berStruct);
		//Ignoring last two bytes; somehow a checksum is leaking into the test, maybe via the TEMAC xmit. I'll track it down later...
		rv = CalculateBER(pktBufs[phypkt_srcAddr]+sizeof(phyHeader)+sizeof(warpnetEthernetPktHeader), pktBufs[phypkt_dstAddr]+sizeof(phyHeader)+sizeof(warpnetEthernetPktHeader), (phypkt_len-2), &berStruct);
			
		if(rv == 0) {
			//BER calculation was successful; update the berStruct and send it to the server
			berSeq++;
			berStruct.sequenceNumber = htons(berSeq);
			berStruct.nodeID_tx = (0xFF & phypkt_srcAddr);
			berStruct.nodeID_rx = (0xFF & phypkt_dstAddr);
			berStruct.mac_seqNum = htons(phypkt_seqNum);
			
			if(debug > 1) printf("BER Results: Seq=%d, TxNode=%d, RxNode=%d, BER: %d / %d = %f\n", phypkt_seqNum, berStruct.nodeID_tx, berStruct.nodeID_rx, berStruct.bits_errors, berStruct.bits_rx, (float)( (float)berStruct.bits_errors / (float)(berStruct.bits_rx)));
			SendStructToServer(&berStruct);
			
			//Invalidate the stored seqNums, to avoid bogus comparisons when sequence numbers wrap and Rx isn't receiving anything
			phypkt_seq_nums[phypkt_dstAddr] = -1;
			phypkt_seq_nums[phypkt_srcAddr] = -1;
		}
		else {
			printf("BER Calculation Failed! (rv=%d)\n", rv);
			return;
		}
	}
	
	return;
}

int CalculateBER(void *bufA, void *bufB, int length, warpnetObserveBER *berResult)
{
	int i, totalErrors;
	unsigned char byteA, byteB, byteComp;
	
	totalErrors = 0;
	
	if(debug > 1) printf("CalculateBER: errors in bytes: ");
	for(i = 0; i<length; i++)
	{
		byteA = *( (unsigned char *)(bufA + i));
		byteB = *( (unsigned char *)(bufB + i));

		byteComp = (byteA ^ byteB);

		totalErrors += ones_in_chars[byteComp];
		if(debug > 1) if(byteComp > 0) printf("%d ", i);
	}
	if(debug > 1) if(totalErrors == 0) printf("none.");
	if(debug > 1) printf("\n");
	
	//Endian-swap the values before storing them in the struct (saves having to do it before sending the struct to the server)
	berResult->bits_rx = htonl(length*8);
	berResult->bits_errors = htonl(totalErrors);
	
	return 0;
}

void SendStructToServer(void *theStruct) {

	unsigned char structID;
	warpnetObserveBER* aBerStruct;

	int structLen = 0;
	int rv;
	
	structID = *( (unsigned char *)theStruct);
	void* txPktPtr;
	
	switch(structID)
	{
		case STRUCTID_OBSERVE_BER:
			aBerStruct = (warpnetObserveBER *)theStruct;
			txEthPktHdr.ethType = WARPNET_ETHTYPE_NODE2SVR;
			txEthPktHdr.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetControllerGroup) + sizeof(warpnetObserveBER);
			txEthPktHdr.numStructs = 1;
			txEthPktHdr.seqNum = (unsigned char)((aBerStruct->sequenceNumber)&0xFF);
			structLen = sizeof(warpnetObserveBER);
			break;
			
		default:
			printf("SendStructToServer: Unknown structID! (%d)\n", structID);
			break;
	}

	if(structLen > 0)
	{
		txPktPtr = &txEthPktBuf;
		memcpy(txPktPtr, &txEthPktHdr, sizeof(warpnetEthernetPktHeader));
		memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader), &groupStruct, sizeof(warpnetControllerGroup));
		memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader)+sizeof(warpnetControllerGroup), theStruct, structLen);

		rv = pcap_inject(pcap_handle, (void *)txPktPtr, (txEthPktHdr.pktLength) );

		if(rv < 0){
			pcap_perror(pcap_handle, "");
			printf("Error on pcap_inject!\n");
		}
	}
		
	return;
}

//This code is based on the excellent libpcap examples at http://www.tcpdump.org/pcap.htm
int SetupPCAP()
{
	char errbuf[PCAP_ERRBUF_SIZE];	// Error string
	struct bpf_program fp;		// The compiled filter
	char filter_exp[19];
	bpf_u_int32 mask;		// Our netmask
	bpf_u_int32 net;		// Our IP
	
	fprintf(stdout, "Attaching to device %s\n", pcap_device);

	sprintf((char *)&filter_exp, "ether proto 0x%04x", WARPNET_ETHTYPE_NODE2BER);
	
	//Lookup properties for the network device
	// pcap_device is a global variable, defined either by default or as a cmd line argument
	if (pcap_lookupnet(pcap_device, &net, &mask, errbuf) == -1)
	{
		fprintf(stderr, "PCAP: Couldn't get netmask for device %s: %s\n", pcap_device, errbuf);
		net = 0;
		mask = 0;
	}

	// Open the session in promiscuous mode with a big enough buffer
	pcap_handle = pcap_open_live(pcap_device, 65535, 1, 100, errbuf);
	
	if (pcap_handle == NULL)
	{
		fprintf(stderr, "PCAP: Couldn't open device %s: %s\n", pcap_device, errbuf);
		return -2;
	}
	
	// Compile and apply the filter
	if (pcap_compile(pcap_handle, &fp, filter_exp, 0, net) == -1)
	{
		fprintf(stderr, "PCAP: Couldn't parse filter %s: %s\n", filter_exp, pcap_geterr(pcap_handle));
		return -2;
	}
	
	if (pcap_setfilter(pcap_handle, &fp) == -1)
	{
		fprintf(stderr, "PCAP: Couldn't install filter %s: %s\n", filter_exp, pcap_geterr(pcap_handle));
		return -2;
	}
	
	fprintf(stdout, "Applied filter '%s'\n", filter_exp);

	//Loop forever on received Ethernet frames
	pcap_loop(pcap_handle, -1, (pcap_handler)ProcessWARPnodeMessage, NULL);

	return 0;
}

int main(int argc, char *argv[])
{
	printf("Starting WARPnet BER Processor\n");

	int i;
	
	//Default number of WARP nodes; can be overridden on the command line
	numWARPnodes = 2;

	//Default Ethernet interface (enX on OS X/BSD, probably ethX on Linux)
	// User running this app must have read/write access for /dev/bpf* (OS X/BSD) or raw Ethernet (Linux)
	pcap_device = "en0";

	//Use a big node ID, to avoid any conflict with actual WARP node IDs
	myID = 99;
	
	berSeq = 0;
	berStruct.structID = STRUCTID_OBSERVE_BER;
	berStruct.nodeID = myID;

	groupStruct.controllerID = 0;
	groupStruct.controllerGrp = 0;
	groupStruct.access = 1;
	groupStruct.reserved0 = 0;
	
	txEthPktHdr.ethType = WARPNET_ETHTYPE_NODE2SVR;
	txEthPktHdr.srcAddr[0]=0x00;
	txEthPktHdr.srcAddr[1]=0x50;
	txEthPktHdr.srcAddr[2]=0xC2;
	txEthPktHdr.srcAddr[3]=0x63;
	txEthPktHdr.srcAddr[4]=0x3F;
	txEthPktHdr.srcAddr[5]=0x80+myID;

	//Replace with MAC address of your WARPnet server!
	txEthPktHdr.dstAddr[0]=0xff;
	txEthPktHdr.dstAddr[1]=0xff;
	txEthPktHdr.dstAddr[2]=0xff;
	txEthPktHdr.dstAddr[3]=0xff;
	txEthPktHdr.dstAddr[4]=0xff;
	txEthPktHdr.dstAddr[5]=0xff;

	for(i=0; i<numWARPnodes; i++)
	{
		pktBufs[i] = (unsigned char *)malloc((size_t)MAX_ETHPKTSIZE);
	}
	
	//Sets up the PCAP capture interface
	// This function blocks, processing Ethernet packets forever
	SetupPCAP();

	return 0;
}
