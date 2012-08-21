function pktNoTx = warplab_enableTx(udpSock)

warplab_siso_defines

pktNoTx = 1;

%Enable Tx Radio #2
warplab_sendCmd(udpSock, RADIO2_TXEN, pktNoTx);

%Enable the transmission
warplab_sendCmd(udpSock, TX_START, pktNoTx);

pktNoTx = pktNoTx + 1; 
