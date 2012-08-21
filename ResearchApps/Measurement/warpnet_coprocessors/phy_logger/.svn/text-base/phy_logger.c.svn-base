#include <assert.h>
#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <pcap.h>
#include "phy_logger.h"
#include <sys/time.h>
#include <netinet/in.h>

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

unsigned int log_param0;
unsigned int log_param1;
unsigned int log_param2;
unsigned int log_param3;
unsigned short berLog_fileSuffix;

//WARPnet structs
warpnetEthernetPktHeader txEthPktHdr;
warpnetControllerGroup groupStruct;

unsigned char txEthPktBuf[MAX_ETHPKTSIZE];
						  
//This "node's" ID (for talking to the warpnet server as if it were a node)
unsigned char myID;

//Array of log file handles, one per node
FILE* log_fds[MAX_NUMWARPNODES];

//Time structs for scheduled node updates
struct timeval currentTime;
struct timezone theTimezone;

void pcap_pktRx_handler(u_char *args, const struct pcap_pkthdr *header, const u_char *packet) {
	
	warpnetEthernetPktHeader* ethPktHdr;
	
	ethPktHdr = (warpnetEthernetPktHeader*)packet;
	
	if(ethPktHdr->ethType == WARPNET_ETHTYPE_SVR2NODE)
		ProcessServerMessage(args, header, packet);
	else if(ethPktHdr->ethType == WARPNET_ETHTYPE_NODE2COPROC)
		ProcessWARPnodeMessage(args, header, packet);
	else
		printf("pcap_pktRx_handler: Unknown ethertype: 0x%04x\n", ethPktHdr->ethType);
	
	return;
}

void ProcessServerMessage(u_char *args, const struct pcap_pkthdr *header, const u_char *packet) {
	
	void* rxPktPtr;
	
	int i, numRxStructs;
	unsigned char rxSeqNum, theStructID;
	
	//Typed pointers for interpreting received structs
	warpnetEthernetPktHeader* pktHeader;
	warpnetControllerGroup* groupStructCopy;
	warpnetCommand* commandStruct;
	warpnetLogParams* logParams;
	
	unsigned short berLog_fileSuffix_new;
	
	//Local ACK struct, used to send responses to the server
	warpnetAck ackStruct;
	
	//Interpret the received bytes as an Ethernet packet
	pktHeader = (warpnetEthernetPktHeader*)packet;
	
	if((pktHeader->ethType) != WARPNET_ETHTYPE_SVR2NODE) {
		//Should never happen; all management packets are type WARPNET_ETHTYPE_SVR2NODE
		return;
	}
	
	numRxStructs = pktHeader->numStructs;
	rxSeqNum = pktHeader->seqNum;
	
	//Initialize the rx pointer to the first byte past the Ethernet header
	rxPktPtr = (void*)(packet + sizeof(warpnetEthernetPktHeader));
	
	//Iterate over each pair of warpnetControllerGroup / otherStruct in the server message
	for(i=0; i<numRxStructs; i++) {
		
		if( ( ((int)rxPktPtr) - ((int)packet) ) >= header->len) {
			printf("Error! Mgmt pktLength too short for numStructs\n");
			return;
		}
		
		//Alternate structs (starting with the first) are always warpnetControllerGroup
		groupStructCopy = (warpnetControllerGroup*)rxPktPtr;
		rxPktPtr += sizeof(warpnetControllerGroup);
		
		//Extract the first byte of the actual struct and interpret as the structID
		theStructID = *( (unsigned char *)rxPktPtr );
		//xil_printf("Mgmt Pkt: StructID=0x%x\r\n", theStructID);
		
		switch(theStructID)
		{
			case STRUCTID_COMMAND:
				commandStruct = (warpnetCommand*)rxPktPtr;
				rxPktPtr += sizeof(warpnetCommand);
				
				if((commandStruct->nodeID) == myID) {
					
					//Send an ACK struct back to the server
					ackStruct.structID = STRUCTID_COMMAND_ACK;
					ackStruct.nodeID = myID;
					ackStruct.cmdID = commandStruct->cmdID;
					
					SendStructToServer(groupStructCopy, &ackStruct);
					
					//Process the received struct
					//processCommand(commandStruct);
				}
				break;
			case STRUCTID_LOGPARAMS:
				logParams = (warpnetLogParams*)rxPktPtr;
				rxPktPtr += sizeof(warpnetLogParams);
				
				if((logParams->nodeID) == myID) {

					berLog_fileSuffix_new = htons(logParams->fileSuffix); //Endian swap, since it's used internally, not just written to the file

					log_param0 = logParams->param0;
					log_param1 = logParams->param1;
					log_param2 = logParams->param2;
					log_param3 = logParams->param3;
					
					if(berLog_fileSuffix_new != berLog_fileSuffix) {
						berLog_fileSuffix = berLog_fileSuffix_new;
						SetupLogFiles();
					}
					
					if(debug > 1) printf("Got LOGPARAMS: 0=%d, 1=%d, 2=%d, 3=%d\n", htonl(log_param0), htonl(log_param1), htonl(log_param2), htonl(log_param3));
					
					//Send an ACK struct back to the server
					ackStruct.structID = STRUCTID_LOGPARAMS_ACK;
					ackStruct.nodeID = myID;
					ackStruct.cmdID = 0;
					
					SendStructToServer(groupStructCopy, &ackStruct);
				}
				break;
				
			default:
				//Unrecognized structID; do nothing
				//printf("Unknown structID: 0x%x\n", theStructID);
				break;
		}//END switch(theStructID)
		
		
	}//END for(0...numStructs-1)
	
	return;
}

