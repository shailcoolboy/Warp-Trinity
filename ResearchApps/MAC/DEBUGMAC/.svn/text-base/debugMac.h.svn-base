/*! \file debugMac.h
 \brief Top-level debug "MAC" for testing PHY/MAC builds between reference design releases
 
 @version 10
 @author Chris Hunter
 
 Doesn't actually implement a MAC, and traffic only flows one direction. This is used for testing/debugging low-level PHY and WARPMAC changes.
*/



void phyRx_goodHeader_callback(Macframe* packet);
void phyRx_badHeader_callback();
void emacRx_callback(Xuint32 length, char* payload);
int main();
