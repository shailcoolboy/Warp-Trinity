/*! \file halfmac_server.c
 \brief Transmission Half of a CSMA MAC protocol
 
 @version 16.1
 @author Chris Hunter
 
 This code is a simple manipulation of csmaMac.c that allows for addressing
 multiple WARP nodes based upon the IP address of the packet being sent.
 
 */

int phyRx_goodHeader_callback(Macframe* packet);
void phyRx_badHeader_callback();
void dataFromNetworkLayer_callback(Xuint32 length, char* payload);
void timer_callback(unsigned char timerType);
void uartRecv_callback(unsigned char uartByte);
void printMenu();
int main();