void ProcessWARPnodeMessage(u_char *args, const struct pcap_pkthdr *header, const u_char *packet)
{
	//printf("ProcessWARPnodeMessage: Got a WARP node update\n");

	//Packets from the WARP node must have this sturcture; indicies are bytes:
	// warpnetEthernetPktHeader struct first:
	//	0-5: Source MAC address (last nibble assumed to be nodeID)
	//	6-11: Destination MAC address
	//	12-13: Ethertype = WARPNET_ETHTYPE_NODE2BER
	//	14-15: Number of bytes in full packet, including this header
	//	16: Number of WARPNet structs in packet
	//	17: seqNum (for what?)
	// 18:... beginning of warpnet structs

	void* rxPktPtr;
	
	int i, j, numRxStructs;
	unsigned char theStructID;

	unsigned char inner_structID;
	unsigned short inner_numStructs;
	unsigned int concat_trialIndex;
	
	//Typed pointers for interpreting received structs
	warpnetEthernetPktHeader* pktHeader;
	warpnetConcatStruct* ptr_concatStruct;
	warpnetRTObserve* ptr_rtObserve;
	warpnetCommand* ptr_commandStruct;
	warpnetRxPHYdump* ptr_rxPHYdumpStruct;
	
	unsigned char ethpkt_nodeID;
	unsigned int ethpkt_len;
	
	unsigned short tmp_relNode;
	
	if( (header->len) < (sizeof(warpnetEthernetPktHeader))) {
		printf("ProcessWARPnodeMessage: pcap captured too short a packet! (%d bytes)\n", (header->len));
		return;
	}
	
	//Intrepret the received packet's header
	pktHeader = (warpnetEthernetPktHeader*)packet;
	ethpkt_len = htons(pktHeader->pktLength);
	ethpkt_nodeID = ((pktHeader->srcAddr[5]) & 0xF);
	
	//Sanity-check the received Ethernet header
	if( (header->len) < ethpkt_len) {
		printf("ProcessWARPnodeMessage: pcap captured too short a packet! (%d bytes captured, ethPktHdr.len claimed %d)\n", (header->len), ethpkt_len);
		return;
	}

	if((ethpkt_nodeID >= numWARPnodes)) {
		printf("ProcessWARPnodeMessage: invalid nodeID! nodeID=%d\n", ethpkt_nodeID);
		return;
	}

	if((pktHeader->ethType) != WARPNET_ETHTYPE_NODE2COPROC) {
		//Should never happen; pcap should only accept COPROC packets
		return;
	}
	
	numRxStructs = pktHeader->numStructs;

	//Initialize the rx pointer to the first byte past the Ethernet header
	rxPktPtr = (void*)(packet + sizeof(warpnetEthernetPktHeader));
	
	//Iterate over each pair of warpnetControllerGroup / otherStruct in the server message
	for(i=0; i<numRxStructs; i++) {
		
		if( ( ((int)rxPktPtr) - ((int)packet) ) >= (header->len)) {
			printf("Error! pktLength too short for numStructs\r\n");
			return;
		}
		
		//Extract the first byte of the actual struct and interpret as the structID
		theStructID = *( (unsigned char *)rxPktPtr );
		
		switch(theStructID)
		{
			case STRUCTID_COMMAND:
				ptr_commandStruct = (warpnetCommand*)rxPktPtr;
				rxPktPtr += sizeof(warpnetCommand);
				
				if((ptr_commandStruct->nodeID) == myID) {
					//FIXME: do something with the commandStruct
				}
				break;
			case STRUCTID_RXPHYDUMP:
				ptr_rxPHYdumpStruct = (warpnetRxPHYdump*)rxPktPtr;
				rxPktPtr += sizeof(warpnetRxPHYdump);
				
				if( (ptr_rxPHYdumpStruct->nodeID) < numWARPnodes) {
					LogRxPHYDump(ptr_rxPHYdumpStruct, log_fds[(ptr_rxPHYdumpStruct->nodeID)]);
				}
				
				break;
			case STRUCTID_CONCAT:
				ptr_concatStruct = (warpnetConcatStruct*)rxPktPtr;
				concat_trialIndex = htonl(ptr_concatStruct->trialIndex);
				inner_numStructs = htons(ptr_concatStruct->numStructs);

				rxPktPtr = &(ptr_concatStruct->innerStructs);

				if(debug > 1) printf("Got ConcatStruct with %d inner structs, trial index %d\n", inner_numStructs, concat_trialIndex);

				for(j=0; j<inner_numStructs; j++) {
					inner_structID = *( (unsigned char*)rxPktPtr);

					if(inner_structID == STRUCTID_RTOBSERVE) {
						ptr_rtObserve = (warpnetRTObserve*)rxPktPtr;
						
						tmp_relNode = (ptr_rtObserve->relNode);
						
						if(log_fds[ethpkt_nodeID] != NULL) {
							LogRTobserve(ptr_rtObserve, concat_trialIndex, log_fds[ethpkt_nodeID]);
						}
						else {
							printf("Error! File closed for node %d\n", ethpkt_nodeID);
							return;
						}
						rxPktPtr += sizeof(warpnetRTObserve);
					}
					else {
						printf("\tUnknown inner_structID: 0x%x\n", inner_structID);
						break;
					}
				}//for concatStruct.numStructs
				
				fflush(log_fds[ethpkt_nodeID]);
				break;//case STRUCTID_CONCAT:
		}
	}//for ethPkt.numStructs
	
	return;
}

