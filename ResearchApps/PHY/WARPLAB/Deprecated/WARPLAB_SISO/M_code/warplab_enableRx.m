function pktNoTx = warplab_enableRx(udpSock)

warplab_siso_defines

pktNoTx = 1;

%Enable Rx Radio #2
warplab_sendCmd(udpSock, RADIO2_RXEN, pktNoTx);

%Enable the capture
warplab_sendCmd(udpSock, RX_START, pktNoTx);

pktNoTx = pktNoTx + 1; 