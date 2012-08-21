/*! \file warpnet_example.h
 \brief No Medium Access Control Workshop MAC.

 @version 16.0
 @author Chris Hunter & Patrick Murphy

*/


int phyRx_goodHeader_callback(Macframe* packet);
void phyRx_badHeader_callback();
void dataFromNetworkLayer_callback(Xuint32 length, char* payload);
void mgmtFromNetworkLayer_callback(Xuint32 length, char* payload);
void processControl(warpnetControl* controlStruct);
void processCommand(warpnetCommand* commandStruct);
int main();

//MS DEMO
void timerCallback(unsigned char timerType);