void SendStructToServer(warpnetControllerGroup* theGroupStruct, void *theStruct) {
	
	unsigned char structID;
	void* structPtr;
	
	int structLen = 0;
	int rv;
	
	structPtr = theStruct;
	
	structID = *( (unsigned char *)theStruct);
	void* txPktPtr;
	
	switch(structID)
	{
		case STRUCTID_LOGPARAMS_ACK:
			structLen = sizeof(warpnetAck);
			structPtr = theStruct;
			break;
			
		default:
			printf("SendStructToServer: Unknown structID! (0x%x)\n", structID);
			break;
	}
	
	if(structLen > 0)
	{
		txEthPktHdr.ethType = WARPNET_ETHTYPE_NODE2SVR;
		txEthPktHdr.pktLength = sizeof(warpnetEthernetPktHeader) + sizeof(warpnetControllerGroup) + structLen;
		txEthPktHdr.numStructs = 1;
		txEthPktHdr.seqNum = 0;
		
		txPktPtr = &txEthPktBuf;
		memcpy(txPktPtr, &txEthPktHdr, sizeof(warpnetEthernetPktHeader));
		memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader), theGroupStruct, sizeof(warpnetControllerGroup));
		memcpy(txPktPtr+sizeof(warpnetEthernetPktHeader)+sizeof(warpnetControllerGroup), structPtr, structLen);
		
		rv = pcap_inject(pcap_handle, (void *)txPktPtr, (txEthPktHdr.pktLength) );
		
		if(rv < 0){
			pcap_perror(pcap_handle, "");
			printf("Error on pcap_inject!\n");
		}
	}
	
	return;
}

