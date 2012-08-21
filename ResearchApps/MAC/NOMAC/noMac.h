/*! \file noMac.h
 \brief No Medium Access Control Workshop MAC.

 @version 15.0
 @author Chris Hunter

 The easiest MAC. Forwards all traffic from
 ethernet to the radio medium and vice versa.
 No address filtering... no retransmissions.
 Medium access is completely dependent on
 the source traffic, so there is no actual
 medium access control. Hence, we have noMac.
*/


int phyRx_goodHeader_callback(Macframe* packet);
void phyRx_badHeader_callback();
void dataFromNetworkLayer_callback(Xuint32 length, char* payload);
void rightButton();
void upButton();
int main();
