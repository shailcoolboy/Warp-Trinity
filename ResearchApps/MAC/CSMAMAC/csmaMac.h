/*! \file csmaMac.h
\brief Carrier-sensing random access MAC.

@version 16.1
@author Chris Hunter

The csmaMac is a modified ALOHA MAC that
serves as an example for novel MAC
development. Nodes transmit whenever
they have information to transmit, and only
move on to the next packet once the original
transmit is acknowledged (ACKed). If no ACK
is received, a collision is inferred and the
packet is re-transmitted.

By default, the MAC also implements carrier-
sensing multiple-access with collision-
avoidance (CSMA-CA). This functionality is
built into hardware peripherals in the project
so very little software state is affected.

In its current state, the project acts as
a true ethernet MAC-level wireless bridge.
Any ethernet activity that appears on one
WARP will be sent to another via the custom
wireless link.
*/

void upButton();
void middleButton();
void rightButton();
void leftButton();
int phyRx_goodHeader_callback(Macframe* packet);
void phyRx_badHeader_callback();
void dataFromNetworkLayer_callback(Xuint32 length, char* payload);
void timer_callback(unsigned char timerType);
void uartRecv_callback(unsigned char uartByte);