int LogRxPHYDump(warpnetRxPHYdump* ptr_rxPHYdumpStruct, FILE* logFile) {

	int writeLen, rv;
	
	//Write the server-provided params first
	rv = fwrite((void *)&log_param0, sizeof(unsigned int), 1, logFile); if(rv<1) {printf("Error writing log! (0; write %d)\n", rv); return -1;}
	rv = fwrite((void *)&log_param1, sizeof(unsigned int), 1, logFile); if(rv<1) {printf("Error writing log! (1; write %d)\n", rv); return -1;}
	rv = fwrite((void *)&log_param2, sizeof(unsigned int), 1, logFile); if(rv<1) {printf("Error writing log! (2; write %d)\n", rv); return -1;}
	rv = fwrite((void *)&log_param3, sizeof(unsigned int), 1, logFile); if(rv<1) {printf("Error writing log! (3; write %d)\n", rv); return -1;}
	
	writeLen = sizeof(warpnetRxPHYdump);
	
	if( (ptr_rxPHYdumpStruct->includedData) & RXPHYDUMP_INCLUDE_EVMPERSC) {
		writeLen += RXPHYDUMP_SIZE_EVMPERSC;
	}
	if( (ptr_rxPHYdumpStruct->includedData) & RXPHYDUMP_INCLUDE_EVMPERSYM) {
		writeLen += RXPHYDUMP_SIZE_EVMPERSYM;
	}
	if( (ptr_rxPHYdumpStruct->includedData) & RXPHYDUMP_INCLUDE_CHANESTAA) {
		writeLen += RXPHYDUMP_SIZE_CHANEST;
	}
	if( (ptr_rxPHYdumpStruct->includedData) & RXPHYDUMP_INCLUDE_CHANESTBA) {
		writeLen += RXPHYDUMP_SIZE_CHANEST;
	}

	rv = fwrite((void *)ptr_rxPHYdumpStruct, sizeof(char), writeLen, logFile);
	if(rv != writeLen) {
		printf("LogRxPHYDump: Error writing log file; tried to write %d bytes; fwrite returned %d\n", writeLen, rv);
		return -1;
	}

	fflush(logFile);
	return 0;
}

int LogRTobserve(warpnetRTObserve* ptr_rtObserve, unsigned int trialIndex, FILE* logFile) {
	
	//trialIndex, sequenceNumber, pktType, srcNode, dstNode, relayNode, phystatus, macstate, RSSI, gain, local timestamp High, local timestamp Low, numPacketDet
	fprintf(logFile, "%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u\r\n",\
			trialIndex, \
			htons(ptr_rtObserve->sequenceNumber), \
			(ptr_rtObserve->srcNode), \
			(ptr_rtObserve->destNode), \
			(ptr_rtObserve->relNode), \
			(ptr_rtObserve->pktType), \
			(ptr_rtObserve->phystatus), \
			(ptr_rtObserve->macstate), \
			htons(ptr_rtObserve->rssi), \
			htons(ptr_rtObserve->gain), \
			htons(ptr_rtObserve->timeStampHigh), \
			htonl(ptr_rtObserve->timeStampLow), \
			htonl(ptr_rtObserve->packetDetCount) \
			);
	return 0;
}

//This code is based on the excellent libpcap examples at http://www.tcpdump.org/pcap.htm
int SetupPCAP()
{
	char errbuf[PCAP_ERRBUF_SIZE];	// Error string
	struct bpf_program fp;		// The compiled filter
//	char filter_exp[19];
	char filter_exp[43];
	bpf_u_int32 mask;		// Our netmask
	bpf_u_int32 net;		// Our IP
	
	fprintf(stdout, "Attaching to device %s\n", pcap_device);

//	sprintf((char *)&filter_exp, "ether proto 0x%04x", WARPNET_ETHTYPE_NODE2COPROC);
	sprintf((char *)&filter_exp, "(ether proto 0x%04x or ether proto 0x%04x)", WARPNET_ETHTYPE_NODE2COPROC, WARPNET_ETHTYPE_SVR2NODE);
	
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
	pcap_loop(pcap_handle, -1, (pcap_handler)pcap_pktRx_handler, NULL);

	return 0;
}

