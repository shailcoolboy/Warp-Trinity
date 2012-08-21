 /*! \file hopMacClient.h
 \brief Hop MAC Workshop Exercise.
 
 @version 12
 @author Chris Hunter
 
 This exercise is an extension of the previous
 HALFMAC exercise. In fact, you are welcome
 top copy and paste the parts of the code you
 completed in that exercise for the similar
 tasks here.
 
 The twist in this lab is that the server
 will periodically hop to a new part of the
 spectrum. Before doing so, it will transmit
 a special control packet (HOPPACKET) that
 contains the destination frequency band.
 
 If the packet is missed, your receiver will
 be stuck until the transmitter randomly hops
 back onto the channel you were sitting at.
 This can potentially be a very long time.
 An advanced extension to this lab is to
 scan for packets in various channels when
 no good packet is received for a certain
 amount of time. For our purposes, let this
 timeout be around 200ms.
 */

void button();
void phyRx_goodHeader_callback(Macframe* packet);
void phyRx_badHeader_callback();
void emacRx_callback(Xuint32 length, char* payload);
int main();
