/*! \file halfmac_client_sw.c
 \brief Reception Half of a CSMA MAC protocol

 @version 14
 @author Chris Hunter

 The goal of this MAC is to act as a receiver to a CSMA-enabled server.
 This server will continue to retransmit packets until this client
 acknowledges its reception.

 In this variant, ACK transmission is handled directly by software using
 the transmission mechanisms in the WARPMAC framework.

 Note to workshop users: any names in quotes
 are names that can be searched for in the
 WARP API.

*/


int phyRx_goodHeader_callback(Macframe* packet);
void phyRx_badHeader_callback();
void dataFromNetworkLayer_callback(Xuint32 length, char* payload);
int main();