int SetupLogFiles() {
	int i;
	char fileName[50];
	
	for(i=0; i<numWARPnodes; i++) {
		sprintf(fileName, "logs/phylog_%04d_n%d.log", berLog_fileSuffix, i);

		if(log_fds[i] != NULL)
			fclose(log_fds[i]);

		log_fds[i] = fopen(fileName, "w");

		if(log_fds[i] == NULL) {
			printf("Error creating log file\r\n");
			return -1;
		}
	}

	return 0;
};
	
int main(int argc, char *argv[])
{
	printf("Starting WARP PHY Logger\n");

	int i;
	//Default number of WARP nodes; can be overridden on the command line
	numWARPnodes = 3;

	log_param0 = 0;
	log_param1 = 0;
	log_param2 = 0;
	log_param3 = 0;

	berLog_fileSuffix = 0;
	
	//Use the next-largest ID, after all the actual nodes
	myID = 98;
	
	groupStruct.controllerID = 0;
	groupStruct.controllerGrp = 0;
	groupStruct.access = 1;
	groupStruct.reserved0 = 0xA5;
	
	txEthPktHdr.ethType = WARPNET_ETHTYPE_NODE2SVR;
	txEthPktHdr.srcAddr[0]=0x00;
	txEthPktHdr.srcAddr[1]=0x50;
	txEthPktHdr.srcAddr[2]=0xC2;
	txEthPktHdr.srcAddr[3]=0x63;
	txEthPktHdr.srcAddr[4]=0x3F;
	txEthPktHdr.srcAddr[5]=0x80+myID;


	//Linux RiceNet2 NIC
	txEthPktHdr.dstAddr[0]=0x00;
	txEthPktHdr.dstAddr[1]=0x50;
	txEthPktHdr.dstAddr[2]=0xC2;
	txEthPktHdr.dstAddr[3]=0x63;
	txEthPktHdr.dstAddr[4]=0x3F;
	txEthPktHdr.dstAddr[5]=0xFC;
	
/*
 //Macbook #1
 txEthPktHdr.dstAddr[0]=0x00;
 txEthPktHdr.dstAddr[1]=0x17;
 txEthPktHdr.dstAddr[2]=0xf2;
 txEthPktHdr.dstAddr[3]=0xdb;
 txEthPktHdr.dstAddr[4]=0x05;
 txEthPktHdr.dstAddr[5]=0x07;
*/
	
	if(argc == 1)
	{	
		//Set sensible defaults if the user forgets to provide arguments
		pcap_device = "eth1";
		printf("No cmd line params; Assuming pcapDevice: %s, numNodes: %d\n", pcap_device, numWARPnodes);
	}
	else if(argc == 2)
	{
		//User provided an Ethernet interface to use
		pcap_device = argv[1];
		printf("Cmd line params: pcapDevice: %s\nAssuming numNodes: %d\n", pcap_device, numWARPnodes);
	}
	else if(argc == 3)
	{
		//User provided an Ethernet interface to use and number of WARP nodes
		pcap_device = argv[1];
		numWARPnodes = atoi((char *)argv[2]);
		printf("Cmd line params: pcapDevice: %s, numNodes: %d\n", pcap_device, numWARPnodes);
	}
	else
	{
		//User didn't provide good arguments; print usage and quit
		printf("Usage: %s <Ethernet device> <number of WARP nodes>\nExamples:\n\t%s (defaults to interface eth1)\n\t%s eth1 3 (use interface eth1, 3 WARP nodes)", argv[0], argv[0], argv[0]);
		return -1;
	}

	//Null out the file descriptors to start out
	for(i=0; i<numWARPnodes; i++) {
		log_fds[i] = NULL;
	}
		
	if(SetupLogFiles() != 0) {
		return -1;
	}
	
	//Sets up the PCAP capture interface
	// This function blocks, processing Ethernet packets forever
	SetupPCAP();

	return 0;
}
